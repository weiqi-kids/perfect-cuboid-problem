\\ ============================================================
\\ Paper B, Script 04: the genuine rational quotient C_q^gen of C, its known
\\ rational points, and the lift to the 16 known points of C.
\\
\\ Genuine quotient (rational morphism pi: C -> C_q^gen, (q,e,g)|->(u,w)=(q^2,egq)):
\\   C_q^gen : w^2 = u(5u^2-16u+20)(5u^2+20) = 25u^5-80u^4+200u^3-320u^2+400u.
\\ Its Jacobian ~ X+^(5) x X-^(5) = 600a2 x 400a2, BOTH RANK 1 (script 05),
\\ so rank Jac(C_q^gen)=2=genus: this quotient does NOT give Chabauty finiteness.
\\ We record its known rational points and confirm they lift to the 16 of C.
\\ ============================================================

Hg = 25*x^5 - 80*x^4 + 200*x^3 - 320*x^2 + 400*x;
print("genuine quotient C_q^gen : w^2 = ", Hg);

\\ known rational points of C_q^gen: images of the 16 points of C under
\\ (q,e,g)->(u,w)=(q^2, e g q).
f1q(z)=5*z^4-16*z^2+20;
f2q(z)=5*z^4+20;
print("\n=== images of the 16 known C-points under pi ===");
imgs = List();
{
for(sq=0,1,
  for(q0=1,2,
    my(qq=(2*sq-1)*q0, ev=0, gv=0, ok1, ok2);
    ok1=issquare(f1q(qq),&ev); ok2=issquare(f2q(qq),&gv);
    if(ok1 && ok2,
      for(es=0,1,
        for(gs=0,1,
          my(ee=(2*es-1)*ev, gg=(2*gs-1)*gv, uu=qq^2, ww=ee*gg*qq);
          listput(imgs, [uu, ww])
        )
      )
    )
  )
);
}
imgs = Set(Vec(imgs));
print("distinct images (u,w): ", imgs);
print("count = ", #imgs, "  (16 C-points collapse to these under the 2:1 map)");
\\ verify each image lies on C_q^gen
{
for(i=1,#imgs, my(P=imgs[i], uu=P[1], ww=P[2]);
  print("  (u,w)=", P, " on C_q^gen? ", ww^2 == uu*(5*uu^2-16*uu+20)*(5*uu^2+20)));
}

\\ search for OTHER rational points of C_q^gen (independent of rank)
print("\n=== search C_q^gen(Q): u=n/d, |n|,d<=2000, H_gen(u) a square ===");
N=2000; extra=List();
{
for(n=-N,N, for(d=1,N,
  if(gcd(n,d)!=1, next);
  my(uu=n/d, hv=uu*(5*uu^2-16*uu+20)*(5*uu^2+20), s);
  if(hv==0, listput(extra,[uu,0]); next);
  if(hv>0 && issquare(hv,&s),
     if(uu!=0 && uu!=1 && uu!=4, listput(extra,[uu,s])));
));
}
print("affine points with u not in {0,1,4} up to height ", N, ": ", Vec(extra));
print("(empty => only u in {0,1,4} up to this height)");

\\ lift: a point (u,w) of C_q^gen lifts to C iff u=q^2 (rational square) and
\\ f1(q),f2(q) are squares.
print("\n=== lift C_q^gen(Q)-points to C(Q) ===");
CQ=List();
{
us = Set([0,1,4]);
for(i=1,#us,
  my(uu=us[i], q0=0, ev=0, gv=0);
  if(uu>=0 && issquare(uu,&q0),
    for(sq=0,1,
      my(qq=(2*sq-1)*q0);
      if(issquare(f1q(qq),&ev) && issquare(f2q(qq),&gv),
        for(es=0,1,
          for(gs=0,1,
            listput(CQ,[qq,(2*es-1)*ev,(2*gs-1)*gv])
          )
        )
      )
    )
  )
);
}
CQ=Set(Vec(CQ));
print("lifted C(Q) points: ", CQ);
print("|C(Q)| (these 16) = ", #CQ);
print("all degenerate: b=q^2-4 in ", Set([P[1]^2-4 | P<-CQ]), " (all <= 0)");
quit;
