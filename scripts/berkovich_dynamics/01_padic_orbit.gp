/* 01_padic_orbit.gp
   p-adic / Berkovich Dynamics of the c-Map (Track T1)

   Goal: For each base Pythagorean q with known MW generators, compute the
   c-image c = 2*q*y/(q^2 - x^2) on the *first* generator, and record
   p-adic data for p in {2, 3, 5, 7, 11}:

     - ord_p(q), ord_p(c)
     - ord_p(numerator), ord_p(denominator) of c
     - ord_p(1+c^2)  -- always 0 if c^2 != -1 mod p (sanity check)
     - ord_p(F_3) = ord_p(1 + q^2 + c^2)
     - |q|_p = p^{-ord_p(q_num) + ord_p(q_den)}  (p-adic absolute value of q)
     - log|c|_p

   First-generator policy matches CMAP-DYNAMICS.md §2.2.  We do NOT compute
   ranks here -- we reuse the gens_db from 01_dynamics_invariants.gp.
*/

default(parisize, 500000000);

/* canonical-q (in (0,1]) */
canonical_q(qv) = my(n=abs(numerator(qv)), d=abs(denominator(qv))); if (n<=d, n/d, d/n);
log_height(qv) = log(max(abs(numerator(qv)), abs(denominator(qv))));

/* p-adic valuation of a rational */
vp(x, p) = valuation(numerator(x), p) - valuation(denominator(x), p);
/* p-adic absolute value: |x|_p = p^{-vp(x)} */
abs_p(x, p) = if (x==0, 0.0, 1.0 * p^(-vp(x,p)));
log_abs_p(x, p) = if (x==0, -oo, -vp(x,p) * log(p));

/* Database of rational MW generators on E_min (from CMAP-DYNAMICS scripts) */
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

/* First-generator policy: pick gens[1] and iterate.  Stop when canonical c
   leaves gens_db or after max_depth steps. */
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

print("=== p-adic c-Map Orbit (first-generator policy) ===");
print("");
print("Columns per orbit step q_n: |num|, |den|, h(q),  ord_p(q_n) for p in ", PRIMES);
print("Edge data q_{n-1} -> q_n:   ord_p(F_3 = 1+q_{n-1}^2+q_n^2) for p in ", PRIMES);
print("");

seeds = [20/21, 7/24, 11/60, 48/55, 20/99, 96/247, 39/80, 17/144, 104/153, 44/117, 60/91, 225/272, 132/475, 252/275, 85/132, 57/176, 135/352, 27/364, 52/165, 160/231, 195/748];

\\ tabulate orbits + ord_p info
{
for (s = 1, length(seeds),
  my(q0 = seeds[s], orbit, n);
  orbit = first_gen_orbit(q0, 6);
  n = length(orbit);
  print("--- Seed q0 = ", q0, "  orbit length=", n, " ---");
  for (k = 1, n,
    my(q = orbit[k], nn = numerator(q), dd = denominator(q), h = log_height(q));
    print("  q_", k-1, " = ", q, "  (h=", strprintf("%.3f", h), ")");
    print("    ord_p(q): ", vector(length(PRIMES), j, vp(q, PRIMES[j])));
    print("    ord_p(num): ", vector(length(PRIMES), j, valuation(nn, PRIMES[j])));
    print("    ord_p(den): ", vector(length(PRIMES), j, valuation(dd, PRIMES[j])));
    if (k >= 2,
      my(qprev = orbit[k-1], F3 = 1 + qprev^2 + q^2);
      print("    F3(", k-2, "->", k-1, ") = ", F3);
      print("    issquare(F3) = ", issquare(F3));
      print("    ord_p(F3): ", vector(length(PRIMES), j, vp(F3, PRIMES[j])));
      print("    ord_p(F3_num): ", vector(length(PRIMES), j, valuation(numerator(F3), PRIMES[j])));
      print("    ord_p(F3_den): ", vector(length(PRIMES), j, valuation(denominator(F3), PRIMES[j])));
    );
  );
  print("");
);
}

print("=== End p-adic orbit tabulation ===");
quit;
