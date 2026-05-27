\\ ct_bit_61_38_v2.gp
\\ ===================
\\ Try MULTIPLE candidate CT formulas to see which gives a non-trivial answer.
\\ Test on the trivial pair (beta_3, beta_3): should be 0 (alternating).
\\ Test on torsion-image pairs: should be 0.
\\ Look for the unique formula that satisfies these constraints AND gives
\\ a non-trivial result for the right test curves.

default(parisize, 1500000000);

e1 = -298991117938864;
e2 =  136054851567711;
e3 =  162936266371152;
BAD = [2, 3, 5, 7, 11, 19, 23, 31, 61, 223, 337, 1033];
PLACES = concat([0], BAD);  \\ 0 = real place in PARI's hilbert convention

beta_3 = [1, -759, -759];
beta_4 = [8012167, 6913, 1159];
beta_1 = [16307767, -16307767, -1];
beta_2 = [28243056730, -3082611455, -586454];
\\ Triples from S²:
all_triples = [[1, 1, 1], [1, -759, -759], [8012167, 6913, 1159], [8012167, -5246967, -879681], [2734081, -2359, -1159], [2734081, 1790481, 879681], [16307767, -16307767, -1], [16307767, 12377595153, 759], [10330, -15495, -6], [10330, 1306745, 506], [82765685110, -107116935, -6954], [82765685110, 9033528185, 586454], [28243056730, 36552705, 6954], [28243056730, -3082611455, -586454], [168459233110, 252688849665, 6], [168459233110, -21310092988415, -506]];

\\ Hilbert F2
hF2(a, b, v) = if(hilbert(a, b, v) == -1, 1, 0);

\\ ----- Witness finding (re-use logic from v1) -----
is_sq_Qp(z, p) =
{
  my(v, u);
  if(z == 0, return(1));
  v = valuation(z, p);
  if(v % 2 != 0, return(0));
  u = z / p^v;
  if(p == 2, return(Mod(u, 8) == Mod(1, 8)));
  return(issquare(Mod(u, p)));
};

local_witness(p, d1, d2, d3) =
{
  my(vp_max, K_i, klist, results);
  vp_max = max(max(valuation(e1-e2, p), valuation(e1-e3, p)), valuation(e2-e3, p));
  results = List();
  klist = List();
  my(kparity = vector(3, i, valuation([d1, d2, d3][i], p) % 2));
  K_i = vector(3, i, vp_max + 1);

  for(k1 = 0, K_i[1],
    if(k1 % 2 != kparity[1], next);
    for(k2 = 0, K_i[2],
      if(k2 % 2 != kparity[2], next);
      for(k3 = 0, K_i[3],
        if(k3 % 2 != kparity[3], next);
        my(v12 = valuation(e1-e2, p), v13 = valuation(e1-e3, p), v23 = valuation(e2-e3, p));
        my(ok = 1);
        if(k1 != k2 && min(k1, k2) != v12, ok = 0);
        if(k1 != k3 && min(k1, k3) != v13, ok = 0);
        if(k2 != k3 && min(k2, k3) != v23, ok = 0);
        if(k1 == k2 && k1 > v12, ok = 0);
        if(k1 == k3 && k1 > v13, ok = 0);
        if(k2 == k3 && k2 > v23, ok = 0);
        if(ok, listput(klist, [k1, k2, k3]));
      );
    );
  );

  for(j = 1, #klist,
    my(kk = klist[j], k_i, e_pivot, M_target, u, X, ok, vals);
    k_i = if(kk[1] <= kk[2] && kk[1] <= kk[3], 1, if(kk[2] <= kk[3], 2, 3));
    e_pivot = [e1, e2, e3][k_i];
    M_target = max(1, ceil(log(10^5)/log(p)));
    for(u = 1, p^M_target - 1,
      if(u % p == 0, next);
      X = e_pivot + p^kk[k_i] * u;
      ok = 1;
      vals = [d1, d2, d3];
      for(i = 1, 3,
        my(z);
        z = X - [e1, e2, e3][i];
        if(z == 0, next);
        if(!is_sq_Qp(z / vals[i], p), ok = 0; break);
      );
      if(ok, listput(results, X); break);
    );
    if(#results > 0, break);
  );
  if(#results == 0, return([-1]));
  return(results[1]);
};

real_witness(d1, d2, d3) =
{
  \\ Find X in R with sign(X - e_i) = sign(d_i) (using d_i > 0 -> X > e_i, d_i < 0 -> X < e_i)
  \\ Sort the constraints, pick a point in the intersection of intervals.
  \\ For full 2-torsion with e1 < e2 < e3:
  \\   X > e_i if d_i > 0; X < e_i if d_i < 0.
  \\ This means: if d_1>0,d_2>0,d_3>0: X > e_3
  \\             if d_1>0,d_2<0,d_3<0: e_1 < X < e_2
  \\             if d_1<0,d_2<0,d_3>0: NOT POSSIBLE (need X < e_1 AND X > e_3 contradiction)
  \\ For Selmer condition d_1 d_2 d_3 > 0 (square in R*).
  \\ Valid patterns: (+,+,+), (+,-,-), (-,+,-), (-,-,+). Only (+,+,+) and (+,-,-) work for e1<e2<e3.
  \\ Actually all 4 sign patterns satisfying product > 0 must work:
  \\  (+,+,+) → X > e_3
  \\  (+,-,-) → X ∈ (e_1, e_2)
  \\  (-,+,-) → X < e_1 AND X > e_2: impossible. So this sign pattern has no real witness?
  \\  (-,-,+) → X < e_1 AND X < e_2 AND X > e_3: impossible since e_3 > e_1.
  \\ Hmm but those would fail local solubility at oo and not be in Selmer.
  my(s1 = sign(d1), s2 = sign(d2), s3 = sign(d3));
  if(s1 > 0 && s2 > 0 && s3 > 0, return(e3 + 1));
  if(s1 > 0 && s2 < 0 && s3 < 0, return((e1+e2)/2));
  return("FAIL");
};

all_witnesses(triple) =
{
  my(W = vector(#PLACES));
  W[1] = real_witness(triple[1], triple[2], triple[3]);
  for(j = 2, #PLACES,
    W[j] = local_witness(PLACES[j], triple[1], triple[2], triple[3]);
  );
  return(W);
};

\\ Convert witness to actual Q_v element (for finite p: it's an integer).
\\ For real: it's a rational.

\\ ----- Try multiple CT formulas -----

\\ Formula F1: sum_i (X_v - e_i, b_i)_v   [prompt's formula]
ct_F1(alpha, beta, W_alpha) =
{
  my(s = 0);
  for(j = 1, #PLACES,
    my(v = PLACES[j], X, c);
    X = W_alpha[j];
    if(X == "FAIL" || X == [-1], next);
    c = (hF2(X - e1, beta[1], v) + hF2(X - e2, beta[2], v) + hF2(X - e3, beta[3], v)) % 2;
    s = (s + c) % 2;
  );
  s;
};

\\ Formula F2: cyclic shift  sum_i (X_v - e_i, b_{i+1})_v
ct_F2(alpha, beta, W_alpha) =
{
  my(s = 0);
  for(j = 1, #PLACES,
    my(v = PLACES[j], X, c);
    X = W_alpha[j];
    if(X == "FAIL" || X == [-1], next);
    c = (hF2(X - e1, beta[2], v) + hF2(X - e2, beta[3], v) + hF2(X - e3, beta[1], v)) % 2;
    s = (s + c) % 2;
  );
  s;
};

\\ Formula F3: (X_v - e_1, b_2 b_3) + (X_v - e_2, b_1 b_3) + (X_v - e_3, b_1 b_2)
ct_F3(alpha, beta, W_alpha) =
{
  my(s = 0);
  for(j = 1, #PLACES,
    my(v = PLACES[j], X, c);
    X = W_alpha[j];
    if(X == "FAIL" || X == [-1], next);
    c = (hF2(X - e1, beta[2]*beta[3], v) + hF2(X - e2, beta[1]*beta[3], v) + hF2(X - e3, beta[1]*beta[2], v)) % 2;
    s = (s + c) % 2;
  );
  s;
};

\\ Formula F4: sum over 2 components only (X_v - e_1, b_1)_v + (X_v - e_2, b_2)_v
ct_F4(alpha, beta, W_alpha) =
{
  my(s = 0);
  for(j = 1, #PLACES,
    my(v = PLACES[j], X, c);
    X = W_alpha[j];
    if(X == "FAIL" || X == [-1], next);
    c = (hF2(X - e1, beta[1], v) + hF2(X - e2, beta[2], v)) % 2;
    s = (s + c) % 2;
  );
  s;
};

\\ Formula F5: anti-symmetric (a_1 b_2, X - e_3) + cyclic
ct_F5(alpha, beta, W_alpha) =
{
  my(s = 0);
  for(j = 1, #PLACES,
    my(v = PLACES[j], X, c);
    X = W_alpha[j];
    if(X == "FAIL" || X == [-1], next);
    c = (hF2(alpha[1]*beta[2], X - e3, v) + hF2(alpha[2]*beta[3], X - e1, v) + hF2(alpha[3]*beta[1], X - e2, v)) % 2;
    s = (s + c) % 2;
  );
  s;
};

\\ ---- Get witnesses for beta_3 and beta_4 ----
print("");
print("Computing witnesses for beta_3 = ", beta_3);
W_b3 = all_witnesses(beta_3);
print("W_b3 = ", W_b3);

print("");
print("Computing witnesses for beta_4 = ", beta_4);
W_b4 = all_witnesses(beta_4);
print("W_b4 = ", W_b4);

print("");
print("Computing witnesses for beta_1 (torsion) = ", beta_1);
W_b1 = all_witnesses(beta_1);
print("W_b1 = ", W_b1);

print("");
print("Computing witnesses for beta_2 (torsion) = ", beta_2);
W_b2 = all_witnesses(beta_2);
print("W_b2 = ", W_b2);

\\ Now try each formula on test pairs:
print("");
print("=========================================");
print("Test pairs (a, b)");
print("Sanity: torsion-image classes should pair to 0 with everything.");
print("Sanity: self-pairing should be 0 (alternating).");
print("=========================================");

{
test_pairs = [
  ["b3", "b3", beta_3, beta_3, W_b3],
  ["b4", "b4", beta_4, beta_4, W_b4],
  ["b1", "b3", beta_1, beta_3, W_b1],
  ["b2", "b3", beta_2, beta_3, W_b2],
  ["b1", "b4", beta_1, beta_4, W_b1],
  ["b2", "b4", beta_2, beta_4, W_b2],
  ["b3", "b4", beta_3, beta_4, W_b3],
  ["b4", "b3", beta_4, beta_3, W_b4],
  ["b3", "b1", beta_3, beta_1, W_b3],
  ["b3", "b2", beta_3, beta_2, W_b3],
  ["b4", "b1", beta_4, beta_1, W_b4],
  ["b4", "b2", beta_4, beta_2, W_b4]
];
}

{
print("Pair        |  F1  F2  F3  F4  F5");
for(j = 1, #test_pairs,
  my(name1, name2, a, b, W, r1, r2, r3, r4, r5);
  name1 = test_pairs[j][1];
  name2 = test_pairs[j][2];
  a = test_pairs[j][3];
  b = test_pairs[j][4];
  W = test_pairs[j][5];
  r1 = ct_F1(a, b, W);
  r2 = ct_F2(a, b, W);
  r3 = ct_F3(a, b, W);
  r4 = ct_F4(a, b, W);
  r5 = ct_F5(a, b, W);
  print(name1, " x ", name2, "   |   ", r1, "   ", r2, "   ", r3, "   ", r4, "   ", r5);
);
}

quit;
