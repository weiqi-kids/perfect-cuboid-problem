\\ ============================================================================
\\ 09_highsigma.gp
\\ Targeted high-sigma / high-n_max fibers: check whether hat_h/log|Delta|
\\ degrades (drops) as sigma and n_max grow.  We try a set of fibers known to
\\ have larger sigma or large 2-power in b (large n_2). For each, attempt to
\\ find a generator via ellheegner (rank-1) and report the ratio. If rank 0 or
\\ Heegner fails, report sigma/n_max only (no point).
\\ ============================================================================
default(parisize,900000000);
default(parisizemax,1000000000);

nonarch_r(EE,PP,pp) =
{
  my(aa1,aa2,aa3,aa4,bb2,bb4,bb6,bb8,cc4,xx,yy,DD,NN,AA,BB,CC,nn,rr);
  aa1=EE.a1; aa2=EE.a2; aa3=EE.a3; aa4=EE.a4;
  bb2=EE.b2; bb4=EE.b4; bb6=EE.b6; bb8=EE.b8; cc4=EE.c4;
  xx=PP[1]; yy=PP[2]; DD=EE.disc; NN=valuation(DD,pp);
  AA = valuation(3*xx^2+2*aa2*xx+aa4-aa1*yy, pp);
  BB = valuation(2*yy+aa1*xx+aa3, pp);
  CC = valuation(3*xx^4+bb2*xx^3+3*bb4*xx^2+3*bb6*xx+bb8, pp);
  nn=-1;
  if(AA<=0 || BB<=0, rr=max(0,-valuation(xx,pp)),
     valuation(cc4,pp)==0, nn=min(BB,NN/2); rr=-nn*(NN-nn)/NN,
     CC>=3*BB, rr=-2*BB/3, rr=-CC/4);
  return([rr,NN,nn]);
}
maxnp_of(EE) = { my(D,fa,mx); D=EE.disc; fa=factor(abs(D)); mx=0; for(k=1,#fa~, if(fa[k,2]>mx,mx=fa[k,2])); return(mx); }
maxcomp_of(EE,PP) = { my(D,fa,mc,res); D=EE.disc; fa=factor(abs(D)); mc=0; for(k=1,#fa~, res=nonarch_r(EE,PP,fa[k,1]); if(res[3]>mc,mc=res[3])); return(mc); }
reduce_to_gen(EE,PP) = { my(best,found,dd,L); best=PP; for(it=1,8, found=0; for(dd=2,3, L=ellisdivisible(EE,best,dd); if(L[1]&&type(L[2])=="t_VEC"&&#L[2]==2, best=L[2]; found=1; break)); if(!found,break)); return(best); }

probe(m,n) =
{
  my(q,E,Emin,vv,logD,gr,N,logN,sig,np,P,Pg,hh,mc);
  q=(m^2-n^2)/(2*m*n); E=ellinit([0,1+q^2,0,q^2,0]); Emin=ellminimalmodel(E,&vv);
  logD=log(abs(Emin.disc)); gr=ellglobalred(Emin); N=gr[1]; logN=log(N); sig=logD/logN; np=maxnp_of(Emin);
  P=ellheegner(Emin);
  if(P==[0], print("  (m,n)=(",m,",",n,") q=",q," sig=",sig," n_max=",np," logD=",logD," -- Heegner=O (rank0/even)"); return(0));
  Pg=reduce_to_gen(Emin,P); hh=ellheight(Emin,Pg);
  if(hh<0.001, print("  (m,n)=(",m,",",n,") sig=",sig," n_max=",np," -- torsion"); return(0));
  mc=maxcomp_of(Emin,Pg);
  print("  (m,n)=(",m,",",n,") q=",q," sig=",sig," n_max=",np," logD=",logD," hat_h=",hh," ratio_h/logD=",hh/logD," h/logN=",hh/logN," maxcomp=",mc);
  return([sig,hh/logD,hh/logN,np]);
}

run() =
{
  my(targets);
  \\ high-sigma / high-n_max candidates: large 2-power in b=2mn (m or n even-heavy)
  \\ and a few mid ones for trend. (m,n) coprime, m+n odd.
  targets = [[8,1],[16,1],[32,1],[64,1],[128,1],[56,25],[256,121],[122,121],[64,21],[96,5],[100,3],[80,39],[48,55],[84,13]];
  print("High-sigma / high-n_max probe (ratio vs sigma, n_max):");
  for(i=1,#targets,
    iferr(probe(targets[i][1],targets[i][2]), E_, print("  (",targets[i][1],",",targets[i][2],") ERR ",E_));
  );
}
run();
quit;
