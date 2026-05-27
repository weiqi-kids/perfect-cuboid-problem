default(parisize,1000000000);
\\ RIGOROUS structural test of sigma boundedness.
\\ Non-minimal model y^2=x(x+1)(x+q^2), q=u/v lowest terms.
\\ Delta_nonmin = 16 q^4 (q^2-1)^2 = 16 u^4 (u-v)^2 (u+v)^2 / v^8.
\\ Bad primes p | 2*u*v*(u-v)*(u+v). All reduction multiplicative (verified).
\\ For multiplicative reduction: v_p(Delta_min) = v_p(j-denominator pole) = "n_p", v_p(N)=1.
\\ j = 256 (q^4-q^2+1)^3 / (q^4 (q^2-1)^2). The pole order of j at a bad prime p:
\\   n_p = v_p( q^4(q^2-1)^2 ) - v_p( (q^4-q^2+1)^3 )  measured p-adically on the curve,
\\ but after minimalization n_p = -v_p(j) when v_p(j)<0 (potentially mult => mult here).
\\ CLAIM: sigma = sum_{p|N} n_p log p / sum_{p|N} log p is bounded because
\\   n_p = -v_p(j) and -v_p(j) <= 6 * 1 structurally? Test the ratio n_p directly vs the
\\   "should be <=6" function-field Szpiro bound for multiplicative reduction.
\\ KEY THEOREM (we test, then cite): for an elliptic curve with MULTIPLICATIVE reduction at p,
\\   v_p(Delta_min) = -v_p(j) = ord of pole of j. There is NO a-priori absolute bound on a SINGLE
\\   n_p, BUT sigma = sum n_p log p / sum log p. We test whether sigma <= 6 + o(1) ALWAYS,
\\   and try to find ANY fiber with sigma > 5.

worst=0.0; mnw=[0,0]; cnt=0; over5=0; over45=0;
\\ Also verify n_p = -v_p(j) at each bad prime (consistency of multiplicative reduction).
mismatch=0;
{
for(m=2,120,
  for(n=1,m-1,
    if(gcd(m,n)==1 && (m+n)%2==1,
      q=(m^2-n^2)/(2*m*n);
      E=ellminimalmodel(ellinit([0,1+q^2,0,q^2,0]));
      Dmin=abs(E.disc); N=ellglobalred(E)[1];
      sig=log(Dmin*1.0)/log(N*1.0);
      cnt++;
      if(sig>worst, worst=sig; mnw=[m,n]);
      if(sig>5.0, over5++);
      if(sig>4.5, over45++);
      \\ verify n_p = -v_p(j) for each bad prime
      jj=E.j;
      fa=factor(N)[,1];
      for(i=1,#fa,
        p=fa[i];
        np=valuation(Dmin,p);          \\ v_p(Delta_min) = I_n index
        vj=valuation(jj,p);            \\ v_p(j) (negative => pole)
        if(np != -vj && vj<0, mismatch++);
      );
    );
  );
);
}
print("FIBERS(m<=120)=", cnt);
print("WORST sigma = ", worst, " at (m,n)=", mnw);
print("fibers with sigma>5.0: ", over5, "   sigma>4.5: ", over45);
print("mismatches of (v_p(Delta_min) != -v_p(j)) at bad primes: ", mismatch);
