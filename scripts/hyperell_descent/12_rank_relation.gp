/* 12_rank_relation.gp
 *
 * Compare rank of E_PCP(q) and E_PCP(q)^(-1) across many Pythagorean fibers.
 * The descent surface S has Jacobian = E_PCP(q)^(-1).
 * Each rational point on S maps to E_PCP(q)^(-1) via choice of base point (0, q^2 h/m).
 *
 * Key question: are the ranks correlated? Sum rule under root number etc.
 */
default(parisize, 1000000000);

/* Generate Pythagorean (n, m) with m^2 + n^2 = h^2, primitive */
\\ Primitive triples: m = s^2-t^2, n = 2st, h = s^2+t^2, gcd(s,t)=1, s>t>0, s+t odd
\\ Or m = 2st, n = s^2-t^2.

print("=== Rank table: E_PCP(q) vs E_PCP(q)^(-1) ===");
print("(over primitive Pythagorean triples with parameters s, t)");
print();
print("| s | t | n | m | h^2 | rk E_PCP | rk E_PCP^(-1) | sum |");
print("|---|---|---|---|-----|----------|----------------|-----|");

{
sum_dist = vector(10);
cnt = 0;
for(s = 2, 8,
  for(t = 1, s-1,
    if(gcd(s,t) == 1 && (s+t)%2 == 1,
      /* Two arrangements */
      m1 = s^2 - t^2;
      n1 = 2*s*t;
      Epcp = ellinit([0, m1^2+n1^2, 0, m1^2*n1^2, 0]);
      Etw = ellinit([0, -(m1^2+n1^2), 0, m1^2*n1^2, 0]);
      r1 = ellrank(Epcp);
      r2 = ellrank(Etw);
      rs1 = r1[1]; rs2 = r2[1];
      print("| ", s, " | ", t, " | ", n1, " | ", m1, " | ", m1^2+n1^2, \
        " | [", r1[1], ",", r1[2], "] | [", r2[1], ",", r2[2], "] | ", \
        if(r1[1]==r1[2] && r2[1]==r2[2], Str(r1[1] + r2[1]), "?"), " |");
      cnt++;
      if(r1[1]==r1[2] && r2[1]==r2[2],
        s_idx = r1[1] + r2[1] + 1;
        if(s_idx <= 10, sum_dist[s_idx]++);
      );
    );
  );
);
print();
print("rank-sum distribution (sum_dist[i+1] = count of rank-sum = i):");
print(sum_dist);
print();
print("Total fibers tested: ", cnt);
}

print();
print("=== Parity check: root number of E_PCP(q) vs E_PCP(q)^(-1) ===");
print("For quadratic twist by -1, the root number flips if and only if the");
print("number of primes p where E_PCP has split or non-split mult red is...");
print("(complicated; let's just compute)");

print();
print("| s | t | n | m | w(E_PCP) | w(E_twist) | (parity match?) |");
{
for(s = 2, 6,
  for(t = 1, s-1,
    if(gcd(s,t) == 1 && (s+t)%2 == 1,
      m1 = s^2 - t^2;
      n1 = 2*s*t;
      Epcp = ellminimalmodel(ellinit([0, m1^2+n1^2, 0, m1^2*n1^2, 0]));
      Etw = ellminimalmodel(ellinit([0, -(m1^2+n1^2), 0, m1^2*n1^2, 0]));
      w1 = ellrootno(Epcp);
      w2 = ellrootno(Etw);
      print("| ", s, " | ", t, " | ", n1, " | ", m1, " | ", w1, " | ", w2, " | ", \
        if(w1 == w2, "match", "flip"), " |");
    );
  );
);
}

quit;
