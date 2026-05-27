\\ PICK-4 master: hidden CM / isogeny / torsion / rank survey
\\ E_PCP(q) minimal integer model:  y^2 = x^3 + s^2 x^2 + (ab)^2 x
\\ with a = m^2-n^2, b = 2mn, s = m^2+n^2; Pythagorean a^2+b^2 = s^2.

CM_JS = [0, 1728, -3375, 8000, -32768, 54000, 287496, -884736, -12288000, 16581375, -884736000, -147197952000, -262537412640768000];
is_cm_j(j) = {my(i); for(i=1, #CM_JS, if(j == CM_JS[i], return(1))); return(0);};

build(m, n) = {my(a = m^2-n^2, b = 2*m*n, s = m^2+n^2); return(ellinit([0, s^2, 0, (a*b)^2, 0]));};

R = List();
print("=== PICK-4 master survey (correct model) ===");
print("# fields: m n a b s j_int cond tors_ord tors_struct isog_size CMflag");
for(m = 2, 16, for(n = 1, m-1, if(gcd(m,n) == 1 && (m+n) % 2 == 1, my(a = m^2-n^2, b = 2*m*n, s = m^2+n^2); my(E = build(m,n)); my(Em = ellminimalmodel(E)); my(j = E.j); my(N = ellglobalred(Em)[1]); my(T = elltors(Em)); my(cls = ellisomat(Em)); my(iscm = is_cm_j(j)); listput(R, [m, n, a, b, s, j, N, T[1], T[2], #cls[1], iscm]); print(m, " ", n, "  a=", a, " b=", b, " s=", s, "  N=", N, "  tors=", T[1], " ", T[2], "  isog=", #cls[1], "  CM=", iscm))));

print("\n=== Summary stats ===");
print("Total fibers: ", #R);
my(cm_total = 0, int_j = 0, isog4 = 0, isog6 = 0, isog8 = 0, tors_v4 = 0, tors_z8 = 0, tors_z2sq = 0, tors_z4 = 0, tors_other = 0);
for(i = 1, #R, my(rec = R[i]); if(rec[11], cm_total++); if(denominator(rec[6]) == 1, int_j++); if(rec[10] == 4, isog4++); if(rec[10] == 6, isog6++); if(rec[10] == 8, isog8++); if(rec[8] == 8 && rec[9] == [4,2], tors_v4++); if(rec[8] == 8 && rec[9] == [8], tors_z8++); if(rec[8] == 4 && rec[9] == [2,2], tors_z2sq++); if(rec[8] == 4 && rec[9] == [4], tors_z4++));
print("CM hits: ", cm_total);
print("integer j: ", int_j);
print("isogeny size 4: ", isog4, "  size 6: ", isog6, "  size 8: ", isog8);
print("torsion Z/4 x Z/2 (order 8): ", tors_v4);
print("torsion Z/8 (order 8): ", tors_z8);
print("torsion (Z/2)^2 (order 4): ", tors_z2sq);
print("torsion Z/4 (order 4): ", tors_z4);

print("\n=== Torsion / isogeny size correlation table ===");
for(i = 1, #R, my(rec = R[i]); print("(m,n)=(", rec[1], ",", rec[2], ")  tors_ord=", rec[8], " ", rec[9], "  isog_size=", rec[10]));

print("\n=== Conductor factorisation analysis ===");
\\ For each fiber, list primes of bad reduction
for(i = 1, #R, my(rec = R[i]); my(m = rec[1], n = rec[2], a = rec[3], b = rec[4], s = rec[5]); my(u = m^2 - 2*m*n - n^2, v = m^2 + 2*m*n - n^2); my(N = rec[7]); my(p_list = factor(N)[,1]); print("(", m, ",", n, ") N=", N, " bad_primes=", p_list~, "  a*b*u*v=", a*b*u*v, " factor=", factor(abs(a*b*u*v))));

print("\n=== Hypothesis: bad primes of E = bad primes of a*b*u*v ===");
my(matches = 0, fail = 0);
for(i = 1, #R, my(rec = R[i]); my(m = rec[1], n = rec[2], a = rec[3], b = rec[4], s = rec[5]); my(u = m^2 - 2*m*n - n^2, v = m^2 + 2*m*n - n^2); my(N = rec[7]); my(N_pr = Set(factor(N)[,1])); my(K = abs(a*b*u*v)); my(K_pr = Set(factor(K)[,1])); if(N_pr == K_pr, matches++, fail++; print("MISMATCH (m,n)=(", m, ",", n, ") N primes=", N_pr, " a*b*u*v primes=", K_pr)));
print("Bad-prime hypothesis matches: ", matches, " / ", #R, "  fails: ", fail);

\\ Heegner-like test: for rank-positive fibers, what's the analytic rank?
print("\n=== Analytic rank for first 12 fibers ===");
for(i = 1, min(12, #R), my(rec = R[i]); my(m = rec[1], n = rec[2]); my(E = build(m,n)); my(Em = ellminimalmodel(E)); my(ar = ellanalyticrank(Em)[1]); print("(", m, ",", n, ") analytic_rank=", ar, " cond=", rec[7]));

quit;
