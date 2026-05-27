/* Paper P4 -- script 05  (PARI/GP 2.15.4)
   The negative proposition: there is NO absolute (sigma-free) constant c with
   hath(P) >= c*log|Delta_min| on E_PCP(q). Mechanism: all reduction is I_n
   (multiplicative), so every non-archimedean Neron local height is <= 0; the
   positive height lives entirely in the archimedean term, which is not bounded
   below by log|Delta|. Empirically the floor hath_min/log|Delta_min| is pulled
   DOWN as sigma grows.

   NB: in PARI 2.15, ellrank returns [lower, upper, s, vec_of_points];
   the candidate generators are in field [4].  We saturate via ellisdivisible. */
default(parisize, 9*10^8);
default(parisizemax, 1200000000);

mkEm(m,n) = { my(a=m^2-n^2, b=2*m*n); ellminimalmodel(ellinit([0,a^2+b^2,0,a^2*b^2,0])); }
logD(Em)  = log(abs(Em.disc)*1.0);
sigE(Em)  = log(abs(Em.disc)*1.0)/log(ellglobalred(Em)[1]*1.0);

/* saturate a point by dividing out small prime indices */
saturate(Em,P) = { my(Q=0); for(it=1,40, my(f=0);
  foreach([2,3,5,7,11,13], d, if(ellisdivisible(Em,P,d,&Q), P=Q; f=1; break));
  if(!f, break)); P; }

print("=== all bad reduction is multiplicative (I_n): v_p(c4)=0 at every bad prime ===");
{
  my(MM=120, allmult=1, nf=0);
  for(m=2,MM, for(n=1,m-1,
    if(gcd(m,n)!=1 || (m+n)%2==0, next);
    my(Em=mkEm(m,n), N=ellglobalred(Em)[1], bp=factor(N)[,1]);
    nf++;
    for(i=1,#bp, if(valuation(Em.c4,bp[i])>0, allmult=0));
  ));
  print("  fibers (m<=", MM, ")=", nf, "   all multiplicative (no additive prime) = ", allmult);
  print("  => every non-archimedean local height lambda_p = -n_c(n_p-n_c)/n_p * log p <= 0.");
}

print("");
print("=== floor of hath_min/log|Delta_min| vs sigma (verified generators) ===");
print("  (m,n)   sigma    hath_min   log|Dmin|   ratio   rank[l,u]  hath(2P)=4hath(P)?");
{
  my(fibs = [[4,3],[7,6],[8,3],[10,1],[16,5],[18,7],[22,3],[16,3]]);
  foreach(fibs, f,
    my(m=f[1], n=f[2], Em=mkEm(m,n), s=sigE(Em), Ld=logD(Em));
    my(rr = ellrank(Em));
    if(#rr>=4 && #rr[4]>=1,
       my(hmin=oo, Pmin=0);
       foreach(rr[4], P, my(Q=saturate(Em,P));
          if(ellisoncurve(Em,Q) && !ellorder(Em,Q),
             my(h=ellheight(Em,Q)); if(h<hmin, hmin=h; Pmin=Q)));
       if(hmin<oo,
          my(h2=ellheight(Em,ellmul(Em,Pmin,2)), fe=abs(h2-4*hmin)<1e-6);
          printf("  (%d,%d)  %.4f   %.5f   %.4f   %.5f   [%d,%d]    %d\n",
                 m,n,s,hmin,Ld,hmin/Ld,rr[1],rr[2],fe),
          printf("  (%d,%d)  %.4f   (only torsion among returned points)  [%d,%d]\n",m,n,s,rr[1],rr[2]));
       ,
       printf("  (%d,%d)  %.4f   (no generator returned)  rank>=%d\n",m,n,s,rr[1]));
  );
}

print("");
print("=== sigma-record fiber 256/121: rank 2, smallest verified non-torsion height ===");
{
  my(m=256, n=121, Em=mkEm(m,n), s=sigE(Em), Ld=logD(Em), N=ellglobalred(Em)[1]);
  printf("  sigma=%.4f  log|Dmin|=%.4f  conductor N=%d\n", s, Ld, N);
  my(rr = ellrank(Em));
  printf("  ellrank lower/upper = [%d,%d]\n", rr[1], rr[2]);
  if(#rr>=4 && #rr[4]>=1,
    my(hmin=oo, Pmin=0);
    foreach(rr[4], P, my(Q=saturate(Em,P));
       if(ellisoncurve(Em,Q) && !ellorder(Em,Q),
          my(h=ellheight(Em,Q)); if(h<hmin, hmin=h; Pmin=Q)));
    if(hmin<oo,
       my(h2=ellheight(Em,ellmul(Em,Pmin,2)));
       printf("  smallest verified non-torsion hath = %.6f   ratio hath/log|Dmin| = %.5f\n", hmin, hmin/Ld);
       printf("  functional eq check: hath(2P)=%.6f, 4 hath(P)=%.6f, equal? %d\n", h2, 4*hmin, abs(h2-4*hmin)<1e-6);
    );
  );
}
print("EXIT=ok");
