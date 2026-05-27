default(parisize,700000000);
default(parisizemax,1000000000);
\\ ============================================================================
\\ 06_rootno_crosstab.gp -- INDEPENDENCE of {sigma large} from the rank-jump locus R.
\\ R = { fibers with global root number w(E_q) = -1 } (BSD => odd analytic rank => rank>=1;
\\ the "rank-jump" locus where PCP points could live). Membership via ellrootno.
\\ Cross-tabulate sigma>sigma0 vs (w=-1). Confirm:
\\   density({sigma>sigma0} | R) -> 0   (sigma-large is density-0 WITHIN R too)
\\   and roughly  P(sigma>sigma0 & R) ~ P(sigma>sigma0)*P(R)  (independence).
\\ ============================================================================
run(MMAX, sigma0)=
{
  my(cnt=0, Rcnt=0);          \\ total, and #{w=-1}
  my(big=0, bigR=0);          \\ #{sigma>sigma0}, #{sigma>sigma0 & w=-1}
  for(m=2,MMAX,
    for(n=1,m-1,
      if(gcd(m,n)==1 && (m+n)%2==1,
        my(a=m^2-n^2,b=2*m*n);
        my(E=ellminimalmodel(ellinit([0,a^2+b^2,0,a^2*b^2,0])));
        my(Dmin=abs(E.disc), N=ellglobalred(E)[1]);
        my(sig=log(Dmin*1.0)/log(N*1.0));
        my(w=ellrootno(E));
        cnt++;
        my(inR = (w==-1));
        if(inR, Rcnt++);
        if(sig>sigma0+1e-12, big++; if(inR, bigR++));
      )
    )
  );
  print("--- MMAX=",MMAX,"  sigma0=",sigma0," ---");
  print("  total fibers = ",cnt);
  print("  P(R) = P(w=-1) = ",Rcnt*1.0/cnt,"   (rank-jump locus density)");
  print("  P(sigma>sigma0) = ",big*1.0/cnt);
  print("  P(sigma>sigma0 & R) = ",bigR*1.0/cnt);
  if(Rcnt>0, print("  P(sigma>sigma0 | R) = ",bigR*1.0/Rcnt,"   <-- KEY: density of sigma-large WITHIN R"));
  if(big>0, print("  P(R | sigma>sigma0) = ",bigR*1.0/big));
  \\ independence ratio: P(big&R)/(P(big)*P(R)); ~1 means independent
  if(big>0 && Rcnt>0,
    my(indep = (bigR*1.0/cnt)/((big*1.0/cnt)*(Rcnt*1.0/cnt)));
    print("  independence ratio P(big&R)/(P(big)P(R)) = ",indep,"   (~1 = independent)")
  );
  print("");
}
\\ sigma0 = 4.0 is the squarefree-bound threshold; {sigma>4} is the residual exceptional set.
run(150, 4.0);
run(400, 4.0);
\\ also a lower threshold to get more sigma-large fibers for statistics
run(400, 3.5);
print("EXIT=ok");
quit;
