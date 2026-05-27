\\ =====================================================================
\\ 17_L3_validate_catalog.gp -- Validate the L3 bound across all known rank≥3 fibers
\\ L3 = 2 + ω(2 · (m²-n²) · sf(P · Q))
\\ =====================================================================

default(parisize, 1500000000);

sf(x) = if(x == 0, 0, my(s = sign(x), a = abs(x), f = factor(a)); s * prod(i=1, matsize(f)[1], f[i,1]^(f[i,2]%2)));

build_E_min(m, n) = {
  my(a = m^2 - n^2, b = 2*m*n, q, E, Em);
  q = a/b;
  E = ellinit([0, 1+q^2, 0, q^2, 0]);
  Em = ellminimalmodel(E);
  Em;
};

print("===== L3 bound validation on rank≥3 catalog =====");
print("L1 = 2 + ω(sf(P*Q))");
print("L2 = 2 + ω(2*m*n*sf(P*Q))");
print("L3 = 2 + ω(2*(m²-n²)*sf(P*Q))");
print();
print("(m,n)      dim_Sel2  L1  L2  L3  L3 OK?");

{
catalog = [[22,17], [35,22], [37,26], [40,29], [40,33], [41,18], [44,9], [53,32], [59,40], [60,43], [161,48], [173,16], [197,20], [99,28], [118,25], [174,83], [176,63], [181,38], [205,66], [209,72], [216,185], [221,202], [261,52], [273,86], [578,319], [217,24]];
}

{
allOK = 1;
for(i=1, #catalog,
  mn = catalog[i];
  m = mn[1]; n = mn[2];
  if(gcd(m,n) != 1 || (m+n) % 2 == 0, next);
  P = (m+n)^2 - 2*n^2;
  Q = (m-n)^2 - 2*n^2;
  sPQ = sf(P * Q);
  Em = build_E_min(m, n);
  rk = ellrank(Em, 2);
  s2 = rk[2] + 2;
  L1 = 2 + omega(abs(sPQ));
  L2 = 2 + omega(2 * m * n * abs(sPQ));
  L3 = 2 + omega(2 * abs(m^2 - n^2) * abs(sPQ));
  okstr = if(s2 <= L3, "Y", "N");
  if(s2 > L3, allOK = 0);
  print(mn, "  ", s2, "       ", L1, "  ", L2, "  ", L3, "  ", okstr);
);
print();
print("L3 holds on entire catalog: ", if(allOK, "YES", "NO"));
}

quit;
