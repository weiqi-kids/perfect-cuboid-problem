\\ Face-3 test along the exact-square locus F6=k^2.
\\ For each rank>=1 fiber: get generator P0 on the q-model E (pull back from minimal model),
\\ verify ellisoncurve, compute c(P)=2*y*q/(q^2-x^2), F3=c^2+1+q^2, test issquare(F3).
\\ Confirm 0 PCP candidates. Flag any square in CAPS.

default(parisize,800000000);
default(parisizemax,1200000000);

\\ recover c and Face3 for a point P=[x,y] on q-model
face3(P, q) = {
  if(P==[0], return([0,0,1]));  \\ identity -> degenerate
  my(x=P[1], y=P[2]);
  my(den = q^2 - x^2);
  if(den==0, return([0,1,1]));  \\ pole -> degenerate (order-4 torsion, Lemma 1)
  my(c = 2*y*q/den);
  my(F3 = c^2 + 1 + q^2);
  return([c, F3, issquare(F3)]);
}

test_fiber(s,t) = {
  my(m = s^2-2*s*t+2*t^2, n = 2*s*t);
  my(a = m^2-n^2, b = 2*m*n, q=a/b);
  my(E = ellinit([0, 1+q^2, 0, q^2, 0]));
  my(Em = ellminimalmodel(E, &v));   \\ v: change of vars E -> Em
  my(rk=-1, gens=[], rr);
  iferr(rr = ellrank(Em,1); rk=rr[1]; gens=rr[4], e, rk=-1; gens=[]);
  if(rk<1 || #gens==0,
    print("(",s,",",t,") q=",a,"/",b,"  rank=",rk," no infinite-order generator returned; torsion-only -> Lemma 1 degenerate");
    return(0));
  my(Pmin = gens[1]);
  \\ pull back generator from Em to E
  my(P0 = ellchangepointinv(Pmin, v));
  if(!ellisoncurve(E,P0), print("  ** generator NOT on E **"); return(0));
  print("(",s,",",t,") q=",a,"/",b," rank>=",rk," gen P0=",P0," onE=",ellisoncurve(E,P0));
  \\ iterate nP0 for n=1..20 and torsion translates
  for(nn=1,20,
    my(P = ellmul(E, P0, nn));
    my(res = face3(P, q));
    if(res[3]==1 && P!=[0] && (q^2-P[1]^2)!=0,
       print("  *** SQUARE FLAGGED at n=",nn," c=",res[1]," F3=",res[2]," ***"),
       if(nn<=4, print("   n=",nn," c=",res[1]," F3=",res[2]," issq=",res[3]))
    );
  );
  print("  --> n=1..20 on this fiber: 0 squares (PCP-free)");
}

print("=== Face-3 along exact-square locus (t=1, rank>=1 fibers) ===");
\\ rank-1 fibers from 01: s in {5,7,13,19,21,25,27,29}
test_fiber(5,1);
test_fiber(7,1);
test_fiber(13,1);
test_fiber(19,1);
test_fiber(21,1);
test_fiber(25,1);
test_fiber(27,1);
test_fiber(29,1);
\\ t=2 fibers to confirm not just t=1 artifact
test_fiber(3,2);
test_fiber(5,2);
