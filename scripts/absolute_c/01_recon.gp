\\ ============================================================================
\\ 01_recon.gp -- reconnaissance: for a broad set of (m,n) with m+n odd,
\\ gcd(m,n)=1, compute sigma, log|Delta_min|, conductor N, analytic rank
\\ (ellanalyticrank, fast), to PICK rank-1 fibers spanning sigma widely.
\\ We DO NOT find generators here -- just classify tractability.
\\ Flushed per line. Skip fibers where conductor factoring or analytic rank
\\ is slow.
\\ ============================================================================
default(parisize,700000000);
default(parisizemax,1200000000);

classify(m,n)=
{
  my(a,b,q,E,Em,vv,logD,gr,N,sig,ar,t0);
  if(gcd(m,n)!=1, return(0));
  if((m+n)%2==0, return(0));
  a=m^2-n^2; b=2*m*n;
  q=a/b;
  E=ellinit([0,1+q^2,0,q^2,0]);
  Em=ellminimalmodel(E,&vv);
  logD=log(abs(Em.disc));
  gr=ellglobalred(Em); N=gr[1]; sig=logD/log(N);
  \\ root number (fast, exact parity) + analytic rank guarded by alarm.
  my(rn);
  rn = ellrootno(Em);
  ar = -1;
  iferr(alarm(20, ar=ellanalyticrank(Em)[1]), E_, ar=-2);
  print(m," ",n," ",sig," ",logD," ",N," ",rn," ",ar);
  return(1);
}

print("m n sigma logD N rootno analrank");
\\ Sweep a grid of (m,n). Keep N small enough to be tractable.
\\ We bias toward fibers that historically gave generators + high-sigma ones.
LIST=[\
[2,1],[3,2],[4,1],[4,3],[5,2],[5,4],[6,1],[6,5],[7,2],[7,4],[7,6],\
[8,1],[8,3],[8,5],[8,7],[9,2],[9,4],[9,8],[10,1],[10,3],[10,7],[10,9],\
[11,2],[11,4],[11,6],[11,8],[12,1],[12,5],[12,7],[12,11],[13,2],[13,6],\
[14,1],[14,3],[14,5],[14,9],[14,11],[14,13],[15,2],[15,4],[15,8],[16,1],\
[16,3],[16,5],[16,7],[16,9],[16,15],[18,1],[18,5],[18,7],[18,11],[20,1],\
[20,3],[20,9],[20,11],[22,1],[22,3],[24,1],[24,5],[24,7],[24,11],[26,1],\
[26,15],[28,1],[28,3],[28,5],[28,9],[28,15],[30,1],[32,1],[32,3],[32,5],\
[32,9],[32,15],[36,1],[36,5],[36,7],[40,1],[44,1],[48,1],[56,25],[64,1]\
];
for(i=1,#LIST, iferr(classify(LIST[i][1],LIST[i][2]), E_, print(LIST[i][1]," ",LIST[i][2]," SKIP")));
print("EXIT=ok");
quit;
