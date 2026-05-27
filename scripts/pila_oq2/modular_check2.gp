Eofq(qv) = ellinit([0,1+qv^2,0,qv^2,0]);
testfiber(qv) = {
  my(E,P,Q,o,twoP);
  E=Eofq(qv);
  P=[qv, qv*(qv+1)];
  o=ellorder(E,P);
  twoP=elladd(E,P,P);
  print("q=",qv,": P=(q,q(q+1)) onc=",ellisoncurve(E,P)," order(P)=",o," 2P=",twoP);
}
testfiber(20/21);
testfiber(24/7);
testfiber(60/11);
\\ Also check the OTHER 4-torsion point (-q, ...) and whether (0,0) is the doubling
\\ Confirm group structure Z/4 x Z/2 and which 2-torsion is 2*(order-4 generator)
quit;
