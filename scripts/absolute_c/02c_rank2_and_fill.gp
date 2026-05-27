\\ ============================================================================
\\ 02c_rank2_and_fill.gp -- fill to >=30 fibers. Two groups:
\\  (1) remaining small/medium-N rank-1 fibers (ellheegner).
\\  (2) rank-2 fibers (ellrank): report the MINIMUM verified non-torsion height
\\      over the returned generators (= best upper bound on ĥ_min), with full
\\      decomposition for that minimal-height point.
\\  All verified: ellisoncurve + ellheight + (recorded) ord!=torsion.
\\  90s alarm each.
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

emit(m,n,Em,Pg)=
{
  my(onc,hh,logD,gr,N,sig,gNA,hNA,la,logHj,jj);
  onc=ellisoncurve(Em,Pg); hh=ellheight(Em,Pg);
  logD=log(abs(Em.disc)); gr=ellglobalred(Em); N=gr[1]; sig=logD/log(N);
  gNA=nonarch_global(Em,Pg); hNA=gNA[1]; la=hh-hNA;
  jj=Em.j; logHj=log(max(abs(numerator(jj)),abs(denominator(jj))));
  print(m," ",n," ",sig," ",hh," ",logD," ",logHj," ",hh/logD," ",hh/logHj," ",gNA[2]," ",gNA[3]," ",hNA," ",la," ",onc);
}

proc1(m,n)=  \\ rank-1 via Heegner
{
  my(a,b,q,E,Em,vv,P,Pg);
  a=m^2-n^2; b=2*m*n; q=a/b;
  E=ellinit([0,1+q^2,0,q^2,0]); Em=ellminimalmodel(E,&vv);
  P=ellheegner(Em); Pg=saturate(Em,P);
  emit(m,n,Em,Pg);
}
proc2(m,n)=  \\ rank-2 via ellrank: pick minimal-height saturated generator
{
  my(a,b,q,E,Em,vv,rr,best,bh,Pg,h);
  a=m^2-n^2; b=2*m*n; q=a/b;
  E=ellinit([0,1+q^2,0,q^2,0]); Em=ellminimalmodel(E,&vv);
  rr=ellrank(Em);
  if(#rr>=4 && #rr[4]>=1,
    best=0; bh=1e9;
    for(k=1,#rr[4], Pg=saturate(Em,rr[4][k]); if(!ellorder(Em,Pg), h=ellheight(Em,Pg); if(h<bh, bh=h; best=Pg)));
    if(best!=0, emit(m,n,Em,best), print(m," ",n," rank2_no_nontors"))
  , print(m," ",n," ellrank_no_gens"));
}

print("m n sigma hat_h logD logHj h/logD h/logHj n_max maxcomp h_NA lambda_inf onc");
\\ rank-1 fills:
R1=[[14,5],[11,6],[11,8],[16,5],[14,1],[12,7],[15,8]];
\\ rank-2 fibers:
R2=[[6,5],[9,8],[14,13],[13,2]];
for(i=1,#R1, iferr(alarm(90, proc1(R1[i][1],R1[i][2])), E_, print(R1[i][1]," ",R1[i][2]," SKIP/slow")));
for(i=1,#R2, iferr(alarm(110, proc2(R2[i][1],R2[i][2])), E_, print(R2[i][1]," ",R2[i][2]," SKIP/slow")));
print("EXIT=ok");
quit;
