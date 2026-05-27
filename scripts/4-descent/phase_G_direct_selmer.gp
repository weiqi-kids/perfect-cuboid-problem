\\ Phase G (direct): Construct Selmer triples by finding local rational points
\\ on each cover at small primes, extracting (X - e_i) mod squares.
\\
\\ Strategy:
\\ - For Cover 1: rational point (x=0, y=8625278) lifts to torsion order 8 on E.
\\ - For Cover 2: rational point (x=0, y=57740923038752) lifts to (e_2, 0) torsion order 2.
\\ - For Cover 3, 4: NO rational point found. We compute LOCAL points at p=13, 17, ... where
\\   the cover is smooth (good reduction); the Selmer image is then "(X-e_i) mod (Q_p^*)^2"
\\   for each bad p (the relevant primes for the Selmer condition).
\\
\\ The Selmer image is a subgroup of (Q*/Q*^2)^3 supported on the bad primes (and sign).
\\ Local points at p give the image mod (Q_p^*/Q_p^*^2). Combining all bad primes pins
\\ down the global triple.
\\
\\ For p > all bad primes, the cover has smooth points mod p (Weil/Hasse-Weil), and the
\\ Selmer condition is auto-satisfied. We only need bad primes.

default(parisize, 1500000000);
default(realprecision, 38);

read("/root/proof/perfect-cuboid-problem/scripts/4-descent/EHm_short_data.gp");
E_short = ellinit([0, A2_short, 0, A4_short, A6_short]);
e1 = e1_short; e2 = e2_short; e3 = e3_short;
covers = ell2cover(E_short);
BAD = [2, 3, 5, 7, 11, 19, 23, 31, 61, 223, 337, 1033];

\\ Compute Selmer triple from a rational/local point (x_C, y_C) on cover via cover_map:
{ get_triple_from_point(cover_data, x_C, y_C) =
  my(P_map, X_E, Y_E);
  P_map = cover_data[2];
  X_E = subst(subst(P_map[1], 'x, x_C), 'y, y_C);
  Y_E = subst(subst(P_map[2], 'x, x_C), 'y, y_C);
  [X_E - e1, X_E - e2, X_E - e3, X_E, Y_E];
}

\\ Reduce to squarefree integer
{ sqf_int(n) =
  my(num, den, k, sign_part, f, result);
  if(n == 0, return(0));
  num = numerator(n);
  den = denominator(n);
  k = num * den;
  sign_part = sign(k);
  k = abs(k);
  f = factor(k);
  result = 1;
  for(i = 1, matsize(f)[1],
    if(f[i, 2] % 2 == 1, result *= f[i, 1]);
  );
  sign_part * result;
}

\\ === Cover 1: x = 0, y = 8625278 ===
print("===========================================");
print("Cover 1: lift x=0, y=8625278 to E");
print("===========================================");
{
y1 = sqrtint(polcoeff(covers[1][1], 0));
trip1 = get_triple_from_point(covers[1], 0, y1);
print("  Lift: X = ", trip1[4], ", Y = ", trip1[5]);
print("  On curve? ", ellisoncurve(E_short, [trip1[4], trip1[5]]));
print("  Order = ", ellorder(E_short, [trip1[4], trip1[5]]));
\\ For non-2-torsion point: Selmer triple is (X-e1, X-e2, X-e3) mod squares
d1_1 = sqf_int(trip1[1]);
d2_1 = sqf_int(trip1[2]);
d3_1 = sqf_int(trip1[3]);
print("  X - e1 = ", trip1[1], " sqf = ", d1_1, " factored = ", factor(abs(d1_1)));
print("  X - e2 = ", trip1[2], " sqf = ", d2_1, " factored = ", factor(abs(d2_1)));
print("  X - e3 = ", trip1[3], " sqf = ", d3_1, " factored = ", factor(abs(d3_1)));
print("  Product d1*d2*d3 = ", d1_1 * d2_1 * d3_1, "  squarefree? ", issquare(d1_1 * d2_1 * d3_1));
S1 = [d1_1, d2_1, d3_1];
print("  Selmer triple S1 = ", S1);
}

\\ === Cover 2: x = 0, y = 57740923038752 ===
\\ This lifts to (e_2, 0) which IS 2-torsion. The Selmer image of a 2-torsion (e_i, 0) is:
\\   δ((e_i, 0)) = (..., e_i - e_j, ...) for j != i  AND  d_i = (e_i - e_j)(e_i - e_k) (closure of product)
\\ So we cannot directly read it from X - e_i = 0.
\\ Instead, the 2-descent map at 2-torsion is given by limits, equivalently:
\\   δ((e_2, 0)) = ((e_2 - e_1)(e_2 - e_3), e_2 - e_1, e_2 - e_3) mod squares
print();
print("===========================================");
print("Cover 2: lift x=0, y=57740923038752 to E");
print("===========================================");
{
y2 = sqrtint(polcoeff(covers[2][1], 0));
trip2 = get_triple_from_point(covers[2], 0, y2);
print("  Lift: X = ", trip2[4], ", Y = ", trip2[5], "  is e_2? ", trip2[4] == e2);
\\ Use the 2-torsion delta formula
d1_2 = sqf_int((e2 - e1) * (e2 - e3));
d2_2 = sqf_int(e2 - e1);
d3_2 = sqf_int(e2 - e3);
print("  d1 = (e2-e1)(e2-e3) sqf = ", d1_2, "  factored = ", factor(abs(d1_2)));
print("  d2 = (e2-e1)         sqf = ", d2_2, "  factored = ", factor(abs(d2_2)));
print("  d3 = (e2-e3)         sqf = ", d3_2, "  factored = ", factor(abs(d3_2)));
print("  Product = ", d1_2 * d2_2 * d3_2, "  squarefree? ", issquare(d1_2 * d2_2 * d3_2));
S2 = [d1_2, d2_2, d3_2];
print("  Selmer triple S2 = ", S2);
}

\\ === Cover 3 and 4: search for local points ===
\\ A Q_p point (x_C, y_C) gives a triple ((X-e1), (X-e2), (X-e3)) in (Q_p^*)^3.
\\ Mod (Q_p^*)^2, this tells us the LOCAL Selmer class. To get the GLOBAL Selmer
\\ class, we need to "lift" this local data to a global triple supported on BAD.
\\
\\ Practical approach: scan small x in Z (or Z/p Z) for which q(x) is a QR mod a chosen prime p
\\ with X (the lifted x-coord on E) not divisible by bad primes. Then sqf(X-e_i) gives the
\\ class mod squares at p.
\\
\\ Even simpler: since Selmer is global and S^2(E/Q) sits inside (Q*/Q*^2)^3 with prescribed
\\ support, the class is determined by its image at EACH bad prime. So we compute:
\\   For each bad prime p, find a Q_p point on the cover, extract local d-image.
\\   Then assemble global class via CRT-like procedure (each prime gives one bit per d_i).
\\
\\ For now, let's just see if we can find ANY local points easily.
print();
print("===========================================");
print("Cover 3: search local points");
print("===========================================");
{
q3 = covers[3][1];
print("q3(x) = ", q3);
\\ Try x = 0..50, see q3(x) factored
for(x_try = 0, 30,
  v = subst(q3, 'x, x_try);
  if(issquare(v),
    print("  RATIONAL POINT! x = ", x_try, " y^2 = ", v, " y = +-", sqrtint(v));
  );
);
\\ Try Q_p points: x mod p such that q3(x) is QR mod p
print("  Searching Q_p points for bad primes p:");
for(pj = 1, #BAD,
  p = BAD[pj];
  found = 0;
  for(x_try = 0, p-1,
    v = Mod(subst(q3, 'x, x_try), p);
    if(v == 0 || issquare(v),
      \\ Check more: lift to Q_p. Hensel's lemma works if q3 is smooth at this point mod p.
      \\ Just record the residue mod p; the local triple is (x_try - e_i mod p)
      print("    p=", p, " x≡", x_try, " mod p, q3(x)≡", v, " (square)");
      found = 1;
      break;
    );
  );
  if(!found, print("    p=", p, " NO solution mod p (would mean cover not locally soluble!)"));
);
}

print();
print("===========================================");
print("Cover 4: search local points");
print("===========================================");
{
q4 = covers[4][1];
\\ Try x = 0..50
for(x_try = 0, 50,
  v = subst(q4, 'x, x_try);
  if(issquare(v),
    print("  RATIONAL POINT! x = ", x_try, " y = +-", sqrtint(v));
  );
);
for(pj = 1, #BAD,
  p = BAD[pj];
  found = 0;
  for(x_try = 0, p-1,
    v = Mod(subst(q4, 'x, x_try), p);
    if(v == 0 || issquare(v),
      print("    p=", p, " x≡", x_try, " mod p, q4(x)≡", v);
      found = 1;
      break;
    );
  );
  if(!found, print("    p=", p, " NO solution"));
);
}

\\ ALTERNATIVE APPROACH: Use the THE FACT that S^2 is determined by an exact sequence.
\\ Since we know S^2 has F_2-dim 4 (basis: covers 1, 2, 3, 4), we can write:
\\   S^2 = span{ S1, S2, S3, S4 }
\\ and S1, S2 are known (S1 = order-8 torsion image, S2 = order-2 torsion image).
\\ Define V = (Q*/Q*^2)^{BAD+sign} = F_2^13 vector space.
\\ Inside V^3 with product=1 constraint: subspace of dim 26.
\\ S^2 is a 4-dim subspace; we know 2 vectors (S1, S2). The other 2 vectors (S3, S4)
\\ are determined by Selmer conditions (everywhere local solubility) up to 2-torsion.
\\
\\ We can search: which Selmer-condition-satisfying vectors complete the basis?
\\
\\ BUT this is a lot of work. Better: use Sage / Magma. In PARI 2.15.4, we don't have
\\ direct Selmer-class extraction.

\\ FALLBACK: just compute partial CT matrix using S1, S2 explicitly and the q-evaluation
\\ for S3, S4 (which is off by global square but well-defined RELATIVELY).

print();
print("===========================================");
print("Partial CT: use known triples S1, S2 + q-evaluations for S3, S4");
print("===========================================");

\\ For local Hilbert symbols, the global square modifier (the 'EXTRA' part) cancels
\\ when paired with bad-prime-supported triples. So Hilbert(S_i, S_j)_p = Hilbert(S_i, S_j_clean)_p
\\ where S_j_clean is the bad-prime part of S_j.
\\
\\ Let me extract just the BAD-prime+sign factor of each d_i:
{ proj_bad(n) =
  my(sign_part, k, p, e, result, nn);
  if(n == 0, return(0));
  sign_part = sign(n);
  nn = abs(n);
  result = 1;
  for(j = 1, #BAD,
    p = BAD[j];
    e = 0;
    while(nn % p == 0, nn = nn / p; e += 1);
    if(e % 2 == 1, result *= p);
  );
  sign_part * result;
}

{ get_triple_bad(q) =
  my(d1, d2, d3);
  d1 = subst(q, 'x, e1) / ((e1 - e2) * (e1 - e3));
  d2 = subst(q, 'x, e2) / ((e2 - e1) * (e2 - e3));
  d3 = subst(q, 'x, e3) / ((e3 - e1) * (e3 - e2));
  [proj_bad(numerator(d1) * denominator(d1)),
   proj_bad(numerator(d2) * denominator(d2)),
   proj_bad(numerator(d3) * denominator(d3))];
}

print();
print("Bad-prime projections of (q(e_i)/cofactor) per cover:");
{
T_bad = vector(#covers);
for(k = 1, #covers,
  T_bad[k] = get_triple_bad(covers[k][1]);
  print("Cover ", k, ": ", T_bad[k]);
  print("           d1 = ", factor(abs(T_bad[k][1])), " sign ", sign(T_bad[k][1]));
  print("           d2 = ", factor(abs(T_bad[k][2])), " sign ", sign(T_bad[k][2]));
  print("           d3 = ", factor(abs(T_bad[k][3])), " sign ", sign(T_bad[k][3]));
);
}

\\ NOTE: T_bad[k] may differ from true Selmer triple by an i-INDEPENDENT global square c_k
\\ (a constant for each cover). But the relative differences T_bad[k1] / T_bad[k2] should match
\\ S[k1] / S[k2] mod squares.
\\
\\ Compute Hilbert symbol matrix at each bad place and infinity.

PLACES = concat([-1], BAD);
{ hilbert_F2(a, b, v) = if(v == -1, if(hilbert(a, b, 0) == -1, 1, 0), if(hilbert(a, b, v) == -1, 1, 0)); }

\\ Variant: (d_1, d_2 d_3) + (d_2, d_3 d_1) + (d_3, d_1 d_2)  [Schaefer-style]
{ h_v_schaefer(a, b, v) = (hilbert_F2(a[1], b[2]*b[3], v) + hilbert_F2(a[2], b[3]*b[1], v) + hilbert_F2(a[3], b[1]*b[2], v)) % 2; }

\\ Symmetric: sum_{i!=j} (a_i, b_j)
{ h_v_offdiag(a, b, v) = ((hilbert_F2(a[1], b[2], v) + hilbert_F2(a[1], b[3], v) + hilbert_F2(a[2], b[1], v) + hilbert_F2(a[2], b[3], v) + hilbert_F2(a[3], b[1], v) + hilbert_F2(a[3], b[2], v)) % 2); }

print();
print("===========================================");
print("CT matrix (Schaefer-style) using T_bad triples:");
print("===========================================");
{
M = matrix(#covers, #covers);
for(i = 1, #covers,
  for(j = 1, #covers,
    s = 0;
    for(vi = 1, #PLACES,
      v = PLACES[vi];
      h = h_v_schaefer(T_bad[i], T_bad[j], v);
      s = (s + h) % 2;
    );
    M[i, j] = s;
  );
);
print("M = ");
print(M);
print("rank(M) over F_2 = ", matrank(M * Mod(1, 2)));
}

print();
print("===========================================");
print("CT matrix (off-diagonal) using T_bad triples:");
print("===========================================");
{
Moff = matrix(#covers, #covers);
for(i = 1, #covers,
  for(j = 1, #covers,
    s = 0;
    for(vi = 1, #PLACES,
      v = PLACES[vi];
      h = h_v_offdiag(T_bad[i], T_bad[j], v);
      s = (s + h) % 2;
    );
    Moff[i, j] = s;
  );
);
print("M_off = ");
print(Moff);
print("rank(M_off) over F_2 = ", matrank(Moff * Mod(1, 2)));
}

\\ Print pairwise per-place breakdown
print();
print("===========================================");
print("Per-place Hilbert (Schaefer) contributions for each pair (i<j):");
print("===========================================");
{
for(i = 1, #covers,
  for(j = i, #covers,
    print();
    print("Pair (", i, ", ", j, "):");
    total = 0;
    for(vi = 1, #PLACES,
      v = PLACES[vi];
      h = h_v_schaefer(T_bad[i], T_bad[j], v);
      vname = if(v == -1, "oo", Str(v));
      if(h != 0,
        print("  v=", vname, ": h=1");
      );
      total = (total + h) % 2;
    );
    print("  TOTAL h = ", total);
  );
);
}

quit;
