\\ ============================================================================
\\ 02_decompose.gp
\\ EXACT non-archimedean Neron local height for E_PCP(q), verbatim Sage/Cremona
\\ multiplicative branch.  hat-h(P) = lambda_inf(P) + sum_p lambda_p(P).
\\   mult I_N branch: n=min(B, N/2); r = -n*(N-n)/N ; lambda_p = r*log p
\\   = (N*B2(n/N) - N/6) log p,  B2(t)=t^2-t+1/6.
\\ ============================================================================
default(parisize,600000000);
default(parisizemax,1000000000);

B2(t) = t^2 - t + 1/6;

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
  return([rr, NN, AA, BB, CC, valuation(cc4,pp), nn]);
}

run() =
{
  my(fibers,q,Porig,E,Emin,vv,P,hh,D,logD,gr,N,logN,sig,fa,sumnonarch,maxnp,maxcomp,p,res,rr,Np,nn,lam_inf);
  fibers = [[20/21,[4/21,220/441]], [80/39,[32/9,1312/117]], [24/7,[3/28,465/392]], [84/13,[56700/36517,329627340/25160213]], [48/55,[288/55,42336/3025]]];
  print("q : sigma : hat_h : logD : h/logD : logN : h/logN : sumNA : lam_inf : n_max : maxcomp");
  for(i=1,#fibers,
    q = fibers[i][1]; Porig = fibers[i][2];
    E = ellinit([0,1+q^2,0,q^2,0]);
    Emin = ellminimalmodel(E,&vv);
    P = ellchangepoint(Porig, vv);
    if(!ellisoncurve(Emin,P), print(q," : NOT on Emin"); next);
    hh = ellheight(Emin,P);
    D = Emin.disc; logD = log(abs(D));
    gr = ellglobalred(Emin); N = gr[1]; logN = log(N);
    sig = logD/logN;
    fa = factor(N);
    sumnonarch = 0.0; maxnp = 0; maxcomp = 0;
    for(k=1,#fa~,
      p = fa[k,1];
      res = nonarch_r(Emin, P, p);
      rr = res[1]; Np = res[2]; nn = res[7];
      sumnonarch += rr*log(p);
      if(Np>maxnp, maxnp=Np);
      if(nn>maxcomp, maxcomp=nn);
      print("    p=",p," N_p=",Np," A=",res[3]," B=",res[4]," v(c4)=",res[6]," comp=",nn," lam_p=",rr*log(p));
    );
    lam_inf = hh - sumnonarch;
    print("  SUMMARY q=",q,": sig=",sig," h=",hh," logD=",logD," h/logD=",hh/logD," logN=",logN," h/logN=",hh/logN," sumNA=",sumnonarch," lam_inf=",lam_inf," n_max=",maxnp," maxcomp=",maxcomp);
    print("");
  );
}

run();
quit;
