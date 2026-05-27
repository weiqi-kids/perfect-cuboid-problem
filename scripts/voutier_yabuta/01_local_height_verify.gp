\\ ============================================================================
\\ 01_local_height_verify.gp
\\ Verify the exact I_n non-archimedean Neron local-height formula against
\\ PARI ellheight, then decompose hat-h(P) = lambda_inf + sum_p lambda_p
\\ for the known rank-jump fibers of E_PCP(q).
\\
\\ Convention (Silverman ATAEC VI / Tate / CPS 2006, the SAME normalization as
\\ PARI ellheight: hat-h = sum_v lambda_v over ALL places, archimedean weight 1):
\\   At a prime p of MULTIPLICATIVE reduction I_n (n = v_p(Delta_min)),
\\   let the point P=(x,y) on the minimal model have d = v_p(denominator(x)) "depth".
\\   The reduction component index is  r = min( N_p, n - N_p )  where
\\     N_p = the component number = (the integer j with 0<=j<=n that P maps to).
\\   For the standard model, the component is determined by:
\\       if v_p(x) >= 0 (P reduces to identity comp or x integral): involves alpha,
\\   We instead use the ROBUST, source-exact Tate formula in terms of B2:
\\       lambda_p(P) = -(1/2)*B2( {v_p( w )} ) * log p  ... (archimedean-style), OR
\\   the standard NON-arch I_n formula (Silverman ATAEC VI.4, Cremona's
\\   nonarchimedean_local_height): with  c = component index in {0,1,...,n-1},
\\       lambda_p(P) = ( (c*(n-c)) / (2*n) ) * log p          [Cremona/Sage sign]
\\   where this is the contribution that, summed with the archimedean local
\\   height and the leading log-denominator term, reconstructs hat-h.
\\
\\ CRUCIAL: rather than trust a sign by hand, we VERIFY numerically that
\\   PARI ellheight(E,P)  ==  (our explicit lambda_inf) + sum_p (our lambda_p).
\\ We obtain lambda_p directly from PARI's internal machinery where possible and
\\ cross-check the B2 formula.
\\ ============================================================================
default(parisize,600000000);
default(parisizemax,1000000000);

\\ ---- B2 second Bernoulli polynomial on the fractional part ----
B2(t) = t^2 - t + 1/6;

\\ ---- The 5 rank-1 fibers + generators (on ORIGINAL model E: y^2=x(x+1)(x+q^2)) ----
\\ q, gen on original E (from silverman_task1b_gens.out)
fibers = [ \
  [20/21, [4/21, 220/441]], \
  [80/39, [32/9, 1312/117]], \
  [24/7,  [3/28, 465/392]], \
  [84/13, [56700/36517, 329627340/25160213]], \
  [48/55, [288/55, 42336/3025]] \
];

print("================ PER-FIBER LOCAL-HEIGHT DECOMPOSITION ================");
for(i=1,#fibers,
  q = fibers[i][1];
  Porig = fibers[i][2];
  a2 = 1+q^2; a4 = q^2;
  E = ellinit([0,a2,0,a4,0]);
  iferr(
  {
    Emin = ellminimalmodel(E,&v);
    \\ map the original-model point onto the minimal model
    P = ellchangepoint(Porig, v);
    if(!ellisoncurve(Emin,P), print(q,": point NOT on Emin -- skip"); next);
    hh = ellheight(Emin,P);
    Dm = Emin.disc;
    logDm = log(abs(Dm));
    gr = ellglobalred(Emin);
    N = gr[1];
    logN = log(N);
    sig = logDm/logN;
    print("");
    print("--- q = ", q, "  (a/b form) ---");
    print("  Delta_min = ", Dm, "   log|Delta| = ", logDm);
    print("  N = ", N, "   sigma = log|D|/logN = ", sig);
    print("  hat-h(P) [ellheight] = ", hh);
    print("  ratio hat-h / log|Delta| = ", hh/logDm);
    print("  ratio hat-h / logN       = ", hh/logN);
    \\ bad primes
    fa = factor(N);
    nbad = #fa~;
    \\ archimedean local height via PARI (psi / sigma) -- compute as
    \\ lambda_inf = hat-h - sum_p lambda_p  AFTER we get lambda_p.
    \\ Compute lambda_p at each bad prime using the explicit I_n formula:
    sum_nonarch = 0.0;
    print("  bad primes (p : kodaira : n_p=v_p(D) : comp index : lambda_p):");
    for(k=1,nbad,
      p = fa[k,1];
      lr = elllocalred(Emin,p);
      np = lr[1];          \\ f_p? no -- lr[1]=conductor exp; lr[2]=kodaira code
      kod = lr[2];         \\ kodaira: I_n -> code = 4+n  (PARI: In is 5,6,7..-> n=code-4) ; actually In code = n+4? we print raw
      vpD = valuation(Dm, p);
      \\ component index of P at p: use Cremona's recipe.
      \\ For multiplicative reduction model, depth of x-denominator:
      xden = denominator(P[1]);
      d = if(xden==0,0, valuation(xden,p));   \\ v_p(denom x) -- but x may have p in numerator too
      \\ general: v_p(x). If v_p(x) < 0, the point is "deep"; comp = min(-vpx? ...)
      vpx = if(P[1]==0,+oo, valuation(P[1],p));
      \\ Tate's parametrization component index:
      \\ c = min( v, n-v ), v = -v_p(x)/?  -- we instead directly use the formula that
      \\ matches Sage: nonarch local height for mult reduction:
      \\   let A = v_p(x), B = v_p of disc = n.
      \\   if A < 0: r = min(-A, n)/?  ... we compute via the Sage closed form below.
      \\ We use the closed Sage form (ell_point.nonarchimedean_local_height):
      \\   if mult reduction: let alpha = v_p(x) (could be neg).
      \\   c = the component = ... we test candidate r in 0..floor(n/2) by matching.
      \\ Print raw data; the matching is done in script 02.
      print("    p=",p," kod_code=",kod," n_p=",vpD," v_p(x)=",vpx," v_p(denomx)=",d);
    );
  }, E_, print("  ERR at q=",q,": ",E_); );
);
print("");
print("================ END ================");
