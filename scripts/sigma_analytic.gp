default(parisize,1200000000);
\\ RIGOROUS analytic bound on sigma.
\\ q=u/v lowest terms, u=m^2-n^2, v=2mn (then reduce). Non-minimal Delta_0 = 16 u^4 (u^2-v^2)^2 / v^8
\\   = 16 u^4 (u-v)^2 (u+v)^2 / v^8.
\\ Numerator of Delta_0 (after clearing v^8 by the model change x->x v^2? ) Actually the MINIMAL
\\   discriminant satisfies: away from 2, v_p(Delta_min) = -v_p(j) (mult reduction, verified).
\\ Since j = 256 (q^4-q^2+1)^3 / (q^4 (q^2-1)^2) and numerator-poly is COPRIME (resultant 1) to
\\   denominator-poly, for an ODD prime p:
\\     -v_p(j) = v_p( q^4(q^2-1)^2 )_as reduced  =  4|v_p(q)| picking pole side + 2|v_p(q^2-1)| pole side.
\\ Equivalent integral statement with q=u/v (gcd(u,v)=1):
\\   q^4(q^2-1)^2 = u^4 (u-v)^2(u+v)^2 / v^8.  The j-pole at odd p is:
\\     if p|v: pole from v^8 in denominator => contributes v_p to -v_p(j) up to 8*v_p(v) minus numerator..
\\ Let me just DIRECTLY bound: log|Delta_min| <= log(16) + 4 log|u| + 2 log|u-v| + 2 log|u+v| + (2-adic corr)
\\   and log N >= sum of DISTINCT primes dividing u(u-v)(u+v)v ...
\\ The cleanest RIGOROUS bound: log|Delta_min| <= log|Delta_0_integral| where
\\   Delta_0_integral = 16 u^4 (u-v)^2 (u+v)^2 * v^? . Minimal model only DECREASES |Delta|.
\\ And N >= rad(Delta_0) roughly. So sigma <= log|Delta_0| / log(rad).
\\ Compute Delta_0 integral form and its radical, bound sigma_0 = log|Delta_0| / log rad(Delta_0).

\\ The TRUE structural fact: for multiplicative reduction everywhere,
\\   log|Delta_min| = sum_{p|N} n_p log p,  log N = sum_{p|N} log p,  n_p = -v_p(j).
\\ MAX n_p can be large at a single p, BUT that p then appears with that weight in BOTH... no, denom is just log p.
\\ The bound on sigma must come from: SUM of (n_p-1) log p  <= 5 * log N? i.e. excess discriminant.
\\ Test the TIGHT inequality: is  log|Delta_min| <= 6 log N ALWAYS (function-field Szpiro analog)?
\\ This is what "sigma <= 6" means. We test it to large m, AND test the SHARPER empirical sigma<=5.

\\ Also test an UPPER STRUCTURAL bound: -v_p(j) <= 4*v_p(q-pole) + 2... Let me bound n_p:
\\ For odd p: n_p = -v_p(j). The denominator q^4(q^2-1)^2 has p-valuation:
\\   4*v_p(q) + 2*v_p(q-1) + 2*v_p(q+1)  (taking pole contributions). With q=u/v:
\\   - p|u (p∤v): v_p(q)=v_p(u)>0 -> denom has +4 v_p(u)? NO: q^4 with v_p(q)>0 is a ZERO of denom, not pole.
\\ The POLES of q^4(q^2-1)^2 are where q=0 (no, that's a zero), where (q^2-1)=0 (zeros too)...
\\ Wait: denominator of j IS q^4(q^2-1)^2, so j has poles where q^4(q^2-1)^2 = 0, i.e. q=0,1,-1 AND q=inf.
\\ p-adically: pole at prime p <=> q reduces to 0,1,-1, or inf mod p.
\\   q≡0: p|u. pole order = 4 v_p(u).
\\   q≡inf: p|v. pole order = 4 v_p(v) (from q=inf, the I_4 fiber) [since deg num - deg den balanced].
\\   q≡1: p|(u-v). pole order = 2 v_p(u-v).
\\   q≡-1: p|(u+v). pole order = 2 v_p(u+v).
\\ A given odd p can satisfy AT MOST ONE of {q≡0,1,-1,inf} (they're distinct mod p for p>3 since 0,1,-1,inf distinct).
\\ So n_p = -v_p(j) = ONE of {4 v_p(u), 4 v_p(v), 2 v_p(u-v), 2 v_p(u+v)} for odd p>3.
\\ Then: sum_p n_p log p <= 4 sum_{p|u} v_p(u) log p + 4 sum v_p(v) log p + 2 sum_{p|u-v} v_p(u-v) log p + 2 sum v_p(u+v)log p
\\   = 4 log|u| + 4 log|v| + 2 log|u-v| + 2 log|u+v|  (+ O(1) for p=2,3).
\\ And log N = sum_{p|N} log p = log( rad(u v (u-v)(u+v)) ) (+O(1)).
\\ So sigma <= [4 log|u| + 4 log|v| + 2 log|u-v| + 2 log|u+v|] / log rad(u v (u-v)(u+v)).
\\ This is UNBOUNDED in general (if u,v,u±v are all prime powers, rad is small)! e.g. u=2^a etc.
\\ BUT that's exactly why we test numerically. Let me compute this UPPER PROXY and the TRUE sigma,
\\ searching hard for u,v,u-v,u+v simultaneously smooth/prime-power.

worst=0.0; mnw=[0,0]; worstproxy=0.0; mnwp=[0,0];
test(m,n)={
  my(u0=m^2-n^2, v0=2*m*n, g=gcd(u0,v0), u=u0/g, v=v0/g);
  my(E,Dmin,N,sig,proxy,radv);
  E=ellminimalmodel(ellinit([0,1+(u/v)^2,0,(u/v)^2,0]));
  Dmin=abs(E.disc); N=ellglobalred(E)[1];
  sig=log(Dmin*1.0)/log(N*1.0);
  radv = abs(u)*abs(v)*abs(u-v)*abs(u+v);
  radv = factorback(factor(radv)[,1]);  \\ radical
  proxy = (4*log(abs(u)*1.0)+4*log(abs(v)*1.0)+2*log(abs(u-v)*1.0)+2*log(abs(u+v)*1.0))/log(radv*1.0);
  [sig,proxy];
};
\\ search including Mersenne/Fermat-like and adversarial smooth pairs
{
for(m=2,300,
  for(n=1,m-1,
    if(gcd(m,n)==1 && (m+n)%2==1,
      my(r=test(m,n));
      if(r[1]>worst, worst=r[1]; mnw=[m,n]);
      if(r[2]>worstproxy, worstproxy=r[2]; mnwp=[m,n]);
    );
  );
);
}
print("TRUE worst sigma (m<=300): ", worst, " at ", mnw);
print("PROXY worst (m<=300): ", worstproxy, " at ", mnwp, "  (proxy = analytic upper bound, NOT tight)");
\\ adversarial: try (m,n) making u,v,u-v,u+v all 2,3,5,7-smooth
print("=== adversarial smooth search ===");
ws=0.0; mns=[0,0];
{
for(m=2,2000,
  for(n=1,m-1,
    if(gcd(m,n)==1 && (m+n)%2==1,
      my(u0=m^2-n^2,v0=2*m*n,g=gcd(u0,v0),u=u0/g,v=v0/g);
      \\ check smoothness of u*v*(u-v)*(u+v)
      my(prod=abs(u*v*(u-v)*(u+v)), sm=1, ff=factor(prod)[,1]);
      for(i=1,#ff, if(ff[i]>13, sm=0; break));
      if(sm,
        my(E=ellminimalmodel(ellinit([0,1+(u/v)^2,0,(u/v)^2,0])));
        my(Dmin=abs(E.disc),N=ellglobalred(E)[1],sig=log(Dmin*1.0)/log(N*1.0));
        if(sig>ws, ws=sig; mns=[m,n,u,v]);
      );
    );
  );
);
}
print("WORST sigma among 13-smooth fibers (m<=2000): ", ws, " at (m,n,u,v)=", mns);
