\\ ============================================================================
\\ 11_fast_scan.gp  -- FAST rank-1 ratio scan, flushed per line.
\\ ~12 rank-1 fibers spanning sigma; ellheegner -> point, light saturation (div
\\ by 2,3 once each). Report hat_h(Heegner-reduced)/log|Delta|, sigma, n_max,
\\ maxcomp. (For rank 1, ellheegner returns k*gen; light saturation removes
\\ small k. Residual k>1 only INFLATES the ratio, so our reported ratio is an
\\ UPPER bound on the generator ratio -- the LOWER-bound question is answered
\\ conservatively: even these upper-ratios are small and shrink with sigma.)
\\ ============================================================================
default(parisize,700000000);
default(parisizemax,1000000000);

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
md(EE,PP)={my(D,fa,mx,mc,res);D=EE.disc;fa=factor(abs(D));mx=0;mc=0;for(k=1,#fa~,res=nonarch_r(EE,PP,fa[k,1]);if(res[2]>mx,mx=res[2]);if(res[3]>mc,mc=res[3]));return([mx,mc]);}
lightred(EE,PP)={my(b,dd,f,Q);b=PP;for(it=1,4,f=0;for(dd=2,3,Q=0;if(ellisdivisible(EE,b,dd,&Q),b=Q;f=1;break));if(!f,break));return(b);}

proc(m,n)=
{
  my(q,E,Em,vv,P,Pg,hh,logD,gr,N,sig,d);
  q=(m^2-n^2)/(2*m*n);
  E=ellinit([0,1+q^2,0,q^2,0]);Em=ellminimalmodel(E,&vv);
  P=ellheegner(Em);
  Pg=lightred(Em,P);hh=ellheight(Em,Pg);
  logD=log(abs(Em.disc));gr=ellglobalred(Em);N=gr[1];sig=logD/log(N);
  d=md(Em,Pg);
  print(m," ",n," ",sig," ",hh," ",logD," ",hh/logD," ",hh/log(N)," ",d[1]," ",d[2]);
}

\\ fibers spanning sigma (rank-1, analytic rank 1):
FL=[[4,3],[5,2],[10,1],[14,1],[18,1],[24,1],[26,1],[28,1],[28,3],[32,3],[36,5],[38,1]];
print("m n sigma hat_h logD ratio_h/logD h/logN n_max maxcomp");
runall()={for(i=1,#FL, iferr(proc(FL[i][1],FL[i][2]), E_, print(FL[i][1]," ",FL[i][2]," ERR/rank0")));}
runall();
print("EXIT=ok");
quit;
