\\ 08_extract_subgroup.gp — Extract Selmer subgroup from survivor set

default(parisize, 1000000000);

basis = [-1, 2, 'q, 'q-1, 'q+1];
n_basis = 5;
elt_from_vec(v) = {my(r = 1); for (i = 1, n_basis, if (v[i] != 0, r = r * basis[i])); return(r)};
vec_from_idx5(k) = {my(v = vector(n_basis)); for (i = 1, n_basis, v[i] = bittest(k, i-1)); return(v)};
idx_to_vec10(k) = {my(v1 = vector(5), v2 = vector(5)); for (i = 1, 5, v1[i] = bittest(k, i-1)); for (i = 1, 5, v2[i] = bittest(k, i+4)); return([v1, v2])};

qf_solvable_q(a, b, c) = {
  if (a == 0 || b == 0 || c == 0, return(1));
  a = core(numerator(a)*denominator(a));
  b = core(numerator(b)*denominator(b));
  c = core(numerator(c)*denominator(c));
  if (a == 0 || b == 0 || c == 0, return(1));
  return(type(qfsolve(matdiagonal([a, b, c]))) == "t_COL")
};

spec_solvable(d_1, d_2, q_val) = {
  my(a, b);
  if (q_val == 0 || q_val == 1 || q_val == -1, return(-1));
  a = subst(d_1, 'q, q_val);
  b = -subst(d_2, 'q, q_val);
  if (a == 0 || b == 0, return(-1));
  return(qf_solvable_q(a, b, 1))
};

\\ Test points all on one line.
test_qs = [2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 17, 19, 21, 23, 29, 31, -2, -3, -5, -7, -11, -13, 1/2, 1/3, 3/2, 5/2, 2/3, 5/3, 7/3, 5/4, 3/4, 7/4, 7/5, 11/5, 2/7, 3/7, 11/7];

ff_solvable_via_spec(d_1, d_2) = {my(cu = 0); for (i = 1, length(test_qs), my(s = spec_solvable(d_1, d_2, test_qs[i])); if (s == 0, cu = cu + 1)); return(cu)};

print("=== Recompute survivors with ", length(test_qs), " test points ===");

surv_list = List();
{
for (k1 = 0, 31,
  v1 = vec_from_idx5(k1);
  d_1 = elt_from_vec(v1);
  for (k2 = 0, 31,
    v2 = vec_from_idx5(k2);
    d_2 = elt_from_vec(v2);
    cu = ff_solvable_via_spec(d_1, d_2);
    idx = k1 + 32 * k2;
    if (cu == 0, listput(surv_list, idx));
  );
);
}
print("Survivors: ", length(surv_list));

\\ Build a sorted vector for set search
surv_vec = Set(Vec(surv_list));
print("Distinct survivors: ", length(surv_vec));

\\ Greedy build of maximal subgroup contained in surv_vec
\\ G is a basis (list of integer "vectors")
\\ Check: candidate basis G has all XOR-spans inside surv_vec
span_in_surv(G) = {
  my(n = length(G), x, ms, mask);
  ms = 2^n;
  for (mask = 0, ms - 1,
    x = 0;
    for (i = 1, n, if (bittest(mask, i-1), x = bitxor(x, G[i])));
    if (setsearch(surv_vec, x) == 0, return(0));
  );
  return(1)
};

G = List();
{
for (j = 1, length(surv_vec),
  x = surv_vec[j];
  if (x == 0, next);
  G_new = concat(Vec(G), [x]);
  if (span_in_surv(G_new),
    listput(G, x);
    print("  Added gen ", x, " (vec=", idx_to_vec10(x), "); dim=", length(G))
  );
);
}
print();
print("Greedy basis dim: ", length(G));
print("Subgroup size: 2^", length(G), " = ", 2^length(G));
print("Survivor count: ", length(surv_vec));
