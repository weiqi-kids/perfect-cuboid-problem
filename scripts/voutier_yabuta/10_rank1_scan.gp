\\ ============================================================================
\\ 10_rank1_scan.gp
\\ Efficient scan: only KNOWN rank-1 fibers (analytic rank 1 from rank_survey).
\\ For each, ellheegner -> generator (reduced), compute hat_h/log|Delta|, sigma,
\\ n_max, maxcomp.  Output direct to file (no pipe), flushed per line.
\\ Goal: trend of ratio hat_h/log|Delta| vs sigma and n_max.
\\ ============================================================================
default(parisize,800000000);
default(parisizemax,1000000000);

nonarch_r(EE,PP,pp) =
{
  my(aa1,aa2,aa3,aa4,bb2,bb4,bb6,bb8,cc4,xx,yy,DD,NN,AA,BB,CC,nn,rr);
  aa1=EE.a1; aa2=EE.a2; aa3=EE.a3; aa4=EE.a4;
  bb2=EE.b2; bb4=EE.b4; bb6=EE.b6; bb8=EE.b8; cc4=EE.c4;
  xx=PP[1]; yy=PP[2]; DD=EE.disc; NN=valuation(DD,pp);
  AA=valuation(3*xx^2+2*aa2*xx+aa4-aa1*yy,pp);
  BB=valuation(2*yy+aa1*xx+aa3,pp);
  CC=valuation(3*xx^4+bb2*xx^3+3*bb4*xx^2+3*bb6*xx+bb8,pp);
  nn=-1;
  if(AA<=0||BB<=0, rr=max(0,-valuation(xx,pp)),
     valuation(cc4,pp)==0, nn=min(BB,NN/2); rr=-nn*(NN-nn)/NN,
     CC>=3*BB, rr=-2*BB/3, rr=-CC/4);
  return([rr,NN,nn]);
}
md(EE,PP)={my(D,fa,mx,mc,res);D=EE.disc;fa=factor(abs(D));mx=0;mc=0;for(k=1,#fa~,res=nonarch_r(EE,PP,fa[k,1]);if(res[2]>mx,mx=res[2]);if(res[3]>mc,mc=res[3]));return([mx,mc]);}
red(EE,PP)={my(b,f,d,L);b=PP;for(it=1,8,f=0;for(d=2,3,L=ellisdivisible(EE,b,d);if(L[1]&&type(L[2])=="t_VEC"&&#L[2]==2,b=L[2];f=1;break));if(!f,break));return(b);}

proc(m,n)=
{
  my(q,E,Em,vv,P,Pg,hh,logD,gr,N,sig,d);
  q=(m^2-n^2)/(2*m*n); E=ellinit([0,1+q^2,0,q^2,0]); Em=ellminimalmodel(E,&vv);
  P=ellheegner(Em); if(P==[0],return(0));
  Pg=red(Em,P); hh=ellheight(Em,Pg); if(hh<0.001,return(0));
  logD=log(abs(Em.disc)); gr=ellglobalred(Em); N=gr[1]; sig=logD/log(N);
  d=md(Em,Pg);
  return([m,n,sig,hh,logD,hh/logD,hh/log(N),d[1],d[2]]);
}

run()=
{
  my(L,r,res,smin,smax,rmin,rmax,rmin_at,smax_at,sumr,cnt);
  \\ rank-1 fibers (analytic rank 1), m<=38, from rank_survey_m60
  L=[[4,3],[5,2],[7,6],[8,3],[8,5],[10,1],[10,3],[11,2],[11,6],[11,8],[12,7],[13,8],[13,10],[14,1],[14,3],[14,5],[15,4],[15,8],[16,3],[16,5],[16,11],[16,13],[17,8],[17,10],[18,1],[19,2],[19,4],[20,3],[21,2],[21,8],[22,3],[23,2],[24,1],[25,2],[26,1],[26,5],[28,1],[28,3],[28,5],[29,2],[30,7],[31,4],[32,3],[32,7],[33,4],[34,3],[35,2],[36,5],[37,2],[38,1]];
  print("m n sigma hat_h logD ratio_h/logD h/logN n_max maxcomp");
  res=List(); smin=9; smax=0; rmin=9; rmax=0; sumr=0.0; cnt=0;
  for(i=1,#L,
    r=0; iferr(r=proc(L[i][1],L[i][2]), E_, r=0);
    if(r!=0,
      print(r[1]," ",r[2]," ",r[3]," ",r[4]," ",r[5]," ",r[6]," ",r[7]," ",r[8]," ",r[9]);
      listput(res,r); cnt++; sumr+=r[6];
      if(r[3]<smin,smin=r[3]); if(r[3]>smax,smax=r[3];smax_at=r);
      if(r[6]<rmin,rmin=r[6];rmin_at=r); if(r[6]>rmax,rmax=r[6]);
    );
  );
  print("");
  print("N_rank1=",cnt);
  print("ratio h/logD: min=",rmin," max=",rmax," mean=",if(cnt>0,sumr/cnt,0));
  print("  MIN-ratio fiber [m,n,sig,h,logD,ratio,h/logN,nmax,comp]=",rmin_at);
  print("sigma range=",smin," .. ",smax);
  print("  MAX-sigma fiber=",smax_at);
}
run();
print("EXIT=ok");
quit;
