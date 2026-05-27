/* 08_identify_twist.gp
 *
 * J(S_q) has same j-invariant as E_PCP(q). So J(S_q) is a quadratic twist
 * E_PCP(q)^(d) for some d. Identify d as a function of (m, n) where q = n/m.
 */
default(parisize, 1000000000);

test_qs = [[3,4], [4,3], [5,12], [20,21], [11,60], [48,55], [39,80], [17,144], [7,24], [195,748]];

print("=== Identify quadratic twist d such that J(S_q) ≅ E_PCP(q)^(d) ===");
print();
print("| n | m | cond(E_PCP) | cond(J(S_q)) | ratio | candidate d |");
print("|---|---|---|---|---|---|");

A_pol = x^2 + q^2;
G_pol = (1+q^2)*x^2 + 4*q^2*x + q^2*(1+q^2);
F_pol = A_pol * G_pol;

{
for(i=1, #test_qs,
  n = test_qs[i][1];
  m = test_qs[i][2];
  q0 = n/m;

  Fq = subst(F_pol, q, q0);

  /* Jacobian */
  E_jac = ellinit(ellfromeqn(y^2 - Fq));
  E_jac_min = ellminimalmodel(E_jac);
  N_jac = ellglobalred(E_jac_min)[1];

  /* E_PCP minimal */
  Epcp = ellinit([0, m^2+n^2, 0, m^2*n^2, 0]);
  Epcp_min = ellminimalmodel(Epcp);
  N_epcp = ellglobalred(Epcp_min)[1];

  ratio = N_jac / N_epcp;

  /* Test twist candidates: E: y^2 = x^3 + a x^2 + b x has twist E^(d): y^2 = x^3 + a d x^2 + b d^2 x */
  /* In our short Weierstrass form y^2 = x^3 + A x + B, twist is y^2 = x^3 + A d^2 x + B d^3 */
  /* Use the [0, a2, 0, a4, 0] form: twist by d gives [0, a2*d, 0, a4*d^2, 0] */
  found_d = 0;
  for(d_abs = 1, 200,
    if(issquarefree(d_abs),
      for(s = -1, 1, if(s != 0,
        d = s * d_abs;
        a2_orig = m^2+n^2;
        a4_orig = m^2*n^2;
        /* Twist: [0, a2*d, 0, a4*d^2, 0] */
        E_twist = ellinit([0, a2_orig*d, 0, a4_orig*d^2, 0]);
        E_twist_min = ellminimalmodel(E_twist);
        if(E_twist_min[1..5] == E_jac_min[1..5],
          found_d = d;
          break(2);
        );
      ));
    );
    if(found_d != 0, break);
  );

  print("| ", n, " | ", m, " | ", N_epcp, " | ", N_jac, " | ", ratio, " | d = ", found_d, " |");
);
}

print();
print("=== Look for pattern in d ===");
quit;
