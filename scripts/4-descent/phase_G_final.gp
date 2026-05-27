\\ Phase G FINAL: Honest partial CT computation.
\\
\\ We have:
\\   S1 (Cover 1, lifts to order-8 torsion):  (28243056730, -3082611455, -586454)
\\   S2 (Cover 2, lifts to (e_2, 0) order 2): (-16307767, 16307767, -1)
\\ These are known correctly.
\\
\\ For S3, S4 (Covers 3, 4) we lack a rigorous extraction in PARI 2.15.4
\\ (no exposed Selmer triple via ell2cover).
\\
\\ What we CAN do:
\\   1. Verify S1, S2 are valid Selmer classes (product square, locally soluble).
\\   2. Compute the 2x2 Hilbert symbol matrix on {S1, S2}.
\\   3. By CT theory: CT(S_torsion, anything) = 0. So the 4x4 CT matrix on the
\\      4-dim Selmer basis has its first 2 rows/columns (corresponding to S1, S2)
\\      being identically 0. The relevant 2x2 sub-matrix is CT on the S3, S4 part.
\\   4. We provide a rigorous lower bound: rk(CT_matrix) >= rk(2x2 Hilbert on S1, S2)
\\      = 0 (since they're torsion images).
\\   5. The only way to compute the (3, 4) part of CT is via Magma's CasselsTatePairing
\\      function, which is not available in PARI 2.15.4.

default(parisize, 1500000000);
default(realprecision, 38);

read("/root/proof/perfect-cuboid-problem/scripts/4-descent/EHm_short_data.gp");
E_short = ellinit([0, A2_short, 0, A4_short, A6_short]);
e1 = e1_short; e2 = e2_short; e3 = e3_short;
covers = ell2cover(E_short);

BAD = [2, 3, 5, 7, 11, 19, 23, 31, 61, 223, 337, 1033];
PLACES = concat([-1], BAD);

\\ Hilbert symbol over F_2
{ hilbert_F2(a, b, v) =
  if(v == -1, if(hilbert(a, b, 0) == -1, 1, 0), if(hilbert(a, b, v) == -1, 1, 0));
}

\\ The known Selmer triples
S1 = [28243056730, -3082611455, -586454];
S2 = [-16307767, 16307767, -1];

print("===========================================");
print("Phase G: CT Pairing analysis on E_Hm Selmer basis");
print("===========================================");
print();
print("Known Selmer triples (verified by direct lift):");
print("  S1 (Cover 1, order-8 torsion image):  ", S1);
print("    d1 = 2·5·7·19·61·337·1033");
print("    d2 = -5·7·11·23·337·1033");
print("    d3 = -2·11·19·23·61");
print("  S2 (Cover 2, order-2 torsion image): ", S2);
print("    d1 = -7·31·223·337");
print("    d2 = +7·31·223·337");
print("    d3 = -1");
print();

\\ Verify product = 1 mod squares
prod_S1 = S1[1] * S1[2] * S1[3];
prod_S2 = S2[1] * S2[2] * S2[3];
print("S1 product = ", prod_S1, "  is_square? ", issquare(prod_S1));
print("S2 product = ", prod_S2, "  is_square? ", issquare(prod_S2));

\\ S1 and S2 are linearly independent over F_2 in (Q*/Q*^2)^3?
\\ Encode in F_2 basis (sign, 2, 3, 5, 7, 11, 19, 23, 31, 61, 223, 337, 1033)
{ enc_F2(n) =
  my(v, k, p, e, nn);
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
  if(nn != 1, error("non-bad prime in ", n));
  v;
}

print();
print("F_2 encodings (over [sign, 2, 3, 5, 7, 11, 19, 23, 31, 61, 223, 337, 1033]):");
print("  S1[1] = ", enc_F2(S1[1]));
print("  S1[2] = ", enc_F2(S1[2]));
print("  S1[3] = ", enc_F2(S1[3]));
print("  S2[1] = ", enc_F2(S2[1]));
print("  S2[2] = ", enc_F2(S2[2]));
print("  S2[3] = ", enc_F2(S2[3]));

\\ Concatenated vectors
v_S1 = concat(concat(enc_F2(S1[1]), enc_F2(S1[2])), enc_F2(S1[3]));
v_S2 = concat(concat(enc_F2(S2[1]), enc_F2(S2[2])), enc_F2(S2[3]));
print();
print("Concatenated S1 vector (length ", #v_S1, "): ", v_S1);
print("Concatenated S2 vector: ", v_S2);

\\ Check linear independence over F_2
M = Mat([v_S1; v_S2]);
print();
print("Matrix [S1; S2]:");
print(M);
print("Rank over F_2: ", matrank(M * Mod(1, 2)));

\\ Compute Hilbert pairing matrix between S1 and S2 at each place
print();
print("===========================================");
print("Per-place Hilbert symbols (Schaefer variant) for (S1, S2):");
print("===========================================");
{
total_C = 0;
total_A = 0;
total_B = 0;
for(vi = 1, #PLACES,
  v = PLACES[vi];
  hC = (hilbert_F2(S1[1], S2[2]*S2[3], v) + hilbert_F2(S1[2], S2[3]*S2[1], v) + hilbert_F2(S1[3], S2[1]*S2[2], v)) % 2;
  hA = (hilbert_F2(S1[1], S2[1], v) + hilbert_F2(S1[2], S2[2], v) + hilbert_F2(S1[3], S2[3], v)) % 2;
  hB = (hilbert_F2(S1[1], S2[2], v) + hilbert_F2(S1[2], S2[3], v) + hilbert_F2(S1[3], S2[1], v)) % 2;
  total_C = (total_C + hC) % 2;
  total_A = (total_A + hA) % 2;
  total_B = (total_B + hB) % 2;
  vname = if(v == -1, "oo", Str(v));
  if(hC != 0 || hA != 0 || hB != 0,
    print("  v=", vname, ": hA=", hA, " hB=", hB, " hC=", hC);
  );
);
print("Sum over places: hA=", total_A, " hB=", total_B, " hC=", total_C);
print("Expected: CT(S1, S2) = 0 (both torsion images, must pair trivially).");
}

\\ Now compute CT(S1, S1), CT(S2, S2) — must be 0 (alternating).
print();
print("CT(S1, S1) check (must = 0 by alternating):");
{
total_C = 0;
for(vi = 1, #PLACES,
  v = PLACES[vi];
  hC = (hilbert_F2(S1[1], S1[2]*S1[3], v) + hilbert_F2(S1[2], S1[3]*S1[1], v) + hilbert_F2(S1[3], S1[1]*S1[2], v)) % 2;
  total_C = (total_C + hC) % 2;
);
print("  CT(S1, S1) [Schaefer] = ", total_C);
}

print("CT(S2, S2) check:");
{
total_C = 0;
for(vi = 1, #PLACES,
  v = PLACES[vi];
  hC = (hilbert_F2(S2[1], S2[2]*S2[3], v) + hilbert_F2(S2[2], S2[3]*S2[1], v) + hilbert_F2(S2[3], S2[1]*S2[2], v)) % 2;
  total_C = (total_C + hC) % 2;
);
print("  CT(S2, S2) [Schaefer] = ", total_C);
}

\\ Information-theoretic analysis:
print();
print("===========================================");
print("Information-theoretic structure:");
print("===========================================");
print("dim_F2 S^2(E_Hm/Q) = 4");
print("S^2 contains image of E_Hm[2](Q) = (Z/2)^2 (full 2-torsion)");
print("Image of 2-torsion has dim_F2 = 2 — that's S1 (= δ(order-8 generator)) and S2 (= δ(order-2 elt)).");
print("Quotient S^2 / δ(E[2]) has dim_F2 = 2, generated by classes of Covers 3, 4.");
print();
print("By Cassels-Tate alternating pairing on S^2 / δ(E[2]) = Sha[2] + E(Q)/torsion image:");
print("  CT is well-defined and alternating on a 2-dim F_2 space.");
print("  Alternating on F_2^2: either identically zero, or matrix [[0,1],[1,0]] (rank 2).");
print();
print("Case A (CT trivial on Cov3, Cov4):");
print("  Cov3, Cov4 could either ALL be in E(Q)/torsion image (=> rk = 2) OR all in Sha[2]");
print("    (=> rk = 0, Sha[2] = (Z/2)^2 with CT identically 0 — BUT this contradicts");
print("    CT being non-deg on Sha[2] by Cassels' theorem).");
print("  Actually CT on Sha[2] is NON-DEGENERATE alternating; on a 2-dim Sha[2] it must be");
print("    rank 2. So CT trivial => no Sha[2] above E(Q)-image => rk = 2.");
print();
print("Case B (CT non-trivial on Cov3, Cov4):");
print("  Then S3, S4 are NOT both in E(Q) image => Sha[2] >= 2-dim. Combined with");
print("    rk + dim Sha[2] = 2 => rk = 0, Sha[2] = (Z/2)^2.");
print();
print("CONCLUSION:");
print("  CT(S3, S4) ≠ 0 (in F_2) ⟺ rk(E_Hm) = 0.");
print("  This is exactly the missing computation we need.");
print();
print("Without correct S3, S4 triples we cannot compute this rigorously in PARI 2.15.4.");
print("Magma's CasselsTatePairing function (or hand-coded local-invariant computation");
print("on covers 3 and 4 with explicit local solubility witness) is required.");

\\ Try one more thing: compute Hilbert symbols on the cover quartic data directly
\\ at each bad place, summing over places. This gives SOMETHING, even if not literally CT.
print();
print("===========================================");
print("Hilbert symbol product on (c4, c0) of covers, raw:");
print("===========================================");
{
c_covers = vector(#covers);
for(k = 1, #covers,
  q = covers[k][1];
  c_covers[k] = [polcoeff(q, 4), polcoeff(q, 0)];
  print("Cover ", k, ": c4=", c_covers[k][1], ", c0=", c_covers[k][2]);
);

\\ Compute (c4_i, c0_j)_v + (c0_i, c4_j)_v for various places
print();
print("Sum over places of [(c4_i, c4_j) + (c0_i, c0_j) + (c4_i, c0_j) + (c0_i, c4_j)] mod 2:");
M_raw = matrix(#covers, #covers);
for(i = 1, #covers,
  for(j = 1, #covers,
    s = 0;
    for(vi = 1, #PLACES,
      v = PLACES[vi];
      h = (hilbert_F2(c_covers[i][1], c_covers[j][1], v)
         + hilbert_F2(c_covers[i][2], c_covers[j][2], v)
         + hilbert_F2(c_covers[i][1], c_covers[j][2], v)
         + hilbert_F2(c_covers[i][2], c_covers[j][1], v)) % 2;
      s = (s + h) % 2;
    );
    M_raw[i, j] = s;
  );
);
print("Raw Hilbert matrix [(c4_i, c4_j) + (c0_i, c0_j) + (c4_i, c0_j) + (c0_i, c4_j)]:");
print(M_raw);
print("Rank over F_2: ", matrank(M_raw * Mod(1, 2)));
}

quit;
