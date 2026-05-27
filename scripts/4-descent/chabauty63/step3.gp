m = 63; n = 38;
a = m^2 - n^2; X2 = a^2;
b = 2*m*n; X3 = b^2;
dab = m^2 + n^2; X1 = dab^2;
S = X1+X2+X3; P = X1*X2 + X1*X3 + X2*X3; Q = X1*X2*X3;
E = ellinit([0, P, 0, Q*S, Q^2]);
T = elltors(E);
print("torsion order = ", T[1], "  structure = ", T[2]);
G1 = T[3][1]; G2 = T[3][2];
print("G1 = ", G1, "  order ", ellorder(E, G1));
print("G2 = ", G2, "  order ", ellorder(E, G2));

\\ enumerate full torsion subgroup
TList = List();
listput(TList, [0]);
for(j=1, 7, listput(TList, ellmul(E, G1, j)));
listput(TList, G2);
for(j=1, 7, listput(TList, elladd(E, ellmul(E, G1, j), G2)));
print("number of torsion points listed = ", length(TList));

\\ For each torsion point, compute s = -Q/x in the quartic model.
print();
print("Checking s = -Q/x for square-ness:");
for(k=1, length(TList), \
  pp = TList[k]; \
  if(length(pp) < 2, print(k, "  Identity O"), \
    xx = pp[1]; yy = pp[2]; \
    if(xx == 0, print(k, "  x=0  s=infty  (this is a branch at infinity in (s,t))"), \
      sq = -Q/xx; \
      print(k, "  x=", xx, "  s=-Q/x=", sq, "  issquare(s)=", issquare(sq)))));
