\\ =====================================================================
\\ 08_hilbert_attack.gp
\\
\\ Hilbert reciprocity attack on the 2-Selmer dimension.
\\
\\ Setup: For E: y^2 = x(x-e_1)(x-e_2) (we shift so 0 is a 2-tor),
\\ the 2-descent has classes (alpha, beta) with alpha*beta in same square
\\ class as -e_1*(-e_2) = e_1 e_2.
\\ For E_PCP(q): y^2 = x(x+1)(x+q^2), shifting:
\\   if we use x' = x, the roots are e = {0, -1, -q^2}
\\   delta(P) = (x(P), x(P)+1) mod squares, and x(P) * (x(P)+1) * (x(P)+q^2) = y^2
\\   so x(P) * (x(P)+1) ≡ (x(P)+q^2) ≡ x(P)*(x(P)+1) (mod squares).
\\   Equivalent: (x(P), x(P)+1) determines x(P)+q^2 mod squares.
\\
\\ The image of delta is supported (each component) on a finite set of primes:
\\   For alpha = x(P): primes dividing 2 * Disc * 1 ?
\\   Standard: support in primes of bad reduction, plus possibly 2.
\\   More precisely: support in primes p such that
\\     ord_p(x) is odd  OR  p | (e_2 - e_1) = -1 - 0 = -1 (trivially)
\\     or p | (e_3 - e_1) = -q^2  or p | (e_3 - e_2) = 1-q^2 = -(q^2-1)
\\   So support(alpha) ⊆ primes(2) ∪ primes(q^2) ∪ primes(q^2 - 1)
\\                    = primes(2mn) ∪ primes(m^2-n^2) ∪ primes(P*Q/(2mn)^2)
\\                    = primes(2mn) ∪ primes(m^2-n^2) ∪ primes(P) ∪ primes(Q)
\\
\\ Note: primes(m^2-n^2) = primes(m+n) ∪ primes(m-n).
\\
\\ So support(alpha) ⊆ Heron-like set H'(m,n) = primes(2mn) ∪ primes(m^2-n^2) ∪ primes(P) ∪ primes(Q)
\\ This is a subset of the full Heron set (which also includes m^2+n^2).
\\
\\ Note: m^2+n^2 doesn't appear in support(alpha) because:
\\   x(P) appears nowhere connected to m^2+n^2 as a divisor.
\\   But it CAN appear in the 2-isogenous curve, hence in dim Sel_2 via isogeny.
\\
\\ Let me check this on real data.

default(parisize, 1500000000);

sf(x) = if(x == 0, 0, my(s = sign(x), a = abs(x), f = factor(a)); s * prod(i=1, matsize(f)[1], f[i,1]^(f[i,2]%2)));

build_E_min(m, n) = {
  my(a = m^2 - n^2, b = 2*m*n, q, E, Em);
  q = a/b;
  E = ellinit([0, 1+q^2, 0, q^2, 0]);
  Em = ellminimalmodel(E);
  Em;
};

\\ ===== Get the actual support of Selmer triples from ell2cover =====
\\
\\ PARI's ell2cover returns the 2-covers of E as quartics y^2 = f(x).
\\ The number of covers = |Sel_2| (one identity-cover + the non-trivial ones).

print("===== Using ell2cover to determine dim Sel_2 directly =====");

{
fibers = [[22,17], [13,4], [44,9], [3,2], [4,1], [5,2], [11,2], [8,3], [99,28], [40,29]];
for(i=1, #fibers,
  mn = fibers[i];
  m = mn[1]; n = mn[2];
  Em = build_E_min(m, n);
  \\ ell2cover returns vector of covers including trivial; dim = log_2(#covers)
  cov = ell2cover(Em);
  s2_count = #cov;
  s2_dim = round(log(s2_count)/log(2));
  rk = ellrank(Em, 1);
  s2_predicted = rk[2] + 2;
  print(mn, "  |ell2cover|=", s2_count, "  dim_Sel2_via_ell2cover=", s2_dim,
        "  dim_Sel2_via_ellrank=", s2_predicted);
);
}

print();
print("===== Hilbert reciprocity test for a Selmer triple =====");
print("Given a Selmer candidate (alpha, beta) supported in BAD union {-1, 2}");
print("we have global solvability iff product (alpha, beta)_v over all v = 1");
print("but EACH local condition (alpha, beta)_p = 1 is required individually.");
print("Hilbert reciprocity gives ONE F_2 dependence among local conditions.");
print();

\\ For E_PCP: the descent locus (alpha, beta, gamma=alpha*beta) in
\\ (Q*/Q*^2)^2 (since gamma is determined). The local Selmer condition
\\ at p is the image of E(Q_p)/2E(Q_p) inside (Q_p*/Q_p*^2)^2.
\\
\\ The local image at p (odd of good reduction) is trivial (0-dim).
\\ At p of split multiplicative reduction with full 2-torsion in Q_p:
\\   dim local image = 1
\\ At p = 2: dim local image is 2 (always, since E[2](Q_2) = (Z/2)^2 has dim 2)
\\
\\ So dim Sel_2 = 2 (from torsion) + bounded contributions from bad primes
\\
\\ Specifically, the standard 2-descent formula (Schaefer 1996 §4):
\\   dim Sel_2(E/Q) = dim H^1(Q_S/Q, E[2]) - dim coker(prod_v: local conditions)
\\
\\ Where H^1(Q_S/Q, E[2]) has dim = 2 + 2*|S| (for S = bad primes ∪ {2, ∞})
\\ if E[2] = (Z/2)^2 is fully rational.
\\
\\ And the local conditions cut down by codim = sum_v dim coker(loc_v).
\\
\\ For our case the dim of H^1(Q_S/Q, (Z/2)^2) is 2*|S|... let me think
\\ more carefully.
\\
\\ Cleaner: image of delta is in (Q(S, 2))^2 where Q(S, 2) = {a in Q*/Q*^2 :
\\ support(a) ⊆ S ∪ {-1}}. dim Q(S, 2) = |S| + 1.
\\ Ambient = (Q(S, 2))^2 of dim 2(|S| + 1), product constraint cuts 1 if
\\ trivially included, but here the constraint d_1*d_2*d_3 in Q*^2 is
\\ encoded by gamma = alpha*beta so (alpha, beta) is 2 dims, hence ambient
\\ has dim 2(|S| + 1) - 0 = 2|S| + 2 (no extra constraint since gamma is
\\ automatic).
\\
\\ Hmm wait the constraint is built into how we use (alpha, beta) instead of
\\ (d_1, d_2, d_3): the 2D ambient already enforces gamma = alpha*beta mod sq.
\\ So ambient size = 2^(2(|S|+1)).
\\
\\ Local conditions at each p in S cut down to local image. For p odd good
\\ this is empty, but p odd bad: cuts by (codim 1) = 1 dim.
\\ At p = 2: cuts by (codim 2) typically.
\\ Plus at infinity: cuts by 1 dim (sign condition).
\\
\\ Total ambient dim 2|S| + 2; cut by |S_bad| + ... rough.
\\
\\ Let me just COMPUTE for a specific fiber.

quit;
