\\ ============================================================
\\ Van Luijk Picard rank bound from Frobenius (t_1, t_2).
\\
\\ Given (t_1, t_2) for K3 with b_2 = 22, eigenvalues |alpha_i| = p:
\\   sum alpha_i = t_1
\\   sum alpha_i^2 = t_2
\\
\\ Algebraic eigenvalues = p * (root of unity).  Non-algebraic come in
\\ complex-conjugate pairs (p e^{i theta}, p e^{-i theta}).
\\
\\ Let r = # algebraic eigenvalues = rho_{F_p}.
\\ Let s = (22 - r)/2 = # cc pairs of transcendental eigenvalues.
\\
\\ Algebraic eigenvalues contribute integer multiples of p to t_1
\\ (sum of roots of unity over a Galois conjugacy class is integer).
\\ Transcendental pairs contribute 2p cos(theta) -- generically irrational.
\\
\\ Bound: rho_{F_p} = r >= max algebraic part dim such that:
\\   - t_1 - p * (alg trace component) = transcendental sum, |..| <= 2*p*s
\\   - t_2 - p^2 * (alg trace component) = transc 2nd power sum, |..| <= 2*p^2*s
\\
\\ For K3, rho is even (parity from Artin-Tate). Tate's conjecture says rho_{F_p}
\\ equals the number of integer-coefficient cyclotomic factors of L_p.
\\
\\ Note: in characteristic p > 0, K3 Picard rank is always EVEN
\\ (Artin/Tate), and supersingular K3 has rho = 22.
\\ ============================================================

\\ Given (t_1, t_2) and p, list achievable rho values and discriminant data.
analyze(p, t1, t2) = {
  my(b2 = 22, q = p^2);
  print("\n--- p = ", p, ", (t_1, t_2) = (", t1, ", ", t2, ") ---");
  print("    sup-singular bound: t_2 <= 22 p^2 = ", 22*q, " (", if(t2 == 22*q, "ATTAINED -> supersingular", "not attained"), ")");
  print("    t_1/p = ", t1*1.0/p, "  (integer? ", t1 % p == 0, ")");

  \\ If supersingular: all eigenvalues = +-p
  if(t2 == 22*q,
    my(rp = (22 + t1/p)/2, rm = (22 - t1/p)/2);
    print("    Supersingular: r_+ = ", rp, ", r_- = ", rm);
    print("    rho_{F_p} = 22 (supersingular K3, Artin)");
    return;
  );

  \\ Non-supersingular: enumerate over (r_+, r_-) with r_+ + r_- <= 22
  \\ and check Newton sums for compatibility.
  \\ Algebraic part: integer eigenvalues p * zeta. For simplicity assume
  \\ all algebraic eigenvalues are real (i.e. +-p). Then:
  \\   alg t_1 contribution = p * (r_+ - r_-)
  \\   alg t_2 contribution = p^2 * (r_+ + r_-)
  \\ Transcendental sum 2p*sum cos(theta_j) for j=1..s, with s = (22-r_+-r_-)/2.
  \\ |trans t_1 contribution| <= 2 p s.
  \\ Trans t_2 = 2p^2 * sum cos(2 theta_j); |..| <= 2 p^2 s.

  print("    Assuming algebraic eigenvalues are all in {+p, -p}:");
  print("    (r_+, r_-) | r=r++r- | trans s=(22-r)/2 | trans_t1 (need) | trans_t2 (need) | feasible?");
  my(best_r = 0);
  for(rp = 0, 22,
    for(rm = 0, 22 - rp,
      my(r = rp + rm, s = (22 - r)/2);
      if(2*s != 22 - r, next);  \\ s must be integer
      my(tt1 = t1 - p*(rp - rm));
      my(tt2 = t2 - p^2*(rp + rm));
      my(feas = abs(tt1) <= 2*p*s && abs(tt2) <= 2*p^2*s);
      if(feas,
        if(r > best_r, best_r = r);
        if(s == 0,
          \\ If s = 0 must have tt1 = tt2 = 0
          if(tt1 == 0 && tt2 == 0,
            print("    (", rp, ", ", rm, ") | r=", r, " | s=", s, " | tt1=", tt1, " | tt2=", tt2, " | YES (r=22)"),
            print("    (", rp, ", ", rm, ") | r=", r, " | s=", s, " | tt1=", tt1, " | tt2=", tt2, " | NO (tt!=0)")
          );
        );
      );
    );
  );
  print("    --> Maximum rho_{F_", p, "} assuming alg = +-p only: ", best_r);
  print("    (Note: extra alg eigenvalues from p*zeta_n for n>2 could increase rho_{F_p}.)");
}

{
  analyze(3, 38, 166);
  analyze(5, 70, 550);
  analyze(7, 126, 1078);
  analyze(11, 118, 2374);
}
