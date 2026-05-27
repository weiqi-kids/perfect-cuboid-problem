default(parisize,800000000);
default(parisizemax,1200000000);

\\ The 2-adic exceptional layer: high v2(b)=v2(2mn). b=2mn, m+n odd => exactly one of m,n even.
\\ v2(b)=1+v2(even one). High v2(b) => the even coordinate is divisible by a high power of 2.
\\ These are the ~21% of sigma>4 fibers NOT on the quadratic Pell locus (per SIGMA-ATTACK-ANALYTIC).
\\ Check: torsion, root number, rank-within-R, Face-3 on these 2-adic-record fibers.

fiber_report(m,n,lab) = {
  if(gcd(m,n)!=1, return(0));
  if((m+n)%2==0, return(0));
  my(a=m^2-n^2, b=2*m*n);
  if(a<=0, return(0));
  my(q=a/b, E=ellinit([0,1+q^2,0,q^2,0]), Em=ellminimalmodel(E));
  my(w=ellrootno(Em), tor=elltors(Em)[1], v2b=valuation(b,2));
  my(rl=-1,ru=-1,rr);
  if(w==-1, iferr(rr=ellrank(Em,2);rl=rr[1];ru=rr[2], e, rl=-1;ru=-1));
  print(lab," (",m,",",n,") v2(b)=",v2b," | tor=",tor," w=",w,
        if(w==-1, Strprintf("  rk=[%d,%d]",rl,ru), "  (even)"));
}

print("=== 2-adic high-v2(b) layer: even coordinate = 2^k * odd ===");
\\ build fibers where n = 2^k (high power of 2), m odd coprime
{
foreach([4,5,6,7,8,9], k,
  my(n = 2^k);
  \\ pick a few odd m coprime to n (n is a power of 2 so any odd m works), m>n
  foreach([n+1, n+3, 3*n+1, 5*n+1], m,
    if(m%2==0, m=m+1);
    if(gcd(m,n)!=1, next);
    fiber_report(m,n, Strprintf("v2layer k=%d",k));
  );
);
}
print();
print("=== Face-3 on a 2-adic-record fiber (1024,549): v2(b)=11 ===");
{
my(m=1024, n=549, a=m^2-n^2, b=2*m*n, q=a/b);
print("v2(b)=",valuation(b,2)," q=",a,"/",b);
my(E=ellinit([0,1+q^2,0,q^2,0]), Em=ellminimalmodel(E,&v));
my(w=ellrootno(Em));
print("root number w=",w," torsion=",elltors(Em)[1]);
my(rr,gens=[]);
iferr(rr=ellrank(Em,2);gens=rr[4], e, gens=[]);
print("rank low/high=",if(#rr>=2,Strprintf("[%d,%d]",rr[1],rr[2]),"?")," gens found=",#gens);
if(#gens>0,
  my(P0=ellchangepointinv(gens[1],v));
  print("gen onE=",ellisoncurve(E,P0));
  my(anysq=0);
  for(nn=1,12,
    my(P=ellmul(E,P0,nn));
    if(P==[0], next);
    my(den=q^2-P[1]^2);
    if(den==0, next);
    my(c=2*P[2]*q/den, F3=c^2+1+q^2);
    if(issquare(F3), print("  *** SQUARE at n=",nn," ***"); anysq=1);
  );
  print("  Face-3 n=1..12: squares found = ",anysq," (0 = PCP-free)");
);
}
