\\ PICK-4 Hidden CM / isogeny structure hunt for PCP
\\ E_PCP(q): Y^2 = X(X+1)(X+q^2), q = (m^2-n^2)/(2mn)
\\ Integer model after clearing denominators: y^2 = x(x+b^2)(x+a^2)
\\   with a = m^2-n^2, b = 2mn; equivalently y^2 = x^3 + s^2 x^2 + (ab)^2 x
\\   where s = m^2 + n^2.

CM_JS = [0, 1728, -3375, 8000, -32768, 54000, 287496, -884736, -12288000, 16581375, -884736000, -147197952000, -262537412640768000];

is_cm_j(j) = {my(i); for(i=1, #CM_JS, if(j == CM_JS[i], return(1))); return(0);};

build_curve(m, n) = {my(a, b, s); a = m^2 - n^2; b = 2*m*n; s = m^2 + n^2; return(ellinit([0, s^2, 0, (a*b)^2, 0]));};

R = List();
total = 0;
cm_hits = 0;
print("=== PICK-4 Hidden CM hunt ===");
print("m  n  a=m^2-n^2   b=2mn   s=m^2+n^2   j(E)   conductor   CM_flag   isogeny_size");
for(m = 2, 22, for(n = 1, m-1, if(gcd(m,n) == 1 && (m+n) % 2 == 1, my(a = m^2-n^2, b = 2*m*n, s = m^2+n^2); my(E = build_curve(m,n)); my(j = E.j); total = total + 1; my(Emin = ellminimalmodel(E)); my(N = ellglobalred(Emin)[1]); my(cls = ellisomat(Emin, 0, 1)); my(deg = cls[2]); my(isize = #deg); my(iscm = is_cm_j(j)); if(iscm, cm_hits = cm_hits + 1); listput(R, [m, n, a, b, s, j, N, isize, iscm]); print(m, " ", n, "  a=", a, " b=", b, " s=", s, "  j=", j, "  N=", N, "  CM=", iscm, "  isog=", isize);)));

print("\n=== Summary ===");
print("Total fibers tested: ", total);
print("CM j-invariant hits: ", cm_hits);

print("\n=== j-invariant integrality / denominator factor ===");
int_j = 0;
for(i = 1, #R, my(rec = R[i]); my(m = rec[1], n = rec[2], j = rec[6]); my(jden = denominator(j)); if(jden == 1, int_j = int_j + 1; print("(m,n)=(", m, ",", n, ") j=", j, "  INTEGER")); );
print("Integral j count: ", int_j, " / ", #R);

print("\n=== j denominator factorisation pattern (sample) ===");
for(i = 1, min(15, #R), my(rec = R[i]); my(m = rec[1], n = rec[2], a = rec[3], b = rec[4], s = rec[5], j = rec[6]); my(jden = denominator(j)); my(jnum = numerator(j)); print("(m,n)=(", m, ",", n, ") s=", s, " a*b=", a*b, " jnum_fact=", factor(jnum), " jden_fact=", factor(jden)));

print("\n=== Closed-form j check ===");
\\ E: y^2 = x^3 + s^2 x^2 + a^2 b^2 x
\\ c4 = 16 s^4 - 48 a^2 b^2 ; c6 = -64 s^6 + 288 s^2 a^2 b^2
\\ disc = 16 a^4 b^4 (s^4 - 4 a^2 b^2)
\\ j = c4^3 / disc / 16 ? Let's check exact normalisation.
for(i = 1, min(5, #R), my(rec = R[i]); my(m = rec[1], n = rec[2], a = rec[3], b = rec[4], s = rec[5]); my(c4f = 16*s^4 - 48*a^2*b^2); my(disc_f = 16*a^4*b^4*(s^4 - 4*a^2*b^2)); my(j_pred = c4f^3 / disc_f); my(E = build_curve(m,n)); my(j_act = E.j); print("(m,n)=(", m, ",", n, ")  j_formula=", j_pred, "  ellj=", j_act, "  equal=", j_pred == j_act));

print("\n=== Isogeny class size distribution ===");
size_dist = vector(20, i, 0);
for(i = 1, #R, my(rec = R[i]); my(sz = rec[8]); if(sz >= 1 && sz <= 20, size_dist[sz] = size_dist[sz] + 1));
for(s = 1, 20, if(size_dist[s] > 0, print("size ", s, ": ", size_dist[s], " fibers")));

print("\n=== s^4 - 4 a^2 b^2 (discriminant kernel) factorisation ===");
\\ algebraic: s^2-2ab and s^2+2ab; note s^2 = (m^2+n^2)^2, 2ab = 4 mn (m^2-n^2)
\\ s^2 - 2ab = (m^2+n^2)^2 - 4mn(m^2-n^2)
\\           = m^4 + 2 m^2 n^2 + n^4 - 4 m^3 n + 4 m n^3
\\           = (m^2 - 2mn - n^2)^2 ?  check: expand
\\ (m^2 - 2mn - n^2)^2 = m^4 - 4 m^3 n - 2 m^2 n^2 + 4 m^2 n^2 + 4 m n^3 + n^4 + ...
\\ Let me just compute symbolically.
for(i = 1, min(15, #R), my(rec = R[i]); my(m = rec[1], n = rec[2]); my(a = m^2-n^2, b = 2*m*n, s = m^2+n^2); my(kern = s^4 - 4*a^2*b^2); my(km = s^2 - 2*a*b); my(kp = s^2 + 2*a*b); print("(m,n)=(", m, ",", n, ") s^2-2ab=", km, "=", factor(km), "  s^2+2ab=", kp, "=", factor(kp)));

\\ Test alg identity s^2-2ab = (m^2-2mn-n^2)^2 vs (m^2+2mn-n^2)^2 etc.
print("\n=== Algebraic identity test ===");
for(i = 1, min(10, #R), my(rec = R[i]); my(m = rec[1], n = rec[2]); my(a = m^2-n^2, b = 2*m*n, s = m^2+n^2); my(c1 = (m-n)^2*(m+n)^2 - 2*m*n*(2*(m^2+n^2))); my(t1 = s^2 - 2*a*b); my(t2 = s^2 + 2*a*b); my(g1 = m^4 - 4*m^3*n + 2*m^2*n^2 + 4*m*n^3 + n^4); my(g2 = m^4 + 4*m^3*n + 2*m^2*n^2 - 4*m*n^3 + n^4); print("(m,n)=(", m, ",", n, ") s^2-2ab=", t1, " matches m^4-4m^3n+2m^2n^2+4mn^3+n^4? ", t1 == g1, "; s^2+2ab matches? ", t2 == g2));

quit;
