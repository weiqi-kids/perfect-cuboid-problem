\\ Picard upper bound at p=17 using (t_1, t_2) = (342, 5206).

analyze(p, t1, t2) = {
  print("\n=== p = ", p, ", (t_1, t_2) = (", t1, ", ", t2, ") ===");
  if(t2 == 22*p^2,
    print("  Supersingular, rho_{F_p} = 22");
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
            if(rho % 2 != 0, next);
            my(M = (22 - rho)/2);
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
  print("  Max rho_{F_", p, "} <= ", best_rho);
  print("  (a, b, c, d, e, M, S_1, S_2) = ", best_data);
  best_rho
}

{
  analyze(17, 342, 5206);
}
