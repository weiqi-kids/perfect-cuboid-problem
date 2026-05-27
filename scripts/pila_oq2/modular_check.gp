\\ Identify the modular curve / level structure of E_PCP(q).
\\ E_PCP(q): Y^2=X(X+1)(X+q^2). Full 2-torsion {0,-1,-q^2}; 4-torsion at X=+-q.
\\ A 4-torsion pt P=(q, q(q+1)): check 2P is a 2-torsion pt; identify which one.
Eofq(q) = ellinit([0,1+q^2,0,q^2,0]);
for(k=1,3,
  q=[20/21,24/7,60/11][k];
  E=Eofq(q);
  P=[q, q*(q+1)];
  print("q=",q,": P=(q,q(q+1)) onc=",ellisoncurve(E,P)," ord(2P)... 2P=",elladd(E,P,P));
  print("   order of P = ", ellorder(E,P));
  \\ the three 2-torsion: which is 2P?
  print("   2-torsion pts: (0,0),(-1,0),(-q^2,0) ; 2P x-coord=", elladd(E,P,P)[1]);
);
\\ The j-line image: family j(q)=256(q^4-q^2+1)^3/(q^4(q^2-1)^2). This is a degree map P^1_q -> P^1_j.
\\ degree of j as rational function in q:
print("---");
jq(q)=256*(q^4-q^2+1)^3/(q^4*(q^2-1)^2);
\\ degree = max(deg num, deg den) after reduction
f = (256*(x^4-x^2+1)^3) / (x^4*(x^2-1)^2);
nu = numerator(f); de = denominator(f);
print("deg j-map numerator = ", poldegree(nu), " denominator = ", poldegree(de), " => degree of q->j map = ", max(poldegree(nu),poldegree(de)));
quit;
