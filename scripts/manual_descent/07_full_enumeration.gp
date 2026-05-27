\\ 07_full_enumeration.gp — Full function-field 2-descent enumeration over Q(q)
\\
\\ Algorithm:
\\   1. Enumerate (d_1, d_2) ∈ K(S, 2)^2 (1024 pairs).
\\   2. For each pair, check local solvability of the conic C: d_1 X^2 - d_2 Y^2 + Z^2 = 0
\\      at every place of K = Q(q).
\\   3. Local places to check:
\\      Geometric: (q), (q-1), (q+1), infinity
\\      Arithmetic: each prime p where d_1, d_2, or coefficients have non-trivial Hilbert symbol
\\   4. By Hasse-Minkowski for Q(q): local everywhere ⟺ global.

default(parisize, 1000000000);

\\ Basis of K(S, 2)
basis = [-1, 2, 'q, 'q-1, 'q+1];
n_basis = 5;

\\ Construct element from F_2^5 exponent vector
elt_from_vec(v) = {
  my(r = 1);
  for (i = 1, n_basis, if (v[i] != 0, r = r * basis[i]));
  return(r);
};

\\ Construct vector from index 0..31
vec_from_idx(k) = {
  my(v = vector(n_basis));
  for (i = 1, n_basis, v[i] = bittest(k, i-1));
  return(v);
};

\\ ============================================================
\\ Q-solvability of ternary form (over the rationals)
\\ ============================================================
\\ Returns 1 if a X^2 + b Y^2 + c Z^2 = 0 has Q-point, else 0.
qf_solvable_q(a, b, c) = {
  my(M, sol);
  if (a == 0 || b == 0 || c == 0, return(1));
  a = core(numerator(a)*denominator(a));
  b = core(numerator(b)*denominator(b));
  c = core(numerator(c)*denominator(c));
  if (a == 0 || b == 0 || c == 0, return(1));
  M = matdiagonal([a, b, c]);
  sol = qfsolve(M);
  return(type(sol) == "t_COL");
};

\\ ============================================================
\\ Test specialization solvability for conic d_1 X^2 - d_2 Y^2 + Z^2 = 0
\\ at q = q_val.
\\ ============================================================
\\ Returns 1 (solvable), 0 (not), -1 (degenerate at this q_val).
spec_solvable(d_1, d_2, q_val) = {
  my(a, b);
  if (q_val == 0 || q_val == 1 || q_val == -1, return(-1));
  a = subst(d_1, 'q, q_val);
  b = -subst(d_2, 'q, q_val);
  if (a == 0 || b == 0, return(-1));
  return(qf_solvable_q(a, b, 1));
};

\\ ============================================================
\\ Test the conic at MANY rational q values.
\\ If unsolvable at any "good" q_val, the conic is not generically solvable.
\\ ============================================================
ff_solvable_via_spec(d_1, d_2) = {
  my(test_qs, count_unsolv);
  test_qs = [2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 13, 17, 19, 23, 29, -2, -3, -5, -7,
             1/2, 1/3, 3/2, 5/2, 2/3, 5/3, 7/3, 5/4, 3/4, 7/4];
  count_unsolv = 0;
  for (i = 1, length(test_qs),
    my(s = spec_solvable(d_1, d_2, test_qs[i]));
    if (s == 0, count_unsolv = count_unsolv + 1);
  );
  return([count_unsolv, length(test_qs)]);
};

\\ Quick test
print("=== Quick test ===");
print("(1, 1): ", ff_solvable_via_spec(1, 1));
print("(-1, q^2-1): ", ff_solvable_via_spec(-1, 'q^2-1));
print("(-1, -('q^2-1)): ", ff_solvable_via_spec(-1, -('q^2-1)));
print("(2, q-1): ", ff_solvable_via_spec(2, 'q-1));
print("(q, q+1): ", ff_solvable_via_spec('q, 'q+1));

\\ Now full enumeration.
print();
print("=== Full enumeration: 1024 pairs ===");
print("Testing specialization solvability at 29 values of q each.");
print();

{
all_solvable = List();  \\ pairs that pass ALL specialization tests
some_unsolv = List();   \\ pairs that fail at some
deg_count = 0;
for (k1 = 0, 31,
  v1 = vec_from_idx(k1);
  d_1 = elt_from_vec(v1);
  for (k2 = 0, 31,
    v2 = vec_from_idx(k2);
    d_2 = elt_from_vec(v2);
    \\ Test specialization solvability
    res = ff_solvable_via_spec(d_1, d_2);
    if (res[1] == 0,
      listput(all_solvable, [v1, v2, d_1, d_2]),
      listput(some_unsolv, [v1, v2, d_1, d_2, res[1]])
    );
  );
);

print("Pairs solvable at ALL 29 specializations: ", length(all_solvable));
print("Pairs failing at SOME specialization:      ", length(some_unsolv));
print();
print("Sample of always-solvable pairs (first 20):");
for (i = 1, min(20, length(all_solvable)),
  print("  ", all_solvable[i][1], " x ", all_solvable[i][2],
        " ⟹ (d_1, d_2) = (", all_solvable[i][3], ", ", all_solvable[i][4], ")");
);
}
