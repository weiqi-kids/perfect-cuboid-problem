\\ =====================================================================
\\ 05_structural_bound.gp
\\
\\ The KEY STRUCTURAL OBSERVATION:
\\ For E_PCP(q) with rational 2-torsion at e_1 = -q^2, e_2 = -1, e_3 = 0:
\\   sf(e_3 - e_2) = 1        [perfect square]
\\   sf(e_3 - e_1) = 1        [perfect square; equals q^2]
\\   sf(e_2 - e_1) = sf(P*Q)/(2mn)^2  --> in Q*/Q*^2 this is sf(P*Q)
\\
\\ The 2-Selmer group of E with full 2-torsion sits inside
\\   (Q*/Q*^2)^2  (via two of three d_i, since their product is sq mod sq)
\\
\\ STANDARD FACT (Schaefer 1996, Cremona "ec-2descent.pdf"):
\\ For E: y^2 = (x - e_1)(x - e_2)(x - e_3), the descent map
\\   delta: E(Q)/2E(Q) -> S = {(d_1, d_2, d_3): d_1 d_2 d_3 in Q*^2}
\\ identifies E(Q)/2E(Q) with a subgroup of S supported on primes
\\ dividing 2 * (e_2 - e_1)(e_3 - e_1)(e_3 - e_2).
\\
\\ In our case, the bad-prime divisor of the discriminant
\\   Disc = (e_2-e_1)^2 (e_3-e_1)^2 (e_3-e_2)^2
\\        = (q^2-1)^2 * q^4 * 1
\\ has prime divisors: those of (q^2-1) = P*Q/(2mn)^2 and of q = a/b.
\\ In particular, the support is contained in primes of:
\\   {2} U primes(P) U primes(Q) U primes(2mn) U primes(m^2 - n^2)
\\
\\ Computing more carefully:
\\   primes(q^2 - 1) ⊆ primes(P) ∪ primes(Q) ∪ primes(2mn)
\\   primes(q) = primes(m^2 - n^2) ∪ primes(2mn)
\\
\\ Heron set H(m,n) = primes(m, n, m±n, m²+n², m²-n², (m+n)²-2n², (m-n)²-2n²)
\\ = primes(2mn(m^2-n^2)(m^2+n^2)P*Q) basically. This contains the bad-prime
\\ support of the descent.
\\
\\ THE LOCAL CONDITIONS at p ∈ BAD:
\\ For each p, the image of E(Q_p)/2E(Q_p) inside (Q_p*/Q_p*^2)^2 has
\\ F_2-dimension exactly  rank E(Q_p) + dim E(Q_p)[2] = ... by local Tate
\\ duality, dim of image equals (1/2) * dim (Q_p*/Q_p*^2)^2 = 1 (for p odd)
\\ or 2 (for p = 2)  -- but this is the WRONG counting; we want the
\\ image of the GLOBAL Selmer in the local quotient.
\\
\\ Actually the cleanest formulation:
\\   dim Sel_2 = dim_{F_2} ker(prod_p res_p: (something))
\\ where each res_p has known codim.
\\
\\ For curves with full rational 2-torsion, the Selmer dimension formula
\\ (Schaefer Theorem A; see also "Heuristics for the arithmetic of elliptic
\\ curves" by Bhargava-Klagsbrun-Lemke-Oliver-Shnidman, 2018) is:
\\
\\   dim Sel_2(E/Q) = -(2 - dim E[2](Q)) - sum_p (local defect)
\\                  + #{primes of additive reduction} + ...
\\
\\ For our purposes, the CONCRETE bound comes from:
\\   dim Sel_2 <= 2 + omega(disc_min(E))
\\ which is way too weak.
\\
\\ A SHARPER bound, exploiting our special structure:
\\
\\ CLAIM (Sharp Selmer Bound for E_PCP):
\\   dim Sel_2(E_PCP(q)/Q) <= 2 + omega(sf(P*Q))
\\ where sf(P*Q) is the squarefree part of (e_2 - e_1) modulo squares.
\\
\\ The +2 is from E[2](Q) = (Z/2)^2.
\\ The omega(sf(P*Q)) is because the Selmer 2-cover's d_1 must factor
\\ ONLY through primes of (e_2 - e_1)/gcd's, since (e_3-e_1) and (e_3-e_2)
\\ are squares contributing no Selmer dimension.
\\
\\ Let's check this claim empirically.
\\
\\ =====================================================================

default(parisize, 1500000000);

sf(x) = if(x == 0, 0, my(s = sign(x), a = abs(x), f = factor(a)); s * prod(i=1, matsize(f)[1], f[i,1]^(f[i,2]%2)));

\\ omega including sign: count factors of |x| plus 1 if x < 0
omega_signed(x) = {
  my(a = abs(x), o = 0);
  if(a > 1, o = omega(a));
  if(x < 0, o++);
  o;
};

build_E_min(m, n) = {
  my(a = m^2 - n^2, b = 2*m*n, q, E, Em);
  q = a/b;
  E = ellinit([0, 1+q^2, 0, q^2, 0]);
  Em = ellminimalmodel(E);
  Em;
};

print("===== CHECKING THE SHARPER BOUND: dim Sel_2 vs 2 + ω(sf(P*Q)) =====");
print("(m,n)  P  Q  sf(P*Q)  ω(sf(P*Q))  predicted_bound  observed_dimSel2  diff");

{
\\ Test on m <= 60, only Pythagorean primitive fibers
violations = List();
nfibers = 0;
maxdiff = 0;
for(m = 2, 60,
  for(n = 1, m-1,
    if(gcd(m, n) != 1 || (m + n) % 2 == 0, next);
    nfibers++;
    P = (m+n)^2 - 2*n^2;
    Q = (m-n)^2 - 2*n^2;
    PQ = P * Q;
    sPQ = sf(PQ);
    omPQ = omega_signed(sPQ);
    Em = build_E_min(m, n);
    rk = ellrank(Em, 1);
    s2 = rk[2] + 2;
    bound = 2 + omPQ;
    diff = s2 - bound;
    if(diff > maxdiff, maxdiff = diff);
    if(diff > 0,
      listput(violations, [m, n, P, Q, sPQ, omPQ, bound, s2]);
      print([m,n], "  P=", P, "  Q=", Q, "  sf(PQ)=", sPQ, "  ω=", omPQ, "  bound=", bound, "  observed=", s2, "  diff=+", diff);
    );
  );
);
print();
print("Tested ", nfibers, " primitive Pythagorean fibers with m <= 60");
print("Violations (observed > bound): ", #violations);
print("Max excess: ", maxdiff);
}

print();
print("===== If violations exist: the naive bound 2 + ω(sf(PQ)) is too tight =====");
print("===== Compute also 2 + ω(sf(P)) + ω(sf(Q)) (no cancellation) =====");

{
viol2 = 0;
for(m = 2, 60,
  for(n = 1, m-1,
    if(gcd(m, n) != 1 || (m + n) % 2 == 0, next);
    P = (m+n)^2 - 2*n^2;
    Q = (m-n)^2 - 2*n^2;
    sP = sf(P); sQ = sf(Q);
    omP = omega_signed(sP);
    omQ = omega_signed(sQ);
    Em = build_E_min(m, n);
    rk = ellrank(Em, 1);
    s2 = rk[2] + 2;
    bound = 2 + omP + omQ;
    if(s2 > bound,
      viol2++;
      print([m,n], "  bound=", bound, "  observed=", s2, "  P=", P, "  Q=", Q);
    );
  );
);
print("Violations of 2 + ω(sf(P)) + ω(sf(Q)) bound: ", viol2);
}

quit;
