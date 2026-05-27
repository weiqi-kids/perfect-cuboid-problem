\\ Validate L2, L3 bounds on m <= 100 (all primitive Pythagorean)

default(parisize, 1500000000);

sf(x) = if(x == 0, 0, my(s = sign(x), a = abs(x), f = factor(a)); s * prod(i=1, matsize(f)[1], f[i,1]^(f[i,2]%2)));

build_E_min(m, n) = {
  my(a = m^2 - n^2, b = 2*m*n, q, E, Em);
  q = a/b;
  E = ellinit([0, 1+q^2, 0, q^2, 0]);
  Em = ellminimalmodel(E);
  Em;
};

print("===== Validate L2, L3 on m <= 100 =====");

{
nfibers = 0;
viol_L2 = 0;
viol_L3 = 0;
viol_examples_L2 = List();
viol_examples_L3 = List();
maxS2 = 0;
maxL2 = 0;
maxL3 = 0;
for(m = 2, 100,
  for(n = 1, m-1,
    if(gcd(m, n) != 1 || (m + n) % 2 == 0, next);
    nfibers++;
    P = (m+n)^2 - 2*n^2;
    Q = (m-n)^2 - 2*n^2;
    sPQ = sf(P * Q);
    Em = build_E_min(m, n);
    rk = ellrank(Em, 1);
    s2 = rk[2] + 2;
    L2 = 2 + omega(2 * m * n * abs(sPQ));
    L3 = 2 + omega(2 * abs(m^2 - n^2) * abs(sPQ));
    if(s2 > L2, viol_L2++; listput(viol_examples_L2, [m, n, s2, L2]));
    if(s2 > L3, viol_L3++; listput(viol_examples_L3, [m, n, s2, L3]));
    if(s2 > maxS2, maxS2 = s2);
    if(L2 > maxL2, maxL2 = L2);
    if(L3 > maxL3, maxL3 = L3);
  );
);
print();
print("Tested ", nfibers, " primitive Pythagorean fibers m <= 100");
print("Max dim Sel_2 = ", maxS2);
print("Max L2 = ", maxL2);
print("Max L3 = ", maxL3);
print("L2 violations: ", viol_L2);
if(viol_L2 > 0, for(i=1, min(20, viol_L2), print("  ", viol_examples_L2[i])));
print("L3 violations: ", viol_L3);
if(viol_L3 > 0, for(i=1, min(20, viol_L3), print("  ", viol_examples_L3[i])));
}

quit;
