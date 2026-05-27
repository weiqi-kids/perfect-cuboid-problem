\\ Enumerate consistent configurations at p=3 with rho=20 (M=1) using (t_1, t_2, t_3).
\\ Newton power sum for trans pair (alpha, alpha_bar):
\\   trans_t_k = alpha^k + alpha_bar^k.
\\   trans_t_1 = 2p S_1 where S_1 = cos(theta).
\\   trans_t_2 = 2p^2 S_2 where S_2 = cos(2 theta) = 2 S_1^2 - 1.
\\   trans_t_3 = 2p^3 S_3 where S_3 = cos(3 theta) = 4 S_1^3 - 3 S_1.

p = 3;
t1 = 38;
t2 = 166;
t3 = 278;

{
  print("=== CONSISTENT configurations at p=3 giving rho=20 (using t_1, t_2, t_3) ===");
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
            \\ Now check t_3.
            \\ Cyclotomic contributions to t_3:
            \\   +p^k contribute p^3 per copy (k=3 trace).  Wait: alpha=+p contributes alpha^3 = p^3.
            \\   -p contributes (-p)^3 = -p^3.
            \\   For n=3 pair (p*omega, p*omega^bar), omega^3 = 1, so cubed = (p^3, p^3), contributing 2p^3.
            \\   For n=6 pair (p*omega', p*omega'^bar), omega' = e^{i pi/3}, omega'^3 = -1, cubed = (-p^3, -p^3), contributing -2p^3.
            \\   For n=4 pair (i p, -i p), cubed = (-i p^3, +i p^3), contributing 0.
            my(alg_t3 = p^3*(a - b) + 2*p^3*c - 2*p^3*d + 0*e);
            \\ Trans contribution: 2 p^3 S_3 = 2 p^3 (4 S_1^3 - 3 S_1)
            my(need_S3 = (t3 - alg_t3)/(2*p^3));
            my(check_S3 = 4*need_S1^3 - 3*need_S1);
            if(abs(check_S3 - need_S3) > 1e-9, next);
            count += 1;
            my(c_trans = 2*p*need_S1);
            my(disc_trans = 4*p^2 - c_trans^2);
            print("  (a,b,c,d,e) = (", a, ",", b, ",", c, ",", d, ",", e, ")  trans c = ", c_trans, "  disc=", disc_trans, "  square class: ", core(abs(disc_trans))*sign(disc_trans));
          );
        );
      );
    );
  );
  print("Total: ", count);
}
