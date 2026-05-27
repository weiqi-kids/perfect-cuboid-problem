/* Multi-seed BFS: rank-1, rank-2, rank-3 seeds all together,
   build the union orbit graph, all verifications.
   Cap depth=4, conductor 2e13. Also measure: distance from any sqrtF3
   to 1 (since 1+q^2+c^2 >= 1+q^2 >= 1 always, but could it approach an
   integer square asymptotically?). Compute min sqrtF3 over all edges.
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

try_gens(q, timeout_s) =
{
  my(E, Em, res);
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

/* Multiple seeds */
seeds = [20/21, 7/24, 39/80, 48/55, 11/60, 17/144, 104/153, 27/364, 195/748];

print("=== Multi-seed BFS, depth 4, cap 2e13 ===");
print("");

maxN_cap = 2*10^13;
max_depth = 4;
timeout_s = 60;

all_edges = List();
all_F3 = List();
all_h = List();
visited_set = Set();

{
for (s_idx = 1, length(seeds),
  my(seed = seeds[s_idx]);
  print("--- Seed: ", seed, " ---");
  my(frontier = [seed]);
  visited_set = setunion(visited_set, Set([seed]));
  listput(all_h, log_height(seed));
  for (d = 0, max_depth-1,
    if (#frontier == 0, break);
    my(next_frontier = List());
    for (j = 1, #frontier,
      my(q = frontier[j], gens);
      gens = try_gens(q, timeout_s);
      if (length(gens) == 0, next);
      for (k = 1, length(gens),
        my(P = gens[k], on_curve, c, c_can, F3, sF3, pcp);
        my(E = build_E(q), v);
        ellminimalmodel(E, &v);
        my(Em = ellminimalmodel(E));
        on_curve = ellisoncurve(Em, P);
        c = cmap_c(q, P);
        if (c == 0, next);
        c_can = canonical_q(c);
        F3 = 1 + q^2 + c^2;
        sF3 = sqrt(F3 * 1.0);
        pcp = issquare(F3);
        if (on_curve != 1, error("on_curve fail q=", q, " k=", k));
        if (pcp == 1, print("    !!! PCP !!! q=", q, " c=", c));
        listput(all_edges, [d, q, c_can, log_height(q), log_height(c_can), sF3, pcp, on_curve]);
        listput(all_F3, sF3);
        listput(all_h, log_height(c_can));
        if (!setsearch(visited_set, c_can),
          my(NEc = -1);
          iferr(NEc = cond_E(c_can), E_, NEc = -1);
          if (NEc > 0 && NEc <= maxN_cap,
            visited_set = setunion(visited_set, Set([c_can]));
            listput(next_frontier, c_can);
          ,
            visited_set = setunion(visited_set, Set([c_can]));
          );
        );
      );
    );
    frontier = Vec(next_frontier);
  );
  print("  visited_set now size: ", #visited_set);
);
}

print("");
print("=== Overall ===");
print("Total unique nodes: ", #visited_set);
print("Total edges traversed: ", #all_edges);

/* Statistics */
{
my(pcps = 0, min_sF3 = 1e30, max_sF3 = -1e30);
for (i = 1, #all_F3,
  if (all_F3[i] < min_sF3, min_sF3 = all_F3[i]);
  if (all_F3[i] > max_sF3, max_sF3 = all_F3[i]);
);
for (i = 1, #all_edges,
  if (all_edges[i][7] == 1, pcps = pcps + 1);
);
print("PCP candidates: ", pcps);
print("min sqrtF3: ", strprintf("%.6f", min_sF3));
print("max sqrtF3: ", strprintf("%.6f", max_sF3));
print("");
print("Closest sqrtF3 to a NEAREST integer:");
my(closest_n = -1, closest_dist = 1e30, closest_edge = 0);
for (i = 1, #all_edges,
  my(sF3 = all_edges[i][6], n = round(sF3), d = abs(sF3 - n));
  if (d < closest_dist, closest_dist = d; closest_n = n; closest_edge = i);
);
print("  edge index ", closest_edge, ":");
print("    q=", all_edges[closest_edge][2], " -> c=", all_edges[closest_edge][3]);
print("    sqrtF3=", strprintf("%.9f", all_edges[closest_edge][6]), "  nearest int=", closest_n, "  dist=", strprintf("%.9f", closest_dist));
}

print("");
print("=== Histogram: sqrtF3 distribution ===");
{
my(bins = vector(20), bin_edges);
bin_edges = vector(21);
for (i = 0, 20, bin_edges[i+1] = 1.0 + i * 0.2);  /* 1.0, 1.2, 1.4, ..., 5.0 */
for (i = 1, #all_F3,
  my(sF3 = all_F3[i], placed = 0);
  for (b = 1, 20,
    if (sF3 >= bin_edges[b] && sF3 < bin_edges[b+1],
      bins[b] = bins[b] + 1;
      placed = 1;
      break;
    );
  );
);
for (b = 1, 20,
  if (bins[b] > 0,
    print("  [", strprintf("%.2f", bin_edges[b]), ", ", strprintf("%.2f", bin_edges[b+1]), "): ", bins[b]);
  );
);
}

quit;
