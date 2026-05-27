/* Orbit closure for multiple seeds: 20/21, 11/60, 7/24, 96/247, 13/84, 27/364, etc.
   For each, do BFS to depth 5 with cap N <= 10^12.
   Track: orbit size, number of PCP candidates (0 expected), max depth.
*/
default(parisize, 1500000000);

canonical_q(qv) = my(n=abs(numerator(qv)), d=abs(denominator(qv))); if (n<=d, n/d, d/n);

gens_db = Map();

addg(q, gv) = mapput(gens_db, q, gv);

addg(20/21, [[-125/4, 395/8]]);
addg(7/24, [[-317/4, 3887/8]]);
addg(11/60, [[-185, 9745], [-515, 7270]]);
addg(48/55, [[-282, 1956]]);
addg(20/99, [[-965, 44950]]);
addg(96/247, [[-2260, 581138]]);
addg(13/84, [[20195/4, 2796619/8]]);
addg(39/80, [[-900, 9030]]);
addg(17/144, [[-1920, 142332], [-3348, 48084]]);
addg(104/153, [[-2894, 44542], [-2998, 7934]]);
addg(44/117, [[-1965, 38553]]);
addg(189/340, [[24850, 3252595]]);
addg(60/91, [[-210, 17805]]);
addg(225/272, [[-4136, 330088]]);
addg(132/475, [[-899/144, 5897298719/1728]]);
addg(252/275, [[-6886, 146663], [-7306, 22553]]);
addg(140/171, [[-482665/169, 164460005/2197]]);
addg(85/132, [[-2281, 16313]]);
addg(108/725, [[360149, 211594238], [39359, 1286048]]);
addg(57/176, [[-1504, 229442]]);
addg(135/352, [[-5496, 1741338]]);
addg(27/364, [[3002, 1265339], [7553, 590681]]);
addg(25/312, [[-48542/9, 37856650/27]]);
addg(28/195, [[7394, 493943]]);
addg(52/165, [[-1346, 190513], [3274, 91183]]);
addg(160/231, [[-6620, 115510]]);
addg(95/168, [[3398, 72536]]);
addg(105/208, [[-13117/4, 2768779/8]]);
addg(52/675, [[5389, 9242848]]);
addg(36/323, [[572049/121, 768697884/1331]]);
addg(195/748, [[151491/4, 15203079/8], [53369, 2563403], [40343619, 256228408278]]);

cmap_data(q) = my(E, Emin, v, gens, results = List(), P_emin, P_E, c); if (!issquare(1 + q^2), return([0, 0, []])); E = ellinit([0, 1+q^2, 0, q^2, 0]); Emin = ellminimalmodel(E, &v); if (!mapisdefined(gens_db, q), return([ellglobalred(Emin)[1], -1, []])); gens = mapget(gens_db, q); for(i=1, length(gens), P_emin = gens[i]; P_E = ellchangepointinv(P_emin, v); if (P_E[1]^2 == q^2, next); c = 2*q*P_E[2]/(q^2 - P_E[1]^2); listput(results, [canonical_q(c), c, issquare(1+q^2+c^2)])); [ellglobalred(Emin)[1], length(gens), Vec(results)];

compute_gens(q, timeout_s) = my(E, Emin, v, N, res); if (!issquare(1 + q^2), return([-1, -1])); E = ellinit([0, 1+q^2, 0, q^2, 0]); Emin = ellminimalmodel(E, &v); N = ellglobalred(Emin)[1]; res = -1; iferr(res = alarm(timeout_s, ellrank(Emin, 2)), E_, res = -1); if (res == -1, return([N, -2])); if (res[1] != res[2] || res[1] == 0, return([N, 0])); if (#res[4] < res[1], return([N, res[1]])); mapput(gens_db, q, res[4]); [N, res[1]];

images_of(q, timeout_s) = my(r); if (!issquare(1+q^2), return([-1, -1, []])); if (!mapisdefined(gens_db, q), r = compute_gens(q, timeout_s); if (r[2] <= 0, return([r[1], r[2], []]))); cmap_data(q);

orbit_closure(seed, max_depth, maxN, timeout) = local(seen, frontier, ranks_seen, total_pcp); seen = Set([seed]); frontier = Set([seed]); ranks_seen = Map(); total_pcp = 0; print(""); print("=== Orbit of seed q=", seed); for(depth = 0, max_depth, if (#frontier == 0, print("  closed at depth ", depth); break); my(next_frontier = Set()); for(j=1, #frontier, my(q = frontier[j], r); r = images_of(q, timeout); if (r[2] <= 0, next); mapput(ranks_seen, q, r[2]); for(k=1, length(r[3]), my(t = r[3][k][1], pcp = r[3][k][3]); if (pcp, total_pcp = total_pcp + 1; print("  PCP CANDIDATE: q=", q, " -> t=", t)); if (!setsearch(seen, t), my(Et = ellinit([0, 1+t^2, 0, t^2, 0]), Nt); Nt = ellglobalred(ellminimalmodel(Et))[1]; if (Nt <= maxN, seen = setunion(seen, Set([t])); next_frontier = setunion(next_frontier, Set([t]))), seen = setunion(seen, Set([t]))))); frontier = next_frontier); print("  size=", #seen, " PCP_candidates=", total_pcp); [seen, total_pcp];

\\ Test orbits for multiple seeds.
{
seeds = [20/21, 7/24, 11/60, 96/247, 13/84, 27/364, 104/153, 195/748, 17/144, 25/312, 132/475, 108/725];
all_seen_global = Set();
max_orbit_size = 0;
total_pcp_global = 0;
for(s=1, length(seeds),
  my(result = orbit_closure(seeds[s], 4, 10^12, 60));
  if (#result[1] > max_orbit_size, max_orbit_size = #result[1]);
  total_pcp_global = total_pcp_global + result[2];
  all_seen_global = setunion(all_seen_global, result[1]);
);

print("");
print("=== Multi-seed summary ===");
print("Total UNIQUE q across all orbits: ", #all_seen_global);
print("Max orbit size: ", max_orbit_size);
print("Total PCP candidates (LD=square): ", total_pcp_global);
print("");
print("All q's in union of orbits:");
print(all_seen_global);
}

quit;
