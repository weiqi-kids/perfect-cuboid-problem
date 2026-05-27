/* 16_rank4_test.gp
 *
 * Test on rank-4 fibers from the catalog.
 * Use Q-isogenous curves to get explicit generators for the high-rank cases.
 *
 * Rank-4 fibers: (m, n) with rank 4, listed in FINAL-SYNTHESIS-2026-05-21.md:
 * From Pick 13 (m≤60): (99,28), ... -- wait these are not (n,m), let me check.
 *
 * From catalog: "26 known rank-4 fibers".
 * Some entries: (99, 28), (118, 25), (174, 83), (176, 63), (181, 38)
 * (217, 24), (1099, 358), (1136, 343), ...
 *
 * BUT — these (m, n) pairs may use a DIFFERENT parametrization.
 * In Pick 13: m^2 + n^2 might not be a square — these may be Saunderson
 * triples or generic Heron-related parameters.
 *
 * Let me check (99, 28): 99^2 + 28^2 = 9801 + 784 = 10585. Not a square.
 * So these are NOT Pythagorean parameters. Different family.
 *
 * The PCP family E_PCP(q) requires q Pythagorean. So rank-4 fibers may
 * be parametrized differently. Skip this for now -- already tested rank-3
 * (195/748) and rank-2 fibers thoroughly.
 *
 * Instead: confirm 0 PCP candidates uniformly.
 *
 * Final empirical check: do the SUM of rank E_PCP(q) + rank E_twist(q) ever
 * combine with a fusion u = square to yield PCP?
 *
 * Test more aggressively on the rank-3 seed.
 */
default(parisize, 1000000000);

print("=== Rank-3 seed: q = 195/748 ===");
print("E_PCP rank 3 + E_twist rank 1 = rank-sum 4. Largest case.");
n = 195; m = 748;
Epcp = ellinit([0, m^2+n^2, 0, m^2*n^2, 0]);
Etw = ellinit([0, -(m^2+n^2), 0, m^2*n^2, 0]);
Estar = ellinit([0, -(m^4+n^4), 0, m^4*n^4, 0]);

rE = ellrank(Epcp, 3);
rT = ellrank(Etw, 3);
rS = ellrank(Estar, 3);

print("E_PCP(q): rank ", rE[1], " gens ", rE[4]);
print("E_twist:  rank ", rT[1], " gens ", rT[4]);
print("E*(q):    rank ", rS[1], " gens ", rS[4]);

print();
print("=== Now test: for each (x_P from E_PCP), is F(x_P, q) a Q-square? ===");

A_pol = 'x^2 + 'q^2;
G_pol = (1+'q^2)*'x^2 + 4*'q^2*'x + 'q^2*(1+'q^2);
F_pol = A_pol * G_pol;

{
gens = rE[4];
rank = #gens;
if(rank > 0,
  /* Try with larger bound on rank-3 case */
  bound = 5;
  total_evals = 0;
  total_squares = 0;
  q0 = n/m;
  coefs = vector(rank);
  for(j=1, rank, coefs[j] = -bound);
  done = 0;
  while(!done,
    P = ellmul(Epcp, gens[1], coefs[1]);
    for(j=2, rank, P = elladd(Epcp, P, ellmul(Epcp, gens[j], coefs[j])));
    if(P != [0] && P[2] != 0,
      X = P[1];
      x_orig = X / m^2;
      if(x_orig != 0 && x_orig != -1 && x_orig != -q0^2 && x_orig != q0 && x_orig != -q0,
        Fval = subst(subst(F_pol, 'q, q0), 'x, x_orig);
        total_evals++;
        if(Fval != 0 && issquare(Fval),
          total_squares++;
          print(" !!! PCP candidate at x = ", x_orig, ", coefs = ", coefs);
        );
      );
    );
    /* increment */
    j = 1;
    while(j <= rank,
      coefs[j]++;
      if(coefs[j] > bound,
        if(j == rank, done = 1);
        coefs[j] = -bound;
        j++;
      , break);
    );
  );
  print("Total evals on rank-3 seed: ", total_evals, ", PCP hits: ", total_squares);
);
}

quit;
