/* 20_thin_set_test.gp
 *
 * The universal generator (h^2, mnh) of E_twist accounts for rank ≥ 1 generic.
 * Question: for it to contribute a PCP candidate, we need x = h^2/m^2 = (1+q^2) to be
 * in the x-projection of E_PCP(q). Test:
 *   E_PCP at x = 1+q^2:  y^2 = (1+q^2) * ((1+q^2)+1) * ((1+q^2)+q^2)
 *                            = (1+q^2)(2+q^2)(1+2q^2)
 * Is this ever a square?
 *
 * This is the "universal PCP candidate from the universal generator".
 */
default(parisize, 1000000000);

print("=== The universal generator on E_twist maps via x = (1+q^2). ===");
print("For PCP, we need (1+q^2)(2+q^2)(1+2q^2) to be a square at our q.");
print();
print("| n | m | q^2 | y^2 = (1+q^2)(2+q^2)(1+2q^2) | issquare? |");

test_qs = [[3,4], [5,12], [8,15], [7,24], [20,21], [9,40], [12,35], [11,60], [13,84], [48,55], [39,80], [17,144], [104,153], [195,748], [44,117], [16,63], [33,56], [65,72]];

{
hits = 0;
for(i=1, #test_qs,
  n = test_qs[i][1]; m = test_qs[i][2];
  if(!issquare(m^2+n^2), next);
  q2 = n^2 * 1.0 / (m^2);
  prod = (1+q2)*(2+q2)*(1+2*q2);
  /* exact */
  q2_rat = (n^2*1)/(m^2);
  prod_rat = (1 + q2_rat)*(2 + q2_rat)*(1 + 2*q2_rat);
  print("| ", n, " | ", m, " | ", n^2,"/",m^2, " | ", prod_rat, " | ", issquare(prod_rat), " |");
  if(issquare(prod_rat), hits++);
);
print();
print("Universal PCP candidates: ", hits);
}

print();
print("=== Now test x_2 = -(1+q^2) on E_PCP — same target ===");
print("E_PCP at x = -(1+q^2): y^2 = -(1+q^2) * (-(1+q^2)+1) * (-(1+q^2)+q^2)");
print("                         = -(1+q^2) * (-q^2) * (-1) = -q^2 (1+q^2)");
print("Negative, so no rational y. ✗");

print();
print("=== Multiplied-out F at x = 1+q^2 (this should match!) ===");
A = 'x^2 + 'q^2;
G = (1+'q^2)*'x^2 + 4*'q^2*'x + 'q^2*(1+'q^2);
F = A * G;
Fval_at_special = subst(F, 'x, 1+'q^2);
print("F(1+q^2, q) = ", Fval_at_special);

print();
print("Factor: ", factor(Fval_at_special));

print();
print("=== Note: x = 1+q^2 is NEVER on E_PCP unless (1+q^2)(2+q^2)(1+2q^2) is a square ===");
print("Empirically, never happens for tested Pythagorean q.");

print();
print("=== Other 'fixed' rational points on E_twist that could be universal? ===");
print("Candidates from the structure:");
print("(0, 0), (1, 0), (q^2, 0): 2-torsion.");
print("(h^2, ±mnh): infinite order universal generator.");
print();
print("=== Map back: (h^2, mnh) on E_twist corresponds to which point on S_q? ===");
print();
print("S_q: w^2 = F(x, q). Jacobian map (with base point at (0, q^2 h/m)):");
print("standard formula: for y^2 = a_0 + a_1 x + a_2 x^2 + a_3 x^3 + a_4 x^4 with a_0 = s^2:");
print("u = (2 s (y + s) + a_1 x)/(x^2) (or similar)");
print();
print("This map takes (0, +s) to identity on J, and other points to non-identity.");
print();
print("For PCP, we need a non-trivial mapping where x_S = x-coord on E_PCP.");

quit;
