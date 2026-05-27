\\ 08b_fast_subgroup.gp — Fast subgroup extraction with smaller test set

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

\\ Use a more compact test set
test_qs = [2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 17, 19, 21, 23, 29, 31, -2, -3, -5, -7, -11, -13, 1/2, 1/3, 3/2, 5/2, 2/3, 5/3, 7/3, 5/4, 3/4, 7/4, 7/5, 11/5, 2/7, 3/7, 11/7];

ff_solvable_via_spec(d_1, d_2) = {my(cu = 0); for (i = 1, length(test_qs), my(s = spec_solvable(d_1, d_2, test_qs[i])); if (s == 0, cu = cu + 1; return(cu))); return(cu)};

print("=== Computing survivor set ===");

\\ Pre-compute the survivor SET as a vector of 0/1.
\\ Build the indicator first.
is_surv = vector(1024);
{
nsurv = 0;
for (k1 = 0, 31,
  v1 = vec_from_idx5(k1);
  d_1 = elt_from_vec(v1);
  for (k2 = 0, 31,
    v2 = vec_from_idx5(k2);
    d_2 = elt_from_vec(v2);
    cu = ff_solvable_via_spec(d_1, d_2);
    idx = k1 + 32 * k2;
    if (cu == 0, is_surv[idx+1] = 1; nsurv = nsurv + 1);
  );
);
print("Survivors: ", nsurv);
}

\\ Find maximal subgroup: greedy.
\\ For an integer x in [0, 1023], is_surv[x+1] is 1 iff x is in surv.
in_surv(x) = is_surv[x+1];

\\ Greedy: maintain a list of generators G. For each x in surv (non-zero),
\\ test: does adding x to G keep all the new spans in surv?
\\ The new spans are x XOR (span(G)). So check x XOR g for each g in span(G).
span_g = List(); listput(span_g, 0);  \\ identity

G = List();
{
\\ Build list of survivors (excluding 0)
surv_list = List();
for (x = 1, 1023, if (is_surv[x+1] == 1, listput(surv_list, x)));
print("Non-zero survivors: ", length(surv_list));

for (j = 1, length(surv_list),
  x = surv_list[j];
  \\ Check x + span_g ⊆ surv
  ok = 1;
  for (i = 1, length(span_g),
    y = bitxor(x, span_g[i]);
    if (is_surv[y+1] == 0, ok = 0; break);
  );
  if (ok,
    \\ Add x to G; update span_g
    listput(G, x);
    new_span = List();
    for (i = 1, length(span_g),
      listput(new_span, span_g[i]);
      listput(new_span, bitxor(x, span_g[i]));
    );
    span_g = new_span;
    print("  Added gen x=", x, " (vec=", idx_to_vec10(x), "); dim=", length(G), " span size=", length(span_g));
  );
);
}
print();
print("Final basis dim: ", length(G));
print("Subgroup size: 2^", length(G), " = ", 2^length(G));
