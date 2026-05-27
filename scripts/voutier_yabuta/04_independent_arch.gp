\\ ============================================================================
\\ 04_independent_arch.gp
\\ FULLY INDEPENDENT validation of the non-archimedean local-height formula.
\\ We implement Silverman's archimedean local-height algorithm (ATAEC Thm VI.4.2,
\\ verbatim from Sage ell_point.archimedean_local_height) for the single real
\\ place, then check:
\\     lambda_inf_indep(P) + sumNA(P)  ==  ellheight(Emin,P).
\\ If they match to float precision, our non-arch implementation is CORRECT
\\ (two independent algorithms reconstruct PARI's canonical height).
\\ ============================================================================
default(parisize,600000000);
default(parisizemax,1000000000);

\\ ---- non-arch (Sage/Cremona, minimal model) ----
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
sumNA(EE,PP) =
{
  my(D,fa,s,p,res);
  D = EE.disc; fa = factor(abs(D)); s = 0.0;
  for(k=1,#fa~, p=fa[k,1]; res=nonarch_r(EE,PP,p); s += res[1]*log(p));
  return(s);
}

\\ ---- archimedean local height, Silverman VI.4.2 (Sage algorithm, real place) ----
arch_lh(EE, PP) =
{
  my(b2,b4,b6,b8,xx,H,nterms,b2p,b4p,b6p,b8p,t,beta,lam,mu,f4n,w,z);
  b2=EE.b2*1.0; b4=EE.b4*1.0; b6=EE.b6*1.0; b8=EE.b8*1.0;
  xx = PP[1]*1.0;
  H = vecmax([4.0, abs(b2), 2*abs(b4), 2*abs(b6), abs(b8)]);
  \\ |Delta|>=1 here so adl3=0
  nterms = ceil(0.51*(38*log(10)/log(2)) + 0.5 + 0.75*log(7 + 4*log(H)/3));
  nterms = max(nterms, 80);
  b2p=b2-12; b4p=b4-b2+6; b6p=b6-2*b4+b2-4; b8p=b8-3*b6+3*b4-b2+3;
  if(abs(xx) >= 0.5, t = 1/xx; beta = 1, t = 1/(xx+1); beta = 0);
  lam = -log(abs(t));
  mu = 0.0; f4n = 1.0;
  for(n=1,nterms,
    if(beta,
      w = t*(4 + t*(b2 + t*(2*b4 + t*b6)));
      z = 1 - t^2*(b4 + t*(2*b6 + t*b8));
      if(abs(w) <= 2*abs(z), mu += f4n*log(abs(z)); t = w/z,
         mu += f4n*log(abs(z+w)); t = w/(z+w); beta = !beta);
    ,
      w = t*(4 + t*(b2p + t*(2*b4p + t*b6p)));
      z = 1 - t^2*(b4p + t*(2*b6p + t*b8p));
      if(abs(w) <= 2*abs(z), mu += f4n*log(abs(z)); t = w/z,
         mu += f4n*log(abs(z-w)); t = w/(z-w); beta = !beta);
    );
    f4n = f4n/4;
  );
  return(lam + mu/4);
}

run() =
{
  my(fibers,q,E,Emin,vv,P,hh,la,sNA,recon,resid);
  fibers = [[20/21,[4/21,220/441]], [80/39,[32/9,1312/117]], [24/7,[3/28,465/392]], [84/13,[56700/36517,329627340/25160213]], [48/55,[288/55,42336/3025]]];
  print("INDEPENDENT VALIDATION:  lambda_inf(Silverman VI.4.2) + sumNA == ellheight ?");
  print("q : ellheight : lam_inf_indep : sumNA : reconstruct : residual");
  for(i=1,#fibers,
    q = fibers[i][1];
    E = ellinit([0,1+q^2,0,q^2,0]);
    Emin = ellminimalmodel(E,&vv);
    P = ellchangepoint(fibers[i][2], vv);
    hh = ellheight(Emin,P);
    la = arch_lh(Emin,P);
    sNA = sumNA(Emin,P);
    recon = la + sNA;
    resid = recon - hh;
    print(q,": h=",hh," lam_inf=",la," sumNA=",sNA," recon=",recon," RESID=",resid);
  );
  print("");
  print("If RESID ~ 1e-25 (float noise): the non-arch formula is VALIDATED by two");
  print("independent algorithms both reproducing PARI's canonical height.");
}

run();
quit;
