/* Orbit classification: for each seed, follow its first-generator-only
   c-iteration as a DETERMINISTIC dynamical system: q -> c -> c' -> ...
   Use the principal generator (first listed).  Track whether the orbit
   2-cycles, is periodic, or escapes to infinity.
   This is the discrete dynamical system the user asked about.
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

/* First-generator orbit: q_0 -> q_1 = canon(cmap(q_0, gens[1])) -> ... */
trace_orbit(seed, max_iter, gen_idx_strategy) =
{
  /* gen_idx_strategy: 1 = always first gen, 2 = always last gen */
  my(q = seed, history = List(), seen = Set(), result_type = "open");
  listput(history, [q, log_height(q), log(cond_E(q))]);
  for (it = 1, max_iter,
    my(gens = try_gens(q, 30), c, c_can);
    if (length(gens) == 0, result_type = concat("dead_at_", Str(it)); break);
    my(g_idx = if (gen_idx_strategy == 1, 1, length(gens)));
    c = cmap_c(q, gens[g_idx]);
    if (c == 0, result_type = concat("fixed_at_", Str(it)); break);
    c_can = canonical_q(c);
    if (setsearch(seen, c_can),
      result_type = concat("cycle_at_", Str(it));
      break;
    );
    seen = setunion(seen, Set([q]));
    my(NEc = -1);
    iferr(NEc = cond_E(c_can), E_, NEc = -1);
    if (NEc < 0, result_type = concat("cond_err_", Str(it)); break);
    listput(history, [c_can, log_height(c_can), log(NEc)]);
    /* Check PCP */
    my(F3 = 1 + q^2 + c^2);
    if (issquare(F3), result_type = concat("PCP_at_", Str(it)); break);
    if (NEc > 5*10^14, result_type = concat("escaped_at_", Str(it)); break);
    q = c_can;
  );
  [seed, result_type, Vec(history)];
};

print("=== First-generator deterministic c-iteration ===");
print("");

seeds = [20/21, 7/24, 39/80, 48/55, 11/60, 17/144, 104/153, 27/364, 195/748, 60/91, 132/475, 96/247, 13/84, 25/312, 28/195];

{
for (i = 1, length(seeds),
  print("--- Seed: ", seeds[i], " (first-gen strategy) ---");
  my(r = trace_orbit(seeds[i], 12, 1));
  print("  result: ", r[2]);
  print("  trajectory:");
  for (j = 1, #r[3],
    my(t = r[3][j]);
    print("    iter ", j-1, ": q=", t[1], "  h=", strprintf("%.3f", t[2]), "  lN=", strprintf("%.3f", t[3]));
  );
  print("");
);
}

print("");
print("=== Last-generator strategy (escapes faster) ===");
print("");

{
for (i = 1, length(seeds),
  print("--- Seed: ", seeds[i], " (last-gen strategy) ---");
  my(r = trace_orbit(seeds[i], 12, 2));
  print("  result: ", r[2]);
  print("  trajectory:");
  for (j = 1, #r[3],
    my(t = r[3][j]);
    print("    iter ", j-1, ": q=", t[1], "  h=", strprintf("%.3f", t[2]), "  lN=", strprintf("%.3f", t[3]));
  );
  print("");
);
}

quit;
