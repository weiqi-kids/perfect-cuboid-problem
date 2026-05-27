\\ ============================================================================
\\ 05_full_decomp.gp  -- CORRECTED full non-archimedean global height.
\\ Sage non_archimedean_local_height global assembly (QQ, minimal model since
\\ all our e=v_p(D)<12 ... but e can be >=12! handle both):
\\   c = (x==0 ? 1 : denominator(x))
\\   h_NA = log(c)
\\          + sum_{p|D, p does NOT divide c}  lambda_p(weighted, is_minimal=(e<12))
\\          + sum_{p|D, e>=12 and p|c} ( lambda_p(weighted) - v_p(c) log p )
\\ For E_PCP, e=v_p(Delta_min)<12 for ALL bad primes EXCEPT possibly p=2,3 where
\\ n_p can reach >=12 (e.g. n_2=28). We pass is_minimal accordingly; but Emin
\\ IS the global minimal model so is_minimal=true and offset=0 for ALL p.
\\ Hence the simplest CORRECT global formula on the GLOBAL minimal model is:
\\   h_NA = log(c) + sum_{p|D, p∤c} lambda_p  + sum_{p|D, p|c}(lambda_p - v_p(c)logp)
\\        = log(c) + sum_{p|D} lambda_p - sum_{p|D,p|c} v_p(c) log p .
\\ Since c only has GOOD primes in our cases (x-denominator coprime to D), this
\\ reduces to  h_NA = log(c) + sum_{p|D} lambda_p .  We implement the general one.
\\
\\ Then validate:  h_NA + arch_lh == ellheight.
\\ Then TABULATE: hat_h, log|Delta|, ratio, sigma, n_max, max component j.
\\ ============================================================================
default(parisize,600000000);
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

\\ full global non-arch on GLOBAL minimal model EE (is_minimal=true everywhere)
\\ returns [h_NA, n_max, maxcomp]
nonarch_global(EE,PP) =
{
  my(D,fa,c,h,maxnp,maxcomp,p,e,res,vc);
  D = EE.disc; fa = factor(abs(D));
  c = if(PP[1]==0, 1, denominator(PP[1]));
  h = log(c); maxnp = 0; maxcomp = 0;
  for(k=1,#fa~,
    p = fa[k,1]; e = fa[k,2];
    res = nonarch_r(EE,PP,p);
    if(res[2]>maxnp, maxnp=res[2]);
    if(res[3]>maxcomp, maxcomp=res[3]);
    vc = valuation(c,p);
    \\ on global minimal model: always add lambda_p; subtract v_p(c) log p when p|c
    h += res[1]*log(p) - vc*log(p);
  );
  return([h, maxnp, maxcomp]);
}

arch_lh(EE, PP) =
{
  my(b2,b4,b6,b8,xx,b2p,b4p,b6p,b8p,t,beta,lam,mu,f4n,w,z);
  b2=EE.b2*1.0; b4=EE.b4*1.0; b6=EE.b6*1.0; b8=EE.b8*1.0;
  xx = PP[1]*1.0;
  b2p=b2-12; b4p=b4-b2+6; b6p=b6-2*b4+b2-4; b8p=b8-3*b6+3*b4-b2+3;
  if(abs(xx) >= 0.5, t = 1/xx; beta = 1, t = 1/(xx+1); beta = 0);
  lam = -log(abs(t)); mu = 0.0; f4n = 1.0;
  for(n=1,200,
    if(beta,
      w = t*(4 + t*(b2 + t*(2*b4 + t*b6))); z = 1 - t^2*(b4 + t*(2*b6 + t*b8));
      if(abs(w) <= 2*abs(z), mu += f4n*log(abs(z)); t = w/z, mu += f4n*log(abs(z+w)); t = w/(z+w); beta = !beta),
      w = t*(4 + t*(b2p + t*(2*b4p + t*b6p))); z = 1 - t^2*(b4p + t*(2*b6p + t*b8p));
      if(abs(w) <= 2*abs(z), mu += f4n*log(abs(z)); t = w/z, mu += f4n*log(abs(z-w)); t = w/(z-w); beta = !beta));
    f4n = f4n/4);
  return(lam + mu/4);
}

run() =
{
  my(fibers,q,E,Emin,vv,P,hh,gNA,hNA,la,recon,resid,logD,gr,N,logN,sig);
  fibers = [[20/21,[4/21,220/441]], [80/39,[32/9,1312/117]], [24/7,[3/28,465/392]], [84/13,[56700/36517,329627340/25160213]], [48/55,[288/55,42336/3025]]];
  print("=== VALIDATION (full global non-arch + independent arch == ellheight) ===");
  for(i=1,#fibers,
    q=fibers[i][1]; E=ellinit([0,1+q^2,0,q^2,0]); Emin=ellminimalmodel(E,&vv);
    P=ellchangepoint(fibers[i][2], vv);
    hh=ellheight(Emin,P);
    gNA=nonarch_global(Emin,P); hNA=gNA[1]; la=arch_lh(Emin,P);
    recon=hNA+la; resid=recon-hh;
    print("q=",q," h=",hh," h_NA=",hNA," arch=",la," recon=",recon," RESID=",resid);
  );
  print("");
  print("=== RATIO TABLE: hat_h / log|Delta_min| vs sigma ===");
  print("q | sigma | hat_h | log|Delta| | hat_h/log|D| | hat_h/logN | n_max | maxcomp | h_NA | arch");
  for(i=1,#fibers,
    q=fibers[i][1]; E=ellinit([0,1+q^2,0,q^2,0]); Emin=ellminimalmodel(E,&vv);
    P=ellchangepoint(fibers[i][2], vv);
    hh=ellheight(Emin,P);
    logD=log(abs(Emin.disc)); gr=ellglobalred(Emin); N=gr[1]; logN=log(N); sig=logD/logN;
    gNA=nonarch_global(Emin,P); hNA=gNA[1]; la=arch_lh(Emin,P);
    print(q," | ",sig," | ",hh," | ",logD," | ",hh/logD," | ",hh/logN," | ",gNA[2]," | ",gNA[3]," | ",hNA," | ",la);
  );
}

run();
quit;
