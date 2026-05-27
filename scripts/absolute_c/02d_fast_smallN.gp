\\ ============================================================================
\\ 02d_fast_smallN.gp -- broad FAST batch: scan many (m,n), keep only fibers
\\ where ellminimalmodel + ellglobalred + ellheegner all finish under a 30s
\\ alarm; emit verified decomposition. Tight alarm => only the genuinely fast
\\ (small-conductor) rank-1 fibers land; slow ones skip immediately. Goal: pad
\\ the table to >=30 verified fibers spanning sigma, cheaply.
\\ ============================================================================
default(parisize,700000000); default(parisizemax,1200000000);

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
nonarch_global(EE,PP)=
{
  my(D,fa,c,h,maxnp,maxcomp,p,res,vc);
  D=EE.disc; fa=factor(abs(D)); c=if(PP[1]==0,1,denominator(PP[1]));
  h=log(c); maxnp=0; maxcomp=0;
  for(k=1,#fa~, p=fa[k,1]; res=nonarch_r(EE,PP,p);
    if(res[2]>maxnp,maxnp=res[2]); if(res[3]>maxcomp,maxcomp=res[3]);
    vc=valuation(c,p); h+=res[1]*log(p)-vc*log(p));
  return([h,maxnp,maxcomp]);
}
saturate(EE,PP)=
{ my(b,f,Q); b=PP;
  for(it=1,40, f=0; foreach([2,3,5,7,11,13],d, Q=0; if(ellisdivisible(EE,b,d,&Q),b=Q;f=1;break)); if(!f,break));
  return(b); }

proc(m,n)=
{
  my(a,b,q,E,Em,vv,rn,P,Pg,onc,hh,logD,gr,N,sig,gNA,hNA,la,logHj,jj);
  if(gcd(m,n)!=1 || (m+n)%2==0, return(0));
  a=m^2-n^2; b=2*m*n; q=a/b;
  E=ellinit([0,1+q^2,0,q^2,0]); Em=ellminimalmodel(E,&vv);
  rn=ellrootno(Em);
  if(rn!=-1, return(0));  \\ only odd analytic rank => Heegner
  P=ellheegner(Em); Pg=saturate(Em,P);
  if(ellorder(Em,Pg), return(0));  \\ torsion only => skip
  onc=ellisoncurve(Em,Pg); hh=ellheight(Em,Pg);
  if(hh<1e-6, return(0));
  logD=log(abs(Em.disc)); gr=ellglobalred(Em); N=gr[1]; sig=logD/log(N);
  gNA=nonarch_global(Em,Pg); hNA=gNA[1]; la=hh-hNA;
  jj=Em.j; logHj=log(max(abs(numerator(jj)),abs(denominator(jj))));
  print(m," ",n," ",sig," ",hh," ",logD," ",logHj," ",hh/logD," ",hh/logHj," ",gNA[2]," ",gNA[3]," ",hNA," ",la," ",onc);
  return(1);
}

print("m n sigma hat_h logD logHj h/logD h/logHj n_max maxcomp h_NA lambda_inf onc");
\\ broad small-m scan; tight 30s alarm => only fast fibers land.
for(m=2,30, for(n=1,m-1, iferr(alarm(30, proc(m,n)), E_, 0)));
print("EXIT=ok");
quit;
