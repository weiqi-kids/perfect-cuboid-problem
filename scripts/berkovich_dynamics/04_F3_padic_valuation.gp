/* 04_F3_padic_valuation.gp
   F_3 = 1 + q^2 + c^2  p-adic valuation along c-map orbits (Track T1).

   Key question: For PCP, F_3 must be a rational square.  This is equivalent
   to: for all primes p, ord_p(F_3) is even AND the squarefree core has
   Kronecker symbol +1 at all primes.

   We compute, for each edge q -> c in the first-generator orbit:
     - ord_p(F_3) for p in {2, 3, 5, 7, 11}
     - Whether ord_p(F_3) is EVEN or ODD (a square is even at every prime)
     - The Kronecker symbol of the "core" mod p
     - The p-adic unit part: F_3 = p^{ord_p(F_3)} * u, with u in Z_p^*
       (we compute u mod p^3 to check if u is a square in Z_p^*)
     - Hensel test: is u mod p a square in F_p?  This is the QR symbol.

   We aggregate over the entire BFS-of-first-generator orbit set:
     - Histogram of ord_p(F_3) values
     - Fraction of edges with ord_p(F_3) odd (would prove F_3 not square via p)
     - Fraction of edges with ord_p(F_3) even but u mod p non-QR (also obstructs)
     - Fraction "p-adically PCP-compatible" (all five primes show even+QR)
*/

default(parisize, 500000000);

canonical_q(qv) = my(n=abs(numerator(qv)), d=abs(denominator(qv))); if (n<=d, n/d, d/n);
log_height(qv) = log(max(abs(numerator(qv)), abs(denominator(qv))));
vp(x, p) = valuation(numerator(x), p) - valuation(denominator(x), p);

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

cmap_image(q, P_emin) = {
  my(E, Em, v, P_E, c);
  E = build_E(q);
  Em = ellminimalmodel(E, &v);
  P_E = ellchangepointinv(P_emin, v);
  if (P_E[1]^2 == q^2, return(0));
  c = 2*q*P_E[2]/(q^2 - P_E[1]^2);
  c;
};

/* p-adic unit part mod p^k */
unit_mod(x, p, k) = {
  my(v, u);
  v = vp(x, p);
  u = x / p^v;
  /* u is now a p-adic unit; reduce numerator * denominator^{-1} mod p^k */
  lift(Mod(numerator(u) * lift(Mod(denominator(u), p^k)^(-1)), p^k));
};

/* Test if (p-adic unit u, given by numerator and denominator) is a square in Z_p^*.
   For odd p: u is a square iff Kronecker(u mod p, p) = 1.
   For p = 2: u is a square iff u ≡ 1 mod 8. */
unit_is_square_in_Zp(x, p) = {
  my(v, num_u, den_u);
  v = vp(x, p);
  num_u = numerator(x) / p^valuation(numerator(x), p);
  den_u = denominator(x) / p^valuation(denominator(x), p);
  if (p == 2,
    /* Check u mod 8 = (num_u * den_u^{-1}) mod 8.  Equivalent to num_u ≡ den_u mod 8 since both odd. */
    return( (num_u - den_u) % 8 == 0 ),
    /* Odd p: Kronecker */
    return( kronecker(num_u * den_u, p) == 1 )
  );
};

/* Build first-generator orbit */
first_gen_orbit(q0, max_depth) = {
  my(orbit = [q0], q = q0, gens, P, c, cc);
  for (k = 1, max_depth,
    if (!mapisdefined(gens_db, q), break);
    gens = mapget(gens_db, q);
    if (length(gens) == 0, break);
    P = gens[1];
    c = cmap_image(q, P);
    if (c == 0, break);
    cc = canonical_q(c);
    orbit = concat(orbit, [cc]);
    q = cc;
  );
  orbit;
};

/* Also: ALL-generator edges (depth-1) for richer statistics */
QLIST = [20/21, 7/24, 11/60, 48/55, 20/99, 96/247, 13/84, 39/80, 17/144, 104/153, 44/117, 189/340, 60/91, 225/272, 132/475, 252/275, 140/171, 85/132, 108/725, 57/176, 135/352, 27/364, 25/312, 28/195, 52/165, 160/231, 95/168, 105/208, 52/675, 36/323, 195/748];

all_gen_depth1_edges() = {
  my(edges = [], q, gens, c);
  for (i = 1, length(QLIST),
    q = QLIST[i];
    if (!mapisdefined(gens_db, q), next);
    gens = mapget(gens_db, q);
    for (k = 1, length(gens),
      c = cmap_image(q, gens[k]);
      if (c == 0, next);
      edges = concat(edges, [[q, canonical_q(c)]]);
    );
  );
  edges;
};

PRIMES = [2, 3, 5, 7, 11];

print("=== F_3 p-adic valuation analysis ===");
print("");
print("EDGE-level data from all-generator depth-1 edges + first-gen orbits");
print("");

edges = all_gen_depth1_edges();
print("Total edges: ", length(edges));
print("");

/* Build aggregate tables */
ord_hist = vector(length(PRIMES), j, Map());     \\ ord_p(F3) histogram
parity_hist = vector(length(PRIMES), j, [0, 0]); \\ [even, odd] counts
unit_sq_hist = vector(length(PRIMES), j, [0, 0]); \\ [u square, u nonsquare]
compatible_p = vector(length(PRIMES), j, 0);     \\ even + unit-square count
all_5_compatible = 0;
issq_F3 = 0;

print("--- Per-edge data (q, c, F_3, [ord_2, ord_3, ord_5, ord_7, ord_11], compatible?) ---");
{
for (i = 1, length(edges),
  my(e = edges[i], q = e[1], c = e[2], F3, ords, parity, units, comp);
  F3 = 1 + q^2 + c^2;
  if (issquare(F3), issq_F3 = issq_F3 + 1; print("** PCP CANDIDATE ** ", e));
  ords = vector(length(PRIMES), j, vp(F3, PRIMES[j]));
  parity = vector(length(PRIMES), j, ords[j] % 2);
  units = vector(length(PRIMES), j, unit_is_square_in_Zp(F3, PRIMES[j]));
  comp = vector(length(PRIMES), j, (parity[j] == 0) && (units[j] == 1));
  /* Update aggregates */
  for (j = 1, length(PRIMES),
    my(v = ords[j], cur);
    cur = if (mapisdefined(ord_hist[j], v), mapget(ord_hist[j], v), 0);
    mapput(ord_hist[j], v, cur + 1);
    if (parity[j] == 0, parity_hist[j][1] = parity_hist[j][1] + 1,
                       parity_hist[j][2] = parity_hist[j][2] + 1);
    if (units[j], unit_sq_hist[j][1] = unit_sq_hist[j][1] + 1,
                  unit_sq_hist[j][2] = unit_sq_hist[j][2] + 1);
    if (comp[j], compatible_p[j] = compatible_p[j] + 1);
  );
  if (vecsum(comp) == length(PRIMES), all_5_compatible = all_5_compatible + 1);
  print(i, ". ", q, " -> ", c, " | ords=", ords, " | parity=", parity, " | u_sq?=", units, " | compat=", comp);
);
}

print("");
print("=== Aggregate statistics ===");
print("");
print("Total edges: ", length(edges));
print("PCP candidates (issquare(F_3)=1): ", issq_F3);
print("");
{
for (j = 1, length(PRIMES),
  my(p = PRIMES[j]);
  print("p = ", p, ":");
  print("  ord_p(F_3) parity: even=", parity_hist[j][1], ", odd=", parity_hist[j][2]);
  print("  unit part square in Z_p^*: yes=", unit_sq_hist[j][1], ", no=", unit_sq_hist[j][2]);
  print("  p-adically PCP-compatible (even + unit-square): ", compatible_p[j], " / ", length(edges));
);
}
print("");
print("All-5-primes p-adically compatible: ", all_5_compatible, " / ", length(edges));
print("");
print("Interpretation:");
print("  An edge q -> c CAN HAVE F_3 = square iff p-adically compatible at ALL primes.");
print("  The remaining obstruction (after p-adic) is that F_3 must NOT have a 'hidden'");
print("  prime obstruction (i.e., square at infinity and at all p, by Hasse principle).");
print("  Since F_3 is positive and the primes 2,3,5,7,11 cover the small-prime");
print("  obstructions, all-5-compatible means F_3 is *probably* square — but we");
print("  test issquare(F_3) directly which is the definitive test.");

quit;
