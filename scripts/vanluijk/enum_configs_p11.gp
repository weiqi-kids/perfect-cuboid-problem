\\ Enumerate ALL configurations (a, b, c, d, e) at p=11 with rho=20,
\\ to see what trans factor structures are possible.

p = 11;
t1 = 118;
t2 = 2374;

{
  print("=== All configurations at p=11 giving rho=20 ===");
  for(a = 0, 22,
    for(b = 0, 22 - a,
      for(cd = 0, (22 - a - b)/2,
        for(c = 0, cd,
          my(d = cd - c);
          for(e = 0, (22 - a - b)/2 - cd,
            my(rho = a + b + 2*(cd + e));
            if(rho != 20, next);
            my(M = (22 - rho)/2);
            if(M != 1, next);
            my(alg_t1 = p*(a - b - c + d));
            my(need_S1 = (t1 - alg_t1)/(2*p));
            if(abs(need_S1) > M + 1e-9, next);
            my(alg_t2 = p^2*(a + b) - p^2*(cd) - 2*p^2*e);
            my(need_S2 = (t2 - alg_t2)/(2*p^2));
            if(abs(need_S2) > M + 1e-9, next);
            \\ Cos(theta) = S_1, Cos(2 theta) = S_2 = 2*S_1^2 - 1. CHECK consistency.
            my(check_S2 = 2*need_S1^2 - 1);
            if(abs(check_S2 - need_S2) > 1e-9,
              print1("INCONSISTENT: ");
            );
            print("  (a,b,c,d,e) = (", a, ",", b, ",", c, ",", d, ",", e, ")  M=", M, "  S_1=", need_S1, "  S_2=", need_S2, "  check S_2=2*S_1^2-1: ", check_S2);
          );
        );
      );
    );
  );
}
