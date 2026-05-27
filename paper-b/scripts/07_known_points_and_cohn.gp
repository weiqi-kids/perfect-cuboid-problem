\\ ============================================================
\\ Paper B, Script 07: the 16 known rational points of C, their degeneracy,
\\ and the UNCONDITIONAL integer-q closure via the Pell/Lucas route (Cohn 1964).
\\ ============================================================

f1q(qq) = 5*qq^4 - 16*qq^2 + 20;
f2q(qq) = 5*qq^4 + 20;

\\ --- the 16 known points ---
print("=== the 16 known rational points (q,e,g) and degeneracy b=q^2-4 ===");
known = [];
{
for(sq = 0, 1,
  for(q0 = 1, 2,
    my(qq = (2*sq-1)*q0, ev, gv, ok1, ok2);
    ok1 = issquare(f1q(qq), &ev); ok2 = issquare(f2q(qq), &gv);
    if(ok1 && ok2,
      for(es = 0, 1, for(gs = 0, 1,
        known = concat(known, [[qq, (2*es-1)*ev, (2*gs-1)*gv]]))));
  ));
}
known = Set(known);
print("count = ", #known);
{
for(i=1,#known,
  my(P=known[i]);
  print("  ", P, "  on C? ", (P[2]^2==f1q(P[1])) && (P[3]^2==f2q(P[1])),
        "  b=q^2-4=", P[1]^2-4);
);
}
print("all have q in {+-1,+-2} => b=q^2-4 in {-3,0} <= 0 => DEGENERATE.");
print("a non-degenerate Case-B cuboid needs b=q^2-4>0, i.e. |q|>=3.");

\\ --- exhaustive search for OTHER rational points up to height bound ---
print("\n=== search C(Q) by q=n/d, |n|,d <= 2000 ===");
N = 2000; extra = List();
{
for(n=-N,N, for(d=1,N,
  if(gcd(n,d)!=1, next);
  my(qq=n/d, ev, gv);
  if(issquare(f1q(qq),&ev) && issquare(f2q(qq),&gv),
    if(!setsearch(Set([qq]), qq) || 1,
      if(abs(qq)!=1 && abs(qq)!=2, listput(extra,[qq,ev,gv]))));
));
}
print("rational points with |q| not in {1,2} found up to height ", N, ": ", Vec(extra));
print("(empty => only the 16 known points up to this height)");

\\ --- UNCONDITIONAL integer route: g^2 = 5q^4+20 with Y=q^2: g^2-5Y^2=20 ---
print("\n=== integer-q route: Pell g^2 - 5 Y^2 = 20, Y=q^2 ===");
print("Fundamental solution (g,Y)=(5,1): ", 5^2 - 5*1^2);
print("orbit Y_n (recurrence Y_{n+1}=3Y_n - Y_{n-1}, Y_1=1,Y_2=4):");
Y=vector(12); Y[1]=1; Y[2]=4;
for(n=3,12, Y[n]=3*Y[n-1]-Y[n-2]);
print("  Y = ", Y);
\\ Lucas numbers L_k:
L=vector(25); L[1]=1; L[2]=3; for(k=3,25, L[k]=L[k-1]+L[k-2]);
print("  L_{2n-1} = ", vector(12, n, L[2*n-1]));
print("  match Y_n = L_{2n-1}? ", vector(12,n, Y[n]==L[2*n-1]));
print("squares among Y_n (=q^2 must be a square): ", select(y->issquare(y), Y));
print("=> only Y in {1,4}, i.e. q in {1,2} (integer q). By Cohn 1964, the only");
print("   squares in the Lucas sequence are L_1=1 and L_3=4, so this is the");
print("   COMPLETE integer list, unconditionally. Both give degenerate cuboids.");
quit;
