\\ Enumerate consistent configurations at p=17 with rho=20 using (t_1, t_2).
\\ Only check S_2 = 2 S_1^2 - 1 since we don't have t_3.

p = 17;
t1 = 342;
t2 = 5206;

{
  print("=== CONSISTENT configurations at p=", p, " giving rho=20 ===");
  my(count = 0);
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
            my(check_S2 = 2*need_S1^2 - 1);
            if(abs(check_S2 - need_S2) > 1e-9, next);
            count += 1;
            my(c_trans = 2*p*need_S1);
            my(disc_trans = 4*p^2 - c_trans^2);
            print("  (a,b,c,d,e) = (", a, ",", b, ",", c, ",", d, ",", e, ")  trans c = ", c_trans, "  disc(NS)=", disc_trans, "  sq class: ", core(abs(disc_trans))*sign(disc_trans));
          );
        );
      );
    );
  );
  print("Total: ", count);
}
