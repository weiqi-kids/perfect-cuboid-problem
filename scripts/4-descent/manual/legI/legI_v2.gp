\\ Leg I v2 — optimized with precomputed per-q combined sieve.
\\
\\ For each q value used, precompute a single bitmap of length M = 11*13*17*19 = 46189
\\ indexed by (p mod M). Then sieve check is one array lookup.
\\
\\ Smaller primes only: 11*13*17*19 = 46189. Combined density:
\\   0.4545 * 0.3077 * 0.2353 * 0.2105 = 0.00693 ≈ 1/144
\\ Plus additional check by 29 and 31 after main sieve survives — adds another 1/12 reduction.

default(parisize, 500000000);
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

\\ Combined modulus for primary sieve (vector lookup)
M_PRIMARY = 11 * 13 * 17 * 19;  \\ = 46189
\\ Secondary sieve primes (used in series after primary survives)
SEC_PRIMES = [29, 31];

is_sq_mod(a, p) = {
  a = a % p; if(a < 0, a = a + p);
  if(a == 0, return(1));
  return(Mod(a, p)^((p-1)/2) == 1);
};

\\ Patch encoders: returns (val1, val2)
\\ patch_1 (z_1): val1=d2*(d1 p^2-C21 q^2), val2=d3*(d1 p^2-C31 q^2)
\\ patch_2 (z_2): val1=d1*(d2 p^2-C12 q^2), val2=d3*(d2 p^2-C32 q^2)
\\ patch_3 (z_3): val1=d1*(d3 p^2-C13 q^2), val2=d2*(d3 p^2-C23 q^2)

\\ Build primary bitmap for given (patch, q). bitmap is vector of M_PRIMARY 0/1s.
build_primary_bitmap(patch_id, q) = {
  my(bm = vector(M_PRIMARY));
  my(M = M_PRIMARY);
  my(primes_used = [11, 13, 17, 19]);
  \\ Precompute single-prime allowed bitmaps for this q
  my(P_bitmaps = vector(#primes_used));
  for(ip = 1, #primes_used,
    my(ell = primes_used[ip]);
    my(qm = q % ell);
    my(arr = vector(ell));
    for(pm = 0, ell - 1,
      my(v1, v2);
      if(patch_id == 1,
        v1 = (d2 * (d1*pm^2 - C21*qm^2)) % ell;
        v2 = (d3 * (d1*pm^2 - C31*qm^2)) % ell;
      );
      if(patch_id == 2,
        v1 = (d1 * (d2*pm^2 - C12*qm^2)) % ell;
        v2 = (d3 * (d2*pm^2 - C32*qm^2)) % ell;
      );
      if(patch_id == 3,
        v1 = (d1 * (d3*pm^2 - C13*qm^2)) % ell;
        v2 = (d2 * (d3*pm^2 - C23*qm^2)) % ell;
      );
      if(is_sq_mod(v1, ell) && is_sq_mod(v2, ell), arr[pm+1] = 1);
    );
    P_bitmaps[ip] = arr;
  );
  \\ Build combined bitmap by CRT-like loop over p mod M
  for(p = 0, M - 1,
    my(ok = 1);
    for(ip = 1, #primes_used,
      my(ell = primes_used[ip]);
      if(P_bitmaps[ip][p % ell + 1] == 0, ok = 0; break);
    );
    bm[p + 1] = ok;
  );
  return(bm);
};

\\ Build secondary bitmaps (one per SEC_PRIMES, for given q).
build_sec_bitmaps(patch_id, q) = {
  my(bms = vector(#SEC_PRIMES));
  for(ip = 1, #SEC_PRIMES,
    my(ell = SEC_PRIMES[ip]);
    my(qm = q % ell);
    my(arr = vector(ell));
    for(pm = 0, ell - 1,
      my(v1, v2);
      if(patch_id == 1,
        v1 = (d2 * (d1*pm^2 - C21*qm^2)) % ell;
        v2 = (d3 * (d1*pm^2 - C31*qm^2)) % ell;
      );
      if(patch_id == 2,
        v1 = (d1 * (d2*pm^2 - C12*qm^2)) % ell;
        v2 = (d3 * (d2*pm^2 - C32*qm^2)) % ell;
      );
      if(patch_id == 3,
        v1 = (d1 * (d3*pm^2 - C13*qm^2)) % ell;
        v2 = (d2 * (d3*pm^2 - C23*qm^2)) % ell;
      );
      if(is_sq_mod(v1, ell) && is_sq_mod(v2, ell), arr[pm+1] = 1);
    );
    bms[ip] = arr;
  );
  return(bms);
};

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

\\ Main loop scanner. Returns [iter, surv, hits].
\\ Scans p ∈ [p_lo, p_hi] for given (patch, q). Uses primary bitmap + secondary bitmaps.
\\ Time-bounded by time_budget_ms (returns early if exceeded).
scan_range(patch_id, q, p_lo, p_hi, time_budget_ms, t_start) = {
  my(prim = build_primary_bitmap(patch_id, q));
  my(sec  = build_sec_bitmaps(patch_id, q));
  my(M = M_PRIMARY);
  my(p1 = SEC_PRIMES[1]);
  my(p2 = SEC_PRIMES[2]);
  my(bm1 = sec[1]);
  my(bm2 = sec[2]);
  my(iter = 0, surv = 0, hits = 0);
  my(check_freq = 10000000);
  my(p);
  p = p_lo;
  while(p <= p_hi,
    iter = iter + 1;
    if(prim[p % M + 1] == 1,
      if(bm1[p % p1 + 1] == 1 && bm2[p % p2 + 1] == 1,
        surv = surv + 1;
        if(process_candidate(p, q, patch_id),
          hits = hits + 1;
        );
      );
    );
    if(iter % check_freq == 0,
      if(getwalltime() - t_start > time_budget_ms,
        print("    (time budget hit at p=", p, ")");
        return([iter, surv, hits, p]);
      );
    );
    p = p + 1;
  );
  return([iter, surv, hits, p_hi]);
};

print("=== Leg I v2 ===");
print("M_PRIMARY = ", M_PRIMARY);
print();

t_global_start = getwalltime();
\\ Calibrate budgets to 26 minutes total (leave margin)
TOTAL_BUDGET_MS = 26 * 60 * 1000;
P3_BUDGET = 9  * 60 * 1000;  \\ z_3 patch — unexplored, prioritize
P2_BUDGET = 8  * 60 * 1000;  \\ z_2 patch — unexplored
P1B_BUDGET = 4 * 60 * 1000;  \\ z_1 q∈[5,8]
P1A_BUDGET = 5 * 60 * 1000;  \\ z_1 q=1 extension

hits_total = 0;

\\======================================================================
\\ PHASE 1: z_3 patch (p_lo = 0), q ∈ [1, 8], generous p range
\\======================================================================
print("--- PHASE 1: z_3 patch ---");
{
my(t_phase = getwalltime());
for(q = 1, 8,
  if(getwalltime() - t_phase > P3_BUDGET, print("  (z_3 phase budget hit)"); break);
  \\ For z_3 patch: no positivity bound. p_max set to give ~Leg-H-equivalent height coverage.
  \\ Leg H covered p ≲ 2e9 at q=1 in z_1 patch with p_lo ≈ 2.26e7 (50x extension).
  \\ For z_3 patch with p_lo=0, equivalent height coverage = p_max ≈ 2e9 for q=1.
  \\ But Leg G2 already covered z_3 implicitly? No — Leg G2 used z_1 patch only.
  \\ So z_3 is essentially unexplored. Sweep generously.
  my(p_lo = 0);
  my(p_hi = 200000000 * q);  \\ 2e8 for q=1, 1.6e9 for q=8
  if(p_hi > 2*10^9, p_hi = 2*10^9);
  print("  q=", q, "  p in [", p_lo, ", ", p_hi, "]");
  my(t0 = getwalltime());
  my(remaining = P3_BUDGET - (t0 - t_phase));
  if(remaining < 5000, print("    skip — insufficient time"); break);
  my(r = scan_range(3, q, p_lo, p_hi, remaining, t0));
  my(t1 = getwalltime());
  print("    iter=", r[1], "  sieve-surv=", r[2], "  hits=", r[3], "  wall=", (t1-t0)/1000.0, "s  (last p=", r[4], ")");
  hits_total = hits_total + r[3];
);
}
print("Phase 1 cumulative wall = ", (getwalltime()-t_global_start)/1000.0, "s");
print();

\\======================================================================
\\ PHASE 2: z_2 patch q ∈ [1, 8]
\\======================================================================
if(getwalltime() - t_global_start < TOTAL_BUDGET_MS,
print("--- PHASE 2: z_2 patch ---");
{
my(t_phase = getwalltime());
for(q = 1, 8,
  if(getwalltime() - t_phase > P2_BUDGET, print("  (z_2 phase budget hit)"); break);
  my(p_lo = sqrtint((C32 * q^2) \ d2) + 1);
  my(p_hi = max(p_lo * 200, 200000000 * q));  \\ 200x extension or 2e8*q whichever bigger
  if(p_hi > 2*10^9, p_hi = 2*10^9);
  print("  q=", q, "  p in [", p_lo, ", ", p_hi, "]");
  my(t0 = getwalltime());
  my(remaining = P2_BUDGET - (t0 - t_phase));
  if(remaining < 5000, print("    skip — insufficient time"); break);
  my(r = scan_range(2, q, p_lo, p_hi, remaining, t0));
  my(t1 = getwalltime());
  print("    iter=", r[1], "  sieve-surv=", r[2], "  hits=", r[3], "  wall=", (t1-t0)/1000.0, "s  (last p=", r[4], ")");
  hits_total = hits_total + r[3];
);
}
print("Phase 2 cumulative wall = ", (getwalltime()-t_global_start)/1000.0, "s");
print();
);

\\======================================================================
\\ PHASE 3: z_1 patch q ∈ [5, 8] (Leg H only covered q ≤ 4)
\\======================================================================
if(getwalltime() - t_global_start < TOTAL_BUDGET_MS,
print("--- PHASE 3: z_1 patch q ∈ [5, 8] ---");
{
my(t_phase = getwalltime());
for(q = 5, 8,
  if(getwalltime() - t_phase > P1B_BUDGET, print("  (z_1 q5-8 phase budget hit)"); break);
  my(p_lo = sqrtint(C31 * q^2) + 1);
  my(p_hi = p_lo * 51);  \\ 50x extension matches Leg H
  if(p_hi > 5*10^9, p_hi = 5*10^9);
  print("  q=", q, "  p in [", p_lo, ", ", p_hi, "]");
  my(t0 = getwalltime());
  my(remaining = P1B_BUDGET - (t0 - t_phase));
  if(remaining < 5000, print("    skip — insufficient time"); break);
  my(r = scan_range(1, q, p_lo, p_hi, remaining, t0));
  my(t1 = getwalltime());
  print("    iter=", r[1], "  sieve-surv=", r[2], "  hits=", r[3], "  wall=", (t1-t0)/1000.0, "s  (last p=", r[4], ")");
  hits_total = hits_total + r[3];
);
}
print("Phase 3 cumulative wall = ", (getwalltime()-t_global_start)/1000.0, "s");
print();
);

\\======================================================================
\\ PHASE 4: z_1 patch q=1 extension p ∈ [2e9, 5e9]
\\======================================================================
if(getwalltime() - t_global_start < TOTAL_BUDGET_MS,
print("--- PHASE 4: z_1 patch q=1 extension p ∈ [2e9, 5e9] ---");
{
my(t_phase = getwalltime());
my(q = 1);
my(p_lo = 2 * 10^9);
my(p_hi = 5 * 10^9);
print("  q=", q, "  p in [", p_lo, ", ", p_hi, "]");
my(t0 = getwalltime());
my(remaining_global = TOTAL_BUDGET_MS - (t0 - t_global_start));
my(remaining = min(P1A_BUDGET, remaining_global - 30000));
if(remaining < 5000, print("    skip — insufficient time"),
  my(r = scan_range(1, q, p_lo, p_hi, remaining, t0));
  my(t1 = getwalltime());
  print("    iter=", r[1], "  sieve-surv=", r[2], "  hits=", r[3], "  wall=", (t1-t0)/1000.0, "s  (last p=", r[4], ")");
  hits_total = hits_total + r[3];
);
}
print("Phase 4 cumulative wall = ", (getwalltime()-t_global_start)/1000.0, "s");
print();
);

t_global_end = getwalltime();
print("=== Leg I v2 complete ===");
print("Total wall = ", (t_global_end - t_global_start)/1000.0, "s");
print("Hits found = ", hits_total);
quit;
