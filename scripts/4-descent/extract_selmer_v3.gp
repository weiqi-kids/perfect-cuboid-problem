\\ v3: Use the principle q(e_i) ~ (d_j d_k) * (e_i - e_j)^? * (e_i - e_k)^?
\\ Empirically, for ell2cover normalization, we observe:
\\   For a cover with rational point P=(x,y), with x-e1 = d1*u1^2, x-e2 = d2*u2^2, x-e3 = d3*u3^2,
\\   the value q(e_j) = c4 * (e_j - r1)(e_j - r2)(e_j - r3)(e_j - r4)
\\   where the roots r_l of q parametrize (x, y).
\\   This is hard to read d_i from directly.
\\
\\ Alternative: use the disc(q) and resultant to extract relations.
\\
\\ Best approach: directly USE PARI's internal Selmer routine via ellrank with effort=7 verbose,
\\ or just numerically lift cover points at all bad primes.
\\
\\ Even simpler: PARI's ell2descent_complete or hyperellratpoints, but neither is exposed.
\\
\\ Pragmatic approach: build the Cassels-Tate "local Hilbert symbol matrix" using
\\ proxy invariants:
\\   For each (α, β) and each bad prime p, find p-adic points on C_α and C_β
\\   then compute Hilbert(x_α - e_i, x_β - e_i)_p summed over i.
\\
\\ But this requires constructing local points, which is nontrivial. Without infrastructure,
\\ a partial fallback: compute Hilbert symbols (c4_α, c4_β)_p (c0_α, c0_β)_p (c2_α, c2_β)_p
\\ since at high p (good reduction p > 1033), the cover has a smooth Q_p point and the
\\ Hilbert symbol is trivial. So only the 12 bad primes plus oo matter.
\\
\\ This is an APPROXIMATION but reveals which pairs are "non-trivially paired".

default(parisize, 1000000000);
default(realprecision, 38);

read("/root/proof/perfect-cuboid-problem/scripts/4-descent/EHm_short_data.gp");
E_short = ellinit([0, A2_short, 0, A4_short, A6_short]);
e1 = e1_short; e2 = e2_short; e3 = e3_short;
covers = ell2cover(E_short);

BAD = [2, 3, 5, 7, 11, 19, 23, 31, 61, 223, 337, 1033];

\\ Squarefree mod BAD: return [sign_bit, e2, e3, e5, ..., e1033] each in F_2
{ sqf_bad(n) =
  my(v, k, p, e, nn, residual);
  if(n == 0, return("zero"));
  v = vector(#BAD + 1);
  v[1] = if(n < 0, 1, 0);
  nn = abs(n);
  for(k = 1, #BAD,
    p = BAD[k];
    e = 0;
    while(nn % p == 0, nn = nn / p; e += 1);
    v[k+1] = e % 2;
  );
  if(!issquare(nn), v = concat(v, [1]), v = concat(v, [0]));   \\ "EXTRA" bit
  v;
}

\\ For each cover, evaluate q(e_i) and divide by (e_i - e_j)*(e_i - e_k) cofactors,
\\ extracting d_i.
\\ The relation: For canonical Selmer cover with rational point P=(x,y),
\\   q(x) = y^2; and substituting x=e_j (j != i):
\\   Resultant-style: q(e_j) = c4 * prod_{l=1}^{4}(e_j - r_l).
\\
\\ For the standard ell2cover normalization, we have q(x) = lc * R(x) where
\\   R(x) parametrizes rational points P=(x_P, y_P) with x_P-e_i = d_i u_i^2.
\\ The relation x_P = (something in x) leads to q(e_i) relating to d-data.
\\
\\ EMPIRICAL APPROACH: Just compute q(e1), q(e2), q(e3) mod squares for each cover,
\\ then divide by the e-differences to isolate the d_i.

\\ According to standard theory: if rationals on cover correspond to delta-image triple (d1,d2,d3),
\\ then q(e_j) / (e_j - e_i) / (e_j - e_k) ≡ d_j mod Q*^2.
\\
\\ Let me verify with Cover #2:
\\   We found (X-e1, X-e2, X-e3) = (435045969506575, 0, -26881414803441) at (e2, 0).
\\   But that's a torsion point on E, not a Q_p point on C_2 in general.
\\   Cover #2 has rational point (x_C, y_C) = (0, 57740923038752).
\\   At this point, X = 136054851567711 = e2, so X-e1 = 435045969506575, X-e2 = 0.
\\   The d-image of (X, 0) being a 2-torsion point requires interpretation.
\\
\\ For 2-torsion point P_2 = (e_2, 0):
\\   δ(P_2) = ((e2-e1)*(e2-e3), e2-e1, e2-e3) ... actually the formula for 2-torsion delta:
\\   δ((e_i, 0)) = (d_1', d_2', d_3') where
\\     d_j' = e_i - e_j  (mod squares) for j != i
\\     d_i' = (e_i - e_j)(e_i - e_k)  (mod squares)
\\   So δ((e2, 0)) = ((e2-e1)(e2-e3), e2-e1, e2-e3) mod squares
\\                = (-(7*31*223*337)*1, 7*31*223*337, -1) mod squares
\\                = (-7*31*223*337, 7*31*223*337, -1)
\\                = (-16133497, 16133497, -1) mod squares
\\   Check: product = -16133497 * 16133497 * -1 = 16133497^2 = square. ✓

\\ So Cover #2's Selmer image triple is δ_2 = (-16133497, 16133497, -1) mod squares.

\\ Cover #1 lifts to a torsion point of order 8 (per phaseB output, x=0 was order 8).
\\ Order-8 generator's image in S^2 is some δ_1. We have lift (X_E, Y_E) from x=0, y=sqrt(c0_1):
print();
print("Cover #1: x=0, y=", sqrtint(polcoeff(covers[1][1], 0)));
y0 = sqrtint(polcoeff(covers[1][1], 0));
P_map = covers[1][2];
X_E = subst(subst(P_map[1], 'x, 0), 'y, y0);
Y_E = subst(subst(P_map[2], 'x, 0), 'y, y0);
print("  Lift (X, Y) = (", X_E, ", ", Y_E, ")  on curve? ", ellisoncurve(E_short, [X_E, Y_E]),
      "  order=", ellorder(E_short, [X_E, Y_E]));
\\ For non-torsion lifts, δ(P) = (X-e1, X-e2, X-e3) mod squares
print("  X - e1 = ", X_E - e1, "  sqf = ", sqf_bad(numerator(X_E - e1)*denominator(X_E - e1)));
print("  X - e2 = ", X_E - e2, "  sqf = ", sqf_bad(numerator(X_E - e2)*denominator(X_E - e2)));
print("  X - e3 = ", X_E - e3, "  sqf = ", sqf_bad(numerator(X_E - e3)*denominator(X_E - e3)));

\\ For Covers #3 and #4, no rational point known. We must construct local points to extract Selmer.
\\ The simplest invariant available: factor c4 and c0, divided by their gcd squares.
\\
\\ A cleaner method: for ell2cover, the cover is normalized such that the discriminant
\\ disc(q) = lc^? * (e1-e2)^2 * (e1-e3)^2 * (e2-e3)^2 * (d1 d2 d3)^? * (...)^2.
\\ Let me compute disc(q)/sigma factor for each cover.

print();
print("Discriminants and their factorizations:");
for(k = 1, #covers,
  q = covers[k][1];
  print("Cover ", k, " disc factored = ", factor(abs(poldisc(q))));
);

\\ All four covers have IDENTICAL disc factored: same bad-prime profile.
\\ This is expected: covers of the same E have the same bad primes.

\\ Selmer triples will come out via direct construction. Let me try a HARD approach:
\\ for each cover, parametrize a rational point in Q_p for the bad primes p, extract d_i.

\\ Actually, let me try yet ANOTHER approach:
\\ ell2cover[k][3] (third entry) might contain Selmer data?
print();
print("Cover #1 length: ", #covers[1]);
print("Cover #1 components types:");
for(j = 1, #covers[1],
  print("  [", j, "]: ", type(covers[1][j]));
);

\\ Let me check ell2cover docs format
\\ In PARI, ell2cover returns vectors [q(x), [X(x,y), Y(x,y)]] giving the quartic
\\ and the (rational) lift map. That's just 2 entries.

quit;
