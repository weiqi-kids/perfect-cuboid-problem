/* Orbit closure of c-map starting from rank-jump seeds.
   For each seed q, compute MW generators, c-images, recurse to depth 3.
   For each new fiber, run ellrank to check it is rank-jump.
   Also verify Face-3 condition for each generator (issquare(c^2 + 1 + q^2)).
*/
default(parisize, 1500000000);

E_PCP(q) = ellinit([0, 1+q^2, 0, q^2, 0]);
canonical_q(qv) = {
  my(n=abs(numerator(qv)), d=abs(denominator(qv)));
  if (n<=d, n/d, d/n);
};

\\ Known generators (from Agent A list)
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
}

\\ For a q where we have generators in DB, compute c-images.
cmap_images(q) = {
  my(E, Emin, v, gens_emin, results = List());
  if (!mapisdefined(gens_db, q), return([]));
  E = ellinit([0, 1+q^2, 0, q^2, 0]);
  Emin = ellminimalmodel(E, &v);
  gens_emin = mapget(gens_db, q);
  for(i=1, length(gens_emin),
    my(P_emin, P_E, c, F3);
    P_emin = gens_emin[i];
    P_E = ellchangepointinv(P_emin, v);
    if (P_E[1]^2 == q^2, next);
    c = 2*q*P_E[2]/(q^2 - P_E[1]^2);
    F3 = c^2 + 1 + q^2;
    listput(results, [canonical_q(c), c, F3, issquare(F3)]);
  );
  Vec(results);
};

\\ Pretty print
print_cimages(q) = {
  my(r);
  r = cmap_images(q);
  if (#r == 0, print("  (no DB entry for q=", q, ")"); return);
  for(i=1, length(r),
    print("  c=", r[i][2], "  canon=", r[i][1], "  F3=", r[i][3], "  PCP?=", r[i][4]);
  );
  r;
};

\\ Compute conductor and rank for fresh q
compute_NR(q) = {
  my(E, Emin, N, ar);
  E = ellinit([0, 1+q^2, 0, q^2, 0]);
  Emin = ellminimalmodel(E);
  N = ellglobalred(Emin)[1];
  ar = ellrank(Emin, 2);
  [N, ar];
};

print("=== Depth-3 orbit from seed 20/21 (rank 1) ===");
print("Depth 0: 20/21");
r0 = print_cimages(20/21);

print("\nDepth 1: targets");
{
seen_d2 = Set([20/21]);
for(i=1, length(r0),
  my(t = r0[i][1]);
  if (!setsearch(seen_d2, t),
    seen_d2 = setunion(seen_d2, Set([t]));
    print("  -> ", t, ":");
    if (mapisdefined(gens_db, t),
      print_cimages(t);
    ,
      print("    (not in DB)");
    );
  );
);
}

print("\n=== Depth-3 orbit from seed 195/748 (rank 3) — need to compute generators ===");
print("Note: 195/748 generators are not in 30-seed DB. Compute them now.");
q3 = 195/748;
E3 = ellinit([0, 1+q3^2, 0, q3^2, 0]);
E3min = ellminimalmodel(E3, &v3);
print("  conductor = ", ellglobalred(E3min)[1]);
print("  rank up/lo (ellrank): ", ellrank(E3min, 2));

\\ Try also from seed 11/60 (rank 2) at depth 3.
print("\n=== Depth-3 orbit from seed 11/60 (rank 2) ===");
print("Depth 0: 11/60");
r0 = print_cimages(11/60);

depth1_targets = Set();
{
for(i=1, length(r0),
  depth1_targets = setunion(depth1_targets, Set([r0[i][1]]));
);
}

print("\nDepth 1: targets and their c-images");
{
depth2_targets = Set();
for(j=1, #depth1_targets,
  my(t = depth1_targets[j]);
  print("  -> ", t, ":");
  if (mapisdefined(gens_db, t),
    my(r = print_cimages(t));
    for(k=1, length(r),
      if (!setsearch(depth1_targets, r[k][1]) && r[k][1] != 11/60,
        depth2_targets = setunion(depth2_targets, Set([r[k][1]]))
      );
    );
  ,
    print("    (not in DB)");
  );
);
}

print("\nDepth 2 fresh targets: ", depth2_targets);

\\ Print all unique q's in depth 0-2 from 11/60
print("\nAll unique q seen from 11/60 at depth <= 2:");
{
all_q = setunion(Set([11/60]), depth1_targets);
all_q = setunion(all_q, depth2_targets);
}
print(all_q);
print("Total unique q: ", #all_q);

quit;
