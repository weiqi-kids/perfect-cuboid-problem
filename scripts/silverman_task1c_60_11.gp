\\ Task 1c: Try harder to find generators for q = 60/11 (rank 2)

default(parisize, 4000000000);

{
q = 60/11;
a2 = 1 + q^2; a4 = q^2;
E = ellinit([0, a2, 0, a4, 0]);
Emin = ellminimalmodel(E, &v);
print("Emin: ", [Emin.a1, Emin.a2, Emin.a3, Emin.a4, Emin.a6]);
print("v: ", v);

\\ ellratpoints search up to height bound
print("ellratpoints search (bound 10000)...");
pts = ellratpoints(Emin, 10000);
print("found ", #pts, " points");
for(j = 1, min(#pts, 30),
  P = pts[j];
  if(P != [0],
    h = ellheight(Emin, P);
    print(" P=", P, " height=", h);
  );
);

\\ Also try with default effort
print();
print("ellrank with effort=5...");
rk = ellrank(Emin, 5);
print("rank: ", rk);

\\ Try analytic for Heegner of related curve
print();
print("ellheegner on quadratic twist? skip; try torsion");
T = elltors(Emin);
print("torsion: ", T);
}
