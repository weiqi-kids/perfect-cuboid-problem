M_LO=21; M_HI=30;
\\ GAP3-C task 2a: search chunk M_LO..M_HI for rank-4 fibers (faster, no minimalmodel).
default(parisize, 500000000);
print("=== search rank>=3 chunk m in [", M_LO, ",", M_HI, "] ===");
high_rank = [];
rank3_list = [];
rank_distribution = vector(8, i, 0);
count = 0;
t0 = getwalltime();

search(m) = {
  my(n, q, E, ar, ar_int);
  for(n=1, m-1,
    if(gcd(m,n) != 1 || (m+n) % 2 == 0, next);
    count++;
    q = (m^2 - n^2) / (2*m*n);
    \\ Use small a_4=1+q^2 coefficient form directly, no minimalmodel.
    E = ellinit([0, 1+q^2, 0, q^2, 0]);
    ar = ellanalyticrank(E, 0.005);
    ar_int = ar[1];
    rank_distribution[1 + ar_int]++;
    if(ar_int >= 3,
      print("  (m=", m, ",n=", n, ") q=", q, " analrank=", ar_int);
      rank3_list = concat(rank3_list, [[m, n, ar_int, ar[2]]]);
    );
    if(ar_int >= 4,
      print("    *** RANK >= 4 CANDIDATE ***");
      high_rank = concat(high_rank, [[m, n, ar_int, ar[2]]]);
    );
  );
};

for(m = M_LO, M_HI, search(m); print("  m=", m, " done, count=", count, " elapsed=", (getwalltime()-t0)/1000.0, "s"));

print("\n=== chunk [", M_LO, ",", M_HI, "] done. Total = ", count, " rank3=", length(rank3_list), " rank>=4=", length(high_rank));
print("Rank dist: ", rank_distribution);
print("Rank3 list: ", rank3_list);
print("High rank: ", high_rank);
quit;
