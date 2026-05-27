\\ =====================================================================
\\ 07_full_catalog.gp -- Comprehensive Sel_2 distribution across catalog
\\ Goal: histogram dim Sel_2 over a much larger sample, find max, identify
\\       the unique fiber (if any) that violates dim Sel_2 ≤ 6.
\\ =====================================================================

default(parisize, 1500000000);

build_E_min(m, n) = {
  my(a = m^2 - n^2, b = 2*m*n, q, E, Em);
  q = a/b;
  E = ellinit([0, 1+q^2, 0, q^2, 0]);
  Em = ellminimalmodel(E);
  Em;
};

sf(x) = if(x == 0, 0, my(s = sign(x), a = abs(x), f = factor(a)); s * prod(i=1, matsize(f)[1], f[i,1]^(f[i,2]%2)));

print("===== Sel_2 dimension survey: m in [2, 100], all primitive Pythagorean =====");

{
nfibers = 0;
high_fibers = List();
counts = vector(20, j, 0);
maxs = 0;
for(m = 2, 100,
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
print("dim Sel_2  count  fraction");
for(d = 0, 12,
  if(counts[d+1] > 0,
    print(d, "       ", counts[d+1], "    ", round(1000.0*counts[d+1]/nfibers)/10.0, "%");
  );
);
print();
print("Max dim Sel_2 observed: ", maxs);
print();
print("Fibers with dim Sel_2 >= 6:");
for(i=1, #high_fibers, print(" ", high_fibers[i]));
}

quit;
