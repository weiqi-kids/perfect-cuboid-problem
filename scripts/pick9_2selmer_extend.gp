\\ Pick 9 extended: 2-Selmer descent for larger m range (19..30)

default(parisize, 4000000000);
default(realprecision, 38);

{
print("=== Pick 9 extended: 2-Selmer for m in [19,30] ===");
print();
print("(m, n) | q          | cond           | tors  | sel_bd | rk_lo | rk_hi | chk");
print("-------+------------+----------------+-------+--------+-------+-------+----");

global_max_sel = 0;
global_max_rk = 0;
total = 0;
violations = 0;
rk_dist = vector(10, i, 0);
sel_dist = vector(10, i, 0);

for(m = 19, 30,
  for(n = 1, m-1,
    if(gcd(m, n) == 1 && (m + n) % 2 == 1,
      a = m^2 - n^2;
      b = 2*m*n;
      q = a / b;

      a2Q = 1 + q^2;
      a4Q = q^2;
      E = ellinit([0, a2Q, 0, a4Q, 0]);
      Emin = ellminimalmodel(E);

      cond = ellglobalred(Emin)[1];
      tors_struct = elltors(Emin)[2];

      rk = ellrank(Emin);
      rk_lo = rk[1];
      rk_hi = rk[2];

      sel_bd = rk_hi + 2;

      chk = if(rk_hi <= 2, "OK", "FAIL");
      if(rk_hi > 2, violations += 1);

      total += 1;
      if(rk_hi > global_max_rk, global_max_rk = rk_hi);
      if(sel_bd > global_max_sel, global_max_sel = sel_bd);

      if(rk_lo >= 0 && rk_lo < 10, rk_dist[rk_lo+1] += 1);
      if(sel_bd >= 0 && sel_bd < 10, sel_dist[sel_bd+1] += 1);

      printf("(%2d,%2d) | %-10s | %-14s | %-5s |   %d    |   %d   |   %d   | %s\n",
        m, n, q, cond, tors_struct, sel_bd, rk_lo, rk_hi, chk);
    );
  );
);

print();
print("=== Summary (m in [19,30]) ===");
print("Total fibers tested:   ", total);
print("Max rk_hi observed:    ", global_max_rk);
print("Max Sel_2 bound:       ", global_max_sel);
print("Violations (rk_hi>2):  ", violations);
print("rk_lo distribution: ", rk_dist);
print("Sel_2 distribution: ", sel_dist);
}

quit;
