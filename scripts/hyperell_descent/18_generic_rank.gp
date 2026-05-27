/* 18_generic_rank.gp
 *
 * E_PCP over Q(q): y^2 = x(x+1)(x+q^2).
 * E_twist over Q(q): y^2 = x(x-1)(x-q^2).
 *
 * Compute rank over Q(q) (= rank of generic fiber).
 * If rank_Q(q)(E_twist) = 0, then by Silverman 1983, rank E_twist(Q) = 0
 * for almost all q (density 1 in Pythagorean q), so S_q(Q) is "thin" and
 * the genus-1 fibration is uniformly small-MW outside a thin exceptional set.
 *
 * We can't directly compute Q(q)-rank in PARI but can do the following:
 * specialize at MANY rational q's and check the empirical floor.
 */
default(parisize, 1000000000);

print("=== Compute rank of E_twist(q) = E_PCP(q)^(-1) for MANY Pythagorean q ===");
print("(small (s,t) Pythagorean parameters)");
print();
print("| s | t | n | m | rank E_PCP | rank E_twist | rank E* |");

{
ranks_twist = vector(10);
total = 0;
for(s = 2, 12,
  for(t = 1, s-1,
    if(gcd(s,t) == 1 && (s+t)%2 == 1,
      m = s^2 - t^2;
      n = 2*s*t;
      Epcp = ellinit([0, m^2+n^2, 0, m^2*n^2, 0]);
      Etw  = ellinit([0, -(m^2+n^2), 0, m^2*n^2, 0]);
      Es   = ellinit([0, -(m^4+n^4), 0, m^4*n^4, 0]);
      r1 = ellrank(Epcp);
      r2 = ellrank(Etw);
      r3 = ellrank(Es);
      total++;
      if(r2[1] == r2[2] && r2[1] + 1 <= 10, ranks_twist[r2[1] + 1]++);
      print("| ", s, " | ", t, " | ", n, " | ", m, " | [", r1[1], ",", r1[2], "] | [", r2[1], ",", r2[2], "] | [", r3[1], ",", r3[2], "] |");
    );
  );
);

print();
print("=== Distribution of rank(E_twist) ===");
for(i = 1, 6, print("rank ", i-1, ": ", ranks_twist[i], " fibers"));
print("Total: ", total);

print();
print("=== Distribution of rank(E*(q)) ===");
}

quit;
