/* OQ1 control: GENERIC rank-1 Pythagorean fibers across a conductor range.
 * The rank-jump/rank-4 fibers may be biased toward large hhat. To test whether
 * R = hhat/logHj stays bounded below across the *generic* family, sweep ordinary
 * primitive Pythagorean (m,n) with small n, take those with rank exactly 1, and
 * record hhat of the (single) generator. Pick the smallest-height generator.
 *
 * We sweep a deterministic set of small (m,n) and only print rank-1 fibers.
 */
default(parisize, 800000000);
\p 30

face3(q, P) = {my(X,Y,den,c,F3); X=P[1];Y=P[2];den=q^2-X^2; if(den==0,return(-1)); c=2*q*Y/den; F3=c^2+1+q^2; issquare(F3);}
Eofq(q) = ellinit([0, 1+q^2, 0, q^2, 0]);

emit(m, n) = {
  my(q, E, N, Hj, logHj, logN, rk, P, hh, R1, R2, f3);
  if(gcd(m,n) != 1, return(0));
  if((m+n) % 2 == 0, return(0));   /* opposite parity for primitive */
  q = (m^2 - n^2)/(2*m*n);
  E = Eofq(q);
  rk = ellrank(E, 2);
  if(rk[1] != 1 || rk[2] != 1, return(0));   /* only clean rank-1 */
  if(#rk[4] < 1, return(0));
  P = rk[4][1];
  if(!ellisoncurve(E, P), return(0));
  N = ellglobalred(E)[1];
  Hj = max(abs(numerator(E.j)), abs(denominator(E.j)));
  logHj = log(Hj*1.0); logN = log(N*1.0);
  hh = ellheight(E, P);
  R1 = hh/logHj; R2 = hh/logN;
  f3 = face3(q, P);
  if(f3 == 1, print("  *** PCP CANDIDATE (m,n)=(",m,",",n,") F3 SQUARE ***"));
  print("GEN_RESULT (",m,",",n,") q=",q," logN=",logN," logHj=",logHj," hhat=",hh," R1=",R1," R2=",R2," F3sq=",f3);
  0;
}

print("#### OQ1 control: generic rank-1 fibers ####");
{
  my(cnt = 0);
  for(m = 2, 80,
    for(n = 1, m-1,
      if(emit(m, n) == 0,);
    );
  );
}
quit;
