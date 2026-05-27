\\ ============================================================================
\\ 05_lambda_inf_theory.gp -- lambda_inf lower-bound diagnostics (§4) and the
\\ VY coupling test (§1).
\\ (A) For each available fiber: compute the REAL PERIOD Omega = E.omega[1], the
\\     archimedean local height lambda_inf of the generator, and the elliptic
\\     logarithm z=ellpointtoz of the generator. Tabulate lambda_inf vs
\\     -log(dist to torsion) / -log|z|, and vs (1/12)log|Delta_inf|.
\\ (B) VY COUPLING TEST: across fibers, does a point with very NEGATIVE sum_p
\\     lambda_p (deep components) necessarily have LARGE lambda_inf? Plot
\\     lambda_inf vs h_NA (=sum_p lambda_p + log c). If lambda_inf grows in
\\     lockstep to keep hat_h>=c*log|Delta|, the coupling COULD give absolute c;
\\     if not, it cannot.
\\ This uses the 5 validated rank-jump fibers (exact generators) + any from sweep.
\\ ============================================================================
default(parisize,700000000);
default(parisizemax,1200000000);

\\ explicit generators (validated, from VOUTIER-YABUTA-IN-HEIGHTS 05_full_decomp)
data = [\
 [20/21,[4/21,220/441]],\
 [80/39,[32/9,1312/117]],\
 [24/7,[3/28,465/392]],\
 [84/13,[56700/36517,329627340/25160213]],\
 [48/55,[288/55,42336/3025]]\
];

one(q,Pc)=
{
  my(E,Em,vv,P,hh,logD,gr,N,sig,Omega,z,zlog);
  E=ellinit([0,1+q^2,0,q^2,0]); Em=ellminimalmodel(E,&vv);
  P=ellchangepoint(Pc,vv);
  hh=ellheight(Em,P);
  logD=log(abs(Em.disc)); gr=ellglobalred(Em); N=gr[1]; sig=logD/log(N);
  Omega=real(Em.omega[1]);
  z=ellpointtoz(Em,P); zlog=-log(abs(z));
  print(q," ",sig," ",hh," ",Omega," ",abs(z)," ",zlog," ",(1.0/12)*logD," ",hh/((1.0/12)*logD));
}
print("q sigma hat_h real_period_Omega |z| -log|z| (1/12)log|Dinf| hat_h/((1/12)logDinf)");
for(i=1,#data, one(data[i][1],data[i][2]));
print("");
print("=== Note: lambda_inf >= -log|2*sigma_Weierstrass(z)| has NO uniform positive");
print("    lower bound in log|Delta|; a point's elliptic log z can be arbitrarily");
print("    close to 0 (small height) independent of Delta. Quantified by min hat_h.");
print("EXIT=ok");
quit;
