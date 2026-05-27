\\ P12: every multiplicative (Kodaira I_n) local height lambda_p(P) <= 0 on E_PCP(q).
\\ E_PCP(q): y^2 = x(x+1)(x+q^2). Non-arch Neron local height (Silverman ATAEC VI;
\\ Cremona-Prickett-Siksek): for I_N reduction, lambda_p(P) = -(n_c(N-n_c)/N) log p,
\\ component index n_c in [0, N/2]  => lambda_p <= 0 always. We confirm (a) every bad
\\ prime is multiplicative (v_p(c4)=0, Kodaira I_n) and (b) the resulting range.
test(m,n) = {
  my(q=(m^2-n^2)/(2*m*n));
  my(E=ellminimalmodel(ellinit([0,1+q^2,0,q^2,0])));
  my(D=E.disc, fa=factor(abs(D))[,1], mult_all=1);
  printf("\n=== fiber (m,n)=(%d,%d)  q=%s  Nbad=%d ===\n", m,n,q,#fa);
  for(i=1,#fa, my(p=fa[i], isMult=(valuation(E.c4,p)==0), kod=elllocalred(E,p)[2]);
     printf("  p=%d  v_p(Dmin)=%d  kodaira=%d  v_p(c4)=%d  I_n?=%d  lambda_p in [%.4f,0]\n",
        p, valuation(D,p), kod, valuation(E.c4,p), isMult, -(valuation(D,p)/4.0)*log(p));
     if(!isMult, mult_all=0));
  printf("  --> all bad primes multiplicative (I_n)? %d ; sum_p lambda_p in [-(1/4)log|Dmin|,0]=[%.4f,0]\n",
     mult_all, -log(abs(D))/4.0);
};
test(11,2);
test(8,3);
test(4,3);
