\\ Leg I — Deep search of ε class [1, 219, 219] for (73, 24) E_Hm generator.
\\
\\ Strategy:
\\   Phase 1: z_3 patch (p_lo = 0) — start small, easy and fast
\\   Phase 2: z_2 patch (p_lo ≈ 830K for q=1) — moderate
\\   Phase 3: z_1 patch, q ∈ [5, 8] — extend Leg H's q range
\\   Phase 4: z_1 patch q=1, p ∈ [2e9, 5e9] — extend Leg H's p range
\\
\\ MW-sieve: skip (p,q) where val2 or val3 is a non-square mod ℓ for ℓ ∈ {11,13,17,19,29,31}.
\\ Combined density ~1/1800.

default(parisize, 400000000);
default(parisizemax, 800000000);
default(realprecision, 30);

A4 = -4296889542830417930548255320;
A6 = 69513195990628448299367172717433334517312;
E = ellinit([1, 0, 0, A4, A6]);

e1 = -289985899459969;
e2 =  69618111281856;
e3 =  220367788178112;
C21 = e2 - e1;  C31 = e3 - e1;
C12 = e1 - e2;  C32 = e3 - e2;
C13 = e1 - e3;  C23 = e2 - e3;

d1 = 1; d2 = 219; d3 = 219;

\\ MW-sieve primes (excluding bad {2,3,5,7,23,73,97,359,1181,1249} and 219=3*73).
\\ Good small primes: 11, 13, 17, 19, 29, 31.
SIEVE_PRIMES = [11, 13, 17, 19, 29, 31];

\\ Build sieve bitmaps: bitmap[patch][ell_index][q mod ell][p mod ell] = 1 if (p,q) survives mod ell.
\\ patch ∈ {1,2,3} for z_1, z_2, z_3.

is_sq_mod(a, p) = {
  a = a % p; if(a < 0, a = a + p);
  if(a == 0, return(1));
  return(Mod(a, p)^((p-1)/2) == 1);
};

\\ For patch p_idx, compute bitmap.
\\ patch_1 (z_1): val2 = d2*(d1 p^2 - C21 q^2),    val3 = d3*(d1 p^2 - C31 q^2)
\\ patch_2 (z_2): val1 = d1*(d2 p^2 - C12 q^2),    val3 = d3*(d2 p^2 - C32 q^2)
\\ patch_3 (z_3): val1 = d1*(d3 p^2 - C13 q^2),    val2 = d2*(d3 p^2 - C23 q^2)
build_bitmap(patch_id) = {
  my(bitmaps = vector(#SIEVE_PRIMES));
  for(ip = 1, #SIEVE_PRIMES,
    my(ell = SIEVE_PRIMES[ip]);
    my(tab = matrix(ell, ell));
    for(qm = 0, ell - 1,
      for(pm = 0, ell - 1,
        my(v1, v2, ok = 1);
        if(patch_id == 1,
          v1 = (d2 * (d1*pm^2 - C21*qm^2)) % ell;
          v2 = (d3 * (d1*pm^2 - C31*qm^2)) % ell;
          if(!is_sq_mod(v1, ell), ok = 0);
          if(ok && !is_sq_mod(v2, ell), ok = 0);
        );
        if(patch_id == 2,
          v1 = (d1 * (d2*pm^2 - C12*qm^2)) % ell;
          v2 = (d3 * (d2*pm^2 - C32*qm^2)) % ell;
          if(!is_sq_mod(v1, ell), ok = 0);
          if(ok && !is_sq_mod(v2, ell), ok = 0);
        );
        if(patch_id == 3,
          v1 = (d1 * (d3*pm^2 - C13*qm^2)) % ell;
          v2 = (d2 * (d3*pm^2 - C23*qm^2)) % ell;
          if(!is_sq_mod(v1, ell), ok = 0);
          if(ok && !is_sq_mod(v2, ell), ok = 0);
        );
        tab[qm+1, pm+1] = ok;
      );
    );
    bitmaps[ip] = tab;
  );
  return(bitmaps);
};

\\ Check if (p, q) survives sieve given bitmaps and patch.
sieve_check(p, q, bitmaps) = {
  for(ip = 1, #SIEVE_PRIMES,
    my(ell = SIEVE_PRIMES[ip]);
    if(bitmaps[ip][q%ell + 1, p%ell + 1] == 0, return(0));
  );
  return(1);
};

\\ Density check
sieve_density(bitmaps) = {
  my(d = 1.0);
  for(ip = 1, #SIEVE_PRIMES,
    my(ell = SIEVE_PRIMES[ip]);
    my(allowed = 0);
    my(M = bitmaps[ip]);
    \\ Average over q != 0 (skip qm=0 since q has nonzero residue typically; gcd(p,q)=1)
    my(total = 0);
    for(qm = 1, ell - 1,
      for(pm = 0, ell - 1,
        total = total + 1;
        if(M[qm+1, pm+1], allowed = allowed + 1);
      );
    );
    d = d * allowed / total;
  );
  return(d);
};

\\ Process candidate (p, q) for patch p_idx. Returns 1 if non-torsion found and updates global.
process_candidate(p, q, patch_id) = {
  my(val1, val2, Xnum, Y2, Yt, x_E, y_E, P, ord, ht);
  if(gcd(p, q) != 1, return(0));
  if(patch_id == 1,
    val1 = d2 * (d1*p^2 - C21*q^2);
    val2 = d3 * (d1*p^2 - C31*q^2);
    Xnum = d1*p^2 + e1*q^2;
  );
  if(patch_id == 2,
    val1 = d1 * (d2*p^2 - C12*q^2);
    val2 = d3 * (d2*p^2 - C32*q^2);
    Xnum = d2*p^2 + e2*q^2;
  );
  if(patch_id == 3,
    val1 = d1 * (d3*p^2 - C13*q^2);
    val2 = d2 * (d3*p^2 - C23*q^2);
    Xnum = d3*p^2 + e3*q^2;
  );
  if(val1 < 0 || val2 < 0, return(0));
  if(!issquare(val1), return(0));
  if(!issquare(val2), return(0));
  Y2 = (Xnum - e1*q^2) * (Xnum - e2*q^2) * (Xnum - e3*q^2);
  if(!issquare(Y2), return(0));
  Yt = sqrtint(Y2);
  x_E = Xnum / (4*q^2);
  for(sgn = 0, 1,
    my(Yu = (-1)^sgn * Yt);
    my(Y_act = Yu / q^3);
    y_E = (Y_act - (Xnum/q^2)/2)/8;
    P = [x_E, y_E];
    if(ellisoncurve(E, P),
      ord = ellorder(E, P);
      print("    *** HIT *** patch=", patch_id, " (p,q)=(", p, ",", q, ")");
      print("       P_E = ", P);
      print("       ellorder = ", ord);
      if(ord == 0,
        ht = ellheight(E, P);
        print("       *** NON-TORSION GENERATOR *** canonical ht = ", ht);
        return(1);
      );
    );
  );
  return(0);
};

print("=== Leg I: deep ε class search ===");
print();

\\ Build bitmaps
print("Building MW-sieve bitmaps...");
bm1 = build_bitmap(1);
bm2 = build_bitmap(2);
bm3 = build_bitmap(3);
print("  z_1 patch sieve density = ", sieve_density(bm1));
print("  z_2 patch sieve density = ", sieve_density(bm2));
print("  z_3 patch sieve density = ", sieve_density(bm3));
print();

\\ Time tracking
t_global_start = getwalltime();
TIME_BUDGET_MS = 28 * 60 * 1000;  \\ 28 minutes for safety margin
hits_total = 0;

\\ Statistics
iter_p1 = 0; iter_p2 = 0; iter_p3 = 0;
test_p1 = 0; test_p2 = 0; test_p3 = 0;  \\ (p,q) after sieve

\\======================================================================
\\ PHASE 1: z_3 patch, q ∈ [1, 8], p ∈ [0, p_max_q].
\\ p_max chosen so naïve height matches Leg H's bound.
\\======================================================================
print("--- PHASE 1: z_3 patch ---");
P_MAX_Q1_PATCH3 = 50000000;  \\ 5e7 — much bigger than Leg H z_1 bound for q=1
{
for(q = 1, 8,
  if(getwalltime() - t_global_start > TIME_BUDGET_MS / 4, break);
  p_lo = 0;
  \\ z_3 patch: no positivity bound; p can start at 0.
  \\ Scale p_max with q (since canonical height bound is on z_3 = p/q):
  p_max = P_MAX_Q1_PATCH3 * q;
  print("  q=", q, "  p in [", p_lo, ", ", p_max, "]");
  my(t0 = getwalltime());
  my(local_iter = 0, local_test = 0, local_hits = 0);
  for(p = p_lo, p_max,
    iter_p3 = iter_p3 + 1;
    local_iter = local_iter + 1;
    if(!sieve_check(p, q, bm3), next);
    test_p3 = test_p3 + 1;
    local_test = local_test + 1;
    if(process_candidate(p, q, 3),
      hits_total = hits_total + 1;
      local_hits = local_hits + 1;
    );
    \\ Time check every 2e7 iterations
    if(local_iter % 20000000 == 0,
      if(getwalltime() - t_global_start > TIME_BUDGET_MS / 4, break);
    );
  );
  my(t1 = getwalltime());
  print("    iter=", local_iter, "  sieve-survivors=", local_test, "  hits=", local_hits, "  wall=", (t1-t0)/1000.0, "s");
);
}
print("Phase 1 done; cumulative wall = ", (getwalltime()-t_global_start)/1000.0, "s");
print();

\\======================================================================
\\ PHASE 2: z_2 patch, q ∈ [1, 8], p ∈ [p_lo, p_max]
\\======================================================================
if(getwalltime() - t_global_start < TIME_BUDGET_MS / 2,
print("--- PHASE 2: z_2 patch ---");
P_MAX_Q1_PATCH2 = 50000000;
{
for(q = 1, 8,
  if(getwalltime() - t_global_start > TIME_BUDGET_MS / 2, break);
  \\ z_2 patch: p_lo = ceil(sqrt(C32/d2))*q
  p_lo_real = sqrtint((C32 * q^2) \ d2) + 1;
  p_lo = p_lo_real;
  p_max = max(P_MAX_Q1_PATCH2 * q, p_lo_real * 50);  \\ at least 50x extension
  if(p_max > 5*10^9, p_max = 5*10^9);
  print("  q=", q, "  p in [", p_lo, ", ", p_max, "]");
  my(t0 = getwalltime());
  my(local_iter = 0, local_test = 0, local_hits = 0);
  for(p = p_lo, p_max,
    iter_p2 = iter_p2 + 1;
    local_iter = local_iter + 1;
    if(!sieve_check(p, q, bm2), next);
    test_p2 = test_p2 + 1;
    local_test = local_test + 1;
    if(process_candidate(p, q, 2),
      hits_total = hits_total + 1;
      local_hits = local_hits + 1;
    );
    if(local_iter % 20000000 == 0,
      if(getwalltime() - t_global_start > TIME_BUDGET_MS / 2, break);
    );
  );
  my(t1 = getwalltime());
  print("    iter=", local_iter, "  sieve-survivors=", local_test, "  hits=", local_hits, "  wall=", (t1-t0)/1000.0, "s");
);
}
print("Phase 2 done; cumulative wall = ", (getwalltime()-t_global_start)/1000.0, "s");
print();
);

\\======================================================================
\\ PHASE 3: z_1 patch, q ∈ [5, 8], p ∈ [p_lo, p_lo + 50*p_lo]
\\======================================================================
if(getwalltime() - t_global_start < 3 * TIME_BUDGET_MS / 4,
print("--- PHASE 3: z_1 patch q ∈ [5, 8] ---");
{
for(q = 5, 8,
  if(getwalltime() - t_global_start > 3 * TIME_BUDGET_MS / 4, break);
  p_lo = sqrtint(C31 * q^2) + 1;
  p_max = p_lo * 51;  \\ 50x extension matches Leg H
  if(p_max > 5*10^9, p_max = 5*10^9);
  print("  q=", q, "  p in [", p_lo, ", ", p_max, "]");
  my(t0 = getwalltime());
  my(local_iter = 0, local_test = 0, local_hits = 0);
  for(p = p_lo, p_max,
    iter_p1 = iter_p1 + 1;
    local_iter = local_iter + 1;
    if(!sieve_check(p, q, bm1), next);
    test_p1 = test_p1 + 1;
    local_test = local_test + 1;
    if(process_candidate(p, q, 1),
      hits_total = hits_total + 1;
      local_hits = local_hits + 1;
    );
    if(local_iter % 20000000 == 0,
      if(getwalltime() - t_global_start > 3 * TIME_BUDGET_MS / 4, break);
    );
  );
  my(t1 = getwalltime());
  print("    iter=", local_iter, "  sieve-survivors=", local_test, "  hits=", local_hits, "  wall=", (t1-t0)/1000.0, "s");
);
}
print("Phase 3 done; cumulative wall = ", (getwalltime()-t_global_start)/1000.0, "s");
print();
);

\\======================================================================
\\ PHASE 4: z_1 patch q=1, p ∈ [2·10⁹, 5·10⁹] — extend Leg H's range
\\======================================================================
if(getwalltime() - t_global_start < TIME_BUDGET_MS,
print("--- PHASE 4: z_1 patch q=1 extension p ∈ [2e9, 5e9] ---");
{
q = 1;
p_lo = 2 * 10^9;
p_max = 5 * 10^9;
print("  q=", q, "  p in [", p_lo, ", ", p_max, "]");
my(t0 = getwalltime());
my(local_iter = 0, local_test = 0, local_hits = 0);
for(p = p_lo, p_max,
  iter_p1 = iter_p1 + 1;
  local_iter = local_iter + 1;
  if(!sieve_check(p, q, bm1), next);
  test_p1 = test_p1 + 1;
  local_test = local_test + 1;
  if(process_candidate(p, q, 1),
    hits_total = hits_total + 1;
    local_hits = local_hits + 1;
  );
  if(local_iter % 50000000 == 0,
    if(getwalltime() - t_global_start > TIME_BUDGET_MS, break);
  );
);
my(t1 = getwalltime());
print("  iter=", local_iter, "  sieve-survivors=", local_test, "  hits=", local_hits, "  wall=", (t1-t0)/1000.0, "s");
}
print("Phase 4 done; cumulative wall = ", (getwalltime()-t_global_start)/1000.0, "s");
print();
);

t_global_end = getwalltime();
print("=== Leg I complete ===");
print("Total wall time = ", (t_global_end - t_global_start)/1000.0, "s");
print("Total iterations: z_1=", iter_p1, "  z_2=", iter_p2, "  z_3=", iter_p3);
print("Sieve survivors:  z_1=", test_p1, "  z_2=", test_p2, "  z_3=", test_p3);
print("Hits found = ", hits_total);
quit;
