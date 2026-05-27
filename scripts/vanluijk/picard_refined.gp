\\ ============================================================
\\ Refined Picard rank upper bound using Frobenius (t_1, t_2).
\\
\\ For K3 X over F_p, rho_{F_p}(X) = #{Frobenius eigenvalues of form p*zeta,
\\ zeta a root of unity}.  Galois conjugacy groups roots of unity by phi(n)
\\ orbits.  Possible contributions to (t_1, t_2) from each orbit of size phi(n):
\\
\\   n=1 (zeta = 1):  alpha = p, contributes (p, p^2) per eigenvalue.
\\   n=2 (zeta = -1): alpha = -p, contributes (-p, p^2).
\\   n=3,6 (phi=2):   pair (p*omega, p*omega^bar), contrib (-p, -p^2) per pair (for n=3)
\\                     or (p, -p^2) (for n=6).
\\   n=4 (phi=2):     pair (ip, -ip), contrib (0, -2p^2) per pair.
\\   n=5,10 (phi=4):  orbit of 4, contributes (mu(...) related, ..) per orbit.
\\   ...
\\
\\ For the rank, we count #orbits * phi(n) summed.  Goal: find max(rho) such
\\ that some combination of these orbits + transcendental pairs reproduces (t_1, t_2).
\\
\\ Simpler bound: use POSITIVITY. Define
\\   a = #(alpha_i = p), b = #(alpha_i = -p)
\\   c = #pairs (p*omega, p*omega^bar)  [n=3, contrib -p to t_1, -p^2 to t_2]
\\   d = #pairs (p*(-omega), p*(-omega^bar))  [n=6, contrib +p to t_1, -p^2 to t_2]
\\   e = #pairs (ip, -ip)  [n=4, contrib 0 to t_1, -2p^2 to t_2]
\\   M = # transcendental pairs (p e^{i theta}, p e^{-i theta}) with theta not rational multiple of pi
\\
\\ Then:
\\   rho_{F_p} = a + b + 2(c + d + e)  [algebraic]
\\   22 - rho = 2M
\\   t_1 = p(a - b) - p*c + p*d + 2p * sum_M cos(theta_j)
\\       = p(a - b - c + d) + 2p * S_1     where S_1 = sum cos(theta_j), |S_1| <= M
\\   t_2 = p^2 * (a + b) - p^2 * (c + d) - 2p^2 * e + 2p^2 * sum_M cos(2 theta_j)
\\        Wait: (p*omega)^2 = p^2 * omega^2, for n=3, omega^2 = omega^bar, so the pair
\\        gives p^2 * (omega^2 + omega^{-2}) = 2p^2 cos(4pi/3) = 2p^2 * (-1/2) = -p^2.
\\        For n=6, omega = e^{i*pi/3}, omega^2 = e^{i*2pi/3} = root of n=3, gives -p^2.
\\        For n=4, omega = i, omega^2 = -1, pair (-p^2, -p^2) -> sum -2p^2. Wait the pair
\\        is (ip, -ip), squares are (-p^2, -p^2), sum = -2p^2. OK.
\\
\\ So:
\\   t_2 = p^2 (a + b) - p^2 (c + d) - 2 p^2 e + 2 p^2 S_2,  |S_2| <= M
\\
\\ Including higher cyclotomic orbits (n=5,7,8,...) would only further constrain.
\\
\\ For upper bound on rho_{F_p}, we want to MAXIMIZE a + b + 2(c+d+e) subject to:
\\   rho even? actually 22 = rho + 2M, with M >= 0 integer, so rho even AUTOMATIC.
\\
\\ Constraints (assuming the only roots of unity are n in {1,2,3,4,6}):
\\   a + b + 2(c + d + e) + 2M = 22
\\   p(a - b - c + d) + 2p S_1 = t_1,  |S_1| <= M
\\   p^2 (a + b) - p^2 (c + d) - 2 p^2 e + 2 p^2 S_2 = t_2,  |S_2| <= M
\\
\\ ============================================================

analyze(p, t1, t2) = {
  print("\n=== p = ", p, ", (t_1, t_2) = (", t1, ", ", t2, ") ===");
  if(t2 == 22*p^2,
    print("  Supersingular at p=", p, ", rho_{F_p} = 22");
    return(22);
  );
  my(best_rho = 0, best_data = []);
  \\ Enumerate (a, b, c, d, e) with a+b+2(c+d+e) <= 22
  for(a = 0, 22,
    for(b = 0, 22 - a,
      for(cd = 0, (22 - a - b)/2,
        \\ cd = c + d (combined "n=3 or n=6" pairs).  c gives -p to t_1, d gives +p.
        \\ enumerate c separately
        for(c = 0, cd,
          my(d = cd - c);
          for(e = 0, (22 - a - b)/2 - cd,
            my(rho = a + b + 2*(cd + e));
            if(rho > 22, next);
            my(M = (22 - rho)/2);
            if(2*M + rho != 22, next);
            \\ t_1 constraint
            my(alg_t1 = p*(a - b - c + d));
            my(need_S1 = (t1 - alg_t1)/(2*p));
            if(abs(need_S1) > M + 1e-9, next);
            \\ t_2 constraint
            my(alg_t2 = p^2*(a + b) - p^2*(cd) - 2*p^2*e);
            my(need_S2 = (t2 - alg_t2)/(2*p^2));
            if(abs(need_S2) > M + 1e-9, next);
            \\ Need need_S1 and need_S2 to be rational (since cos(theta) for transcendental
            \\ Frobenius eigenvalues is algebraic but need not be rational).
            \\ For an UPPER bound on rho, we accept any real S1, S2 with |.| <= M.
            if(rho > best_rho,
              best_rho = rho;
              best_data = [a, b, c, d, e, M, need_S1, need_S2];
            );
          );
        );
      );
    );
  );
  print("  Max algebraic rank rho_{F_", p, "} = ", best_rho);
  print("  (a, b, c, d, e, M, S_1, S_2) = ", best_data);
  best_rho
}

{
  my(b3 = analyze(3, 38, 166));
  my(b5 = analyze(5, 70, 550));
  my(b7 = analyze(7, 126, 1078));
  my(b11 = analyze(11, 118, 2374));
  print("\n=== SUMMARY ===");
  print("rho_{F_3} <= ", b3);
  print("rho_{F_5} = 22 (supersingular)");
  print("rho_{F_7} = 22 (supersingular)");
  print("rho_{F_11} <= ", b11);
  print();
  print("rho_{Qbar}(V'_min) <= min over good p of rho_{F_p} = min(", b3, ", 22, 22, ", b11, ") = ", vecmin([b3, b11]));
}
