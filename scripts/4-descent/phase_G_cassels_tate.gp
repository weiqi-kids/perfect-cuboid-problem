\\ Phase G: Cassels-Tate pairing matrix on the 4 Selmer covers of E_Hm.
\\
\\ Method:
\\ 1. Extract Selmer triples (d_1, d_2, d_3) for each cover via the formula
\\      d_i^(α) = q_α(e_i) / [(e_i - e_j)(e_i - e_k)] mod Q*^2.
\\ 2. For each pair (α, β) and each place v in BAD ∪ {oo}, compute the local
\\    Hilbert-symbol contribution to the Cassels-Tate pairing:
\\      h_v(α, β) := (d_1^α, d_1^β)_v + (d_2^α, d_2^β)_v + (d_3^α, d_3^β)_v  in F_2
\\    summed over v: CT_pair(α, β) = Σ_v h_v(α, β) mod 2.
\\    (This is one common formulation; up to sign/correction it's the right matrix
\\    on Selmer/2-torsion.)
\\ 3. Build 4x4 matrix M over F_2 and compute its rank.
\\
\\ Interpretation:
\\   rk M = r implies kernel has dim 4-r. The kernel is the image of E(Q)/2E(Q)
\\   minus 2-torsion image (plus possibly Sha[4]/2 contributions).

default(parisize, 1500000000);
default(realprecision, 38);

read("/root/proof/perfect-cuboid-problem/scripts/4-descent/EHm_short_data.gp");
E_short = ellinit([0, A2_short, 0, A4_short, A6_short]);
e1 = e1_short; e2 = e2_short; e3 = e3_short;
covers = ell2cover(E_short);
print("Number of covers: ", #covers);

\\ Places: bad primes plus infinity (encode oo as -1)
BAD = [2, 3, 5, 7, 11, 19, 23, 31, 61, 223, 337, 1033];
PLACES = concat([-1], BAD);   \\ -1 means infinity

\\ Hilbert symbol (a, b)_v for v=-1 (infinity) or v=p prime.
\\ PARI has hilbert(a, b, p): returns -1 or 1; convert to {0,1} in F_2.
{ hilbert_F2(a, b, v) =
  if(v == -1,
    if(hilbert(a, b, 0) == -1, 1, 0)
  ,
    if(hilbert(a, b, v) == -1, 1, 0)
  );
}

\\ Cassels-Tate local contribution at place v for triples (a1,a2,a3) and (b1,b2,b3):
\\   Different formulas appear in literature. Implement multiple variants
\\   and compute them all.
\\ Variant A: h_v = (a1, b1) + (a2, b2) + (a3, b3) in F_2
\\ Variant B: h_v = (a1, b2) + (a2, b3) + (a3, b1) in F_2
\\ Variant C (Schaefer): h_v = (a1, b2*b3) + (a2, b3*b1) + (a3, b1*b2) in F_2
\\ Variant D (full): h_v = sum_{i,j} (a_i, b_j)
\\ These differ on individual entries but the rank pattern of the resulting matrix
\\ should be consistent (CT pairing is well-defined up to choice of co-cycle).

{ h_v_A(a, b, v) = (hilbert_F2(a[1], b[1], v) + hilbert_F2(a[2], b[2], v) + hilbert_F2(a[3], b[3], v)) % 2; }
{ h_v_B(a, b, v) = (hilbert_F2(a[1], b[2], v) + hilbert_F2(a[2], b[3], v) + hilbert_F2(a[3], b[1], v)) % 2; }
{ h_v_C(a, b, v) = (hilbert_F2(a[1], b[2]*b[3], v) + hilbert_F2(a[2], b[3]*b[1], v) + hilbert_F2(a[3], b[1]*b[2], v)) % 2; }

\\ Selmer triple extraction (rationals representing d_i mod squares)
{ selmer_triple(q) =
  my(d1, d2, d3);
  d1 = subst(q, 'x, e1) / ((e1 - e2) * (e1 - e3));
  d2 = subst(q, 'x, e2) / ((e2 - e1) * (e2 - e3));
  d3 = subst(q, 'x, e3) / ((e3 - e1) * (e3 - e2));
  [d1, d2, d3];
}

\\ Convert rational n to "squarefree representative" (an integer): num * den
{ sqf_rep(n) =
  if(n == 0, return(0));
  numerator(n) * denominator(n);
}

print();
print("===========================================");
print("Extracted Selmer triples:");
print("===========================================");
triples = vector(#covers);
{
for(k = 1, #covers,
  q = covers[k][1];
  trip = selmer_triple(q);
  trip_int = [sqf_rep(trip[1]), sqf_rep(trip[2]), sqf_rep(trip[3])];
  triples[k] = trip_int;
  print("Cover ", k, ":");
  print("  d1 = ", trip_int[1]);
  print("  d2 = ", trip_int[2]);
  print("  d3 = ", trip_int[3]);
  print("  product = ", trip_int[1] * trip_int[2] * trip_int[3], "  issquare? ", issquare(trip_int[1] * trip_int[2] * trip_int[3]));
);
}

print();
print("===========================================");
print("CT pairing matrix - VARIANT A: (a_i, b_i)_v");
print("===========================================");
{
M_A = matrix(#covers, #covers);
for(i = 1, #covers,
  for(j = 1, #covers,
    s = 0;
    for(vi = 1, #PLACES,
      v = PLACES[vi];
      h = h_v_A(triples[i], triples[j], v);
      s = (s + h) % 2;
    );
    M_A[i, j] = s;
  );
);
print("M_A = ");
print(M_A);
print("rank(M_A) over F_2 = ", matrank(M_A * Mod(1, 2)));
}

print();
print("===========================================");
print("CT pairing matrix - VARIANT B: (a_i, b_{i+1})_v");
print("===========================================");
{
M_B = matrix(#covers, #covers);
for(i = 1, #covers,
  for(j = 1, #covers,
    s = 0;
    for(vi = 1, #PLACES,
      v = PLACES[vi];
      h = h_v_B(triples[i], triples[j], v);
      s = (s + h) % 2;
    );
    M_B[i, j] = s;
  );
);
print("M_B = ");
print(M_B);
print("rank(M_B) over F_2 = ", matrank(M_B * Mod(1, 2)));
}

print();
print("===========================================");
print("CT pairing matrix - VARIANT C: (a_i, b_j*b_k)_v Schaefer-like");
print("===========================================");
{
M_C = matrix(#covers, #covers);
for(i = 1, #covers,
  for(j = 1, #covers,
    s = 0;
    for(vi = 1, #PLACES,
      v = PLACES[vi];
      h = h_v_C(triples[i], triples[j], v);
      s = (s + h) % 2;
    );
    M_C[i, j] = s;
  );
);
print("M_C = ");
print(M_C);
print("rank(M_C) over F_2 = ", matrank(M_C * Mod(1, 2)));
}

print();
print("===========================================");
print("Per-place Hilbert symbol contributions (Variant A) for each pair (i, j):");
print("===========================================");
{
for(i = 1, #covers,
  for(j = i+1, #covers,
    print("Pair (", i, ", ", j, "):");
    for(vi = 1, #PLACES,
      v = PLACES[vi];
      h = h_v_A(triples[i], triples[j], v);
      vname = if(v == -1, "oo", Str(v));
      if(h != 0,
        print("  v = ", vname, ": (d_1, d_1) = ",
              hilbert_F2(triples[i][1], triples[j][1], v),
              ", (d_2, d_2) = ", hilbert_F2(triples[i][2], triples[j][2], v),
              ", (d_3, d_3) = ", hilbert_F2(triples[i][3], triples[j][3], v),
              "  sum = ", h);
      );
    );
  );
);
}

print();
print("===========================================");
print("Summary:");
print("  rank(M_A) = ", matrank(M_A * Mod(1, 2)));
print("  rank(M_B) = ", matrank(M_B * Mod(1, 2)));
print("  rank(M_C) = ", matrank(M_C * Mod(1, 2)));
print();
print("Interpretation:");
print("  - rank = 4: non-degenerate => Sha[2] generates Selmer above E(Q) image");
print("              => dim Sha[2] = 4 minus E(Q)/2 image; combined with rk+dim=2");
print("              => more constraints.");
print("  - rank = 2: typical for either case");
print("  - rank = 0: all pairing trivial => uninformative");
print("===========================================");

quit;
