\\ Phase G clean: CT computation using full triples (no factoring needed).
\\ The Hilbert symbol can be computed for any rationals without factoring them.
\\ Sum over places: only finitely many primes give non-trivial contributions
\\ (those dividing the rationals), so we enumerate.

default(parisize, 1500000000);
default(realprecision, 38);

read("/root/proof/perfect-cuboid-problem/scripts/4-descent/EHm_short_data.gp");
E_short = ellinit([0, A2_short, 0, A4_short, A6_short]);
e1 = e1_short; e2 = e2_short; e3 = e3_short;
covers = ell2cover(E_short);

BAD = [2, 3, 5, 7, 11, 19, 23, 31, 61, 223, 337, 1033];

\\ Helper: given a rational n, compute the set of primes dividing num*den
\\ For large numbers this can be slow; we'll only check at BAD primes + a small extra set.

\\ However, hilbert(a, b, p) for prime p is fast as long as a, b are computed.

\\ For the CT-style pairing using extracted d_i:
\\ Use Selmer triples from rational point lifts (where possible) or from q(e_i)/cofactor (with extra factors).
\\ Compute Hilbert symbol pairwise at BAD primes and oo.

\\ S1 from x=0 lift on Cover 1
S1 = [28243056730, -3082611455, -586454];   \\ verified squarefree

\\ S2 from 2-torsion (e2, 0) lift on Cover 2
S2 = [-16307767, 16307767, -1];

\\ S3, S4 from q(e_i) / (e_i - e_j)(e_i - e_k) — these have extra prime factors but should
\\ still give correct Hilbert pairing values at BAD primes (and oo) IF combined correctly.

{ selmer_raw(q) =
  my(d1, d2, d3);
  d1 = subst(q, 'x, e1) / ((e1 - e2) * (e1 - e3));
  d2 = subst(q, 'x, e2) / ((e2 - e1) * (e2 - e3));
  d3 = subst(q, 'x, e3) / ((e3 - e1) * (e3 - e2));
  \\ Return num*den (an integer representing the rational mod squares).
  [numerator(d1)*denominator(d1), numerator(d2)*denominator(d2), numerator(d3)*denominator(d3)];
}

\\ Compute (un-cleaned) Selmer-like triples for all 4 covers
S_raw = vector(#covers);
S_raw[1] = selmer_raw(covers[1][1]);
S_raw[2] = selmer_raw(covers[2][1]);
S_raw[3] = selmer_raw(covers[3][1]);
S_raw[4] = selmer_raw(covers[4][1]);

\\ Compute "correction factor" for each cover: ratio between raw and known triple
\\ For Covers 1, 2 we know S1, S2 explicitly. For 3, 4 we'll use raw.
\\ Correction: raw_k = S_k * (c_k)^... but c_k cancels in HILBERT(_, _).
\\ Wait: Hilbert(a*c, b*c, v) = Hilbert(a, b, v) * Hilbert(a, c, v) * Hilbert(b, c, v) * Hilbert(c, c, v).
\\ This is NOT invariant under multiplying by common factor c.
\\
\\ The PROPER CT formula requires actual Selmer triples (not raw).
\\
\\ For Cover 1 raw = (q(e1)/[(e1-e2)(e1-e3)], q(e2)/[(e2-e1)(e2-e3)], q(e3)/[(e3-e1)(e3-e2)])
\\ Cover 1 known S1 = (X-e1, X-e2, X-e3) where (X, Y) lifts cover (0, 8625278).
\\ Let's check the ratio:

print("===========================================");
print("Verifying raw vs. known Selmer triple for Cover 1:");
print("===========================================");
{
S1_known = [28243056730, -3082611455, -586454];
print("S1 known = ", S1_known);
print("S1 raw   = ", S_raw[1]);
print("Ratios (raw / known):");
for(i = 1, 3, print("  d", i, ": ", S_raw[1][i] / S1_known[i], "  isqrt? ", issquare(S_raw[1][i] / S1_known[i])));
}

\\ The ratio for each i should be a square (up to a global cover-dependent constant).
\\ If raw_i / known_i = c_k * (square) for all i, then c_k is the cover-specific "constant".

\\ Compute ratios for Cover 2:
print();
print("Verifying for Cover 2:");
{
S2_known = [-16307767, 16307767, -1];
print("S2 known = ", S2_known);
print("S2 raw   = ", S_raw[2]);
print("Ratios:");
for(i = 1, 3, print("  d", i, ": ", S_raw[2][i] / S2_known[i], "  issquare? ", issquare(S_raw[2][i] / S2_known[i])));
}

\\ The CORRECT formula: For ell2cover with cover quartic q,
\\   q(e_i) = lc * (e_i - r_1)(e_i - r_2)(e_i - r_3)(e_i - r_4)
\\ where r_1, ..., r_4 are roots of q.
\\ The standard 2-cover y^2 = q(x) parametrizes points (x, y) with
\\   (x-e_i) = d_i u_i^2 for cover with Selmer image (d_1, d_2, d_3).
\\ So at a Q-point of the cover with x = x_P, the relation:
\\   q(e_i) ... involves d_j * d_k * (something).
\\
\\ The cleanest formula (Cassels-Smart): For y^2 = q(x), the Selmer image at p of any local
\\ point lifts via X-e_i = c * d_i (for the cover's class), where c = c4 * (something).
\\
\\ Let me try: q(e_i) / [(e_i-e_j)(e_i-e_k) * c4] mod squares.
print();
print("===========================================");
print("Try: q(e_i) / [(e_i-e_j)(e_i-e_k) * c4] for Cover 1:");
print("===========================================");
{
q1 = covers[1][1];
c4_1 = polcoeff(q1, 4);
d1_cor = subst(q1, 'x, e1) / ((e1 - e2) * (e1 - e3)) / c4_1;
d2_cor = subst(q1, 'x, e2) / ((e2 - e1) * (e2 - e3)) / c4_1;
d3_cor = subst(q1, 'x, e3) / ((e3 - e1) * (e3 - e2)) / c4_1;
print("d1 = ", d1_cor, "  ratio to S1[1]: ", d1_cor / 28243056730, "  issquare? ", issquare(d1_cor / 28243056730));
print("d2 = ", d2_cor, "  ratio to S1[2]: ", d2_cor / (-3082611455), "  issquare? ", issquare(d2_cor / (-3082611455)));
print("d3 = ", d3_cor, "  ratio to S1[3]: ", d3_cor / (-586454), "  issquare? ", issquare(d3_cor / (-586454)));
}

\\ Try a different normalization: q(e_i) * c4 / [(e_i-e_j)(e_i-e_k)]
print();
print("Try q(e_i) * c4 / cofactor for Cover 1:");
{
q1 = covers[1][1];
c4_1 = polcoeff(q1, 4);
d1 = subst(q1, 'x, e1) * c4_1 / ((e1 - e2) * (e1 - e3));
d2 = subst(q1, 'x, e2) * c4_1 / ((e2 - e1) * (e2 - e3));
d3 = subst(q1, 'x, e3) * c4_1 / ((e3 - e1) * (e3 - e2));
print("d1 = ", d1, "  ratio: ", d1 / 28243056730, "  issquare? ", issquare(d1 / 28243056730));
print("d2 = ", d2, "  ratio: ", d2 / (-3082611455), "  issquare? ", issquare(d2 / (-3082611455)));
print("d3 = ", d3, "  ratio: ", d3 / (-586454), "  issquare? ", issquare(d3 / (-586454)));
}

\\ Maybe the formula needs lc(q), not c4. lc(q) is the same as c4. Try different combinations.
print();
print("Try q(e_i)/c4 / cofactor:");
{
q1 = covers[1][1];
c4_1 = polcoeff(q1, 4);
d1 = subst(q1, 'x, e1) / c4_1 / ((e1 - e2) * (e1 - e3));
d2 = subst(q1, 'x, e2) / c4_1 / ((e2 - e1) * (e2 - e3));
d3 = subst(q1, 'x, e3) / c4_1 / ((e3 - e1) * (e3 - e2));
print("d1/d2/d3 ratios to S1:");
print("  d1 ratio: ", d1 / 28243056730, "  iss? ", issquare(d1 / 28243056730));
print("  d2 ratio: ", d2 / (-3082611455), "  iss? ", issquare(d2 / (-3082611455)));
print("  d3 ratio: ", d3 / (-586454), "  iss? ", issquare(d3 / (-586454)));
}

quit;
