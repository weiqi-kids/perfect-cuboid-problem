\\ PATTERN HUNT 5: Tabulate properties of all 127 unclosed fibers

\\ Helper: minimal E_PCP curve from (m, n)
E_PCP_curve(m, n) = { my(num, den, g, q); num = m^2 - n^2; den = 2*m*n; g = gcd(num, den); num = num/g; den = den/g; q = num/den; return(ellminimalmodel(ellinit([0, -2*(1+q^2), 0, (1-q^2)^2, 0]))); }

\\ Read HARD list and parse
parse_hard() = { my(fname, lines, data, parts, m, n, reason, cond); fname = "/root/proof/perfect-cuboid-problem/scripts/peschmann_968/hard_remainders.txt"; lines = readstr(fname); data = List(); for(i = 1, #lines, my(L = lines[i]); if(#L == 0, next); if(Vec(L)[1] == Vec("#")[1], next); parts = strsplit(L, " "); m = eval(parts[1]); n = eval(parts[2]); reason = parts[3]; cond = 0; for(k = 4, #parts, if(#parts[k] >= 6, my(pre = strsplit(parts[k], "=")[1]); if(pre == "(cond" || pre == "cond", cond = eval(strsplit(parts[k], "=")[2])))); listput(data, [m, n, reason, cond])); return(Vec(data)); }

\\ Compute one row
do_row(rec) = { my(m, n, reason, cond_listed, s, d, g, mn, s2, d2, sp, om_m, om_n, big_m, big_n, E, N, w, badp); m = rec[1]; n = rec[2]; reason = rec[3]; cond_listed = rec[4]; s = m + n; d = m - n; g = gcd(m, n); mn = m*n; s2 = m^2 + n^2; d2 = m^2 - n^2; sp = isprime(s); om_m = omega(m); om_n = omega(n); big_m = bigomega(m); big_n = bigomega(n); E = E_PCP_curve(m, n); N = ellglobalred(E)[1]; w = ellrootno(E); badp = #factor(N)[, 1]; return(Str(m, " ", n, " ", g, " ", s, " ", d, " ", s%2, " ", s%3, " ", s%4, " ", s%6, " ", s%12, " ", s%24, " ", mn, " ", s2, " ", d2, " ", sp, " ", m%2, " ", n%2, " ", m%3, " ", n%3, " ", m%4, " ", n%4, " ", om_m, " ", om_n, " ", big_m, " ", big_n, " ", reason, " ", cond_listed, " ", N, " ", w, " ", badp)); }

hardlist = parse_hard();
print("Total HARD entries read: ", #hardlist);

fout = "/root/proof/perfect-cuboid-problem/scripts/pattern_hunt/hard127_table.txt";
write(fout, "# m n gcd s d s%2 s%3 s%4 s%6 s%12 s%24 m*n m^2+n^2 m^2-n^2 sp m%2 n%2 m%3 n%3 m%4 n%4 om_m om_n big_m big_n reason cond_listed N_EPCP w n_badp");

for(i = 1, #hardlist, write(fout, do_row(hardlist[i])); if(i%20 == 0, print("  processed ", i, " / ", #hardlist)));

print("Done. Output: ", fout);
quit;
