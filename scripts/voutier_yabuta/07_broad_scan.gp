\\ ============================================================================
\\ 07_broad_scan.gp  (no embedded braces)
\\ Broad scan over rank-1 Pythagorean fibers; compute hat_h(gen)/log|Delta|,
\\ sigma, n_max, max component. See whether ratio degrades with sigma / n_max.
\\ ============================================================================
default(parisize,800000000);
default(parisizemax,1000000000);

nonarch_r(EE,PP,pp) =
{
  my(aa1,aa2,aa3,aa4,bb2,bb4,bb6,bb8,cc4,xx,yy,DD,NN,AA,BB,CC,nn,rr);
  aa1=EE.a1; aa2=EE.a2; aa3=EE.a3; aa4=EE.a4;
  bb2=EE.b2; bb4=EE.b4; bb6=EE.b6; bb8=EE.b8; cc4=EE.c4;
  xx=PP[1]; yy=PP[2];
  DD=EE.disc; NN=valuation(DD,pp);
  AA = valuation(3*xx^2+2*aa2*xx+aa4-aa1*yy, pp);
  BB = valuation(2*yy+aa1*xx+aa3, pp);
  CC = valuation(3*xx^4+bb2*xx^3+3*bb4*xx^2+3*bb6*xx+bb8, pp);
  nn = -1;
  if(AA<=0 || BB<=0, rr = max(0, -valuation(xx,pp)),
     valuation(cc4,pp)==0, nn = min(BB, NN/2); rr = -nn*(NN-nn)/NN,
     CC >= 3*BB, rr = -2*BB/3,
     rr = -CC/4);
  return([rr, NN, nn]);
}
maxcomp_data(EE,PP) =
{
  my(D,fa,maxnp,maxcomp,res);
  D = EE.disc; fa = factor(abs(D)); maxnp=0; maxcomp=0;
  for(k=1,#fa~, res=nonarch_r(EE,PP,fa[k,1]); if(res[2]>maxnp,maxnp=res[2]); if(res[3]>maxcomp,maxcomp=res[3]));
  return([maxnp,maxcomp]);
}
reduce_to_gen(EE,PP) =
{
  my(best,found,dd,L);
  best = PP;
  for(it=1,8,
    found=0;
    for(dd=2,3,
      L = ellisdivisible(EE, best, dd);
      if(L[1] && type(L[2])=="t_VEC" && #L[2]==2, best=L[2]; found=1; break);
    );
    if(!found, break);
  );
  return(best);
}

\\ process one fiber; return [m,n,q,sigma,hh,logD,ratio,h/logN,n_max,maxcomp] or 0
process_fiber(m,n) =
{
  my(q,E,Emin,vv,P,Pg,hh,logD,gr,N,logN,sig,md);
  q = (m^2-n^2)/(2*m*n);
  E = ellinit([0,1+q^2,0,q^2,0]);
  Emin = ellminimalmodel(E,&vv);
  P = ellheegner(Emin);
  if(P==[0], return(0));
  Pg = reduce_to_gen(Emin, P);
  hh = ellheight(Emin, Pg);
  if(hh < 0.001, return(0));
  logD = log(abs(Emin.disc));
  gr = ellglobalred(Emin); N=gr[1]; logN=log(N); sig=logD/logN;
  md = maxcomp_data(Emin, Pg);
  return([m,n,q,sig,hh,logD,hh/logD,hh/logN,md[1],md[2]]);
}

run(MMAX) =
{
  my(cnt,r,results,rmin,rmax,smin,smax,rNmin,rNmax,smin_at,rmin_at);
  print("m n q sigma hat_h_gen logD ratio_h/logD h/logN n_max maxcomp");
  results = List();
  for(m=2,MMAX,
    for(n=1,m-1,
      if(gcd(m,n)!=1, next);
      if((m+n)%2==0, next);
      r = 0;
      iferr(r = process_fiber(m,n), ERRH, r = 0);
      if(r!=0,
        print(r[1]," ",r[2]," ",r[3]," ",r[4]," ",r[5]," ",r[6]," ",r[7]," ",r[8]," ",r[9]," ",r[10]);
        listput(results, r);
      );
    );
  );
  print("");
  print("#rank1-fibers-found = ", #results);
  if(#results>0,
    rmin=1e9; rmax=-1e9; smin=1e9; smax=-1e9; rNmin=1e9; rNmax=-1e9;
    for(j=1,#results,
      if(results[j][7]<rmin, rmin=results[j][7]; rmin_at=results[j]);
      if(results[j][7]>rmax, rmax=results[j][7]);
      if(results[j][4]<smin, smin=results[j][4]);
      if(results[j][4]>smax, smax=results[j][4]; smin_at=results[j]);
      if(results[j][8]<rNmin, rNmin=results[j][8]);
      if(results[j][8]>rNmax, rNmax=results[j][8]);
    );
    print("ratio h/logD: min=",rmin," max=",rmax);
    print("  min-ratio fiber: ",rmin_at);
    print("ratio h/logN: min=",rNmin," max=",rNmax);
    print("sigma range: ",smin," .. ",smax);
    print("  max-sigma fiber: ",smin_at);
  );
}

run(80);
quit;
