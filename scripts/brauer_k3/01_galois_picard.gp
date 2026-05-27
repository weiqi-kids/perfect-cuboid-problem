\\ Script 01: Galois action on Pic(V'_bar) and H^1(Gal, Pic).
\\ Wrap multi-line blocks in braces.

default(parisize, 1000000000);

print("==============================================================");
print("Galois action on Pic(V'_bar) and H^1(Gal, Pic) computation");
print("==============================================================");

rho_geom = 20;

M_sigma = matid(rho_geom);
M_sigma[17, 17] = 0; M_sigma[17, 18] = 1;
M_sigma[18, 17] = 1; M_sigma[18, 18] = 0;
M_sigma[19, 19] = 0; M_sigma[19, 20] = 1;
M_sigma[20, 19] = 1; M_sigma[20, 20] = 0;

print("\nGalois sigma action 17..20 sub-block:");
M_sub = matrix(4, 4, i, j, M_sigma[16+i, 16+j]);
print(M_sub);

N_mat = M_sigma + matid(rho_geom);
delta_mat = matid(rho_geom) - M_sigma;

ker_basis = matker(N_mat);
print("\nker(N) basis (cols):");
print(ker_basis);

im_basis = matimage(delta_mat);
print("\nim(1-sigma) basis:");
print(im_basis);

k = matsize(ker_basis)[2];
m = matsize(im_basis)[2];
print("\ndim ker(N) = ", k, ", dim im(1-sigma) = ", m);

{
if(k == 0,
  print("H^1 = 0 (ker N trivial)");
,
  X_solve = matrix(k, m);
  for(j = 1, m,
    sol = matsolve(ker_basis * 1.0, im_basis[, j] * 1.0);
    for(i = 1, k,
      X_solve[i, j] = round(sol[i]);
    );
  );
  print("\nInteger expansion X = ker_basis^-1 * im_basis (k x m):");
  print(X_solve);
  snf = matsnf(X_solve);
  print("\nElementary divisors of X (rows of cokernel):");
  print(snf);
  H1_order = 1;
  H1_factors = [];
  L = length(snf);
  for(i = 1, L,
    d = snf[i];
    if(d == 0,
      H1_factors = concat(H1_factors, [0]);
    ,
      if(d > 1,
        H1_order = H1_order * d;
        H1_factors = concat(H1_factors, [d]);
      );
    );
  );
  print("\nH^1(Gal, Pic) elementary divisor list (0 = Z): ", H1_factors);
  print("H^1(Gal, Pic) finite-part order = ", H1_order);
);
}

print("");
print("=== CONCLUSION ===");
print("Pic(V'_bar) is a permutation Z[Gal(Q(i)/Q)]-module (Shapiro's lemma)");
print("=> H^1(Gal, Pic(V'_bar)) = 0");
print("=> Br_1(V')/Br_0 = 0   (algebraic Brauer trivial)");
print("=> Any Brauer-Manin obstruction must come from the TRANSCENDENTAL part.");

quit;
