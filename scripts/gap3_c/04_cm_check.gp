\\ GAP3-C task 4: Check for CM in Pythagorean fibers.
default(parisize, 500000000);

CM_j_h1 = [0, 1728, -3375, 8000, 54000, -32768, -12288000, 287496, -884736, -884736000, -147197952000, -262537412640768000, 16581375];

print("=== GAP3-C task 4: CM check across Pythagorean fibers ===");

j_PCP(q) = 256 * (q^4 - q^2 + 1)^3 / (q^4 * (q^2 - 1)^2);

check_pyth(m, n) = {my(q, j, k, hit); if(gcd(m,n)!=1 || (m+n)%2==0, return(0)); q = (m^2-n^2)/(2*m*n); j = j_PCP(q); hit = 0; for(k=1, length(CM_j_h1), if(j == CM_j_h1[k], hit = k; print("  CM hit: (m,n)=(", m, ",", n, ") q=", q, " j=", j, " k=", k); break)); return(if(hit > 0, 1, 0))};

cm_count = 0; total = 0;
for(m=2, 60, for(n=1, m-1, my(r); r = check_pyth(m, n); if(r > 0, cm_count++); if(gcd(m,n)==1 && (m+n)%2==1, total++)));
print("\nTotal Pythagorean q surveyed (m<=60): ", total);
print("CM hits in class-number-1 list: ", cm_count);

\\ Check the 5 rank-3 fibers' j-values
print("\nRank-3 fibers j-invariants:");
r3_pairs = [[22,17], [35,22], [37,26], [40,29], [40,33]];
for(i=1, length(r3_pairs), my(p=r3_pairs[i], mm=p[1], nn=p[2], qq=(mm^2-nn^2)/(2*mm*nn), jj=j_PCP(qq)); print("  (m,n)=(", mm, ",", nn, ") q=", qq, " j=", jj));

print("\nRank-jump fibers (canonical §5.4 list) j-invariants:");
rj_qpairs = [[20,21], [7,24], [11,60], [48,55], [20,99], [96,247], [13,84], [39,80], [17,144], [104,153]];
for(i=1, length(rj_qpairs), my(q_pair=rj_qpairs[i], qq=q_pair[1]/q_pair[2], jj=j_PCP(qq)); print("  q=", qq, " j=", jj));

\\ Also check whether j(q) ever equals a CM j over the small Pyth set:
\\ Print all j up to m<=20 sorted to detect repeats
all_j = vector(0);
for(m=2, 30, for(n=1, m-1, if(gcd(m,n)==1 && (m+n)%2==1, my(q=(m^2-n^2)/(2*m*n)); all_j = concat(all_j, [j_PCP(q)]))));
print("\n#distinct j values (m<=30): ", length(Set(all_j)), " vs total ", length(all_j));

quit;
