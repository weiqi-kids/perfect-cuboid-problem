default(parisize,700000000);
default(parisizemax,1000000000);
\\ Step 3 (numerical). Enumerate the quadratic-form values F5, F6 over fibers and
\\ identify the SQUARE / NEAR-SQUARE / POWERFUL loci. Confirm the Pell parametrization
\\ generates exactly the perfect-square fibers, and locate where the SIGMA records sit.
\\
\\ F6 = m^2+2mn-n^2 = (m+n)^2 - 2 n^2 = k^2  <=>  X^2 - 2 n^2 = k^2, X=m+n.
\\ Param A (n even): m = s^2 - 2 s t + 2 t^2, n = 2 s t, k = |s^2-2t^2|.

powerfulpart(K) = {
  my(f=factor(abs(K)), res=1);
  for(i=1,#f~, if(f[i,2]>=2, res *= f[i,1]^f[i,2]));
  res;
};
issq(K) = issquare(abs(K));

\\ (1) verify the parametrization PRODUCES square F6, and that those (m,n) are
\\     valid primitive Pythagorean params (gcd(m,n)=1, m+n odd) in a sub-family.
print("=== Param A for F6=k^2 : (m,n)=(s^2-2st+2t^2, 2st) ===");
print("  list small (s,t) with gcd-> primitive fibers, show F6 is a square");
{
for(s=1,12,
  for(t=1,12,
    my(m = s^2 - 2*s*t + 2*t^2, n = 2*s*t);
    if(m>n && n>=1 && gcd(m,n)==1 && (m+n)%2==1,
      my(F6 = m^2+2*m*n-n^2);
      printf("  s=%d t=%d -> (m,n)=(%d,%d)  F6=%d  issquare=%d  sqrt=%d\n",
        s,t,m,n,F6, issq(F6), if(issq(F6), sqrtint(abs(F6)), -1));
    );
  );
);
}
print();

\\ (2) Direct scan: which fibers have F5 or F6 a perfect SQUARE? a perfect CUBE/higher?
\\     and what is the powerful part. Tabulate the link to sigma.
radK(K) = factorback(factor(abs(K))[,1]);
sigformula(mm,nn) = {
  my(a=mm^2-nn^2, b=2*mm*nn, c=a^2-b^2, v2b=valuation(b,2));
  my(D = 4*log(abs(a)) + 4*log(abs(b)) + 2*log(abs(c)) - 8*log(2));
  my(N = radK(a)*radK(b)*radK(c)); if(v2b==2, N=N/2);
  D/log(N);
};

print("=== Fibers (m<=400) where F5 or F6 is a PERFECT SQUARE ===");
cntsq=0;
{
for(m=2,400,
  for(n=1,m-1,
    if(gcd(m,n)==1 && (m+n)%2==1,
      my(F5=m^2-2*m*n-n^2, F6=m^2+2*m*n-n^2);
      if(issq(F5) || issq(F6),
        cntsq++;
        if(cntsq<=40,
          printf("  (%d,%d) sigma=%.4f  F5=%d(sq=%d) F6=%d(sq=%d)\n",
            m,n, sigformula(m,n), F5, issq(F5), F6, issq(F6));
        );
      );
    );
  );
);
}
print("  total square-form fibers (m<=400): ", cntsq);
print();

\\ (3) The high-powerful-form locus: where powerfulpart(F5) or powerfulpart(F6) is LARGE
\\     (>= F5^{2/3} say -> 'mostly powerful'). These drive sigma. Check (256,121) family.
print("=== Top fibers by powerfulpart(F6) (m<=400) and their sigma ===");
best=List();
{
for(m=2,400,
  for(n=1,m-1,
    if(gcd(m,n)==1 && (m+n)%2==1,
      my(F6=m^2+2*m*n-n^2, pw=powerfulpart(F6));
      if(pw>=2000, listput(best, [pw, m, n, F6, sigformula(m,n)]));
    );
  );
);
}
best=Vec(best); best=vecsort(best,1,4);  \\ descending by pw
{
for(i=1, min(20,#best),
  my(e=best[i]);
  printf("  pw(F6)=%d at (%d,%d): F6=%d=%s  sigma=%.4f\n",
    e[1], e[2], e[3], e[4], Str(factor(e[4])), e[5]);
);
}
