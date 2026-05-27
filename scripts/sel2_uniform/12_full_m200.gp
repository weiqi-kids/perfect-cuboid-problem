\\ =====================================================================
\\ 12_full_m200.gp -- comprehensive enumeration over m <= 200
\\ Goal: confirm max dim Sel_2 in a larger range
\\ =====================================================================

default(parisize, 1500000000);

build_E_min(m, n) = {
  my(a = m^2 - n^2, b = 2*m*n, q, E, Em);
  q = a/b;
  E = ellinit([0, 1+q^2, 0, q^2, 0]);
  Em = ellminimalmodel(E);
  Em;
};

\\ Just track histogram of dim_Sel_2 = ellrank.up + 2

print("===== dim Sel_2 distribution, m in [101, 200] =====");

{
nfibers = 0;
high_fibers = List();
counts = vector(20, j, 0);
maxs = 0;
for(m = 101, 200,
  for(n = 1, m-1,
    if(gcd(m, n) != 1 || (m + n) % 2 == 0, next);
    nfibers++;
    Em = build_E_min(m, n);
    rk = ellrank(Em, 1);
    s2 = rk[2] + 2;
    counts[s2 + 1]++;
    if(s2 > maxs, maxs = s2);
    if(s2 >= 6, listput(high_fibers, [m, n, rk[1], rk[2], s2]));
  );
);
print("Total fibers tested: ", nfibers);
print();
print("dim Sel_2  count");
for(d = 0, 15,
  if(counts[d+1] > 0,
    print(d, "       ", counts[d+1]);
  );
);
print();
print("Max dim Sel_2 observed: ", maxs);
print();
print("Fibers with dim Sel_2 >= 6:");
for(i=1, #high_fibers, print(" ", high_fibers[i]));
}

quit;
