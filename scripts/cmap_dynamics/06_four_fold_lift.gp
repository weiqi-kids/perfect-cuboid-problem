/* 4-to-1 lift analysis: at each c-image edge q -> c, the K3 mechanism says
   there are 4 distinct points on E_PCP(c) all mapping to the same q.
   These are obtained by adding 2-torsion of E_PCP(c) to the base lift:
     T0 = origin, T1 = (0,0), T2 = (-1, 0), T3 = (-c^2, 0).

   For each of the 4 lifted points P on E_PCP(c), compute its c-image c' = cmap(P, c).
   That gives 4 candidate "next" Pythagorean rationals c'.
   Test if any c' produces F3' = 1 + c^2 + c'^2 that is a perfect rational square.

   This is the "4-branching" tree the user asked about.  Depth-1 4-branching
   from depth-1 base generators: gives 4^1 = 4 candidates per base gen.
   Depth-2 (compose twice): up to 4^2 = 16 candidates.
*/

default(parisize, 1500000000);

canonical_q(qv) = my(n=abs(numerator(qv)), d=abs(denominator(qv))); if (n<=d, n/d, d/n);
log_height(qv) = log(max(abs(numerator(qv)), abs(denominator(qv))));

gens_db = Map();
mapput(gens_db, 20/21, [[-125/4, 395/8]]);
mapput(gens_db, 7/24, [[-317/4, 3887/8]]);
mapput(gens_db, 11/60, [[-185, 9745], [-515, 7270]]);
mapput(gens_db, 48/55, [[-282, 1956]]);
mapput(gens_db, 20/99, [[-965, 44950]]);
mapput(gens_db, 96/247, [[-2260, 581138]]);
mapput(gens_db, 13/84, [[20195/4, 2796619/8]]);
mapput(gens_db, 39/80, [[-900, 9030]]);
mapput(gens_db, 17/144, [[-1920, 142332], [-3348, 48084]]);
mapput(gens_db, 104/153, [[-2894, 44542], [-2998, 7934]]);
mapput(gens_db, 44/117, [[-1965, 38553]]);
mapput(gens_db, 60/91, [[-210, 17805]]);
mapput(gens_db, 225/272, [[-4136, 330088]]);
mapput(gens_db, 252/275, [[-6886, 146663], [-7306, 22553]]);
mapput(gens_db, 85/132, [[-2281, 16313]]);
mapput(gens_db, 108/725, [[360149, 211594238], [39359, 1286048]]);
mapput(gens_db, 57/176, [[-1504, 229442]]);
mapput(gens_db, 135/352, [[-5496, 1741338]]);
mapput(gens_db, 27/364, [[3002, 1265339], [7553, 590681]]);
mapput(gens_db, 52/165, [[-1346, 190513], [3274, 91183]]);
mapput(gens_db, 195/748, [[151491/4, 15203079/8], [53369, 2563403], [40343619, 256228408278]]);

build_E(q) = ellinit([0, 1+q^2, 0, q^2, 0]);

cmap_c_from_pt(q, P_on_E) =
{
  /* P_on_E is already on the un-minimal model y^2 = x(x+1)(x+q^2) */
  if (P_on_E[1]^2 == q^2, return(0));
  2*q*P_on_E[2]/(q^2 - P_on_E[1]^2);
};

/* Pull generator on Emin back to E_PCP(q) (Weierstrass form). */
gen_on_E(q, P_emin) =
{
  my(E = build_E(q), v);
  ellminimalmodel(E, &v);
  ellchangepointinv(P_emin, v);
};

/* Given a base point P0 = (x0, y0) on E_PCP(c) (y^2 = x(x+1)(x+c^2)),
   produce 4 points obtained by adding 2-torsion translations:
   - P0 itself
   - P0 + (0, 0)
   - P0 + (-1, 0)
   - P0 + (-c^2, 0)
   Use ellinit on E_PCP(c) and elladd.
*/
four_lifts(c, P0) =
{
  my(Ec = build_E(c), T1 = [0, 0], T2 = [-1, 0], T3 = [-c^2, 0]);
  my(L = vector(4));
  L[1] = P0;
  L[2] = elladd(Ec, P0, T1);
  L[3] = elladd(Ec, P0, T2);
  L[4] = elladd(Ec, P0, T3);
  L;
};

print("=== 4-fold lift / branching tree of c-map ===");
print("");
print("From each c-edge q -> c, take the c-image point P0 on E_PCP(c),");
print("add 2-torsion translates to get 4 lifts P0,P0+T1,P0+T2,P0+T3,");
print("re-apply c-map from c to get 4 candidate next-rationals c'.");
print("Check F3' = 1 + c^2 + c'^2 for square.");
print("");

src_list = [20/21, 7/24, 11/60, 48/55, 17/144, 104/153, 27/364, 52/165, 195/748];

pcp_found = 0;
total_branches = 0;
min_F3_core = 10^30;
min_F3_edge = 0;

{
for (i = 1, length(src_list),
  my(q = src_list[i], gens);
  gens = mapget(gens_db, q);
  print("--- Source q = ", q, " ---");
  for (k = 1, length(gens),
    my(P_emin = gens[k], P_on_q, c, c_canonical, P0_on_c);
    P_on_q = gen_on_E(q, P_emin);
    c = cmap_c_from_pt(q, P_on_q);
    if (c == 0, next);
    c_canonical = canonical_q(c);
    print("  gen ", k, ": q -> c = ", c);
    /* The c-image point on E_PCP(c) is obtained from the identity:
       Set Y = (q*(x^2 + 2x + q^2))/(q^2 - x^2) (sqrt of I2)
       Set X = c*(some thing)?  Actually we want to find P0 = (X, Y_on_Ec).
       Alternatively: solve the c^2-defining equation.
       Easier: x-coordinate X comes from y^2 = X(X+1)(X+c^2).
       We KNOW from CMAP-MECHANISM that there are 4 solutions; let's find ANY one.

       Approach: factor the quartic q^2*(c^2 - X^2)^2 - 4*c^2*X*(X+1)*(X+c^2) = 0.
    */
    my(Pol = q^2*(c^2 - 'X^2)^2 - 4*c^2*'X*('X+1)*('X+c^2));
    Pol = numerator(Pol);  /* polynomial in X */
    my(fac = factor(Pol));
    /* Collect linear factors -> rational roots */
    my(roots = List());
    for (f = 1, matsize(fac)[1],
      my(P = fac[f, 1]);
      if (poldegree(P, 'X) == 1,
        /* P = a*X + b => root = -b/a */
        my(b_ = polcoef(P, 0, 'X), a_ = polcoef(P, 1, 'X));
        listput(roots, -b_/a_);
      );
    );
    if (#roots == 0,
      print("    [no rational roots in quartic — non-standard, skipping]"); next);
    print("    Quartic roots (X-coords on E_PCP(c)): ", Vec(roots));
    /* For each root, recover Y from y^2 = X(X+1)(X+c^2) */
    my(P0_list = List());
    for (r = 1, #roots,
      my(X = roots[r], Y2 = X*(X+1)*(X+c^2), Yex);
      if (issquare(Y2, &Yex),
        listput(P0_list, [X, Yex]);
      ,
        print("      [X=", X, " Y2=", Y2, " not square]");
      );
    );

    if (#P0_list == 0, print("    [no rational lift on E_PCP(c)]"); next);

    /* For each lift P0, apply 2-torsion translates, then re-apply c-map */
    for (l_i = 1, #P0_list,
      my(P0 = P0_list[l_i], lifts);
      print("    Lift ", l_i, ": P0 = ", P0);
      lifts = four_lifts(c, P0);
      for (m = 1, 4,
        my(P_branch = lifts[m], c_prime, F3p, sF3p, pcp_flag, cor);
        if (length(P_branch) == 1 && P_branch == [0],
          print("      branch ", m, ": [point at infinity, skip]"); next);
        if (P_branch[1]^2 == c^2,
          print("      branch ", m, ": P=", P_branch, " degenerate"); next);
        c_prime = cmap_c_from_pt(c, P_branch);
        if (c_prime == 0,
          print("      branch ", m, ": c'=0, skip"); next);
        F3p = 1 + c^2 + c_prime^2;
        pcp_flag = issquare(F3p);
        cor = core(numerator(F3p)*denominator(F3p));
        total_branches = total_branches + 1;
        print("      branch ", m, ": P=", P_branch, "  c' = ", c_prime,
              "  F3'=", F3p, "  core=", cor, "  PCP=", pcp_flag);
        if (pcp_flag == 1,
          pcp_found = pcp_found + 1;
          print("      !!!!!!!! PCP CANDIDATE BRANCH !!!!!!!! c=", c, " c'=", c_prime);
        );
        if (cor < min_F3_core, min_F3_core = cor; min_F3_edge = [q, c, c_prime, F3p]);
      );
    );
  );
);
}

print("");
print("=== 4-Fold Branching Summary ===");
print("Total branch evaluations: ", total_branches);
print("PCP candidates found: ", pcp_found);
print("Min core in any branch: ", min_F3_core);
if (min_F3_edge != 0, print("  At edge q=", min_F3_edge[1], " c=", min_F3_edge[2], " c'=", min_F3_edge[3]); print("  F3' = ", min_F3_edge[4]));

quit;
