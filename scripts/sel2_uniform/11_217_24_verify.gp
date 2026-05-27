\\ Verify dim Sel_2 = 7 at (217, 24)
default(parisize, 1500000000);

m = 217; n = 24;
q = (m^2 - n^2)/(2*m*n);
print("q = ", q);

E = ellinit([0, 1+q^2, 0, q^2, 0]);
Em = ellminimalmodel(E);
print("Emin discriminant: ", Em.disc);
print("Conductor: ", ellglobalred(Em)[1]);
print();

\\ Try ellrank2 directly
print("Trying ellrank(Em, 10)...");
rk = ellrank(Em, 10);
print("ellrank result: ", rk);
print("Lower bound on rank: ", rk[1]);
print("Upper bound on rank: ", rk[2]);
print("dim Sel_2 upper bound: ", rk[2] + 2);

\\ Number of 2-covers
print();
print("Number of 2-covers (ell2cover): ", #ell2cover(Em));

\\ Try isogeny class
print();
print("Isogeny class:");
iso = ellisomat(Em, 0, 1);
print("Number of isogenous curves: ", #iso[1]);
for(i=1, #iso[1],
  Ei = ellinit(iso[1][i]);
  rki = ellrank(Ei, 3);
  print("  E_", i, " rk = ", rki[1..2], " dim Sel_2 <= ", rki[2] + 2);
);

quit;
