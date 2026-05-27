\\ GAP3-C task 6b: extended 2-Selmer survey to m<=60, using ellrank(_, 2) (low effort).
default(parisize, 500000000);
print("=== GAP3-C task 6b: 2-Selmer survey m<=60 ===");

sel_dist = vector(10, i, 0);
rank_dist = vector(10, i, 0);
total = 0;
high_sel = [];
unprov_count = 0;
t0 = getwalltime();

work(m, n) = {my(q, E, Em, rk, sel_dim); if(gcd(m,n)!=1 || (m+n)%2==0, return); total++; q = (m^2-n^2)/(2*m*n); E = ellinit([0, 1+q^2, 0, q^2, 0]); Em = ellminimalmodel(E); rk = ellrank(Em, 2); rank_dist[1 + rk[1]]++; sel_dim = rk[2] + 2; sel_dist[1 + sel_dim]++; if(rk[1] != rk[2], unprov_count++; print("  UNPROV: (m,n)=(",m,",",n,") q=",q," rk=[",rk[1],",",rk[2],"]")); if(sel_dim >= 6, print("  HIGH SEL: (m,n)=(",m,",",n,") q=",q," rank=[",rk[1],",",rk[2],"] dim Sel_2=", sel_dim); high_sel = concat(high_sel, [[m,n,rk[1],rk[2],sel_dim]]))};

for(m=2, 60, for(n=1, m-1, work(m, n)); if(m%5==0, print("  m=", m, " done. total=", total, " elapsed=", (getwalltime()-t0)/1000.0, "s")));

print("\nRank dist [r=0..6]: ", rank_dist[1..7]);
print("Sel_2 dim dist [d=2..8]: ", sel_dist[3..9]);
print("Total fibers tested = ", total);
print("# with unproven (lo<up) = ", unprov_count);
print("Max dim Sel_2 (proven) = ", if(length(high_sel)>0, vecmax(apply(x->x[5], high_sel)), "<= 5"));
print("HIGH SEL >= 6 list: ", high_sel);
quit;
