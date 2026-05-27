\\ Extend rank survey to 250 < m <= 300.
default(parisize, 800000000);
print("=== rank survey 250 < m <= 300 ===");

high_list = [];
total = 0;
unprov = 0;
t0 = getwalltime();

work(m, n) = {my(q, E, Em, rk, sd); if(gcd(m,n)!=1 || (m+n)%2==0, return); total++; q = (m^2-n^2)/(2*m*n); E = ellinit([0, 1+q^2, 0, q^2, 0]); Em = ellminimalmodel(E); rk = ellrank(Em, 2); sd = rk[2] + 2; if(rk[1] != rk[2], unprov++); if(rk[1] >= 4 || rk[2] >= 5, print("  *** rk>=4: (m,n)=(",m,",",n,") rk=[",rk[1],",",rk[2],"] dim Sel_2=", sd); high_list = concat(high_list, [[m,n,rk[1],rk[2]]])); if(rk[1] >= 5, print("    !!! RANK >= 5 PROVEN !!!"))};

for(m=251, 300, for(n=1, m-1, work(m, n)); if(m%5==0, print("  m=", m, " done total=", total, " elapsed=", (getwalltime()-t0)/1000.0, "s")));

print("\nTotal m in (250,300]: ", total);
print("# rank>=4 or up>=5: ", length(high_list));
print("# unproven (lo<up): ", unprov);
print("rank>=4 list: ", high_list);
quit;
