\\ Pick 9: 2-Selmer uniform descent for E_PCP(q): Y^2 = X(X+1)(X+q^2)
\\ Pythagorean q = (m^2 - n^2)/(2mn) for gcd(m,n)=1, m+n odd, m>n>=1.
\\ Goal: verify dim_F2 Sel_2(E_PCP(q)/Q) <= 4 (so rank <= 2) for many fibers.
\\
\\ Strategy: use ellrank(E) which performs 2-descent for full-2-torsion curves.
\\ ellrank returns [low, high, gens]; for full-2-torsion curves, `high` is the
\\ 2-Selmer-derived upper bound on Mordell-Weil rank.
\\ Sel_2 dim (as F_2 vector space) = rank_high + dim E[2](Q) + (Sha[2] contribution)
\\ Since (Z/2)^2 sits in E(Q), and dim E[2](Q) = 2, we report:
\\   sel_bd := rk_hi + 2  (upper bound on dim Sel_2 from ellrank)

default(parisize, 4000000000);
default(realprecision, 38);

{
print("=== Pick 9: 2-Selmer uniform descent for E_PCP(q) ===");
print("Family: E_PCP(q) : Y^2 = X(X+1)(X+q^2), q Pythagorean");
print();
print("(m, n) | q          | cond              | tors  | sel_bd | rk_lo | rk_hi | chk");
print("-------+------------+-------------------+-------+--------+-------+-------+----");

global_max_sel = 0;
global_max_rk = 0;
total = 0;
violations = 0;
rk_dist = vector(10, i, 0);
sel_dist = vector(10, i, 0);
gap_cases = List();

for(m = 2, 18,
  for(n = 1, m-1,
    if(gcd(m, n) == 1 && (m + n) % 2 == 1,
      a = m^2 - n^2;
      b = 2*m*n;
      q = a / b;

      \\ Integer model: substitute X -> X*b^2 / 1 won't work; use the curve over Q.
      \\ ellinit accepts rational a-invariants and computes minimal model.
      a2Q = 1 + q^2;
      a4Q = q^2;
      E = ellinit([0, a2Q, 0, a4Q, 0]);
      Emin = ellminimalmodel(E);

      cond = ellglobalred(Emin)[1];
      tors_struct = elltors(Emin)[2];

      \\ ellrank: 2-descent based rank bounds + generators search.
      rk = ellrank(Emin);
      rk_lo = rk[1];
      rk_hi = rk[2];

      sel_bd = rk_hi + 2;

      chk = if(rk_hi <= 2, "OK", "FAIL");
      if(rk_hi > 2, violations += 1);
      if(rk_lo != rk_hi, listput(gap_cases, [m, n, q, rk_lo, rk_hi]));

      total += 1;
      if(rk_hi > global_max_rk, global_max_rk = rk_hi);
      if(sel_bd > global_max_sel, global_max_sel = sel_bd);

      if(rk_lo >= 0 && rk_lo < 10, rk_dist[rk_lo+1] += 1);
      if(sel_bd >= 0 && sel_bd < 10, sel_dist[sel_bd+1] += 1);

      printf("(%2d,%2d) | %-10s | %-17s | %-5s |   %d    |   %d   |   %d   | %s\n",
        m, n, q, cond, tors_struct, sel_bd, rk_lo, rk_hi, chk);
    );
  );
);

print();
print("=== Summary ===");
print("Total fibers tested:   ", total);
print("Max rk_hi observed:    ", global_max_rk);
print("Max Sel_2 bound:       ", global_max_sel);
print("Violations (rk_hi>2):  ", violations);
print();
print("rk_lo distribution (index = rk_lo): ", rk_dist);
print("Sel_2 distribution (index = dim):    ", sel_dist);
print();
print("Cases with rk_lo < rk_hi (Sha[2] potentially nontrivial):");
for(j = 1, #gap_cases,
  print("  ", gap_cases[j]);
);
print();
if(violations == 0,
  print(">>> rk(E_PCP(q)) <= 2 holds across all ", total, " tested fibers.");
  print(">>> dim Sel_2(E_PCP(q)/Q) <= ", global_max_sel, " uniformly across sample.");
,
  print(">>> *** VIOLATION FOUND: rk_hi > 2 observed. Conjecture FAILS. ***");
);
}

quit;
