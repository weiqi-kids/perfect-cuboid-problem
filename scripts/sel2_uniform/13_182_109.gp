default(parisize, 1500000000);

m = 182; n = 109;
print("Checking (182, 109):");
print("  m+n = ", m+n, " = ", factor(m+n));
print("  m-n = ", m-n, " = ", factor(m-n));
print("  m*n = ", m*n, " = ", factor(m*n));
print("  m^2+n^2 = ", m^2+n^2, " = ", factor(m^2+n^2));
print("  m^2-n^2 = ", m^2-n^2, " = ", factor(m^2-n^2));
print("  P = (m+n)^2 - 2n^2 = ", (m+n)^2 - 2*n^2, " = ", factor((m+n)^2 - 2*n^2));
print("  Q = (m-n)^2 - 2n^2 = ", (m-n)^2 - 2*n^2, " = ", factor((m-n)^2 - 2*n^2));
print();

q = (m^2-n^2)/(2*m*n);
E = ellinit([0, 1+q^2, 0, q^2, 0]);
Em = ellminimalmodel(E);
print("Trying ellrank at effort 10...");
rk = ellrank(Em, 10);
print("ellrank(Em, 10) = ", rk);
print();
print("Trying isogeny class approach...");
iso = ellisomat(Em, 0, 1);
{
print("Number of isogenous curves: ", #iso[1]);
for(i = 1, #iso[1],
  Ei = ellinit(iso[1][i]);
  rki = ellrank(Ei, 5);
  print("  E_", i, " ellrank=", rki[1], "..", rki[2]);
);
}

quit;
