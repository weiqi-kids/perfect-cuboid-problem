/* 02_padic_height.gp
   p-adic "canonical height" along c-map orbits (Track T1).

   The c-map is NOT a rational self-map of P^1: it depends on the chosen
   generator on E_PCP(q).  But under the FIRST-GENERATOR policy (gens[1]
   pulled back from E_min), we get a deterministic sequence
       q_0, q_1, q_2, ...
   For each base q in gens_db.  We compute:

     - log|q_n|_p = -ord_p(q_n) * log(p)   (p-adic log-absolute value)
     - "local height growth rate":
           rho_p(q_0) = lim_{n->infty} (1/n) * log|q_n|_p
       approximated by mean over last few steps
     - "local archimedean rate":
           rho_inf(q_0) = lim_{n->infty} (1/n) * h(q_n)
       approximated similarly.

   We also accumulate the "Mahler / p-adic Néron-Tate" style sum
       H_p(q_0) = sum_{n=0}^{N-1} max(0, -ord_p(q_n))
   which measures how often the orbit visits the unit disc / open disc
   complement in B_p^1.

   We do NOT compute Néron-Tate canonical height on the elliptic curves
   (the c-map is not a self-isogeny).  This is a height-on-P^1-style
   accumulator -- the closest one can get given that c-map is not a
   polynomial of P^1 to itself.
*/

default(parisize, 500000000);

canonical_q(qv) = my(n=abs(numerator(qv)), d=abs(denominator(qv))); if (n<=d, n/d, d/n);
log_height(qv) = log(max(abs(numerator(qv)), abs(denominator(qv))));
vp(x, p) = valuation(numerator(x), p) - valuation(denominator(x), p);
log_abs_p(x, p) = if (x==0, -oo, -vp(x,p) * log(p));

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

PRIMES = [2, 3, 5, 7, 11];

/* Per-orbit p-adic "canonical height" data.
   - H_p_pos(q0) = sum over orbit of max(0, -ord_p(q_n)) = "visits to outside |.|_p<=1"
   - H_p_neg(q0) = sum over orbit of max(0, ord_p(q_n))  = "visits to inside |.|_p<1"
   - rho_p(q0) = mean( |ord_p(q_n) - ord_p(q_{n-1})| ) along orbit
   - rho_inf(q0) = mean( |h(q_n) - h(q_{n-1})| )
*/

print("=== p-adic Canonical Height Accumulators ===");
print("");
print("Cols: seed q0 | orbit_len | h-sum | rho_inf || for each p in ", PRIMES, ": [H_p_pos, H_p_neg, rho_p]");
print("");

seeds = [20/21, 7/24, 11/60, 48/55, 20/99, 96/247, 39/80, 17/144, 104/153, 44/117, 60/91, 225/272, 132/475, 252/275, 85/132, 57/176, 135/352, 27/364, 52/165, 160/231, 195/748, 95/168, 13/84, 105/208, 52/675, 28/195, 36/323, 25/312, 108/725, 140/171, 189/340];

print("Total seeds tested: ", length(seeds));
print("");

\\ Headers for the per-prime breakdown
print("seed | n | sum_h | rho_inf | (p, H_pos, H_neg, rho_p) for p=2,3,5,7,11");
print("");

aggreg_rho_inf = 0.0;
aggreg_rho_p = vector(length(PRIMES), j, 0.0);
aggreg_n = 0;

{
for (s = 1, length(seeds),
  my(q0 = seeds[s], orbit, n, sumh = 0.0, rho_inf = 0.0,
     row_p = vector(length(PRIMES)));
  orbit = first_gen_orbit(q0, 8);
  n = length(orbit);
  if (n < 2, print(q0, " | trivial orbit (n=", n, ")"); next);
  for (k = 1, n,
    sumh = sumh + log_height(orbit[k]);
  );
  rho_inf = (log_height(orbit[n]) - log_height(orbit[1])) / (n - 1);
  for (j = 1, length(PRIMES),
    my(p = PRIMES[j], hpos = 0, hneg = 0, dsum = 0.0);
    for (k = 1, n,
      my(v = vp(orbit[k], p));
      if (v < 0, hpos = hpos + (-v));
      if (v > 0, hneg = hneg + v);
    );
    for (k = 2, n,
      dsum = dsum + abs(vp(orbit[k], p) - vp(orbit[k-1], p));
    );
    row_p[j] = [hpos, hneg, 1.0 * dsum / (n - 1)];
  );
  print(q0, " | n=", n, " | sumh=", strprintf("%.3f", sumh),
        " | rho_inf=", strprintf("%.3f", rho_inf),
        " | p-data: ", row_p);
  aggreg_rho_inf = aggreg_rho_inf + rho_inf;
  for (j = 1, length(PRIMES), aggreg_rho_p[j] = aggreg_rho_p[j] + row_p[j][3]);
  aggreg_n = aggreg_n + 1;
);
}

print("");
print("=== Aggregate over ", aggreg_n, " seeds with non-trivial orbits ===");
print("mean rho_inf = ", strprintf("%.4f", aggreg_rho_inf / aggreg_n));
{
for (j = 1, length(PRIMES),
  print("mean rho_p (p=", PRIMES[j], ") = ", strprintf("%.4f", aggreg_rho_p[j] / aggreg_n));
);
}
print("");
print("Interpretation: rho_inf > 0 = expansion at infinity.");
print("                rho_p > 0   = ord_p NOT preserved -- orbit moves in Q_p.");
print("                rho_p == 0  = ord_p constant along orbit -- the prime p is");
print("                              'inert' for the c-map dynamics from this seed.");
quit;
