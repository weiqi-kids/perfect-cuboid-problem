/* Deep BFS test: starting from a seed, follow the 4-to-1 c-map (which
   actually generates 1 image per generator; the 4-fold is at the K3 level,
   gives 2-torsion translations).  Here we use the DB; for nodes not in DB
   we try to compute ellrank(timeout) with conductor cap.

   At each step:
   - Verify identity I1 (1+c^2 must be square)
   - Verify ellisoncurve = 1
   - Test F3 = 1+q^2+c^2 for square (PCP candidate test)
   - Tabulate height/conductor trajectory

   Seeds with known many generators: 195/748 (rank 3), 11/60 (rank 2),
   17/144 (rank 2), 104/153 (rank 2), 27/364 (rank 2), 252/275 (rank 2),
   52/165 (rank 2), 108/725 (rank 2).

   Cap conductors at 5e13, depth max 6.
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

build_E(q) = ellinit([0, 1+q^2, 0, q^2, 0]);
cond_E(q) = my(E=build_E(q), Em=ellminimalmodel(E)); ellglobalred(Em)[1];

cmap_c(q, P_emin) =
{
  my(E = build_E(q), v, P_E, c);
  ellminimalmodel(E, &v);
  P_E = ellchangepointinv(P_emin, v);
  if (P_E[1]^2 == q^2, return(0));
  2*q*P_E[2]/(q^2 - P_E[1]^2);
};

/* Attempt to compute generators with timeout */
try_gens(q, timeout_s) =
{
  my(E, Em, res, vr);
  if (mapisdefined(gens_db, q), return(mapget(gens_db, q)));
  E = build_E(q);
  Em = ellminimalmodel(E);
  res = -1;
  iferr(res = alarm(timeout_s, ellrank(Em, 2)), E_, res = -1);
  if (res == -1, return([]));
  if (length(res) < 4 || res[1] != res[2] || res[1] == 0, return([]));
  if (#res[4] < res[1], return([]));
  mapput(gens_db, q, res[4]);
  res[4];
};

/* === BFS with rich tracking === */

print("=== Deep BFS from rank-3 seed 195/748 ===");

seed = 195/748;
maxN_cap = 5*10^13;
max_depth = 6;
timeout_s = 60;

/* Track: depth -> list of (q, parent, h, log_N, F3_sqrt, pcp_flag) */
visited = Map();
mapput(visited, seed, [0, 0, log_height(seed), log(cond_E(seed)), 0, -1, 0]);  /* depth, parent_idx, h, lN, sqrtF3, pcp, gens_count */

pcp_found = 0;
total_nodes = 0;
total_edges_traversed = 0;
verify_failures = 0;

frontier = [seed];
trajectory = List();
listput(trajectory, [0, seed, log_height(seed), log(cond_E(seed)), 0.0, -1]);

{
for (d = 0, max_depth-1,
  print("");
  print("--- Depth ", d, ": frontier size = ", #frontier, " ---");
  if (#frontier == 0, break);
  my(next_frontier = List());
  for (j = 1, #frontier,
    my(q = frontier[j], gens, hq, lNq, c, c_can, hc, lNc, F3, sF3, pcp);
    hq = log_height(q);
    lNq = log(cond_E(q));
    gens = try_gens(q, timeout_s);
    if (length(gens) == 0,
      print("  q=", q, "  [no gens]");
      next;
    );
    print("  q=", q, "  h=", strprintf("%.3f", hq), "  lN=", strprintf("%.3f", lNq), "  #gens=", length(gens));
    for (k = 1, length(gens),
      my(P, on_curve, id_ok);
      P = gens[k];
      /* sanity: build Emin, check ellisoncurve */
      my(E = build_E(q), v);
      ellminimalmodel(E, &v);
      my(Em = ellminimalmodel(E));
      on_curve = ellisoncurve(Em, P);
      c = cmap_c(q, P);
      if (c == 0,
        print("    [gen ", k, ": fixed point of c-map]"); next);
      /* check identity I1 */
      my(P_E = ellchangepointinv(P, v));
      id_ok = (1 + c^2 == ((P_E[1]^2 + 2*q^2*P_E[1] + q^2)/(q^2 - P_E[1]^2))^2);
      if (on_curve != 1 || id_ok != 1,
        verify_failures = verify_failures + 1;
        print("    *** VERIFY FAIL gen ", k, " on_curve=", on_curve, " id_ok=", id_ok));
      c_can = canonical_q(c);
      hc = log_height(c_can);
      F3 = 1 + q^2 + c^2;
      sF3 = sqrt(F3 * 1.0);
      pcp = issquare(F3);
      total_edges_traversed = total_edges_traversed + 1;
      my(lNc_val = -1);
      iferr(lNc_val = log(cond_E(c_can)), E_, lNc_val = -1);
      print("    gen ", k, " -> c=", c_can, "  h(c)=", strprintf("%.3f", hc),
            "  lN(c)~", if(lNc_val>0, strprintf("%.3f", lNc_val), "?"),
            "  sqF3=", strprintf("%.6f", sF3),
            "  PCP=", pcp);
      if (pcp == 1,
        pcp_found = pcp_found + 1;
        print("    !!!!!!! PCP CANDIDATE !!!!!!! q=", q, " c=", c);
      );
      if (!mapisdefined(visited, c_can),
        my(NEc = -1);
        iferr(NEc = cond_E(c_can), E_, NEc = -1);
        if (NEc > 0 && NEc <= maxN_cap,
          mapput(visited, c_can, [d+1, q, hc, log(NEc), sF3, pcp, -1]);
          listput(next_frontier, c_can);
          listput(trajectory, [d+1, c_can, hc, log(NEc), sF3, pcp]);
          total_nodes = total_nodes + 1;
        ,
          if (NEc > maxN_cap,
            print("    [cap: lN=", strprintf("%.3f", log(NEc)), " > ", strprintf("%.3f", log(maxN_cap)), ", no further expansion]");
          ,
            print("    [conductor compute fail]");
          );
          mapput(visited, c_can, [d+1, q, hc, log(max(NEc, 1)), sF3, pcp, -1]);
          listput(trajectory, [d+1, c_can, hc, log(max(NEc, 1)), sF3, pcp]);
        );
      );
    );
  );
  frontier = Vec(next_frontier);
);
}

print("");
print("=== BFS Summary ===");
print("Total unique visited: ", #visited);
print("Total edges traversed: ", total_edges_traversed);
print("Verification failures (ellisoncurve / I1): ", verify_failures);
print("PCP candidates found: ", pcp_found);

print("");
print("=== Full trajectory (depth, q, h, lN, sqF3, pcp) ===");
{
for (i = 1, #trajectory,
  my(t = trajectory[i]);
  print("d=", t[1], "  q=", t[2], "  h=", strprintf("%.3f", t[3]),
        "  lN=", strprintf("%.3f", t[4]),
        "  sqF3=", strprintf("%.6f", t[5]),
        "  PCP=", t[6]);
);
}

quit;
