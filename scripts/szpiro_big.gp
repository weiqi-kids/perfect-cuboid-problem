default(parisize, 1000000000);
\\ E_PCP(q): Y^2 = X(X+1)(X+q^2), q = (m^2-n^2)/(2mn) Pythagorean.
\\ Step 2: Szpiro ratio over larger sample + verify all-multiplicative + max I_n index.
\\ Step 3: compare log|Delta_min|, log N, log H_j (height of j-invariant).

smin=100.0; smax=0.0; cnt=0; mn_smin=[0,0]; mn_smax=[0,0];
sumsig=0.0;
maxIn=0; mn_maxIn=[0,0];          \\ max Tate index n_p (=v_p(Delta_min)) over all fibers/primes
allmult=1;                         \\ flag: 1 if every bad prime is multiplicative (Kodaira I_n)
nonmult_example=[0,0,0];           \\ record a counterexample if found
\\ ratio trackers for Step 3
r_dN_min=100.0; r_dN_max=0.0;      \\ log|Delta_min| / log N
r_jN_min=100.0; r_jN_max=0.0;      \\ log H_j / log N
r_jd_min=100.0; r_jd_max=0.0;      \\ log H_j / log|Delta_min|

{
for(m=2, 60,
  for(n=1, m-1,
    if(gcd(m,n)==1 && (m+n)%2==1,
      q = (m^2-n^2)/(2*m*n);
      E0 = ellinit([0, 1+q^2, 0, q^2, 0]);
      E = ellminimalmodel(E0);
      D = abs(E.disc);
      gr = ellglobalred(E);
      N = gr[1];
      \\ j-invariant height: j = numerator/denominator in lowest terms, H_j = max(|num|,|den|)
      jj = E.j;
      jn = numerator(jj); jd = denominator(jj);
      Hj = max(abs(jn), abs(jd));
      if(N>2 && D>2,
        sig = log(D*1.0)/log(N*1.0);
        sumsig += sig;
        if(sig<smin, smin=sig; mn_smin=[m,n]);
        if(sig>smax, smax=sig; mn_smax=[m,n]);
        cnt++;
        \\ reduction-type check: gr[6] is the list of [p, fp, kodaira_code, cp]
        \\ Kodaira code: Tate's labels; multiplicative I_n has code n+4 in PARI (1->5,2->6,...,In->n+4? )
        \\ Actually PARI elllocalred / ellglobalred: kodaira symbol via integer code.
        \\ We instead directly test multiplicative: at bad p, v_p(c4)=0  <=> potentially mult.
        fa = factor(N)[,1];
        for(i=1, #fa,
          p = fa[i];
          loc = elllocalred(E, p);
          kod = loc[2];        \\ Kodaira type code (PARI convention)
          \\ PARI Kodaira codes: 1=I0(good), 2=II,3=III,4=IV, In: code = 4+n (n>=1) => I1=5,...
          \\  -1=I0*, In*: code = -(4+n); etc. Multiplicative = I_n (n>=1) => code>=5, i.e. code-4=n.
          if(kod>=5,
            nidx = kod-4;       \\ this is n in I_n => = v_p(Delta_min)
            if(nidx>maxIn, maxIn=nidx; mn_maxIn=[m,n,p]);
          ,
            \\ code not >=5 at a bad prime: additive or special. Flag (p=2 may be additive)
            \\ allow good (code 1) shouldn't be a bad prime; flag genuine additive
            if(kod!=1,
              allmult=0; nonmult_example=[m,n,p];
            );
          );
        );
        \\ Step 3 ratios
        lN = log(N*1.0); lD = log(D*1.0); lJ = log(max(Hj,2)*1.0);
        rdn = lD/lN; rjn = lJ/lN; rjd = lJ/lD;
        if(rdn<r_dN_min, r_dN_min=rdn); if(rdn>r_dN_max, r_dN_max=rdn);
        if(rjn<r_jN_min, r_jN_min=rjn); if(rjn>r_jN_max, r_jN_max=rjn);
        if(rjd<r_jd_min, r_jd_min=rjd); if(rjd>r_jd_max, r_jd_max=rjd);
      );
    );
  );
);
}
print("FIBERS=",cnt);
print("SZPIRO_MIN=", smin, " at (m,n)=", mn_smin);
print("SZPIRO_MAX=", smax, " at (m,n)=", mn_smax);
print("SZPIRO_MEAN=", sumsig/cnt);
print("MAX_I_n_INDEX=", maxIn, " at (m,n,p)=", mn_maxIn);
print("ALL_MULTIPLICATIVE(away from additive)=", allmult, "  nonmult_example=", nonmult_example);
print("--- Step 3 comparisons (over sample) ---");
print("log|Delta_min|/log N  in [", r_dN_min, ", ", r_dN_max, "]");
print("log H_j / log N       in [", r_jN_min, ", ", r_jN_max, "]");
print("log H_j / log|Delta|  in [", r_jd_min, ", ", r_jd_max, "]");
