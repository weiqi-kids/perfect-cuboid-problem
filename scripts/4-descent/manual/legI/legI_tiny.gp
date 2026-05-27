\\ Tiny version of legI_main.gp - run for 30s only to check correctness.

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

SIEVE_PRIMES = [11, 13, 17, 19, 29, 31];

is_sq_mod(a, p) = {
  a = a % p; if(a < 0, a = a + p);
  if(a == 0, return(1));
  return(Mod(a, p)^((p-1)/2) == 1);
};

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

sieve_check(p, q, bitmaps) = {
  for(ip = 1, #SIEVE_PRIMES,
    my(ell = SIEVE_PRIMES[ip]);
    if(bitmaps[ip][q%ell + 1, p%ell + 1] == 0, return(0));
  );
  return(1);
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

print("=== Leg I tiny test (z_3 patch q=1, p ∈ [0, 1e6]) ===");
bm3 = build_bitmap(3);
print("bm3 built");

t0 = getwalltime();
iter = 0; surv = 0; hits = 0;
{
q = 1;
for(p = 0, 1000000,
  iter = iter + 1;
  if(!sieve_check(p, q, bm3), next);
  surv = surv + 1;
  if(process_candidate(p, q, 3), hits = hits + 1);
);
}
t1 = getwalltime();
print("iter=", iter, "  surv=", surv, "  hits=", hits, "  wall=", (t1-t0)/1000.0, "s");
print();
print("Extrapolated full Phase 1 (z_3 q=1, p to 5e7): ", (t1-t0)/1000.0 * 50, "s");
quit;
