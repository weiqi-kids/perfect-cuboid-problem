\\ Smoke test for legI_v2.gp logic: just test scan_range on z_3 patch q=1, p ∈ [0, 1e7].

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

M_PRIMARY = 11 * 13 * 17 * 19;
SEC_PRIMES = [29, 31];

is_sq_mod(a, p) = {
  a = a % p; if(a < 0, a = a + p);
  if(a == 0, return(1));
  return(Mod(a, p)^((p-1)/2) == 1);
};

build_primary_bitmap(patch_id, q) = {
  my(bm = vector(M_PRIMARY));
  my(M = M_PRIMARY);
  my(primes_used = [11, 13, 17, 19]);
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

print("=== Leg I v2 smoke ===");
t0 = getwalltime();
r = scan_range(3, 1, 0, 10000000, 600000, t0);
t1 = getwalltime();
print("z_3 q=1 [0, 1e7]: iter=", r[1], " surv=", r[2], " hits=", r[3], " wall=", (t1-t0)/1000.0, "s");
print("rate: ", r[1]/((t1-t0)/1000.0), " iter/s");
print();
\\ Extrapolate to full Phase 1 z_3 patch (q=1, p to 1e8): 10x
print("Extrapolated to p=1e8 (q=1): ", 10*(t1-t0)/1000.0, "s");

\\ Test z_1 patch quickly
print("Testing z_1 patch with q=1, p ∈ [22591010, 32591010] (1e7 range):");
t0 = getwalltime();
r = scan_range(1, 1, 22591010, 32591010, 600000, t0);
t1 = getwalltime();
print("z_1 q=1 1e7 range: iter=", r[1], " surv=", r[2], " hits=", r[3], " wall=", (t1-t0)/1000.0, "s");
print("rate: ", r[1]/((t1-t0)/1000.0), " iter/s");

quit;
