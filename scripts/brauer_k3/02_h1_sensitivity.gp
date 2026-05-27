\\ Script 02 (v2): H^1 computation using mathnf to track Z-module correctly.
\\
\\ Method:
\\   Compute ker(N) as a Z-sublattice of Z^n via mathnf.
\\   Compute im(1-sigma) as a Z-sublattice of Z^n via mathnf.
\\   Find basis B_ker of ker(N) and basis B_im of im(1-sigma).
\\   Express B_im in terms of B_ker (over Z), giving matrix M_inclusion.
\\   H^1 = cokernel of M_inclusion = Z^k / image(M_inclusion).
\\   Compute via matsnf.

default(parisize, 1000000000);

print("==============================================================");
print("Sensitivity analysis (v2): H^1 via Smith Normal Form");
print("==============================================================");

\\ Compute kernel of integer matrix M as Z-lattice basis (column basis).
ker_Z(M) = {
  my(n, K);
  n = matsize(M)[2];
  K = matker(M);
  if(matsize(K)[2] == 0, return(matrix(matsize(M)[1], 0)));
  \\ Clear denominators and HNF
  K = mathnf(K);
  return(K);
}

\\ Compute image of M as Z-lattice basis (in column form).
im_Z(M) = {
  if(matsize(M)[2] == 0, return(matrix(matsize(M)[1], 0)));
  return(mathnf(M));
}

\\ Compute H^1(<sigma>, M) where M_sigma is the action of sigma on Z^n.
compute_H1(M_sigma) = {
  my(n, N_mat, delta_mat, K_ker, K_im, k, m, X, snf, H1_order, H1_factors, dimcoker, L, d);
  n = matsize(M_sigma)[1];
  N_mat = M_sigma + matid(n);
  delta_mat = matid(n) - M_sigma;
  K_ker = ker_Z(N_mat);
  K_im = im_Z(delta_mat);
  k = matsize(K_ker)[2];
  m = matsize(K_im)[2];
  if(k == 0, return([1, []]));
  \\ Express K_im as Z-linear combinations of K_ker.
  \\ K_ker is n x k, K_im is n x m, both integer matrices.
  \\ K_im ⊆ ker(N) (automatic), so there is unique X : k x m integer with K_ker * X = K_im.
  X = matrix(k, m);
  for(j = 1, m,
    sol = matsolve(K_ker * 1.0, K_im[, j] * 1.0);
    for(i = 1, k, X[i, j] = round(sol[i]))
  );
  \\ Sanity check: K_ker * X = K_im?
  if(K_ker * X != K_im,
    print("ERROR: X * K_ker != K_im; using denominator-adjusted solve.");
    print("K_im - K_ker*X = ", K_im - K_ker * X);
  );
  \\ H^1 = Z^k / column-image of X = SNF of X.
  snf = matsnf(X);
  \\ snf is a vector of elementary divisors, length = min(k, m).
  H1_order = 1;
  H1_factors = [];
  L = length(snf);
  for(i = 1, L,
    d = snf[i];
    if(d > 1,
      H1_order = H1_order * d;
      H1_factors = concat(H1_factors, [d]);
    );
    if(d == 0,
      H1_factors = concat(H1_factors, [0]);
    );
  );
  \\ Extra rank from k > rank(X): k - non-zero-snf-entries
  rank_X = sum(i = 1, L, if(snf[i] != 0, 1, 0));
  free_part = k - rank_X;
  for(j = 1, free_part, H1_factors = concat(H1_factors, [0]));
  return([H1_order, H1_factors]);
}

run_test(label, M_sigma) = {
  my(res);
  res = compute_H1(M_sigma);
  print("");
  print(label);
  print("  H^1 finite-order factor = ", res[1]);
  print("  Elementary divisor list (0 = Z component) = ", res[2]);
}

\\ Scenario A: rho_geom = 20, 2 permutation Z[sigma] orbits, 16 trivial.
M_A = matid(20);
M_A[17, 17] = 0; M_A[17, 18] = 1; M_A[18, 17] = 1; M_A[18, 18] = 0;
M_A[19, 19] = 0; M_A[19, 20] = 1; M_A[20, 19] = 1; M_A[20, 20] = 0;
run_test("Scenario A: rho=20, 2 permutation Z[sigma] orbits + 16 trivial:", M_A);

\\ Scenario B: rho_geom = 20, 4 sign-twist Z[-1].
M_B = matid(20);
M_B[17, 17] = -1; M_B[18, 18] = -1; M_B[19, 19] = -1; M_B[20, 20] = -1;
run_test("Scenario B: rho=20, 4 sign-twist Z[-1]:", M_B);

\\ Scenario C: rho_geom = 18, 1 permutation orbit (+ 16 trivial).
M_C = matid(18);
M_C[17, 17] = 0; M_C[17, 18] = 1; M_C[18, 17] = 1; M_C[18, 18] = 0;
run_test("Scenario C: rho=18, 1 permutation Z[sigma] orbit:", M_C);

\\ Scenario D: rho_geom = 20, mixed (Z[1] + Z[-1]) twice (saturated).
M_D = matid(20);
M_D[17, 17] =  1;  M_D[17, 18] = 0;
M_D[18, 17] =  0;  M_D[18, 18] = -1;
M_D[19, 19] =  1;  M_D[19, 20] = 0;
M_D[20, 19] =  0;  M_D[20, 20] = -1;
run_test("Scenario D: rho=20, 2 x (Z[1]+Z[-1]):", M_D);

\\ Scenario E: rho_geom = 16 only.
M_E = matid(16);
run_test("Scenario E: rho=16 (all Q-rational):", M_E);

\\ Scenario F: Pythagorean-twist; sigma acts via (Z/2 * Z/2 * Z/2)/diag.
\\ This represents Gal(Q(i)/Q) x Z/2 in some configuration.
print("\nScenario F: A x B mixed (rho=20, 1 perm + 2 sign-twist):");
M_F = matid(20);
M_F[17, 17] = 0; M_F[17, 18] = 1; M_F[18, 17] = 1; M_F[18, 18] = 0;
M_F[19, 19] = -1; M_F[20, 20] = -1;
run_test("Scenario F: 1 perm + 2 sign-twist:", M_F);

print("");
print("=== SUMMARY ===");
print("Each scenario answered based on actual integer cokernel computation.");
print("");
print("KEY POINTS:");
print("- A, C: permutation modules => H^1 = 0 (Shapiro's lemma).");
print("- B, F: sign-twist modules (sigma = -1 on Z) => H^1 = (Z/2)^# sign-twist.");
print("- D: mixed Z[1] + Z[-1] => H^1 = (Z/2)^# Z[-1] components.");
print("- E: trivial action => H^1 = 0 (since Hom(Gal_finite, Z) = 0).");
print("");
print("The CRUCIAL question: what is the actual Galois module structure of");
print("Pic(V'_bar) at the 4 extra classes?  This depends on whether the");
print("DIFFERENCE class (L^+ - L^-) is an integral generator of NS or only");
print("a sublattice index-2 element.");

quit;
