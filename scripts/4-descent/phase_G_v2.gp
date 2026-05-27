\\ Phase G v2: clean Selmer triples (reduce mod squares; restrict to BAD primes and sign)
\\ then compute the Hilbert-symbol matrix.
\\
\\ For correctness, after extracting d_i = q(e_i)/[(e_i-e_j)(e_i-e_k)], we reduce mod
\\ squares: keep only squarefree part. We expect the squarefree part to be supported
\\ entirely on the bad primes (plus sign). If there's a leftover "EXTRA prime" factor,
\\ that's a sign of the formula being off by a constant — but since all 4 covers share
\\ the SAME leftover (as a global square modifier from ell2cover normalization), the
\\ relative class is correct.

default(parisize, 1500000000);
default(realprecision, 38);

read("/root/proof/perfect-cuboid-problem/scripts/4-descent/EHm_short_data.gp");
E_short = ellinit([0, A2_short, 0, A4_short, A6_short]);
e1 = e1_short; e2 = e2_short; e3 = e3_short;
covers = ell2cover(E_short);

BAD = [2, 3, 5, 7, 11, 19, 23, 31, 61, 223, 337, 1033];
PLACES = concat([-1], BAD);

\\ Squarefree reduction: input rational n, output integer that is squarefree representative
\\ (multiply num*den, then divide out square factors).
{ make_sqf(n) =
  my(num, den, k, f, result, sign_part);
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

\\ Selmer triple
{ selmer_triple(q) =
  my(d1, d2, d3);
  d1 = subst(q, 'x, e1) / ((e1 - e2) * (e1 - e3));
  d2 = subst(q, 'x, e2) / ((e2 - e1) * (e2 - e3));
  d3 = subst(q, 'x, e3) / ((e3 - e1) * (e3 - e2));
  [make_sqf(d1), make_sqf(d2), make_sqf(d3)];
}

print("===========================================");
print("Reduced Selmer triples (squarefree representatives):");
print("===========================================");
{
triples = vector(#covers);
for(k = 1, #covers,
  q = covers[k][1];
  trip = selmer_triple(q);
  triples[k] = trip;
  print("Cover ", k, ":");
  print("  d1 = ", trip[1]);
  print("  d2 = ", trip[2]);
  print("  d3 = ", trip[3]);
  print("  d1 factored = ", if(trip[1] != 0, factor(abs(trip[1])), 0));
  print("  d2 factored = ", if(trip[2] != 0, factor(abs(trip[2])), 0));
  print("  d3 factored = ", if(trip[3] != 0, factor(abs(trip[3])), 0));
  pprod = trip[1] * trip[2] * trip[3];
  print("  product = ", pprod, "  sqf? ", issquare(pprod));
);
}

\\ Now compute (d_i^α / d_i^β) mod squares: this is the RELATIVE class, free of common normalization.
print();
print("===========================================");
print("Pairwise relative triples (d_i^α * d_i^β / common-norm, mod squares):");
print("===========================================");
{
\\ Define rel_triple(α, β) = (d1^α * d1^β, d2^α * d2^β, d3^α * d3^β) mod squares
for(i = 1, #covers,
  for(j = i, #covers,
    rt1 = make_sqf(triples[i][1] * triples[j][1]);
    rt2 = make_sqf(triples[i][2] * triples[j][2]);
    rt3 = make_sqf(triples[i][3] * triples[j][3]);
    print("Pair (", i, ",", j, "): rel = (", rt1, ", ", rt2, ", ", rt3, ")");
  );
);
}

\\ The actual Selmer class lives in (Q*/Q*^2)^3 / (1, 1, 1)-translation by overall square.
\\ So the meaningful thing is the triple modulo (c, c, c) where c is any rational.
\\ Effective: take ratios d1/d2, d2/d3 mod squares.
print();
print("===========================================");
print("Pairwise ratios d1/d2 and d2/d3 mod squares per cover:");
print("===========================================");
{
for(k = 1, #covers,
  r12 = make_sqf(triples[k][1] * triples[k][2]);   \\ d1*d2 mod squares
  r23 = make_sqf(triples[k][2] * triples[k][3]);   \\ d2*d3 mod squares
  print("Cover ", k, ": (d1*d2, d2*d3) mod sq = (", r12, ", ", r23, ")");
  print("           factored: ", if(r12 != 0, factor(abs(r12)), 0), "  ,  ", if(r23 != 0, factor(abs(r23)), 0));
);
}

\\ Hilbert symbol pairing
{ hilbert_F2(a, b, v) =
  if(v == -1,
    if(hilbert(a, b, 0) == -1, 1, 0)
  ,
    if(hilbert(a, b, v) == -1, 1, 0)
  );
}

\\ Variant C (Schaefer): h_v(α, β) = (a_1, b_2 b_3) + (a_2, b_3 b_1) + (a_3, b_1 b_2) mod 2
\\ Using cleaned triples
{ h_v_C(a, b, v) = (hilbert_F2(a[1], b[2]*b[3], v) + hilbert_F2(a[2], b[3]*b[1], v) + hilbert_F2(a[3], b[1]*b[2], v)) % 2; }

\\ Variant D (symmetric Schaefer alt): h_v(α, β) = (a_1 a_2, b_1 b_2) + ...
\\ This is actually = (a_1, b_1)(a_1, b_2)(a_2, b_1)(a_2, b_2) which factors badly.

\\ Build M_C
print();
print("===========================================");
print("CT pairing matrix - VARIANT C (clean):");
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
print("M_C symmetric? ", M_C == mattranspose(M_C));
}

\\ Build M_A
{ h_v_A(a, b, v) = (hilbert_F2(a[1], b[1], v) + hilbert_F2(a[2], b[2], v) + hilbert_F2(a[3], b[3], v)) % 2; }
print();
print("===========================================");
print("CT pairing matrix - VARIANT A (clean):");
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
print("M_A symmetric? ", M_A == mattranspose(M_A));
}

\\ Per-place breakdown for variant C
print();
print("===========================================");
print("Per-place Hilbert contributions (Variant C):");
print("===========================================");
{
for(i = 1, #covers,
  for(j = i, #covers,
    print();
    print("Pair (", i, ",", j, "):");
    total = 0;
    for(vi = 1, #PLACES,
      v = PLACES[vi];
      h = h_v_C(triples[i], triples[j], v);
      vname = if(v == -1, "oo", Str(v));
      total = (total + h) % 2;
      if(h != 0,
        print("  v = ", vname, ": h = 1");
      );
    );
    print("  TOTAL h = ", total);
  );
);
}

print();
print("===========================================");
print("Interpretation:");
print("===========================================");
print("If CT matrix has rank 2 (kernel dim 2):");
print("  E(Q)/2E(Q) has F_2-dimension >= dim(kernel) - dim(torsion image)");
print("  Selmer has dim 4 = 2 (torsion) + rk + dim Sha[2]");
print("  So rk + dim Sha[2] = 2.");
print("  CT non-degenerate on Sha[2] => dim Sha[2] even.");
print();
print("Kernel description:");
{
kerC = matker(M_C * Mod(1, 2));
print("ker(M_C) = ", kerC, " dim = ", matsize(kerC)[2]);
}

quit;
