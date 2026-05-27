\\ Verify complete intersection via dimension count of I_d for low d
\\
\\ I_d = (R*Q1 + R*Q2 + R*Q3 + R*Q4)_d
\\     = R_{d-2}*Q1 + ... + R_{d-2}*Q4
\\
\\ dim of this space = 4 * dim(R_{d-2}) - dim(linear_syzygies_{d-2})
\\
\\ Build basis of R_d (monomials of degree d in 7 vars), express the products
\\ Q_i * monomial and compute rank.

\\ For d = 3: R_1 has 7 monomials; products R_1 * Q_i give 4 * 7 = 28 cubics.
\\ R_3 has C(9,6) = 84. If linearly independent in R_3, no linear syzygy.
\\ Hilbert function HF(3) = 84 - 28 = 56 (if rank is 28).

\\ Vars: a,b,c,d,e,f,g indexed 1..7.
\\ Monomial of deg d represented as multi-exponent vector summing to d.

monomials_deg(d, n) = {
  my(L = List(), v);
  if(d == 0, return([vector(n)]));
  v = vector(n); v[1] = d;
  L = listput(L, v); listput(L, v);
  \\ Use a recursive enumeration
  return(monomials_deg_aux(d, n));
}

monomials_deg_aux(d, n) = {
  if(n == 1, return([[d]]));
  my(L = List());
  for(k = 0, d,
    my(sub = monomials_deg_aux(d - k, n - 1));
    for(j = 1, #sub,
      listput(L, concat([k], sub[j]));
    );
  );
  return(Vec(L));
}

\\ Encode quadrics as exponent vectors
\\ Q1 = a^2 + b^2 - d^2: vars 1,2,4 with coeffs +1,+1,-1
\\ Q2 = b^2 + c^2 - e^2: vars 2,3,5
\\ Q3 = a^2 + c^2 - f^2: vars 1,3,6
\\ Q4 = a^2 + b^2 + c^2 - g^2: vars 1,2,3,7

\\ Each quadric: list of (exponent_vec, coeff)
Q1_terms = [[[2,0,0,0,0,0,0], 1], [[0,2,0,0,0,0,0], 1], [[0,0,0,2,0,0,0], -1]];
Q2_terms = [[[0,2,0,0,0,0,0], 1], [[0,0,2,0,0,0,0], 1], [[0,0,0,0,2,0,0], -1]];
Q3_terms = [[[2,0,0,0,0,0,0], 1], [[0,0,2,0,0,0,0], 1], [[0,0,0,0,0,2,0], -1]];
Q4_terms = [[[2,0,0,0,0,0,0], 1], [[0,2,0,0,0,0,0], 1], [[0,0,2,0,0,0,0], 1], [[0,0,0,0,0,0,2], -1]];

multiply_mon(m, q_terms) = {
  my(L = List());
  for(i = 1, #q_terms,
    my(new_exp = m + q_terms[i][1]);
    listput(L, [new_exp, q_terms[i][2]]);
  );
  return(Vec(L));
}

\\ For degree d, compute rank of {monomial * Q_i : monomial in R_{d-2}, i=1..4}.

compute_HF(d) = {
  if(d < 2,
    my(R_d_size = binomial(d+6, 6));
    return(R_d_size);
  );
  my(R_dm2 = monomials_deg_aux(d-2, 7));
  my(R_d = monomials_deg_aux(d, 7));
  my(index_R_d);
  index_R_d = Map();
  for(i = 1, #R_d, mapput(index_R_d, R_d[i], i));
  my(N = #R_d);
  \\ Build matrix M of size N x (4 * #R_dm2)
  my(cols = 4 * #R_dm2);
  my(M = matrix(N, cols));
  my(col = 0);
  for(qi = 1, 4,
    my(q_terms = if(qi==1, Q1_terms, if(qi==2, Q2_terms, if(qi==3, Q3_terms, Q4_terms))));
    for(mi = 1, #R_dm2,
      col = col + 1;
      my(prod = multiply_mon(R_dm2[mi], q_terms));
      for(t = 1, #prod,
        my(row = mapget(index_R_d, prod[t][1]));
        M[row, col] = M[row, col] + prod[t][2];
      );
    );
  );
  my(r = matrank(M));
  return([N, cols, r, N - r]);
}

print("Degree   dim(R_d)   dim(I_d as image)   rank(matrix)   HF(R/I)(d)");
{
for(d = 2, 6,
  my(res = compute_HF(d));
  print("d=", d, "  R_d=", res[1], "  image_cols=", res[2], "  rank=", res[3], "  HF=", res[4]);
);
}

\\ Compare with CI Hilbert series (1+t)^4 / (1-t)^3 coefficients:
print("\nExpected (CI Hilbert series): 1, 7, 24, 56, 104, 168, 248, ...");

quit;
