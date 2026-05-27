\\ ============================================================================
\\ 02_sweep.gp -- DECISIVE rank-1 sweep. For each analytic-rank-1 fiber:
\\   * build E_PCP(q), minimal model
\\   * ellheegner -> Heegner point (= k*generator on rank-1 fibers)
\\   * SATURATE: divide out small index k via ellisdivisible up to k_max
\\   * VERIFY: ellisoncurve(Em, Pg) AND hat_h via ellheight
\\   * record sigma, log|Delta_min|, log H_j (=h(j(E))), hat_h, ratios,
\\     n_max (max v_p(Delta)), deepest component depth, h_NA, lambda_inf
\\ The KEY output: hat_h/log|Delta| vs sigma vs n_max -- does the FLOOR decrease
\\ toward 0 as sigma grows?
\\ Flushed per line; each fiber guarded by alarm so a slow ellheegner is SKIPPED.
\\ ============================================================================
default(parisize,700000000);
default(parisizemax,1200000000);

\\ non-archimedean local r at prime pp (Cremona-Prickett-Siksek / Sage branch)
nonarch_r(EE,PP,pp)=
{
  my(a1,a2,a3,a4,b2,b4,b6,b8,c4,xx,yy,DD,NN,AA,BB,CC,nn,rr);
  a1=EE.a1;a2=EE.a2;a3=EE.a3;a4=EE.a4;b2=EE.b2;b4=EE.b4;b6=EE.b6;b8=EE.b8;c4=EE.c4;
  xx=PP[1];yy=PP[2];DD=EE.disc;NN=valuation(DD,pp);
  AA=valuation(3*xx^2+2*a2*xx+a4-a1*yy,pp);
  BB=valuation(2*yy+a1*xx+a3,pp);
  CC=valuation(3*xx^4+b2*xx^3+3*b4*xx^2+3*b6*xx+b8,pp);
  nn=-1;
  if(AA<=0||BB<=0,rr=max(0,-valuation(xx,pp)),
     valuation(c4,pp)==0,nn=min(BB,NN/2);rr=-nn*(NN-nn)/NN,
     CC>=3*BB,rr=-2*BB/3,rr=-CC/4);
  return([rr,NN,nn]);
}

\\ global non-arch height on GLOBAL MINIMAL model + n_max + maxcomp depth
nonarch_global(EE,PP)=
{
  my(D,fa,c,h,maxnp,maxcomp,p,res,vc);
  D=EE.disc; fa=factor(abs(D));
  c=if(PP[1]==0,1,denominator(PP[1]));
  h=log(c); maxnp=0; maxcomp=0;
  for(k=1,#fa~,
    p=fa[k,1]; res=nonarch_r(EE,PP,p);
    if(res[2]>maxnp,maxnp=res[2]);
    if(res[3]>maxcomp,maxcomp=res[3]);
    vc=valuation(c,p);
    h+=res[1]*log(p)-vc*log(p);
  );
  return([h,maxnp,maxcomp]);
}

\\ saturate Heegner point: try dividing by d=2,3,5,7 repeatedly, up to many passes
saturate(EE,PP)=
{
  my(b,f,Q);
  b=PP;
  for(it=1,30,
    f=0;
    foreach([2,3,5,7],d,
      Q=0;
      if(ellisdivisible(EE,b,d,&Q), b=Q; f=1; break)
    );
    if(!f,break)
  );
  return(b);
}

proc(m,n)=
{
  my(a,b,q,E,Em,vv,P,Pg,onc,hh,logD,gr,N,sig,gNA,hNA,la,logHj,jj);
  a=m^2-n^2; b=2*m*n; q=a/b;
  E=ellinit([0,1+q^2,0,q^2,0]); Em=ellminimalmodel(E,&vv);
  P=ellheegner(Em);
  Pg=saturate(Em,P);
  onc=ellisoncurve(Em,Pg);
  hh=ellheight(Em,Pg);
  logD=log(abs(Em.disc));
  gr=ellglobalred(Em); N=gr[1]; sig=logD/log(N);
  gNA=nonarch_global(Em,Pg); hNA=gNA[1]; la=hh-hNA;
  \\ height of j-invariant: h(j) = log H_j = log of max(|num|,|den|) of j in lowest terms
  jj=Em.j; logHj=log(max(abs(numerator(jj)),abs(denominator(jj))));
  print(m," ",n," ",sig," ",hh," ",logD," ",logHj," ",hh/logD," ",hh/logHj," ",gNA[2]," ",gNA[3]," ",hNA," ",la," ",onc);
}

print("m n sigma hat_h logD logHj h/logD h/logHj n_max maxcomp h_NA lambda_inf onc");
\\ 38 analytic-rank-1 fibers spanning sigma 2.75 -> 3.96, ORDERED smallest-conductor
\\ first (from 01_recon.out N column) so fast results appear early and slow large-N
\\ fibers (alarm-guarded) come last. The high-sigma low-N fibers (16,3 N=1.57M;
\\ 22,3 N=13.3M; 5,2 N=4305; 8,3 N=237930) are EARLY so the decisive high-sigma
\\ data lands fast.
FL=[\
[5,2],[8,3],[16,3],[4,3],[14,5],[11,2],[10,1],[10,3],[22,3],[16,7],\
[16,9],[16,5],[18,1],[12,11],[14,3],[15,4],[15,8],[16,15],[24,1],[8,5],\
[7,6],[11,6],[32,9],[11,8],[26,1],[28,5],[36,5],[36,7],[12,7],[44,1],\
[28,3],[20,3],[64,1],[40,1],[5,4],[13,6],[16,5],[18,7]\
];
runone(m,n)={iferr(alarm(110, proc(m,n)), E_, print(m," ",n," SKIP/slow_or_rank0"));}
for(i=1,#FL, runone(FL[i][1],FL[i][2]));
print("EXIT=ok");
quit;
