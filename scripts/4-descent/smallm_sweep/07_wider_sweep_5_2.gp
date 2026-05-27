\\ Try wider parameter sweep for (5,2) to check for PCP misses.
default(parisize, 2000000000);
sf(n) = if(n == 0, 0, sign(n) * core(abs(n)));

selmer_necessary(d1, d2, d3, a, b) =
{
  my(M1, M2, MD, s1, s2, sD);
  M1 = matdiagonal([d2, -d1, -a^2]); s1 = qfsolve(M1); if(type(s1) == "t_INT", return(0));
  M2 = matdiagonal([d3, -d1, -b^2]); s2 = qfsolve(M2); if(type(s2) == "t_INT", return(0));
  MD = matdiagonal([(b^2-a^2)*d1, b^2*d2, -a^2*d3]); sD = qfsolve(MD); if(type(sD) == "t_INT", return(0));
  return([s1, s2, sD]);
}

try_pcp_wider(d1, d2, d3, a, b, base_pt_D, Nmax) =
{
  my(X1_0, X2_0, X3_0, c1, c2, c3, p, q, r, A_c, B_c, X1n, X2n, X3n, W2_times_asq, Wn2, x_val, e_sq, f_sq, g_sq, x_num, x_den, e_num, e_den, f_num, f_den, g_num, g_den, found);
  X1_0 = base_pt_D[1]; X2_0 = base_pt_D[2]; X3_0 = base_pt_D[3];
  c1 = (b^2-a^2)*d1; c2 = b^2*d2; c3 = -a^2*d3;
  found = 0;
  for(p = -Nmax, Nmax,
    if(found, break);
    for(q = -Nmax, Nmax,
      if(found, break);
      for(r = -5, 5,
        if(found, break);
        if(p == 0 && q == 0 && r == 0, next);
        A_c = c1*p^2 + c2*q^2 + c3*r^2; if(A_c == 0, next);
        B_c = c1*X1_0*p + c2*X2_0*q + c3*X3_0*r;
        X1n = X1_0 * A_c - 2*B_c*p; X2n = X2_0 * A_c - 2*B_c*q; X3n = X3_0 * A_c - 2*B_c*r;
        if(c1*X1n^2 + c2*X2n^2 + c3*X3n^2 != 0, next);
        W2_times_asq = d2*X2n^2 - d1*X1n^2;
        if(W2_times_asq <= 0, next);
        if(!issquare(W2_times_asq), next);
        Wn2 = W2_times_asq / a^2; if(Wn2 == 0, next);
        x_val = d1 * X1n^2 / Wn2;
        if(x_val <= 0, next);
        if(type(x_val) == "t_INT", x_num = x_val; x_den = 1, x_num = numerator(x_val); x_den = denominator(x_val));
        if(x_num < 0, next);
        if(!issquare(x_num) || !issquare(x_den), next);
        e_sq = x_val + a^2; f_sq = x_val + b^2; g_sq = x_val + a^2 + b^2;
        if(e_sq <= 0 || f_sq <= 0 || g_sq <= 0, next);
        if(type(e_sq) == "t_INT", e_num = e_sq; e_den = 1, e_num = numerator(e_sq); e_den = denominator(e_sq));
        if(type(f_sq) == "t_INT", f_num = f_sq; f_den = 1, f_num = numerator(f_sq); f_den = denominator(f_sq));
        if(type(g_sq) == "t_INT", g_num = g_sq; g_den = 1, g_num = numerator(g_sq); g_den = denominator(g_sq));
        if(!issquare(e_num) || !issquare(e_den), next);
        if(!issquare(f_num) || !issquare(f_den), next);
        if(!issquare(g_num) || !issquare(g_den), next);
        return(["PCP_BRICK_FOUND",
                sqrtint(x_num)/sqrtint(x_den),
                sqrtint(e_num)/sqrtint(e_den),
                sqrtint(f_num)/sqrtint(f_den),
                sqrtint(g_num)/sqrtint(g_den)]);
      );
    );
  );
  return("NO_HIT");
}

\\ Test on (5,2) with N=150 for top 20 Selmer classes (sorted by triple-norm)
m = 5; n = 2; a = m^2 - n^2; b = 2*m*n;
bad = factor(2 * a * b * abs((m+n)^2-2*n^2) * abs((m-n)^2-2*n^2))[,1];
S = concat([-1], Vec(bad));
k = #S; total = 2^k;
print("Fiber (5,2): a=", a, " b=", b, " S=", S);

selmer_list = List();
{
for(i1 = 0, total - 1,
  d1 = 1; for(j = 1, k, if(bittest(i1, j-1), d1 = d1 * S[j]));
  for(i2 = 0, total - 1,
    d2 = 1; for(j = 1, k, if(bittest(i2, j-1), d2 = d2 * S[j]));
    d3 = sf(d1 * d2);
    sel = selmer_necessary(d1, d2, d3, a, b);
    if(sel == 0, next);
    listput(selmer_list, [d1, d2, d3, sel[3]]);
  );
);
}
print("Total Selmer-candidates: ", #selmer_list);
print("Running wider sweep N=120 on each...");
t0 = getwalltime();
hits = 0;
{
for(j = 1, #selmer_list,
  s = selmer_list[j];
  base_D = s[4]; if(type(base_D) == "t_MAT", base_D = base_D[,1]);
  res = try_pcp_wider(s[1], s[2], s[3], a, b, base_D, 120);
  if(type(res) == "t_VEC", hits = hits + 1; print("HIT on [", s[1], ",", s[2], ",", s[3], "]: ", res));
);
}
t1 = getwalltime();
print("Wall: ", (t1-t0)/1000.0, " s, hits = ", hits);
quit;
