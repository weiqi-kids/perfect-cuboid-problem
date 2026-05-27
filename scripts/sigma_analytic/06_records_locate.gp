default(parisize,700000000);
default(parisizemax,1000000000);
\\ Step 3 (locate the records). For each sigma-record fiber, decompose log|Delta_min|
\\ into the SIX-FORM contributions and identify which forms carry the powerful excess.
\\ Confirm whether the fiber sits on (or near) a quadratic-form-square Pell locus.
\\
\\ Delta excess weights:  n_p = 4 v_p for p|a or p|b ; n_p = 2 v_p for p|(a^2-b^2)=F5*F6.
\\ So the discriminant "powerful budget" (excess over the radical) per prime is:
\\   (n_p - 1) log p.  We attribute it to whichever of the 6 forms p divides.

radK(K) = factorback(factor(abs(K))[,1]);
powerfulpart(K) = {my(f=factor(abs(K)),r=1);for(i=1,#f~,if(f[i,2]>=2,r*=f[i,1]^f[i,2]));r;};
sigformula(mm,nn) = {
  my(a=mm^2-nn^2, b=2*mm*nn, c=a^2-b^2, v2b=valuation(b,2));
  my(D = 4*log(abs(a)) + 4*log(abs(b)) + 2*log(abs(c)) - 8*log(2));
  my(N = radK(a)*radK(b)*radK(c)); if(v2b==2, N=N/2);
  D/log(N);
};

\\ For a form value V, the "excess exponent in Delta" attributed to it:
\\   forms a-side (m,n,m-n,m+n contribute to a or b with weight 4): excess = sum (e_p-1) log p over p|V *4?
\\ Cleaner: compute log|Delta| numerically and log N, plus the fraction of log|Delta| coming from each form's powerful part.
contrib(V, wt) = {  \\ wt = 4 (for a,b factors) or 2 (for c=F5*F6 factors). returns [logV*wt contribution to Delta, powerful excess part]
  my(f=factor(abs(V)), tot=0.0, pw=0.0);
  for(i=1,#f~,
    tot += wt * f[i,2] * log(f[i,1]);
    if(f[i,2]>=2, pw += wt * f[i,2] * log(f[i,1]) - wt*log(f[i,1]));  \\ excess over a single power...
  );
  [tot, pw];
};

analyze(mm,nn) = {
  my(a=mm^2-nn^2, b=2*mm*nn, c=a^2-b^2, v2b=valuation(b,2));
  my(F5=mm^2-2*mm*nn-nn^2, F6=mm^2+2*mm*nn-nn^2);
  my(X6=mm+nn, X5=mm-nn);  \\ F6=X6^2-2n^2, F5=X5^2-2n^2
  printf("(%d,%d)  sigma=%.4f  v2(b)=%d\n", mm,nn, sigformula(mm,nn), v2b);
  printf("   a=%d=%s\n", a, Str(factor(a)));
  printf("   b/2^v2=%d (odd part)=%s ; 2-power=2^%d\n", b>>v2b, Str(factor(b>>v2b)), v2b);
  printf("   F5=m-n form: X5=m-n=%d, F5=X5^2-2n^2=%d=%s  pw=%d\n", X5, F5, Str(factor(F5)), powerfulpart(F5));
  printf("   F6=m+n form: X6=m+n=%d, F6=X6^2-2n^2=%d=%s  pw=%d\n", X6, F6, Str(factor(F6)), powerfulpart(F6));
  \\ is F6 (or F5) a perfect square, cube, or k^2*small?
  my(sqf6 = core(abs(F6)), sqf5=core(abs(F5)));   \\ core = squarefree kernel
  printf("   squarefree kernel of F6 = %d (so F6 = %d * (%d)^2)\n", sqf6, sqf6, sqrtint(abs(F6)\sqf6));
  printf("   squarefree kernel of F5 = %d (so F5 = %d * (%d)^2)\n", sqf5, sqf5, sqrtint(abs(F5)\sqf5));
  print();
};

print("======== SIGMA-RECORD FIBERS: locate the obstruction ========");
records = [[256,121],[304,135],[233,80],[320,121],[56,25],[92,81],[265,114]];
for(i=1,#records, my(r=records[i]); analyze(r[1],r[2]));

\\ Now: is (256,121) on a Pell square locus for F6? F6=112847=7^4*47, NOT a perfect square,
\\ but its powerful part 7^4 is huge. The relevant locus is F6 = 7^4 * (squarefree).
\\ The form F6 = X6^2 - 2n^2 takes the value 7^4*47. Check: does (256,121) lie on the
\\ Pell-conic family X^2 - 2n^2 = 7^4 * 47? It does by definition. The point: the powerful
\\ part 7^4 means F6 is represented by the SAME quadratic form with a large square factor.
print("======== Is (256,121) on a high-power layer of F6 = X^2-2n^2 ? ========");
{
my(mm=256,nn=121, X=mm+nn, F6=mm^2+2*mm*nn-nn^2);
print("X=m+n=", X, ", n=", nn, ", F6=X^2-2n^2=", X^2-2*nn^2, " =? ", F6, "  -> ", X^2-2*nn^2==F6);
print("F6 = ", factor(F6), "  powerful part = 7^4 = ", 7^4);
print("So F6 = 7^4 * 47.  The form value is 7^4 times a squarefree -> heavily powerful.");
print("This is the QUADRATIC-FORM-NEAR-SQUARE locus: F6 = (perfect square)*(small squarefree).");
}
