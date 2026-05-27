\\ ============================================================================
\\ 08_identity_component.gp
\\ THE IDENTITY-COMPONENT OBSTACLE (theoretical §3), made explicit & numeric.
\\
\\ Validated formula: at a bad (mult I_N) prime, with component index
\\   n_comp = min(component, N/2) in [0, N/2],   N = v_p(Delta),
\\   lambda_p(P) = -[ n_comp (N - n_comp) / N ] * log p.
\\ Extremes:
\\   n_comp = 0      => lambda_p = 0                 (IDENTITY component)
\\   n_comp = N/2    => lambda_p = -(N/4) log p       (DEEPEST component)
\\ Summing over bad primes:
\\   sum_p lambda_p in [ -(1/4) sum_p N_p log p , 0 ]  =  [ -(1/4) log|Delta| , 0 ]
\\ (the global denominator term log(c) is >=0 and small for good-prime denoms).
\\
\\ Consequence for hat_h = lambda_inf + h_NA:
\\   * If P is on the identity comp at every prime: h_NA ~ 0, so hat_h ~ lambda_inf.
\\     The non-arch sum gives NO positive lower bound; hat_h must come from arch.
\\   * If P is deep everywhere: h_NA ~ -(1/4) log|Delta|, so lambda_inf >= hat_h + (1/4)log|Delta|.
\\
\\ THEREFORE the non-archimedean local heights can be ZERO or NEGATIVE; they do
\\ NOT by themselves force hat_h >= c log|Delta|. Any positive lower bound on
\\ hat_h/log|Delta| with an ABSOLUTE constant must come from the ARCHIMEDEAN term
\\ controlling lambda_inf - it cannot come from the I_N structure alone.
\\
\\ This script confirms numerically: for the validated fibers, what fraction of
\\ -(1/4)log|Delta| does the actual h_NA realize, and how close to the identity
\\ component the generators sit (maxcomp vs N/2).
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

analyze(EE,PP) =
{
  my(D,fa,hNA,deepest,p,res,c);
  D = EE.disc; fa = factor(abs(D));
  c = if(PP[1]==0,1,denominator(PP[1]));
  hNA = log(c); deepest = 0.0;
  for(k=1,#fa~,
    p=fa[k,1]; res=nonarch_r(EE,PP,p);
    hNA += res[1]*log(p) - valuation(c,p)*log(p);
    deepest += -(res[2]/4)*log(p);   \\ most-negative possible at this prime
  );
  return([hNA, deepest]);  \\ deepest = -(1/4)log|Delta|
}

run() =
{
  my(fibers,q,E,Emin,vv,P,hNA,deepest,logD,frac);
  fibers = [[20/21,[4/21,220/441]], [80/39,[32/9,1312/117]], [24/7,[3/28,465/392]], [84/13,[56700/36517,329627340/25160213]], [48/55,[288/55,42336/3025]]];
  print("q | h_NA(actual) | -(1/4)log|D|(deepest) | log|D| | h_NA/log|D| | frac_of_deepest");
  for(i=1,#fibers,
    q=fibers[i][1]; E=ellinit([0,1+q^2,0,q^2,0]); Emin=ellminimalmodel(E,&vv);
    P=ellchangepoint(fibers[i][2], vv);
    a=analyze(Emin,P); hNA=a[1]; deepest=a[2];
    logD=log(abs(Emin.disc));
    frac = hNA/deepest;  \\ what fraction of the most-negative the point realizes
    print(q," | ",hNA," | ",deepest," | ",logD," | ",hNA/logD," | ",frac);
  );
  print("");
  print("Interpretation: h_NA/log|D| ranges over [-1/4, ~0]. The non-arch part is");
  print("NEGATIVE or near-zero -> it gives NO positive lower bound on hat_h.");
  print("The positive height lower bound MUST come from lambda_inf (archimedean).");
}
run();
quit;
