m = 63; n = 38;
a = m^2 - n^2;   X2 = a^2;
b = 2*m*n;       X3 = b^2;
dab = m^2 + n^2; X1 = dab^2;
S = X1+X2+X3; P = X1*X2 + X1*X3 + X2*X3; QQ = X1*X2*X3;
print("QQ = X1 X2 X3 = ", QQ);
print("QQ = (a b dab)^2 = ", (a*b*dab)^2, "   match: ", QQ == (a*b*dab)^2);
print();
print("** Crucial: since QQ = (a b dab)^2 is a SQUARE,  s = -QQ/x ∈ Q^2  iff  -x ∈ Q^2.  **");
print();

E = ellinit([0, P, 0, QQ*S, QQ^2]);
T = elltors(E);
G1 = T[3][1]; G2 = T[3][2];

TList = List();
listput(TList, [0]);
{
  for(j = 1, 7,
    listput(TList, ellmul(E, G1, j));
  );
}
listput(TList, G2);
{
  for(j = 1, 7,
    listput(TList, elladd(E, ellmul(E, G1, j), G2));
  );
}

print("Torsion x-coordinates and -x square check:");
{
  for(k = 1, length(TList),
    PT = TList[k];
    if(length(PT) < 2,
      print(k, "  Identity O")
    ,
      xx = PT[1];
      negx = -xx;
      isnegsq = issquare(negx);
      if(isnegsq,
        sqrtnegx = sqrtint(negx);
        print(k, "  x=", xx, "   -x=", negx, "  =  ", sqrtnegx, "^2   ====> Y=±", sqrtnegx, " (rational)!")
      ,
        print(k, "  x=", xx, "   -x=", negx, "   NOT a square")
      )
    );
  );
}
