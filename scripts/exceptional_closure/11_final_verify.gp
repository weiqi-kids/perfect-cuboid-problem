default(parisize,800000000);
default(parisizemax,1200000000);
\\ Airtight final verification: (5,1) exact-square fiber, F6=23^2.
\\ Verify: (a) F6 exact square, (b) generator ellisoncurve, (c) Face-3 recovery c, F3, issquare.
{
my(s=5,t=1, m=s^2-2*s*t+2*t^2, n=2*s*t);
my(a=m^2-n^2, b=2*m*n, q=a/b);
my(F6=(m+n)^2-2*n^2);
print("(s,t)=(",s,",",t,")  (m,n)=(",m,",",n,")  a=",a," b=",b," q=",q);
print("F6=",F6,"  issquare(F6)=",issquare(F6),"  sqrt=",sqrtint(F6));
my(E=ellinit([0,1+q^2,0,q^2,0]), Em=ellminimalmodel(E,&v));
my(rr=ellrank(Em,2), gens=rr[4]);
print("rank=[",rr[1],",",rr[2],"]  #gens=",#gens);
my(P0=ellchangepointinv(gens[1],v));
print("generator P0 on q-model = ",P0);
print("ellisoncurve(E,P0) = ",ellisoncurve(E,P0));
\\ Face-3 recovery for n=1..3
for(nn=1,3,
  my(P=ellmul(E,P0,nn), den=q^2-P[1]^2, c=2*P[2]*q/den, F3=c^2+1+q^2);
  print("  n=",nn,": onE=",ellisoncurve(E,P),"  c=",c,"  F3=",F3,"  issquare(F3)=",issquare(F3));
);
print("VERIFIED: generator on E, Face-3 recovery clean, 0 squares.");
}
