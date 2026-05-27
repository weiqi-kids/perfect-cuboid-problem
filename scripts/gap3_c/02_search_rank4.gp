\\ GAP3-C task 2: search for rank-4 Pythagorean fibers up to m<=80.
default(parisize, 800000000);
print("=== GAP3-C task 2: search for rank-4 fibers up to m<=80 ===");

M_MAX = 80;
high_rank = [];
rank_distribution = vector(10, i, 0);
count = 0;
t0 = getwalltime();

search(m) = {my(n, q, E, Em, ar, ar_int); for(n=1, m-1, if(gcd(m,n) != 1 || (m+n) % 2 == 0, next); count++; q = (m^2 - n^2) / (2*m*n); E = ellinit([0, 1+q^2, 0, q^2, 0]); Em = ellminimalmodel(E); ar = ellanalyticrank(Em, 0.001); ar_int = ar[1]; rank_distribution[1 + ar_int]++; if(ar_int >= 3, print("(m=", m, ",n=", n, ") q=", q, " analrank=", ar_int, " L^(",ar_int,")(E,1)=", ar[2])); if(ar_int >= 4, print("  *** RANK >= 4 CANDIDATE ***"); high_rank = concat(high_rank, [[m,n,ar_int,ar[2]]])))};

for(m=2, M_MAX, search(m); if(m%10==0, print("  ... progress m=", m, " elapsed=", (getwalltime()-t0)/1000.0, "s count=", count)));

elapsed = (getwalltime() - t0) / 1000.0;
print("\n=== Done. Fibers tested = ", count, ", elapsed = ", elapsed, " s ===");

print("\nAnalytic rank distribution:");
for(i=0, 6, if(rank_distribution[i+1] > 0, print("  rank=", i, ": ", rank_distribution[i+1])));

if(length(high_rank) > 0, print("\n=== HIGH RANK (>=4) CANDIDATES ==="); for(k=1, length(high_rank), print(high_rank[k])), print("\n=== NO RANK >= 4 OBSERVED ==="));
quit;
