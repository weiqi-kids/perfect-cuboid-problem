\\ Phase β — Cassels-Tate pairing matrix for E_Hm.
\\
\\ Strategy:
\\ 1. Read the 16 Selmer triples from Phase α.
\\ 2. Encode each triple as F_2 vector w.r.t. factor base F = [-1, 2, 3, ..., 1033] (13 bits per coord = 39 bits per triple).
\\ 3. Compute torsion image dim_F2(<δ(E_Hm[2](Q))>) = 1 (since δ(e3,0) = id, δ(e1,0) = δ(e2,0)).
\\    But torsion of E_Hm = Z/8 × Z/2. dim_F2(image of E(Q)_tors / 2 E(Q)_tors) = 2.
\\ 4. Identify basis {β1, β2, β3, β4} of S² with the first 2 from torsion image (δ of T8 and δ of (e1,0))
\\    and the next 2 free.
\\ 5. Compute 4x4 Cassels-Tate matrix M_{ij} = <βi, βj>.
\\
\\ Schaefer formula (full 2-torsion):
\\   <α, β>_v = (α_1, β_2)_v + (α_2, β_3)_v + (α_3, β_1)_v   in F_2
\\   <α, β>   = Σ_v <α, β>_v
\\
\\ Validation: pairing must be (a) alternating: <α, α> = 0, (b) bilinear, (c) symmetric in F_2.
\\
\\ Decision rule:
\\ - rk(M) = 4 → Sha[2] = (Z/2)^4 ?? wait.
\\
\\ Actually correct interpretation (Cassels-Tate):
\\   ker(M restricted to S²/E[2]) = image of E(Q)/E_tors in S²/E[2]  (= rank component)
\\   rk(M) = 2 * dim(Sha[2]/something).
\\
\\ Let V = S²(E)/<δ(E(Q)_tors)>. dim V = rk + dim Sha[2].
\\ CT pairing on V is non-degenerate on Sha[2] component.
\\ ker(CT on V) = image of E(Q)/E_tors in V = rank component.
\\ So dim ker(CT|_V) = rk.
\\
\\ For E_Hm: dim V = 4 - dim(torsion image in S²) = 4 - 2 = 2 (since torsion image dim = 2: δ(T8), δ(e1,0)).
\\
\\ So CT pairing lives on 2-dimensional V. Alternating ⇒ rk(M_V) ∈ {0, 2}.
\\   rk(M_V) = 2 ⇒ dim Sha[2]_V = 2, dim ker = 0 = rk(E). So rk(E) = 0.
\\   rk(M_V) = 0 ⇒ dim ker = 2 = rk(E). So rk(E) = 2.
\\
\\ This is exactly the decisive bit.

default(parisize, 1500000000);

\\ Squarefree
sqf(n) = { my(s = sign(n), a = abs(n), f, r); if(n == 0, return(0)); f = factor(a); r = 1; for(i = 1, matsize(f)[1], if(f[i,2] % 2 == 1, r *= f[i,1])); s * r; }

\\ Hilbert symbol in F_2
hilb_F2(a, b, v) = { my(h); if(v == -1, h = hilbert(a, b, 0), h = hilbert(a, b, v)); if(h == -1, 1, 0); }

\\ Schaefer CT pairing
ct_schaefer(alpha, beta, places) =
{
  my(s);
  s = 0;
  for(j = 1, #places,
    my(v = places[j]);
    s = (s + hilb_F2(alpha[1], beta[2], v)
            + hilb_F2(alpha[2], beta[3], v)
            + hilb_F2(alpha[3], beta[1], v)) % 2;
  );
  s;
}

\\ E_Hm data
e1 = -298991117938864;
e2 = 136054851567711;
e3 = 162936266371152;
F_base = [-1, 2, 3, 5, 7, 11, 19, 23, 31, 61, 223, 337, 1033];
BAD = [2, 3, 5, 7, 11, 19, 23, 31, 61, 223, 337, 1033];
PLACES = concat([-1], BAD);

\\ The 16 Selmer triples from Phase α
{
S2 = [[1, 1, 1], [1, -759, -759], [8012167, 6913, 1159], [8012167, -5246967, -879681], [2734081, -2359, -1159], [2734081, 1790481, 879681], [16307767, -16307767, -1], [16307767, 12377595153, 759], [10330, -15495, -6], [10330, 1306745, 506], [82765685110, -107116935, -6954], [82765685110, 9033528185, 586454], [28243056730, 36552705, 6954], [28243056730, -3082611455, -586454], [168459233110, 252688849665, 6], [168459233110, -21310092988415, -506]];
}

\\ Encode integer in F_2^nF w.r.t. factor base.
\\ Returns vector of bits.
to_vec(n) =
{
  my(v, k, p);
  v = vector(#F_base);
  for(k = 1, #F_base,
    p = F_base[k];
    if(p == -1, v[k] = if(n < 0, 1, 0), v[k] = valuation(n, p) % 2);
  );
  v;
}

\\ Encode triple as F_2 vector of length 3*nF
triple_to_vec(t) =
{
  my(v1 = to_vec(t[1]), v2 = to_vec(t[2]), v3 = to_vec(t[3]));
  concat(concat(v1, v2), v3);
}

\\ Build matrix of S² in F_2 (rows = triples)
print("Encoding S² as F_2 matrix...");
M_S2 = matrix(#S2, 3 * #F_base);
{
for(i = 1, #S2,
  my(vv = triple_to_vec(S2[i]));
  for(j = 1, 3 * #F_base, M_S2[i, j] = vv[j]);
);
}
print("Rank of S² as F_2 matrix = ", matrank(M_S2 * Mod(1,2)));

\\ Torsion images
delta_e1 = [sqf((e1-e2)*(e1-e3)), sqf(e1-e2), sqf(e1-e3)];
delta_e2 = [sqf(e2-e1), sqf((e2-e1)*(e2-e3)), sqf(e2-e3)];
delta_e3 = [sqf(e3-e1), sqf(e3-e2), sqf((e3-e1)*(e3-e2))];
print("delta(e1,0) = ", delta_e1);
print("delta(e2,0) = ", delta_e2);
print("delta(e3,0) = ", delta_e3);

\\ Find which triples are these in S2
{
for(k = 1, #S2,
  if(S2[k] == delta_e1, print("S2[", k, "] = delta(e1,0)"));
  if(S2[k] == delta_e2, print("S2[", k, "] = delta(e2,0)"));
  if(S2[k] == delta_e3, print("S2[", k, "] = delta(e3,0)"));
);
}

\\ Find image of E(Q)_tors / 2 E(Q)_tors:
\\ E_Hm.tors = Z/8 × Z/2.
\\ A generator of order 8: lifts to (x, y) with x = some integer. From prior work (Phase F), the order-8 point lifts from Cover #1 at x=0.
\\ Concretely: P_8 on E_Hm corresponds to cover_1 (x=0, y=...).
\\ The Selmer image of P_8 is one of the triples in S². From SESSION analysis: P_8 → S1 (Cover #1) = [28243056730, -3082611455, -586454].
\\ A generator of order 2 that's NOT in <2 P_8>: that's an (e_i, 0). δ(e_i,0) gives [16307767, -16307767, -1] (= δ(e1) = δ(e2)).
\\ Or δ(e3,0) = [1, 1, 1] = 0 (trivial).
\\
\\ So torsion image basis in S² has dim 2:
\\   T1_image = delta_e1 = [16307767, -16307767, -1]   (from rational 2-torsion (e1,0))
\\   T2_image = S1_cover1 = [28243056730, -3082611455, -586454]   (from order-8 torsion)
\\
\\ These should be linearly independent in S². Verify.

T1_image = [16307767, -16307767, -1];
T2_image = [28243056730, -3082611455, -586454];

print("");
print("Torsion image basis:");
print("  T1_image (from (e1,0)) = ", T1_image);
print("  T2_image (from 8-torsion) = ", T2_image);

\\ Verify these are in S²
{
print("Verifying torsion images are in S²:");
in_S2_T1 = 0;
in_S2_T2 = 0;
for(k = 1, #S2,
  if(S2[k] == T1_image, in_S2_T1 = k);
  if(S2[k] == T2_image, in_S2_T2 = k);
);
print("  T1_image in S² at index ", in_S2_T1);
print("  T2_image in S² at index ", in_S2_T2);
}

\\ Linear-algebra approach: pick a basis of S² (=4 elements), then find which span torsion.
print("");
print("=== Linear algebra ===");
\\ All 16 triples form a 4-dim F_2 vector space. Find basis vectors.

\\ S² as F_2 generators (the matrix M_S2). Find 4 linearly independent triples.
basis_indices = List();
B = matrix(0, 3 * #F_base);  \\ growing basis matrix
{
for(i = 1, #S2,
  my(vv = triple_to_vec(S2[i]), Btest);
  if(matsize(B)[1] == 0,
    \\ first nonzero
    if(vecmax(abs(vv)) > 0,
      B = matrix(1, #vv, r, c, vv[c]);
      listput(basis_indices, i);
    );
    next
  );
  Btest = matconcat([B; matrix(1, #vv, r, c, vv[c])]);
  if(matrank(Btest * Mod(1,2)) > matrank(B * Mod(1,2)),
    B = Btest;
    listput(basis_indices, i);
  );
);
}
print("Basis of S² as F_2: indices ", basis_indices);
print("Basis matrix dimensions: ", matsize(B));
print("Basis triples:");
{
for(k = 1, #basis_indices, print("  beta_", k, " = ", S2[basis_indices[k]]));
}

\\ Choose torsion-aware basis:
\\   beta_1 = T1_image (rational 2-torsion delta)
\\   beta_2 = T2_image (order-8 torsion delta)
\\   beta_3, beta_4 = other independent elements of S²
\\
\\ Form change-of-basis to find {beta_3, beta_4} ⊂ S² that span S² mod torsion image.

print("");
print("=== Constructing torsion-aware basis ===");
\\ Convert T1, T2 to F_2 vectors
v_T1 = triple_to_vec(T1_image);
v_T2 = triple_to_vec(T2_image);
B_tors = matrix(2, 3 * #F_base, r, c, if(r == 1, v_T1[c], v_T2[c]));
print("rank(B_tors mod 2) = ", matrank(B_tors * Mod(1,2)));

\\ Find 2 more triples that, with T1 and T2, give a basis of S².
final_basis = List([T1_image, T2_image]);
B = B_tors;
{
for(i = 1, #S2,
  my(vv = triple_to_vec(S2[i]), Btest);
  Btest = matconcat([B; matrix(1, #vv, r, c, vv[c])]);
  if(matrank(Btest * Mod(1,2)) > matrank(B * Mod(1,2)),
    B = Btest;
    listput(final_basis, S2[i]);
    if(#final_basis == 4, break);
  );
);
}
print("Final basis (size ", #final_basis, "):");
{
for(k = 1, #final_basis, print("  beta_", k, " = ", final_basis[k]));
}

\\ === Cassels-Tate matrix (Schaefer variant) ===
print("");
print("=== Cassels-Tate matrix (Schaefer variant) ===");
M_CT = matrix(4, 4);
{
for(i = 1, 4,
  for(j = 1, 4,
    M_CT[i, j] = ct_schaefer(final_basis[i], final_basis[j], PLACES);
  );
);
}
print("M_CT (Schaefer) =");
print(M_CT);
print("rank(M_CT) over F_2 = ", matrank(M_CT * Mod(1,2)));

\\ Per-place contributions for diagnostic
print("");
print("Per-place CT contributions for beta_3, beta_4 pair (Schaefer):");
{
my(s_per_place = 0);
for(j = 1, #PLACES,
  my(v = PLACES[j], contrib);
  contrib = (hilb_F2(final_basis[3][1], final_basis[4][2], v) + hilb_F2(final_basis[3][2], final_basis[4][3], v) + hilb_F2(final_basis[3][3], final_basis[4][1], v)) % 2;
  print("  v=", v, " contrib=", contrib);
  s_per_place = (s_per_place + contrib) % 2;
);
print("  Total: ", s_per_place);
}

\\ Variant 2: symmetric
print("");
print("=== CT variant 2 (off-diag full) ===");
ct_offdiag(alpha, beta, places) =
{
  my(s);
  s = 0;
  for(j = 1, #places,
    my(v = places[j]);
    s = (s + hilb_F2(alpha[1], beta[2], v) + hilb_F2(alpha[1], beta[3], v) + hilb_F2(alpha[2], beta[1], v) + hilb_F2(alpha[2], beta[3], v) + hilb_F2(alpha[3], beta[1], v) + hilb_F2(alpha[3], beta[2], v)) % 2;
  );
  s;
}
M_CT2 = matrix(4, 4);
{
for(i = 1, 4,
  for(j = 1, 4,
    M_CT2[i, j] = ct_offdiag(final_basis[i], final_basis[j], PLACES);
  );
);
}
print("M_CT (off-diag full) =");
print(M_CT2);
print("rank(M_CT2) over F_2 = ", matrank(M_CT2 * Mod(1,2)));

\\ Variant 3: Stamminger / Cassels-Schaefer (Cassels 1998)
\\ <α, β> = Σ_v <a_v, beta - delta(P_v)>_v ...  this requires global P_v
\\ Simpler form: <α, β> = sum over primes p of Σ_i (α_i, β_{i+1}*β_{i+2})_p
print("");
print("=== CT variant 3 (Cassels-Schaefer alternative) ===");
ct_schaefer_v3(alpha, beta, places) =
{
  my(s);
  s = 0;
  for(j = 1, #places,
    my(v = places[j]);
    \\ Symmetric: (a_1, b_1) + (a_2, b_2) + (a_3, b_3)  — but this is symmetric, not alternating
    \\ Use the alternating combination (a_i, b_j) where (i, j) = (1, 2), (2, 1)
    \\ <α, β>_v = (a_1, b_2)_v + (a_2, b_1)_v
    s = (s + hilb_F2(alpha[1], beta[2], v) + hilb_F2(alpha[2], beta[1], v)) % 2;
  );
  s;
}
M_CT3 = matrix(4, 4);
{
for(i = 1, 4,
  for(j = 1, 4,
    M_CT3[i, j] = ct_schaefer_v3(final_basis[i], final_basis[j], PLACES);
  );
);
}
print("M_CT (variant 3) =");
print(M_CT3);
print("rank(M_CT3) over F_2 = ", matrank(M_CT3 * Mod(1,2)));

\\ Check alternating
print("");
print("Diagonal entries (must be 0 if alternating):");
{
for(i = 1, 4, print("  M[", i, ",", i, "] = ", M_CT[i, i]));
}

\\ Decision:
\\ Recall:
\\   - In our final basis, beta_1 and beta_2 are torsion-image (δ(E(Q)_tors)).
\\   - beta_3, beta_4 generate S² / δ(E(Q)_tors).
\\
\\ CT pairing properties:
\\   - CT(beta_1, anything) = 0 (since torsion image is in kernel of CT on full S²).
\\   - CT(beta_2, anything) = 0 (same).
\\   - CT(beta_3, beta_4) and CT(beta_3, beta_3), CT(beta_4, beta_4) live in S²/torsion 2-d space.
\\
\\ So M_CT should have its first 2 rows/cols all zero (CT vanishes on torsion image).
\\ The lower-right 2x2 block gives the CT pairing on S²/torsion_image.

print("");
print("Lower-right 2x2 block (CT on S²/E(Q)_tors_image):");
print("M[3..4, 3..4] = [", M_CT[3,3], " ", M_CT[3,4], "; ", M_CT[4,3], " ", M_CT[4,4], "]");

submatrix_22 = [M_CT[3,3], M_CT[3,4]; M_CT[4,3], M_CT[4,4]];
print("rank of lower-right 2x2 over F_2 = ", matrank(submatrix_22 * Mod(1,2)));

\\ Final verdict
print("");
print("===========================================");
print("VERDICT");
print("===========================================");
verdict_r = matrank(submatrix_22 * Mod(1,2));
print("rank(M_22) = ", verdict_r);
{
if(verdict_r == 2,
  print("→ Sha(E_Hm)[2] = (Z/2)^2, rk(E_Hm) = 0");
  print("→ (61, 38) BECOMES CLOSEABLE.");
  ,
  if(verdict_r == 0,
    print("→ Sha(E_Hm)[2] = 0, rk(E_Hm) = 2");
    print("→ (61, 38) PERMANENTLY EXITS GENUS-2 TIER.");
    ,
    print("→ rank = 1 INCONSISTENT (alternating, must be even); CHECK FORMULA");
  );
);
}

quit;
