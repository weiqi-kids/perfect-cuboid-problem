\\ Joint local Selmer test via parametrized substitution.
\\
\\ For each candidate triple (d1, d2, d3):
\\   1. qfsolve conic C_1: d2*X2^2 - d1*X1^2 - a^2*W^2 = 0.
\\      If insoluble, skip.
\\   2. Parametrize C_1 rationally:
\\        (X1, X2, W) = (X1_0*A - 2*B*p, X2_0*A - 2*B*q, W_0*A - 2*B*r) / A
\\      where p, q, r are parameters with A = d2 q^2 - d1 p^2 - a^2 r^2,
\\            B = d2 X2_0 q - d1 X1_0 p - a^2 W_0 r.
\\      Restrict to a 1-parameter family by fixing 2 of (p, q, r) and varying the third.
\\      Easiest: project to the line at infinity, parametrize via (X1, W).
\\   3. Substitute into C_2: d3 X3^2 = d1 X1^2 + b^2 W^2 = Q(t) (binary form in t).
\\      Test if Q(t) ≡ d3·square (mod Q^*^2) is locally solvable in t.
\\      This is a conic in (t, X3, U) and we can test with qfsolve again.
\\
\\ More elegant approach: form the JOINT torsor in P^3 and convert to a single qfsolve-able
\\ conic via a clever rational map. Specifically:
\\   System: d2 X2^2 - d1 X1^2 = a^2 W^2,  d3 X3^2 - d1 X1^2 = b^2 W^2.
\\   Eliminate W^2 from both equations:
\\     W^2 = (d2 X2^2 - d1 X1^2) / a^2 = (d3 X3^2 - d1 X1^2) / b^2
\\   ⇒ b^2 (d2 X2^2 - d1 X1^2) = a^2 (d3 X3^2 - d1 X1^2)
\\   ⇒ b^2 d2 X2^2 - a^2 d3 X3^2 = (b^2 - a^2) d1 X1^2 = -PQ * d1 X1^2
\\   So we have a NEW ternary conic D in (X1, X2, X3):
\\     b^2 d2 X2^2 - a^2 d3 X3^2 + PQ * d1 X1^2 = 0
\\   Local solubility of D over Q_v ⇔ local solubility of joint torsor over Q_v
\\   (modulo the additional W requirement, which is implied since W^2 = (d2 X2^2 - d1 X1^2)/a^2
\\   is square if X2 = X3 satisfy D and we have a Q_v-solution of D from which we can pull back W,
\\   which holds locally everywhere — at most places automatically — at bad places by tracking).
\\
\\ ⇒ The joint torsor is locally solvable at v iff D is solvable at v AND the resulting W^2 is
\\ a square locally. The latter is an EXTRA condition: from a Q_v-point on D, we get
\\ W^2 = (d2 X2^2 - d1 X1^2)/a^2 which we need to be a square.
\\
\\ But if (X1, X2, X3) is a Q_v-point on D, then (d2 X2^2 - d1 X1^2) is automatically a square IFF...
\\ Hmm, from D: d2 X2^2 - d1 X1^2 = (a^2/b^2)(d3 X3^2 - d1 X1^2)·... no wait,
\\   From b^2 d2 X2^2 - a^2 d3 X3^2 + PQ d1 X1^2 = 0:
\\     d2 X2^2 = (a^2 d3 X3^2 - PQ d1 X1^2)/b^2
\\     d2 X2^2 - d1 X1^2 = (a^2 d3 X3^2 - PQ d1 X1^2)/b^2 - d1 X1^2
\\                       = (a^2 d3 X3^2 - PQ d1 X1^2 - b^2 d1 X1^2)/b^2
\\                       = (a^2 d3 X3^2 - (PQ + b^2) d1 X1^2)/b^2
\\                       = (a^2 d3 X3^2 - a^2 d1 X1^2)/b^2     (since PQ + b^2 = a^2)
\\                       = (a^2/b^2)(d3 X3^2 - d1 X1^2)
\\   So d2 X2^2 - d1 X1^2 = (a^2/b^2)(d3 X3^2 - d1 X1^2).
\\   Therefore W^2 = (d2 X2^2 - d1 X1^2)/a^2 = (d3 X3^2 - d1 X1^2)/b^2.
\\   Setting W = (something)/b, we get W is rational ⇔ (d3 X3^2 - d1 X1^2)/b^2 is a square.
\\   So the EXTRA condition: d3 X3^2 - d1 X1^2 must be (b^2 * square).
\\   Equivalently, given a point on D, we additionally need d3 X3^2 - d1 X1^2 ∈ Q_v^{*2}.
\\
\\ Hmm this is still a "joint" condition. Let me just use the conic D as a NECESSARY condition,
\\ then for survivors do the qfsolve+parameter sweep.
\\
\\ Test for being in 2-Selmer (necessary, NOT sufficient — but very tight): D is locally everywhere
\\ solvable (qfsolve succeeds on D).

default(parisize, 2000000000);

sf(n) = if(n == 0, 0, sign(n) * core(abs(n)));

\\ Necessary Selmer test: D conic solvable.
test_joint_conic(d1, d2, d3, a, b) =
{
  my(P, Q, PQ, M, sol);
  P = (a + b);   \\ not really P, but we use a*b-form
  \\ D: b^2 d2 X2^2 - a^2 d3 X3^2 + (b^2-a^2) d1 X1^2 = 0
  M = matdiagonal([(b^2 - a^2)*d1, b^2*d2, -a^2*d3]);
  sol = qfsolve(M);
  if(type(sol) == "t_INT", return(0));
  return(sol);
}

\\ Combined Selmer test: conic1 + conic2 + conic D all globally soluble.
selmer_necessary(d1, d2, d3, a, b) =
{
  my(M1, M2, MD, s1, s2, sD);
  M1 = matdiagonal([d2, -d1, -a^2]);
  s1 = qfsolve(M1);
  if(type(s1) == "t_INT", return(0));
  M2 = matdiagonal([d3, -d1, -b^2]);
  s2 = qfsolve(M2);
  if(type(s2) == "t_INT", return(0));
  MD = matdiagonal([(b^2-a^2)*d1, b^2*d2, -a^2*d3]);
  sD = qfsolve(MD);
  if(type(sD) == "t_INT", return(0));
  return([s1, s2, sD]);
}

\\ For each fiber:
\\   1. Enumerate triples
\\   2. Apply selmer_necessary
\\   3. For each survivor, do parameter sweep on conic 1 to attempt PCP-brick extraction

\\ Direct PCP brick attempt from conic D point:
\\   We have (X1_0, X2_0, X3_0) on D: b^2 d2 X2^2 - a^2 d3 X3^2 + (b^2-a^2) d1 X1^2 = 0
\\   Then W^2 = (d2 X2^2 - d1 X1^2)/a^2 (if rational, sqrt to get W).
\\   The "extra" condition: this W^2 must be a square in Q.
\\   Then x = d1 X1^2 / W^2 = candidate c^2.
\\   Check x is square (so c rational), check (x + a^2) is square (so e rational),
\\   check (x + b^2) is square (so f rational), check (x + a^2 + b^2) is square (so g rational).
\\
\\ Parametrize D to sweep over rational points:
\\   Given base (X1_0, X2_0, X3_0) on D, set (X1, X2, X3) = (X1_0 + s*p, X2_0 + s*q, X3_0 + s*r).
\\   Substitute into D: A s^2 + 2 B s = 0 ⇒ s = -2B/A.
\\   (X1', X2', X3') = (X1_0*A - 2Bp, X2_0*A - 2Bq, X3_0*A - 2Br).

try_pcp_from_class(d1, d2, d3, a, b, base_pt_D) =
{
  my(X1_0, X2_0, X3_0, p, q, r, A_c, B_c, X1n, X2n, X3n, c1, c2, W2_num, W2_den,
     x_val_num, x_val_den, e_sq_num, e_sq_den, f_sq_num, f_sq_den, g_sq_num, g_sq_den,
     N, c_val, e_val, f_val, g_val, found, x_val, e_sq, f_sq, g_sq);
  X1_0 = base_pt_D[1]; X2_0 = base_pt_D[2]; X3_0 = base_pt_D[3];
  c1 = (b^2-a^2)*d1; c2 = b^2*d2; c3 = -a^2*d3;
  if(c1*X1_0^2 + c2*X2_0^2 + c3*X3_0^2 != 0, return("BASE_VERIFY_FAIL"));
  found = 0;
  result = "NO_HIT";
  N = 40;
  for(p = -N, N,
    if(found, break);
    for(q = -N, N,
      if(found, break);
      for(r = -3, 3,
        if(found, break);
        if(p == 0 && q == 0 && r == 0, next);
        A_c = c1*p^2 + c2*q^2 + c3*r^2;
        if(A_c == 0, next);
        B_c = c1*X1_0*p + c2*X2_0*q + c3*X3_0*r;
        X1n = X1_0 * A_c - 2*B_c*p;
        X2n = X2_0 * A_c - 2*B_c*q;
        X3n = X3_0 * A_c - 2*B_c*r;
        \\ Verify on D
        if(c1*X1n^2 + c2*X2n^2 + c3*X3n^2 != 0, next);
        \\ Need W^2 = (d2 X2n^2 - d1 X1n^2)/a^2 to be a rational square (positive)
        W2_times_asq = d2*X2n^2 - d1*X1n^2;
        if(W2_times_asq < 0, next);
        \\ a^2 W^2 = W2_times_asq, so W^2 = W2_times_asq/a^2
        \\ W rational iff W2_times_asq/a^2 is a square, iff W2_times_asq is a perfect square (a^2 is sq).
        if(!issquare(W2_times_asq), next);
        Wn_abs = sqrtint(W2_times_asq) / a;     \\ this is |W|
        \\ But Wn_abs must be integer (W rational); since a divides sqrt(W2_times_asq) up to sign.
        \\ Actually W^2 = W2_times_asq / a^2 might be rational; check explicitly.
        Wn2 = W2_times_asq / a^2;       \\ rational
        \\ x = d1 X1n^2 / W^2 = d1 X1n^2 * a^2 / W2_times_asq
        if(Wn2 == 0, next);
        x_val = d1 * X1n^2 / Wn2;
        if(x_val <= 0, next);
        \\ Check x is a perfect rational square
        if(type(x_val) != "t_FRAC" && type(x_val) != "t_INT", next);
        if(type(x_val) == "t_INT", x_num = x_val; x_den = 1, x_num = numerator(x_val); x_den = denominator(x_val));
        if(x_num < 0, next);
        if(!issquare(x_num) || !issquare(x_den), next);
        \\ e^2 = x + a^2, f^2 = x + b^2, g^2 = x + a^2 + b^2 — all need to be rational squares
        e_sq = x_val + a^2;
        f_sq = x_val + b^2;
        g_sq = x_val + a^2 + b^2;
        if(e_sq <= 0 || f_sq <= 0 || g_sq <= 0, next);
        if(type(e_sq) == "t_INT", e_num = e_sq; e_den = 1, e_num = numerator(e_sq); e_den = denominator(e_sq));
        if(type(f_sq) == "t_INT", f_num = f_sq; f_den = 1, f_num = numerator(f_sq); f_den = denominator(f_sq));
        if(type(g_sq) == "t_INT", g_num = g_sq; g_den = 1, g_num = numerator(g_sq); g_den = denominator(g_sq));
        if(!issquare(e_num) || !issquare(e_den), next);
        if(!issquare(f_num) || !issquare(f_den), next);
        if(!issquare(g_num) || !issquare(g_den), next);
        \\ ALL CHECKS PASS — PCP brick!
        c_val = sqrtint(x_num) / sqrtint(x_den);
        e_val = sqrtint(e_num) / sqrtint(e_den);
        f_val = sqrtint(f_num) / sqrtint(f_den);
        g_val = sqrtint(g_num) / sqrtint(g_den);
        result = ["PCP_BRICK_FOUND", c_val, e_val, f_val, g_val];
        found = 1;
        break;
      );
    );
  );
  return(result);
}

\\ Run sweep for one fiber
sweep_fiber(m, n) =
{
  my(a, b, P, Q, sfP, sfQ, bad, S, k, total, d1, d2, d3, total_classes, sel_classes, pcp_hits, t0, t1);
  a = m^2 - n^2;
  b = 2*m*n;
  P = (m+n)^2 - 2*n^2;
  Q = (m-n)^2 - 2*n^2;
  sfP = sf(P); sfQ = sf(Q);
  bad = factor(2 * a * b * abs(P) * abs(Q))[,1];
  S = concat([-1], Vec(bad));
  k = #S;
  total = 2^k;
  print("\n========== Fiber (", m, ", ", n, ") ==========");
  print("a = ", a, "  b = ", b, "  P = ", P, " (sf=", sfP, ")  Q = ", Q, " (sf=", sfQ, ")");
  print("S = ", S, "  (|S| = ", k, ", total triples = ", total^2, ")");
  total_classes = 0;
  sel_classes = List();
  pcp_hits = List();
  t0 = getwalltime();
  for(i1 = 0, total - 1,
    d1 = 1;
    for(j = 1, k, if(bittest(i1, j-1), d1 = d1 * S[j]));
    for(i2 = 0, total - 1,
      d2 = 1;
      for(j = 1, k, if(bittest(i2, j-1), d2 = d2 * S[j]));
      d3 = sf(d1 * d2);
      total_classes = total_classes + 1;
      sel = selmer_necessary(d1, d2, d3, a, b);
      if(sel == 0, next);
      listput(sel_classes, [d1, d2, d3]);
      \\ Try to find PCP brick using conic D's base point.
      base_D = sel[3];
      if(type(base_D) == "t_MAT", base_D = base_D[,1]);
      res = try_pcp_from_class(d1, d2, d3, a, b, base_D);
      if(type(res) == "t_VEC" && #res >= 1 && res[1] == "PCP_BRICK_FOUND",
        listput(pcp_hits, [d1, d2, d3, res]);
        print("  *** PCP HIT at [", d1, ", ", d2, ", ", d3, "]: c=", res[2], " e=", res[3], " f=", res[4], " g=", res[5]);
      );
    );
  );
  t1 = getwalltime();
  print("Wall: ", (t1-t0)/1000.0, " s");
  print("Total triples enumerated: ", total_classes);
  print("Selmer-candidate triples (C1, C2, D all qfsolve-soluble): ", #sel_classes);
  print("PCP hits: ", #pcp_hits);
  print("Selmer-candidates:");
  for(j = 1, #sel_classes, print("  ", sel_classes[j]));
  return([m, n, total_classes, #sel_classes, #pcp_hits, Vec(sel_classes), Vec(pcp_hits)]);
}

\\ ---- Run on all 5 survivors ----
survivors = [[5, 2], [9, 2], [13, 4], [17, 4], [17, 6]];
results = List();
{
for(idx = 1, #survivors,
  pair = survivors[idx];
  res = sweep_fiber(pair[1], pair[2]);
  listput(results, res);
);
}

print();
print("========== AGGREGATE SUMMARY ==========");
{
for(i = 1, #results,
  r = results[i];
  print("Fiber (", r[1], ", ", r[2], "): total=", r[3], "  Selmer-cand=", r[4], "  PCP hits=", r[5]);
);
}

quit;
