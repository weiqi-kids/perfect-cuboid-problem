\\ ============================================================================
\\ 03_highsigma_probe.gp -- SMALLEST-HEIGHT probe at the HIGHEST sigma reachable.
\\ For high-sigma fibers (sigma up to 4.61) we may not get an explicit generator
\\ cheaply. Two routes:
\\  (A) If ellheegner / ellrank yields a point fast, saturate + ellheight -> exact ĥ_min.
\\  (B) Else, RIGOROUS LOWER BOUND on ĥ_min via the CPS / Silverman height-difference:
\\        ĥ(P) >= h_naive(P) - mu_E ,  mu_E = (CPS height-difference bound),
\\      and a non-torsion integral point has h_naive >= log 2 say; more usefully we
\\      report the family lower bound structure. We MAINLY report, per high-sigma
\\      fiber, sigma, log|Delta|, n_max, and the Petsche per-fiber c(1,sigma):
\\        c(1,sigma) = 1/(1e15 * sigma^6 * log(104613*sigma^2)^2),
\\      giving the GUARANTEED floor  ĥ_min/log|Delta| >= c(1,sigma)  -- the only
\\      rigorous sigma-dependent lower bound. We tabulate how c degrades vs sigma.
\\ Also: for the very-high-sigma EVEN-rank fibers (56,25 sigma=4.26; 256,121
\\ sigma=4.61) we attempt ellrank to confirm rank and (if cheap) a generator.
\\ ============================================================================
default(parisize,700000000);
default(parisizemax,1200000000);

petsche_c(sig)= 1.0/(1e15 * sig^6 * log(104613*sig^2)^2);

saturate(EE,PP)=
{
  my(b,f,Q); b=PP;
  for(it=1,30, f=0; foreach([2,3,5,7],d, Q=0; if(ellisdivisible(EE,b,d,&Q), b=Q; f=1; break)); if(!f,break));
  return(b);
}

\\ try to get a generator: ellheegner first (if odd analytic rank), else ellrank
gen_or_bound(m,n)=
{
  my(a,b,q,E,Em,vv,logD,gr,N,sig,rn,P,Pg,hh,got);
  a=m^2-n^2; b=2*m*n; q=a/b;
  E=ellinit([0,1+q^2,0,q^2,0]); Em=ellminimalmodel(E,&vv);
  logD=log(abs(Em.disc)); gr=ellglobalred(Em); N=gr[1]; sig=logD/log(N);
  rn=ellrootno(Em);
  got=0; hh=-1.0;
  if(rn==-1,
    iferr(alarm(120, P=ellheegner(Em); Pg=saturate(Em,P); if(ellisoncurve(Em,Pg)&&!ellorder(Em,Pg), hh=ellheight(Em,Pg); got=1)), E_, got=0)
  ,
    \\ even root number: try ellrank for a generator (effort modest), guarded
    iferr(alarm(120, my(rr); rr=ellrank(Em); if(#rr>=4 && #rr[4]>=1, Pg=saturate(Em,rr[4][1]); if(ellisoncurve(Em,Pg)&&!ellorder(Em,Pg), hh=ellheight(Em,Pg); got=1))), E_, got=0)
  );
  print(m," ",n," ",sig," ",logD," ",N," ",rn," ",got," ",hh," ",if(got,hh/logD,-1)," ",petsche_c(sig));
}

print("m n sigma logD N rootno got hat_h_min h/logD petsche_c(1,sigma)");
\\ highest-sigma fibers from recon + the SIGMA-BOUND record holders:
\\ (16,3) 3.96 r1, (22,3) 3.85 r1, (32,9) 3.70 r1, (5,4) 3.72 r0?, (13,6) 3.57 r0,
\\ (16,9) 3.67 r0, (56,25) 4.26 even, (256,121) 4.61 even (huge N, will SKIP/bound)
FL=[[16,3],[22,3],[32,9],[5,4],[16,9],[13,6],[16,7],[18,7],[26,1],[44,1],[56,25],[122,121],[256,121]];
for(i=1,#FL, iferr(gen_or_bound(FL[i][1],FL[i][2]), E_, print(FL[i][1]," ",FL[i][2]," SKIP")));
print("EXIT=ok");
quit;
