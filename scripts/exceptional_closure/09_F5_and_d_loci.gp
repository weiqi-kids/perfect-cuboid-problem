default(parisize,800000000);
default(parisizemax,1200000000);

\\ Extend the structural rank-1-within-R finding to:
\\  (i) the F5 = square locus: (m,n)=(s^2+2st+2t^2, 2st), k=|s^2-2t^2|;
\\  (ii) a d>1 conic F6 = 7 k^2 (powerful F6 with squarefree co-factor 7) via direct scan;
\\ confirm torsion = Z/4xZ/2 (order 8) uniformly and w=-1 => rank 1.

fiber_report(m,n,lab) = {
  if(gcd(m,n)!=1, return(0));
  if((m+n)%2==0, return(0));
  if(m<=n || n<=0, return(0));
  my(a=m^2-n^2, b=2*m*n);
  if(a<=0, return(0));
  my(q=a/b, E=ellinit([0,1+q^2,0,q^2,0]), Em=ellminimalmodel(E));
  my(w=ellrootno(Em), tor=elltors(Em)[1]);
  my(rl=-1,ru=-1,rr);
  if(w==-1, iferr(rr=ellrank(Em,2);rl=rr[1];ru=rr[2], e, rl=-1;ru=-1));
  my(F5=(m-n)^2-2*n^2, F6=(m+n)^2-2*n^2);
  print(lab," (",m,",",n,") F5=",F5," F6=",F6," | tor=",tor," w=",w,
        if(w==-1, Strprintf("  rk=[%d,%d]",rl,ru), "  (even)"));
  if(w==-1 && rl==1 && ru==1, return(1), return(0));
}

print("=== (i) F5 = square locus (m,n)=(s^2+2st+2t^2, 2st) ===");
{
my(nR=0, nR1=0);
for(s=2,40,
  my(t=1, m=s^2+2*s*t+2*t^2, n=2*s*t);
  my(r = fiber_report(m,n,"F5sq"));
  \\ count R/rank1
);
}
print();
print("=== (ii) F6 = 7*k^2 conic (squarefree co-factor d=7) ===");
\\ scan (m,n) primitive with F6=(m+n)^2-2n^2 = 7*(square)
{
my(cnt=0);
for(m=3,400,
  for(n=1,m-1,
    if(gcd(m,n)!=1, next);
    if((m+n)%2==0, next);
    my(F6=(m+n)^2-2*n^2);
    if(F6<=0, next);
    if(F6 % 7 != 0, next);
    if(!issquare(F6/7), next);
    fiber_report(m,n,"F6=7k^2");
    cnt++;
    if(cnt>=8, break(2));
  )
);
}
print();
print("=== (iii) F6 = 23*k^2 conic (d=23) ===");
{
my(cnt=0);
for(m=3,500,
  for(n=1,m-1,
    if(gcd(m,n)!=1, next);
    if((m+n)%2==0, next);
    my(F6=(m+n)^2-2*n^2);
    if(F6<=0, next);
    if(F6 % 23 != 0, next);
    if(!issquare(F6/23), next);
    fiber_report(m,n,"F6=23k^2");
    cnt++;
    if(cnt>=6, break(2));
  )
);
}
