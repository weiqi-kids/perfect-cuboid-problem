\\ Tabulate closed fibers (cheap properties only — no full ellinit cost)

read_pairs(fname) = { my(lines, data, parts); lines = readstr(fname); data = List(); for(i = 1, #lines, my(L = lines[i]); if(#L == 0, next); if(Vec(L)[1] == Vec("#")[1], next); parts = strsplit(L, " "); listput(data, [eval(parts[1]), eval(parts[2])])); return(Vec(data)); }

do_row_lite(rec, tag) = { my(m, n, s, d, g, mn, s2, d2, sp, om_m, om_n, big_m, big_n); m = rec[1]; n = rec[2]; s = m + n; d = m - n; g = gcd(m, n); mn = m*n; s2 = m^2 + n^2; d2 = m^2 - n^2; sp = isprime(s); om_m = omega(m); om_n = omega(n); big_m = bigomega(m); big_n = bigomega(n); return(Str(m, " ", n, " ", g, " ", s, " ", d, " ", s%2, " ", s%3, " ", s%4, " ", s%6, " ", s%12, " ", s%24, " ", mn, " ", s2, " ", d2, " ", sp, " ", m%2, " ", n%2, " ", m%3, " ", n%3, " ", m%4, " ", n%4, " ", om_m, " ", om_n, " ", big_m, " ", big_n, " ", tag)); }

rank0 = read_pairs("/root/proof/perfect-cuboid-problem/scripts/peschmann_968/epcp_rank0.txt");
rank1 = read_pairs("/root/proof/perfect-cuboid-problem/scripts/peschmann_968/epcp_rank1.txt");
rank2 = read_pairs("/root/proof/perfect-cuboid-problem/scripts/peschmann_968/epcp_rank2.txt");
print("rank0: ", #rank0, "  rank1: ", #rank1, "  rank2: ", #rank2);

fout = "/root/proof/perfect-cuboid-problem/scripts/pattern_hunt/closed_table.txt";
write(fout, "# m n gcd s d s%2 s%3 s%4 s%6 s%12 s%24 m*n m^2+n^2 m^2-n^2 sp m%2 n%2 m%3 n%3 m%4 n%4 om_m om_n big_m big_n tag");

for(i = 1, #rank0, write(fout, do_row_lite(rank0[i], "R0")));
for(i = 1, #rank1, write(fout, do_row_lite(rank1[i], "R1")));
for(i = 1, #rank2, write(fout, do_row_lite(rank2[i], "R2")));
print("Done. Output: ", fout);
quit;
