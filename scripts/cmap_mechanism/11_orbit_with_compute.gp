/* Extended orbit closure with on-demand rank/generator computation.
   Fixed syntax: alarm(seconds, expression) returns expression value or errors.
*/
default(parisize, 1500000000);

canonical_q(qv) = {
  my(n=abs(numerator(qv)), d=abs(denominator(qv)));
  if (n<=d, n/d, d/n);
};

{
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
}

\\ For q with DB entry, compute c-images and Face data.
cmap_data(q) = {
  my(E, Emin, v, gens, results = List());
  if (!issquare(1 + q^2), return([0, 0, []]));  \\ not Pythagorean, can't be source
  E = ellinit([0, 1+q^2, 0, q^2, 0]);
  Emin = ellminimalmodel(E, &v);
  if (!mapisdefined(gens_db, q),
    return([ellglobalred(Emin)[1], -1, []]);  \\ not in DB
  );
  gens = mapget(gens_db, q);
  for(i=1, length(gens),
    my(P_emin = gens[i], P_E, c);
    P_E = ellchangepointinv(P_emin, v);
    if (P_E[1]^2 == q^2, next);
    c = 2*q*P_E[2]/(q^2 - P_E[1]^2);
    listput(results, [canonical_q(c), c, issquare(1+q^2+c^2)]);
  );
  [ellglobalred(Emin)[1], length(gens), Vec(results)];
};

\\ For fresh q, compute generators via ellrank (with alarm).
compute_gens(q, timeout_s) = {
  my(E, Emin, v, N, res, gens_v);
  if (!issquare(1 + q^2), return([-1, -1, []]));
  E = ellinit([0, 1+q^2, 0, q^2, 0]);
  Emin = ellminimalmodel(E, &v);
  N = ellglobalred(Emin)[1];
  res = -1;
  iferr(
    res = alarm(timeout_s, ellrank(Emin, 2)),
    E_,
    res = -1
  );
  if (res == -1, return([N, -2, []]));
  if (res[1] != res[2] || res[1] == 0, return([N, 0, res]));
  gens_v = res[4];
  if (#gens_v < res[1], return([N, res[1], []]));
  \\ Save to DB
  mapput(gens_db, q, gens_v);
  [N, res[1], gens_v];
};

\\ Get c-images for any Pythagorean q (uses cache or computes).
images_of(q, timeout_s) = {
  if (!issquare(1+q^2), return([-1, -1, []]));
  if (!mapisdefined(gens_db, q),
    my(r = compute_gens(q, timeout_s));
    if (r[2] <= 0, return([r[1], r[2], []]));
  );
  cmap_data(q);
};

\\ Orbit BFS from a seed.
{
print("=== Orbit BFS from 195/748 (rank 3, large conductor) ===");
seed = 195/748;
print("Seed: ", seed);
seen = Set([seed]);
frontier = Set([seed]);
all_data = List();
ranks_seen = Map();
mapput(ranks_seen, seed, 3);

max_depth = 5;
maxN = 10^13;
timeout = 120;

for(depth = 0, max_depth,
  print("\n--- Depth ", depth, ": frontier size = ", #frontier, " ---");
  if (#frontier == 0, print("Closed at depth ", depth); break);
  my(next_frontier = Set());
  for(j=1, #frontier,
    my(q = frontier[j]);
    if (q == 0 || abs(q) >= 1 && q != frontier[j], next);
    print("  q=", q);
    my(r = images_of(q, timeout));
    if (r[2] <= 0,
      print("    N=", r[1], " rank=", r[2], " (skip)");
      next;
    );
    mapput(ranks_seen, q, r[2]);
    print("    N=", r[1], "  rank=", r[2]);
    for(k=1, length(r[3]),
      my(t = r[3][k][1], pcp = r[3][k][3]);
      print("    -> ", t, " (PCP?=", pcp, ")");
      listput(all_data, [q, t, pcp]);
      if (!setsearch(seen, t),
        if (t == 0 || abs(t) >= 1, next);
        \\ Check conductor bound before adding
        my(Et = ellinit([0, 1+t^2, 0, t^2, 0]));
        my(Nt = ellglobalred(ellminimalmodel(Et))[1]);
        if (Nt <= maxN,
          seen = setunion(seen, Set([t]));
          next_frontier = setunion(next_frontier, Set([t]));
        ,
          print("      [conductor ", Nt, " > maxN, skip]");
          seen = setunion(seen, Set([t]));  \\ still mark seen
        );
      );
    );
  );
  frontier = next_frontier;
);

print("\n=== Final orbit closure from 195/748 ===");
print("Total unique q (depth <= ", max_depth, "): ", #seen);
print("Q values: ", seen);
print("\nRanks: ");
{
keys_r = Vec(Mat(ranks_seen)[,1]);
for(j=1, #keys_r,
  if (mapisdefined(ranks_seen, keys_r[j]),
    print("  q=", keys_r[j], "  rank=", mapget(ranks_seen, keys_r[j]));
  );
);
}
}

quit;
