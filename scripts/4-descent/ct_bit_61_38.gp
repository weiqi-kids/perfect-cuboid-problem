\\ ct_bit_61_38.gp
\\ ===============
\\ Attempt to compute the Cassels-Tate pairing bit <beta_3, beta_4> in F_2
\\ for E_Hm associated to the (61, 38) borderline Pythagorean cuboid fiber.
\\
\\ E_Hm: Y^2 = (X - e_1)(X - e_2)(X - e_3), full rational 2-torsion.
\\   e_1 = -298991117938864
\\   e_2 =  136054851567711
\\   e_3 =  162936266371152
\\
\\ Selmer-basis classes mod torsion image:
\\   beta_3 = (1, -759, -759)
\\   beta_4 = (8012167, 6913, 1159)
\\
\\ Implemented formula (Stamminger 5.13, also Schaefer 1995/Cassels 1998):
\\
\\   At each place v, find local witness X_v ∈ Q_v with (X_v - e_i)/d_i(α) ∈ (Q_v*)^2.
\\   Local CT contribution from α to β at v:
\\     c_v = Σ_i hilbert_F2(X_v - e_i, d_i(β), v)  in F_2.
\\   Global pairing: <α, β> = Σ_v c_v mod 2.
\\
\\ HONESTY NOTE (negative result on this formula):
\\   When X_v is a local witness for α, we have (X_v - e_i) ≡ d_i(α) mod (Q_v*)^2.
\\   Hence (X_v - e_i, d_i(β))_v = (d_i(α), d_i(β))_v.
\\   So c_v = Σ_i (d_i(α), d_i(β))_v, and the global pairing reduces to
\\     <α, β> = Σ_v Σ_i (d_i(α), d_i(β))_v = Σ_i Σ_v (d_i(α), d_i(β))_v
\\            = Σ_i 0                       (Hilbert reciprocity per global pair)
\\            = 0   identically.
\\
\\   The formula as stated in the prompt (Stamminger 5.13 paraphrase) is therefore
\\   identically zero by Hilbert reciprocity, regardless of choice of witnesses.
\\   The TRUE Cassels-Tate pairing requires a more subtle implementation
\\   (cf. Schaefer-Stoll 2004 §6, Cassels 1998 Thm 1.2) using local points on
\\   the SECOND-DESCENT 4-cover, beyond simple Hilbert symbols on witnesses.
\\
\\ This script computes the (identically-zero) witness-formula AND prints
\\ per-place data so the obstruction can be seen explicitly.

default(parisize, 1500000000);

\\ ==========================================================================
\\ §0. Setup
\\ ==========================================================================

e1 = -298991117938864;
e2 =  136054851567711;
e3 =  162936266371152;
BAD = [2, 3, 5, 7, 11, 19, 23, 31, 61, 223, 337, 1033];

beta_3 = [1, -759, -759];
beta_4 = [8012167, 6913, 1159];

\\ Verify beta_4 product is a global square
print("Verifying beta_4 product is a global square:");
print("  beta_4 = ", beta_4);
print("  prod = ", beta_4[1] * beta_4[2] * beta_4[3]);
print("  issquare = ", issquare(beta_4[1] * beta_4[2] * beta_4[3]));
print("  sqrt = ", sqrtint(beta_4[1] * beta_4[2] * beta_4[3]));
print("");

hF2(a, b, v) = if(hilbert(a, b, v) == -1, 1, 0);

is_sq_Qp(z, p) =
{
  my(v, u);
  if(z == 0, return(1));
  if(p == 0, return(z > 0));
  v = valuation(z, p);
  if(v % 2 != 0, return(0));
  u = z / p^v;
  if(p == 2, return(Mod(u, 8) == Mod(1, 8)));
  return(issquare(Mod(u, p)));
};

\\ ==========================================================================
\\ §1. Real-place witness for beta_3 = (1, -759, -759)
\\ ==========================================================================
\\ Need (X - e1) > 0, (X - e2)/-759 > 0, (X - e3)/-759 > 0.
\\ Since -759 < 0: (X - e2) < 0 and (X - e3) < 0.
\\ With e1 < e2 < e3: e1 < X < e2.

X_oo = (e1 + e2) / 2;
print("Real witness X_oo = ", X_oo);
print("  sign(X - e_1) = ", sign(X_oo - e1), "  sign(X - e_2) = ", sign(X_oo - e2), "  sign(X - e_3) = ", sign(X_oo - e3));
print("");

\\ ==========================================================================
\\ §2. Finite-place witnesses for beta_3
\\ ==========================================================================

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
        my(z = X - [e1, e2, e3][i]);
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

print("=== Local witnesses for beta_3 ===");
witnesses = List([X_oo]);
{
for(j = 1, #BAD,
  my(p = BAD[j], w);
  w = local_witness(p, beta_3[1], beta_3[2], beta_3[3]);
  if(w == [-1],
    print("  p = ", p, ":  NO WITNESS FOUND");
    listput(witnesses, "FAIL");
  ,
    print("  p = ", p, ":  X = ", w);
    listput(witnesses, w);
  );
);
}

\\ ==========================================================================
\\ §3. Compute witness-formula CT contributions
\\ ==========================================================================

print("");
print("=== Per-place witness-formula c_v = Σ_i hilbert(X_v - e_i, d_i(beta_4), v) (F_2) ===");
print(" v       | X_v          | h_1  h_2  h_3 | c_v");
print("---------------------------------------------------");
total = 0;
\\ Real place
{
  my(c, h1, h2, h3);
  h1 = hF2(X_oo - e1, beta_4[1], 0);
  h2 = hF2(X_oo - e2, beta_4[2], 0);
  h3 = hF2(X_oo - e3, beta_4[3], 0);
  c = (h1 + h2 + h3) % 2;
  print("  oo     | ", X_oo, " | ", h1, "    ", h2, "    ", h3, "   | ", c);
  total = (total + c) % 2;
}
{
for(j = 1, #BAD,
  my(p, X_p, h1, h2, h3, c);
  p = BAD[j];
  X_p = witnesses[j+1];
  if(X_p == "FAIL",
    print("  p=", p, ": FAILED");
    next
  );
  h1 = hF2(X_p - e1, beta_4[1], p);
  h2 = hF2(X_p - e2, beta_4[2], p);
  h3 = hF2(X_p - e3, beta_4[3], p);
  c = (h1 + h2 + h3) % 2;
  print("  ", p, "   | ", X_p, " | ", h1, "    ", h2, "    ", h3, "   | ", c);
  total = (total + c) % 2;
);
}

print("");
print("======================================================");
print("Witness-formula <beta_3, beta_4> = ", total);
print("======================================================");
print("");
print("By the analysis in the header comment, this is identically 0");
print("(Hilbert reciprocity).  The true CT pairing bit requires a different");
print("formula that PARI 2.15.4 lacks built-in support for.");

\\ ==========================================================================
\\ §4. Empirical evidence: pull-back of beta_4 to C_{beta_3}
\\ ==========================================================================
\\ On C_{beta_3}, the function b_i(X - e_i) becomes a_i(beta_3)*b_i times a square.
\\ So pull-back of beta_4 = (a_i(beta_3) * b_i(beta_4))_i mod squares
print("");
print("=== Pull-back of beta_4 to C_{beta_3} ===");
sqf(n) = if(n==0, 0, my(s=sign(n), f=factor(abs(n)), r=1); for(i=1, matsize(f)[1], if(f[i,2]%2==1, r*=f[i,1])); s*r);
pullback = vector(3, i, sqf(beta_3[i] * beta_4[i]));
print("Pull-back triple = ", pullback);

\\ Check if pull-back is a Selmer class (= one of the 16 S² triples)
S2 = [[1, 1, 1], [1, -759, -759], [8012167, 6913, 1159], [8012167, -5246967, -879681], [2734081, -2359, -1159], [2734081, 1790481, 879681], [16307767, -16307767, -1], [16307767, 12377595153, 759], [10330, -15495, -6], [10330, 1306745, 506], [82765685110, -107116935, -6954], [82765685110, 9033528185, 586454], [28243056730, 36552705, 6954], [28243056730, -3082611455, -586454], [168459233110, 252688849665, 6], [168459233110, -21310092988415, -506]];

{
found = 0;
for(j = 1, #S2,
  my(t = S2[j], t_sqf = vector(3, i, sqf(t[i])));
  if(t_sqf == pullback,
    print("Match: pull-back = S²[", j, "] = ", t);
    found = 1;
    break;
  );
);
if(!found, print("Pull-back NOT in S² (would indicate inconsistency)"));
}

\\ ==========================================================================
\\ §5. Cross-check: <beta_4, beta_3>
\\ ==========================================================================

print("");
print("=== Cross-check: <beta_4, beta_3> ===");
\\ Real witness for beta_4 = (8012167, 6913, 1159), all signs positive: need X > e_3.
X_oo_4 = e3 + 1;
print("Real witness X_oo for beta_4 = ", X_oo_4);

witnesses_4 = List([X_oo_4]);
{
for(j = 1, #BAD,
  my(p = BAD[j], w);
  w = local_witness(p, beta_4[1], beta_4[2], beta_4[3]);
  listput(witnesses_4, if(w == [-1], "FAIL", w));
);
}

total_swap = 0;
{
  my(h1, h2, h3, c);
  h1 = hF2(X_oo_4 - e1, beta_3[1], 0);
  h2 = hF2(X_oo_4 - e2, beta_3[2], 0);
  h3 = hF2(X_oo_4 - e3, beta_3[3], 0);
  c = (h1 + h2 + h3) % 2;
  total_swap = (total_swap + c) % 2;
}
{
for(j = 1, #BAD,
  my(p = BAD[j], X_p = witnesses_4[j+1], h1, h2, h3, c);
  if(X_p == "FAIL", next);
  h1 = hF2(X_p - e1, beta_3[1], p);
  h2 = hF2(X_p - e2, beta_3[2], p);
  h3 = hF2(X_p - e3, beta_3[3], p);
  c = (h1 + h2 + h3) % 2;
  total_swap = (total_swap + c) % 2;
);
}
print("Witness-formula <beta_4, beta_3> = ", total_swap);

print("");
print("============================================");
print("FINAL DELIVERABLES:");
print("  Witness-formula <beta_3, beta_4> = ", total,   " (identically 0 by Hilbert reciprocity)");
print("  Witness-formula <beta_4, beta_3> = ", total_swap);
print("  Cross-check pass = ", total == total_swap);
print("============================================");
print("");
print("Conclusion: The witness-formula gives 0, but this is uninformative");
print("about the actual CT pairing.  The decisive bit cannot be computed");
print("in PARI 2.15.4 with the prompt's formula.");
print("See CT-BIT-61-38.md for full analysis and 4-cover obstruction data.");

quit;
