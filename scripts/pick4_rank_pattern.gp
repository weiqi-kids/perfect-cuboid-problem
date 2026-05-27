\\ Large-scale analytic-rank survey for PCP family with the CORRECT model
\\ E(m,n): y^2 = x^3 + s^2 x^2 + (ab)^2 x

build(m, n) = {my(a = m^2-n^2, b = 2*m*n, s = m^2+n^2); return(ellinit([0, s^2, 0, (a*b)^2, 0]));};

R = List();
for(m = 2, 18, for(n = 1, m-1, if(gcd(m,n) == 1 && (m+n) % 2 == 1, my(a = m^2-n^2, b = 2*m*n, s = m^2+n^2); my(u = m^2-2*m*n-n^2, v = m^2+2*m*n-n^2); my(E = build(m,n)); my(Em = ellminimalmodel(E)); my(N = ellglobalred(Em)[1]); my(w = ellrootno(Em)); my(ar_dat = ellanalyticrank(Em, 0.05)); my(ar = ar_dat[1]); listput(R, [m, n, a, b, s, u, v, N, w, ar]); print("(", m, ",", n, ") N=", N, " w=", w, " ar=", ar, " a-b=", a-b, " a+b=", a+b, " uv=", u*v, " uv_fact=", factor(abs(u*v))))));

print("\n=== Rank distribution ===");
my(n0 = 0, n1 = 0, n2 = 0, n_other = 0);
for(i = 1, #R, my(ar = R[i][10]); if(ar == 0, n0++); if(ar == 1, n1++); if(ar == 2, n2++); if(ar >= 3, n_other++));
print("rank 0: ", n0, "    rank 1: ", n1, "    rank 2: ", n2, "    rank >= 3: ", n_other, "  /  total ", #R);

print("\n=== Root number distribution by rank ===");
my(w_p_0 = 0, w_m_0 = 0, w_p_1 = 0, w_m_1 = 0, w_p_2 = 0, w_m_2 = 0);
for(i = 1, #R, my(w = R[i][9], ar = R[i][10]); if(ar == 0 && w == 1, w_p_0++); if(ar == 0 && w == -1, w_m_0++); if(ar == 1 && w == 1, w_p_1++); if(ar == 1 && w == -1, w_m_1++); if(ar == 2 && w == 1, w_p_2++); if(ar == 2 && w == -1, w_m_2++));
print("rank 0 w=+1: ", w_p_0, "  rank 0 w=-1: ", w_m_0);
print("rank 1 w=+1: ", w_p_1, "  rank 1 w=-1: ", w_m_1);
print("rank 2 w=+1: ", w_p_2, "  rank 2 w=-1: ", w_m_2);

print("\n=== Cases where uv = -7 ? or other small invariants ===");
my(uv_table = vector(0, i, [0,0,0]));
for(i = 1, #R, my(rec = R[i]); my(uv = rec[6]*rec[7]); print("(m,n)=(", rec[1], ",", rec[2], ") uv=", uv, " sign(u)=", sign(rec[6]), " ar=", rec[10]));

quit;
