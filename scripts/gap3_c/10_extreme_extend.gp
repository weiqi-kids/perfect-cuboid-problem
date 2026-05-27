\\ GAP3-C task 10: extend rank survey to m<=100 using ellrank(_,2). Goal: detect rank-4 if exists.
default(parisize, 800000000);
print("=== GAP3-C task 10: extended rank survey m<=100 ===");

rank3 = [];
high = [];
sel_dist = vector(10, i, 0);
rank_dist = vector(10, i, 0);
unprov = 0;
total = 0;
t0 = getwalltime();

work(m, n) = {my(q, E, Em, rk, sd); if(gcd(m,n)!=1 || (m+n)%2==0, return); total++; q = (m^2-n^2)/(2*m*n); E = ellinit([0, 1+q^2, 0, q^2, 0]); Em = ellminimalmodel(E); rk = ellrank(Em, 2); rank_dist[1 + rk[1]]++; sd = rk[2] + 2; sel_dist[1 + sd]++; if(rk[1] != rk[2], unprov++); if(rk[1] >= 3 || rk[2] >= 4, print("  (m,n)=(",m,",",n,") q=", q, " rk=[",rk[1],",",rk[2],"] dim Sel_2=", sd); rank3 = concat(rank3, [[m,n,rk[1],rk[2],sd]])); if(rk[1] >= 4, print("    *** RANK >= 4 ***"); high = concat(high, [[m,n,rk[1],rk[2]]]))};

for(m=2, 100, for(n=1, m-1, work(m, n)); if(m%10==0, print("  m=", m, " done total=", total, " elapsed=", (getwalltime()-t0)/1000.0, "s")));

print("\n=== Survey complete ===");
print("Total fibers tested = ", total);
print("Rank dist [r=0..6]: ", rank_dist[1..7]);
print("Sel_2 dim dist [d=2..8]: ", sel_dist[3..9]);
print("# unproven (lo<up) = ", unprov);
print("# rank-3 fibers = ", length(rank3));
print("# rank-4 fibers = ", length(high));
print("rank-3 list:");
for(i=1, length(rank3), print(rank3[i]));
if(length(high) == 0, print("\n*** NO RANK-4 OBSERVED IN ", total, " FIBERS m<=100 ***"));
quit;
