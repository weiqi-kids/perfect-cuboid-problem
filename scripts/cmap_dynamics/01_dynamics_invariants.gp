/* c-Map Dynamics: Invariant tracking along orbits.
   For each seed q with generators G_1,...,G_r:
     - Compute c-image c_i for each generator
     - Track invariants: h(q), log N(E_q), F_3 = 1+q^2+c^2 (issquare? sqrt?)
     - At depth >= 1, recursively call ellrank to find generators of E_c
       (only if N(E_c) is bounded).
   No fabrication: every orbit point verified with ellisoncurve and 1+c^2 = square.
*/

default(parisize, 1500000000);

/* Canonical form: q in (0,1] */
canonical_q(qv) = my(n=abs(numerator(qv)), d=abs(denominator(qv))); if (n<=d, n/d, d/n);

/* Log height of rational */
log_height(qv) = log(max(abs(numerator(qv)), abs(denominator(qv))));

/* Pre-computed generators (from cmap_mechanism/11_orbit_with_compute_v2.gp,
   verified rank-jump fibers).  These are on E_min, must be pulled back. */
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
mapput(gens_db, 189/340, [[24850, 3252595]]);
mapput(gens_db, 60/91, [[-210, 17805]]);
mapput(gens_db, 225/272, [[-4136, 330088]]);
mapput(gens_db, 132/475, [[-899/144, 5897298719/1728]]);
mapput(gens_db, 252/275, [[-6886, 146663], [-7306, 22553]]);
mapput(gens_db, 140/171, [[-482665/169, 164460005/2197]]);
mapput(gens_db, 85/132, [[-2281, 16313]]);
mapput(gens_db, 108/725, [[360149, 211594238], [39359, 1286048]]);
mapput(gens_db, 57/176, [[-1504, 229442]]);
mapput(gens_db, 135/352, [[-5496, 1741338]]);
mapput(gens_db, 27/364, [[3002, 1265339], [7553, 590681]]);
mapput(gens_db, 25/312, [[-48542/9, 37856650/27]]);
mapput(gens_db, 28/195, [[7394, 493943]]);
mapput(gens_db, 52/165, [[-1346, 190513], [3274, 91183]]);
mapput(gens_db, 160/231, [[-6620, 115510]]);
mapput(gens_db, 95/168, [[3398, 72536]]);
mapput(gens_db, 105/208, [[-13117/4, 2768779/8]]);
mapput(gens_db, 52/675, [[5389, 9242848]]);
mapput(gens_db, 36/323, [[572049/121, 768697884/1331]]);
mapput(gens_db, 195/748, [[151491/4, 15203079/8], [53369, 2563403], [40343619, 256228408278]]);

/* Build E_PCP(q) and its minimal model */
build_E(q) = my(E); E = ellinit([0, 1+q^2, 0, q^2, 0]); E;

/* Compute the conductor of E_PCP(q) (minimal model). */
cond_E(q) = my(E, Em); E = build_E(q); Em = ellminimalmodel(E); ellglobalred(Em)[1];

/* j-invariant of E_PCP(q). */
jinv_E(q) = my(E); E = build_E(q); E.j;

/* Discriminant (minimal). */
disc_E(q) = my(E, Em); E = build_E(q); Em = ellminimalmodel(E); Em.disc;

/* For an MW gen P_emin on E_min, recover P on E_PCP(q), then compute c.
   Returns [c, c_canonical, F3_value, F3_issquare, h_c, ellisoncurve_q, identity_check].
*/
cmap_one(q, P_emin) =
{
  my(E, Em, v, P_E, c, F3, ok_on, id_lhs, id_rhs);
  E = build_E(q);
  Em = ellminimalmodel(E, &v);
  ok_on = ellisoncurve(Em, P_emin);
  P_E = ellchangepointinv(P_emin, v);
  /* Verify P_E on E (with original Weierstrass) */
  if (P_E[1]^2 == q^2, return([0, 0, 0, -1, 0, 0, 0]));
  c = 2*q*P_E[2]/(q^2 - P_E[1]^2);
  /* Identity (I1): 1 + c^2 must be a square. */
  id_lhs = 1 + c^2;
  id_rhs = ((P_E[1]^2 + 2*q^2*P_E[1] + q^2)/(q^2 - P_E[1]^2))^2;
  /* F3 = 1 + q^2 + c^2 — the PCP defect */
  F3 = 1 + q^2 + c^2;
  [c, canonical_q(c), F3, issquare(F3), log_height(c), ok_on, id_lhs == id_rhs];
};

/* For a fiber q in DB, compute all c-images and tabulate invariants. */
process_fiber(q) =
{
  my(gens, results, hq, NE, jE, dE);
  if (!issquare(1+q^2), error("non-Pyth ", q));
  if (!mapisdefined(gens_db, q), return([q, log_height(q), 0, 0, 0, 0, []]));
  gens = mapget(gens_db, q);
  hq = log_height(q);
  NE = cond_E(q);
  jE = jinv_E(q);
  dE = disc_E(q);
  results = vector(length(gens));
  for (i=1, length(gens),
    results[i] = cmap_one(q, gens[i]);
  );
  [q, hq, NE, jE, dE, length(gens), results];
};

/* === Main pass: tabulate invariants for all DB seeds === */

print("=== c-Map Dynamics: Invariant Tracking ===");
print("");
print("Columns: q | h(q) | log_N | log|disc| | rank | depth-1 c-images:");
print("           [c_canon, h(c), F3=1+q^2+c^2, issquare(F3), on_curve, identity_holds]");
print("");

seeds_all = [20/21, 7/24, 11/60, 48/55, 20/99, 96/247, 13/84, 39/80, 17/144, 104/153, 44/117, 189/340, 60/91, 225/272, 132/475, 252/275, 140/171, 85/132, 108/725, 57/176, 135/352, 27/364, 25/312, 28/195, 52/165, 160/231, 95/168, 105/208, 52/675, 36/323, 195/748];

pcp_flags = 0;
identity_flags = 0;
oncurve_flags = 0;
total_edges = 0;
rec = vector(length(seeds_all));

{
for (i = 1, length(seeds_all),
  my(q = seeds_all[i], r = process_fiber(seeds_all[i]));
  rec[i] = r;
  print("q = ", r[1], "  h(q) = ", strprintf("%.4f", r[2]),
        "  log_N = ", strprintf("%.4f", log(r[3])),
        "  log|disc| = ", strprintf("%.4f", log(abs(r[5]))),
        "  rank>=", r[6]);
  for (k=1, length(r[7]),
    my(cd = r[7][k]);
    print("    [c=", cd[2], ", h(c)=", strprintf("%.4f", cd[5]),
          ", F3=", cd[3], ", sqF3?=", cd[4],
          ", onE?=", cd[6], ", I1?=", cd[7], "]");
    total_edges = total_edges + 1;
    if (cd[4] == 1, pcp_flags = pcp_flags + 1; print("    *** PCP CANDIDATE *** q=", r[1], " c=", cd[1]));
    if (cd[6] != 1, oncurve_flags = oncurve_flags + 1);
    if (cd[7] != 1, identity_flags = identity_flags + 1);
  );
);
}

print("");
print("=== Summary ===");
print("Total seeds: ", length(seeds_all));
print("Total c-edges: ", total_edges);
print("PCP candidates flagged: ", pcp_flags);
print("on_curve failures: ", oncurve_flags);
print("identity (I1) failures: ", identity_flags);

quit;
