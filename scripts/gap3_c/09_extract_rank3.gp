\\ Extract rank-3 (and higher) fibers in m<=60 with ellrank
default(parisize, 500000000);
print("=== List of all rank>=3 fibers m<=60 ===");
rank3 = [];
t0 = getwalltime();

work(m, n) = {my(q, E, Em, rk); if(gcd(m,n)!=1 || (m+n)%2==0, return); q = (m^2-n^2)/(2*m*n); E = ellinit([0, 1+q^2, 0, q^2, 0]); Em = ellminimalmodel(E); rk = ellrank(Em, 2); if(rk[1] >= 3 || rk[2] >= 4, print("  (m,n)=(",m,",",n,") q=", q, " rk=[",rk[1],",",rk[2],"] dim Sel_2=", rk[2]+2); rank3 = concat(rank3, [[m,n,rk[1],rk[2],rk[2]+2]]))};

for(m=2, 60, for(n=1, m-1, work(m, n)); if(m%10==0, print("  m=", m, " done elapsed=", (getwalltime()-t0)/1000.0, "s")));

print("\nTotal rank>=3 fibers found = ", length(rank3));
print("Full list:");
for(i=1, length(rank3), print(rank3[i]));
quit;
