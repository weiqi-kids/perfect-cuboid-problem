\\ Same as picard_refined but enforce rho even (Artin parity for K3 over F_p)
\\ and use integer transcendental rank.

analyze(p, t1, t2) = {
  print("\n=== p = ", p, ", (t_1, t_2) = (", t1, ", ", t2, ") ===");
  if(t2 == 22*p^2,
    print("  Supersingular at p=", p, ", rho_{F_p} = 22");
    return(22);
  );
  my(best_rho = 0, best_data = []);
  for(a = 0, 22,
    for(b = 0, 22 - a,
      for(cd = 0, (22 - a - b)/2,
        for(c = 0, cd,
          my(d = cd - c);
          for(e = 0, (22 - a - b)/2 - cd,
            my(rho = a + b + 2*(cd + e));
            if(rho > 22, next);
            if(rho % 2 != 0, next);  \\ Artin parity for K3
            my(M = (22 - rho)/2);
            if(2*M + rho != 22, next);
            my(alg_t1 = p*(a - b - c + d));
            my(need_S1 = (t1 - alg_t1)/(2*p));
            if(abs(need_S1) > M + 1e-9, next);
            my(alg_t2 = p^2*(a + b) - p^2*(cd) - 2*p^2*e);
            my(need_S2 = (t2 - alg_t2)/(2*p^2));
            if(abs(need_S2) > M + 1e-9, next);
            if(rho > best_rho,
              best_rho = rho;
              best_data = [a, b, c, d, e, M, need_S1, need_S2];
            );
          );
        );
      );
    );
  );
  print("  Max even algebraic rank rho_{F_", p, "} <= ", best_rho);
  print("  (a, b, c, d, e, M, S_1, S_2) = ", best_data);
  best_rho
}

{
  my(b3 = analyze(3, 38, 166));
  my(b11 = analyze(11, 118, 2374));
  print("\n=== SUMMARY (with K3 parity rho even) ===");
  print("rho_{F_3} <= ", b3);
  print("rho_{F_11} <= ", b11);
  print();
  print("rho_{Qbar}(V'_min) <= min(", b3, ", ", b11, ") = ", vecmin([b3, b11]));
}
