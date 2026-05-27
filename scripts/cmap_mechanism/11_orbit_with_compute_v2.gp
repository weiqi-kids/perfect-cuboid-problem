/* Orbit closure v2: no nested braces. */
default(parisize, 1500000000);

canonical_q(qv) = my(n=abs(numerator(qv)), d=abs(denominator(qv))); if (n<=d, n/d, d/n);

addgens(q, gv) = mapput(gens_db, q, gv);

gens_db = Map();

addgens(20/21, [[-125/4, 395/8]]);
addgens(7/24, [[-317/4, 3887/8]]);
addgens(11/60, [[-185, 9745], [-515, 7270]]);
addgens(48/55, [[-282, 1956]]);
addgens(20/99, [[-965, 44950]]);
addgens(96/247, [[-2260, 581138]]);
addgens(13/84, [[20195/4, 2796619/8]]);
addgens(39/80, [[-900, 9030]]);
addgens(17/144, [[-1920, 142332], [-3348, 48084]]);
addgens(104/153, [[-2894, 44542], [-2998, 7934]]);
addgens(44/117, [[-1965, 38553]]);
addgens(189/340, [[24850, 3252595]]);
addgens(60/91, [[-210, 17805]]);
addgens(225/272, [[-4136, 330088]]);
addgens(132/475, [[-899/144, 5897298719/1728]]);
addgens(252/275, [[-6886, 146663], [-7306, 22553]]);
addgens(140/171, [[-482665/169, 164460005/2197]]);
addgens(85/132, [[-2281, 16313]]);
addgens(108/725, [[360149, 211594238], [39359, 1286048]]);
addgens(57/176, [[-1504, 229442]]);
addgens(135/352, [[-5496, 1741338]]);
addgens(27/364, [[3002, 1265339], [7553, 590681]]);
addgens(25/312, [[-48542/9, 37856650/27]]);
addgens(28/195, [[7394, 493943]]);
addgens(52/165, [[-1346, 190513], [3274, 91183]]);
addgens(160/231, [[-6620, 115510]]);
addgens(95/168, [[3398, 72536]]);
addgens(105/208, [[-13117/4, 2768779/8]]);
addgens(52/675, [[5389, 9242848]]);
addgens(36/323, [[572049/121, 768697884/1331]]);
addgens(195/748, [[151491/4, 15203079/8], [53369, 2563403], [40343619, 256228408278]]);

cmap_data(q) = my(E, Emin, v, gens, results = List(), P_emin, P_E, c); if (!issquare(1 + q^2), return([0, 0, []])); E = ellinit([0, 1+q^2, 0, q^2, 0]); Emin = ellminimalmodel(E, &v); if (!mapisdefined(gens_db, q), return([ellglobalred(Emin)[1], -1, []])); gens = mapget(gens_db, q); for(i=1, length(gens), P_emin = gens[i]; P_E = ellchangepointinv(P_emin, v); if (P_E[1]^2 == q^2, next); c = 2*q*P_E[2]/(q^2 - P_E[1]^2); listput(results, [canonical_q(c), c, issquare(1+q^2+c^2)])); [ellglobalred(Emin)[1], length(gens), Vec(results)];

compute_gens(q, timeout_s) = my(E, Emin, v, N, res); if (!issquare(1 + q^2), return([-1, -1])); E = ellinit([0, 1+q^2, 0, q^2, 0]); Emin = ellminimalmodel(E, &v); N = ellglobalred(Emin)[1]; res = -1; iferr(res = alarm(timeout_s, ellrank(Emin, 2)), E_, res = -1); if (res == -1, return([N, -2])); if (res[1] != res[2] || res[1] == 0, return([N, 0])); if (#res[4] < res[1], return([N, res[1]])); mapput(gens_db, q, res[4]); [N, res[1]];

images_of(q, timeout_s) = my(r); if (!issquare(1+q^2), return([-1, -1, []])); if (!mapisdefined(gens_db, q), r = compute_gens(q, timeout_s); if (r[2] <= 0, return([r[1], r[2], []]))); cmap_data(q);

print("=== Orbit BFS from 195/748 (rank 3, large conductor) ===");
seed = 195/748;
print("Seed: ", seed);
seen = Set([seed]);
frontier = Set([seed]);
ranks_seen = Map();
mapput(ranks_seen, seed, 3);

max_depth = 5;
maxN = 5*10^12;
timeout = 90;

cnt = 0;

{
for(depth = 0, max_depth,
  print("");
  print("--- Depth ", depth, ": frontier size = ", #frontier, " ---");
  if (#frontier == 0, print("Closed at depth ", depth); break);
  my(next_frontier = Set());
  for(j=1, #frontier,
    my(q = frontier[j], r);
    print("  q=", q);
    r = images_of(q, timeout);
    if (r[2] <= 0, print("    N=", r[1], " rank=", r[2], " (skip)"); next);
    mapput(ranks_seen, q, r[2]);
    print("    N=", r[1], "  rank=", r[2]);
    for(k=1, length(r[3]),
      my(t = r[3][k][1], pcp = r[3][k][3]);
      print("    -> ", t, " (PCP?=", pcp, ")");
      if (!setsearch(seen, t),
        my(Et, Nt);
        Et = ellinit([0, 1+t^2, 0, t^2, 0]);
        Nt = ellglobalred(ellminimalmodel(Et))[1];
        if (Nt <= maxN,
          seen = setunion(seen, Set([t]));
          next_frontier = setunion(next_frontier, Set([t]));
        ,
          print("      [conductor ", Nt, " > maxN, skip from frontier]");
          seen = setunion(seen, Set([t]));
        );
      );
    );
  );
  frontier = next_frontier;
);
}

print("");
print("=== Final orbit closure from 195/748 ===");
print("Total unique q (depth <= ", max_depth, "): ", #seen);
print("");
print("Q values seen:");
{
for(j=1, #seen,
  my(q = seen[j], rk = -99);
  if (mapisdefined(ranks_seen, q), rk = mapget(ranks_seen, q));
  print("  q=", q, "  rank=", rk);
);
}

quit;
