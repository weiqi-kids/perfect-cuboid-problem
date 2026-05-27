\\ GAP3-C task 6: Compute dim Sel_2(E_PCP(q)/Q) for many Pythagorean q
\\ and tabulate. Goal: show dim Sel_2 stays bounded across the sample.
\\
\\ Formula with full 2-torsion (T_0=(0,0), T_1=(-1,0), T_2=(-q^2,0)):
\\   dim Sel_2 = rank + 2 (torsion contribution) + dim Sha[2]
\\ When ellrank gives lo=up, then Sha[2]=0 and dim Sel_2 = rank + 2.

default(parisize, 500000000);
print("=== GAP3-C task 6: 2-Selmer dim across Pythagorean fibers m<=25 ===");

sel_dist = vector(10, i, 0);
rank_dist = vector(10, i, 0);
total = 0;
high_sel = [];
t0 = getwalltime();

work(m, n) = {my(q, E, Em, rk, sel_dim); if(gcd(m,n)!=1 || (m+n)%2==0, return); total++; q = (m^2-n^2)/(2*m*n); E = ellinit([0, 1+q^2, 0, q^2, 0]); Em = ellminimalmodel(E); rk = ellrank(Em, 2); rank_dist[1 + rk[1]]++; sel_dim = rk[2] + 2; sel_dist[1 + sel_dim]++; if(sel_dim >= 6, print("  HIGH SEL: (m,n)=(",m,",",n,") q=",q," rank=[",rk[1],",",rk[2],"] dim Sel_2=", sel_dim); high_sel = concat(high_sel, [[m,n,rk[1],rk[2],sel_dim]]))};

for(m=2, 25, for(n=1, m-1, work(m, n)); print("  m=", m, " done elapsed=", (getwalltime()-t0)/1000.0, "s"));

print("\nRank dist [r=0..6]: ", rank_dist[1..7]);
print("Sel_2 dim dist [d=0..8]: ", sel_dist[1..9]);
print("Max dim Sel_2 = ", max(if(length(high_sel)>0, vecmax(apply(x->x[5], high_sel)), 0), 5));
print("Total fibers tested = ", total);
print("HIGH SEL >= 6 list: ", high_sel);
quit;
