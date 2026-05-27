/* Extended orbit closure with ON-DEMAND rank/generator computation.
   Start from rank-3 seed 195/748, iterate c-map, track every new q,
   verify rank-jump and Pythagorean and Face-3 status.

   Cap computation by conductor/wall time. Goal: list orbit closure up to
   some depth or conductor bound. Track effective orbit size.
*/
default(parisize, 1500000000);

canonical_q(qv) = {
  my(n=abs(numerator(qv)), d=abs(denominator(qv)));
  if (n<=d, n/d, d/n);
};

\\ Pre-computed generators for known seeds.
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
mapput(gens_db, 60/91, [[-210, 17805]]);
mapput(gens_db, 225/272, [[-4136, 330088]]);
mapput(gens_db, 195/748, [[151491/4, 15203079/8], [53369, 2563403], [40343619, 256228408278]]);
}

\\ Compute c-image for a Pythagorean q with known minimal-model generators.
\\ Returns list of (canonical_c, raw_c, F3, is_pcp_candidate).
cmap_images_db(q) = {
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

\\ For a fresh q, compute generators on-the-fly using ellrank.
\\ Time-bound: skip if conductor > maxN.
cmap_images_compute(q, maxN, timebound) = {
  my(E, Emin, v, N, res, rk, gens_emin, gens_E, results = List());
  if (!issquare(1+q^2),
    print("    [skip: q=", q, " not Pythagorean]"); return([]));
  E = ellinit([0, 1+q^2, 0, q^2, 0]);
  Emin = ellminimalmodel(E, &v);
  N = ellglobalred(Emin)[1];
  if (N > maxN, print("    [skip: N=", N, " > maxN=", maxN, "]"); return([N, -1, []]));
  \\ Try ellrank with time bound
  alarm(timebound, res = ellrank(Emin, 2), res = [-1, -1, 0, []]);
  rk = res[1];
  if (rk == 0 || rk != res[2],
    print("    [rank unclear: ellrank=", res[1], "/", res[2], "  N=", N, "]");
    return([N, 0, []]);
  );
  gens_emin = res[4];
  if (#gens_emin < rk,
    print("    [rank ", rk, " but only ", #gens_emin, " gens; saturate maybe needed]");
    return([N, rk, []]);
  );
  for(i=1, rk,
    my(P_emin, P_E, c, F3);
    P_emin = gens_emin[i];
    P_E = ellchangepointinv(P_emin, v);
    if (P_E[1]^2 == q^2, next);
    c = 2*q*P_E[2]/(q^2 - P_E[1]^2);
    F3 = c^2 + 1 + q^2;
    listput(results, [canonical_q(c), c, F3, issquare(F3)]);
  );
  [N, rk, Vec(results)];
};

print("=== Orbit closure starting from 195/748 (rank 3) ===");
print("\nDepth 0: 195/748");
print("  Generators (from DB): 3 points");
r0 = cmap_images_db(195/748);
print("  c-images:");
for(i=1, length(r0), print("    G", i, ": c=", r0[i][2], " canon=", r0[i][1], " PCP?=", r0[i][4]));

\\ Build set of seeds and frontier
seen = Set();
frontier = Set();
{
seen = setunion(seen, Set([195/748]));
for(i=1, length(r0),
  frontier = setunion(frontier, Set([r0[i][1]]));
);
}

\\ Process each frontier element
print("\nDepth 1 targets and their c-images:");
{
depth2 = Set();
for(j=1, #frontier,
  my(t = frontier[j]);
  seen = setunion(seen, Set([t]));
  print("\n--- q=", t);
  if (mapisdefined(gens_db, t),
    my(r = cmap_images_db(t));
    for(k=1, length(r),
      print("    -> c=", r[k][2], " canon=", r[k][1], " PCP?=", r[k][4]);
      if (!setsearch(seen, r[k][1]) && !setsearch(frontier, r[k][1]),
        depth2 = setunion(depth2, Set([r[k][1]]));
      );
    );
  ,
    print("    [not in DB, attempting ellrank...]");
    my(r = cmap_images_compute(t, 10^10, 60));
    if (#r == 3 && r[2] > 0,
      print("    N=", r[1], "  rank=", r[2]);
      for(k=1, length(r[3]),
        print("    -> c=", r[3][k][2], " canon=", r[3][k][1], " PCP?=", r[3][k][4]);
        if (!setsearch(seen, r[3][k][1]) && !setsearch(frontier, r[3][k][1]),
          depth2 = setunion(depth2, Set([r[3][k][1]]));
        );
      );
    );
  );
);
print("\nDepth 2 new targets: ", depth2);
print("Total unique q after depth 2: ", #setunion(setunion(seen, frontier), depth2));
}

\\ ----- Now extensive search from 11/60 with on-demand rank computation -----
print("\n\n=== Orbit closure starting from 11/60 (rank 2), depth 4 ===");
seen = Set([11/60]);
frontier = Set();
r = cmap_images_db(11/60);
{
print("Depth 0 -> 1:");
for(i=1, length(r),
  print("  ", r[i][1], " (PCP?=", r[i][4], ")");
  frontier = setunion(frontier, Set([r[i][1]]));
);
}

\\ Iterate manually depths 1, 2, 3
\\ At each depth, for each q in frontier, compute c-images either from DB or by ellrank.
{
for(depth = 1, 4,
  print("\n--- Depth ", depth, " ---");
  print("Frontier size: ", #frontier);
  print("Frontier: ", frontier);
  my(next_frontier = Set());
  for(j=1, #frontier,
    my(t = frontier[j]);
    if (setsearch(seen, t), next);
    seen = setunion(seen, Set([t]));
    print("  q=", t, ":");
    my(r);
    if (mapisdefined(gens_db, t),
      r = cmap_images_db(t);
    ,
      print("    [computing rank for q=", t, "...]");
      my(rcomp = cmap_images_compute(t, 10^12, 180));
      if (type(rcomp) == "t_VEC" && #rcomp == 3 && rcomp[2] > 0,
        r = rcomp[3];
        print("    N=", rcomp[1], "  rank=", rcomp[2]);
      ,
        r = [];
        if (type(rcomp) == "t_VEC" && #rcomp >= 1, print("    N=", rcomp[1], " rank-unclear or too large"));
      );
    );
    for(k=1, length(r),
      print("    -> ", r[k][1], " (PCP?=", r[k][4], ")");
      if (!setsearch(seen, r[k][1]),
        next_frontier = setunion(next_frontier, Set([r[k][1]]));
      );
    );
  );
  frontier = next_frontier;
  if (#frontier == 0, print("Frontier empty, orbit closed at depth ", depth); break);
);
}

print("\n=== Final orbit closure of 11/60 ===");
print("Total unique q: ", #seen);
print("Seen: ", seen);

quit;
