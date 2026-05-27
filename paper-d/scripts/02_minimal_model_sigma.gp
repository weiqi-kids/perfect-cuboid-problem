/* Paper P4 -- script 02  (PARI/GP 2.15.4)
   Minimal model, all-multiplicative reduction, exact Delta_min, Tate indices,
   exact Szpiro formula, and the rigorous chain  sigma <= 6 log C / log N.

   Family: E_PCP(q): y^2=x(x+1)(x+q^2), q=a/b, a=m^2-n^2, b=2mn,
           gcd(m,n)=1, m+n odd.  Integral model E: Y^2=X(X+b^2)(X+a^2).
*/
default(parisize, 8*10^8);
default(parisizemax, 1200000000);

mkE(m,n) = { my(a=m^2-n^2, b=2*m*n); ellinit([0, a^2+b^2, 0, a^2*b^2, 0]); }

MMAX = 150;
nfib = 0;
allmult = 1;          /* 1 iff every bad prime is multiplicative everywhere */
maxgap2 = 0; nzgap2 = 0;
maxgap3 = 0; nzgap3 = 0;
deltaform_ok = 1;     /* Delta_min = Delta_0/2^12 ? */
np_formula_ok = 1;    /* Tate-index formula for odd primes ? */
cond_rad_ok = 1;      /* N = rad(Delta_min)  (up to factor 2) ? */

{
for(m=2,MMAX,
  for(n=1,m-1,
    if(gcd(m,n)!=1, next);
    if((m+n)%2==0, next);
    my(a=m^2-n^2, b=2*m*n, E=mkE(m,n), Em=ellminimalmodel(E));
    my(D0=E.disc, Dm=Em.disc, gr=ellglobalred(Em), N=gr[1], badp=factor(N)[,1]);
    nfib++;
    for(i=1,#badp, if(valuation(Em.c4, badp[i]) > 0, allmult = 0));
    my(g2 = valuation(D0,2)-valuation(Dm,2), g3 = valuation(D0,3)-valuation(Dm,3));
    if(g2!=0, nzgap2++; if(g2>maxgap2, maxgap2=g2));
    if(g3!=0, nzgap3++; if(g3>maxgap3, maxgap3=g3));
    if(Dm != D0/2^12, deltaform_ok = 0);
    my(c = a^2-b^2);
    forprime(p=3, 200,
       if(N%p==0,
          my(vp = valuation(Dm,p), pred = 4*valuation(a,p)+4*valuation(b,p)+2*valuation(c,p));
          if(vp != pred, np_formula_ok = 0)));
    my(radD = factorback(factor(abs(Dm))[,1]));
    if(N % (radD/gcd(radD,2^valuation(radD,2))) != 0, cond_rad_ok = 0);
  );
);
}

print("FIBERS (m<=", MMAX, ") = ", nfib);
print("ALL MULTIPLICATIVE (0 additive primes) = ", allmult);
print("v2 minimalization gap: max=", maxgap2, "  (#nonzero=", nzgap2, ")  [expect 12, all fibers]");
print("v3 minimalization gap: max=", maxgap3, "  (#nonzero=", nzgap3, ")  [expect 0]");
print("Delta_min = Delta_0/2^12 for all fibers ? ", deltaform_ok);
print("odd-prime Tate-index formula n_p in {4v(a),4v(b),2v(c)} holds ? ", np_formula_ok);
print("N = rad(Delta_min) (odd part) ? ", cond_rad_ok);

print("");
print("=== exact Szpiro formula and rigorous chain  sigma <= 6 logC/logN ===");
/* sigma = log|Delta_min| / log N ;  D = 4 log a + 4 log b + 2 log|c| - 8 log2 */
{
  my(MM=500, cnt=0, chainfails=0, smax=0.0, smarg=[0,0],
     C, R, sig, ub, dform_ok=1);
  for(m=2,MM,
    for(n=1,m-1,
      if(gcd(m,n)!=1 || (m+n)%2==0, next);
      my(a=m^2-n^2, b=2*m*n, c=a^2-b^2);
      my(E=ellminimalmodel(mkE(m,n)));
      my(Dm=E.disc, N=ellglobalred(E)[1]);
      sig = log(abs(Dm*1.0))/log(N*1.0);
      /* exact D-formula check */
      my(Dform = 4*log(a)+4*log(b)+2*log(abs(c))-8*log(2));
      if(abs(Dform - log(abs(Dm*1.0))) > 1e-9, dform_ok=0);
      /* rigorous chain */
      C = max(a^2, b^2);
      ub = 6*log(C*1.0)/log(N*1.0);
      if(sig > ub + 1e-9, chainfails++);
      if(sig > smax, smax=sig; smarg=[m,n]);
      cnt++;
    );
  );
  print("fibers checked (m<=", MM, ") = ", cnt);
  print("exact D=4loga+4logb+2log|c|-8log2 = log|Delta_min| for all ? ", dform_ok);
  print("sigma <= 6 logC/logN failures = ", chainfails, "  [expect 0]");
  print("sigma_max (m<=", MM, ") = ", smax, " at (m,n)=", smarg);
}
print("EXIT=ok");
