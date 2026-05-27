\\ Extend rank survey from m=100 to m=120 (skip-ahead with effort=2).
default(parisize, 800000000);
print("=== rank survey 100 < m <= 120 ===");

high_list = [];
rank3 = [];
total = 0;
unprov = 0;
t0 = getwalltime();

work(m, n) = {my(q, E, Em, rk, sd); if(gcd(m,n)!=1 || (m+n)%2==0, return); total++; q = (m^2-n^2)/(2*m*n); E = ellinit([0, 1+q^2, 0, q^2, 0]); Em = ellminimalmodel(E); rk = ellrank(Em, 2); sd = rk[2] + 2; if(rk[1] != rk[2], unprov++); if(rk[1] >= 3 || rk[2] >= 4, print("  (m,n)=(",m,",",n,") q=", q, " rk=[",rk[1],",",rk[2],"] dim Sel_2=", sd); rank3 = concat(rank3, [[m,n,rk[1],rk[2],sd]])); if(rk[1] >= 4, print("    *** RANK >= 4 ***"); high_list = concat(high_list, [[m,n,rk[1],rk[2]]]))};

for(m=101, 120, for(n=1, m-1, work(m, n)); print("  m=", m, " done total=", total, " elapsed=", (getwalltime()-t0)/1000.0, "s"));

print("\nTotal m in (100,120]: ", total);
print("# rank>=3: ", length(rank3));
print("# rank>=4: ", length(high_list));
print("# unproven: ", unprov);
print("rank>=4 list: ", high_list);
quit;
