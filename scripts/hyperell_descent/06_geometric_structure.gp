/* 06_geometric_structure.gp
 *
 * Structure summary:
 *   E_PCP(q): y^2 = x(x+1)(x+q^2)         (2-torsion: x=0, x=-1, x=-q^2)
 *   F(x,q) = (x^2+q^2) * G(x,q),  G(x,q) = (1+q^2)x^2 + 4q^2 x + q^2(1+q^2)
 *   PCP closure ⟺ F(x,q) ∉ Q^*2 at any rational point (x,y) of E_PCP(q).
 *
 *   Identity 1: (1+q^2) F = P1^2 + 4q^6 (x+1)^2,  P1 = (1+q^2)x^2 + 2q^2 x + q^2(1-q^2)
 *   Identity 2: (1+q^2) F = P1'^2 + 4q^2 (x+q^2)^2,  P1' = (1+q^2)x^2 + 2q^2 x + q^2(q^2-1)
 *
 * Note: (x+1)(x+q^2) = x*y^2/x^2 *... wait, on E_PCP, x(x+1)(x+q^2) = y^2,
 * so (x+1)(x+q^2) = y^2/x at x ≠ 0.
 *
 * Let me explore.
 */
default(parisize, 1000000000);

print("=== Setup ===");
A = x^2 + q^2;
G = (1+q^2)*x^2 + 4*q^2*x + q^2*(1+q^2);
F = A * G;

print("F(x,q) = (x^2+q^2) * G(x,q)");
print("G(x,q) = (1+q^2)x^2 + 4q^2 x + q^2(1+q^2)");
print();

print("=== Identity 2 again: (1+q^2) G = ((1+q^2)x + 2q^2)^2 + q^2(1-q^2)^2 ===");
verify1 = (1+q^2)*G - (((1+q^2)*x + 2*q^2)^2 + q^2*(1-q^2)^2);
print("Diff = ", verify1);

print();
print("=== Substituting y^2 = x(x+1)(x+q^2): ===");
print();
print("On E_PCP, (x+1)(x+q^2) = y^2/x (assuming x≠0).");
print();
print("Therefore: ");
print("  (1+q^2) F(x,q) = P1^2 + 4q^6 (x+1)^2");
print("");
print("On the curve, we can rewrite 4q^6 (x+1)^2:");
print("  (x+1)^2 = ((x+1)(x+q^2))^2 / (x+q^2)^2 = (y^2/x)^2 / (x+q^2)^2 = y^4 / (x^2 (x+q^2)^2)");
print("  Not particularly helpful directly.");
print();

print("=== Direct geometric approach: the surface S: w^2 = F(x,q) ===");
print();
print("S is a surface defined by w^2 = (x^2+q^2)((1+q^2)x^2 + 4q^2 x + q^2(1+q^2)) in (x,q,w)-space.");
print();
print("This is a 'two-conic' surface. Each rational point yields a sum-of-2-squares decomposition.");
print();

/* For each fixed Pythagorean q, F(x,q) is a quartic in x, so y^2 = F(x,q) is a genus-1 curve.
   Let's compute Jacobian elliptic curve. */

print("=== Genus of F(x,q) as quartic in x, varying q ===");
print();
print("For each fixed q, the quartic F has factor x^2+q^2 with disc -4q^2 < 0,");
print("and G(x,q) with disc -4q^2(1-q^2)^2/(1+q^2) ... let me recompute.");

print();
print("disc(G in x) = 16 q^4 - 4 (1+q^2) * q^2(1+q^2) = 16 q^4 - 4 q^2 (1+q^2)^2");
print("            = 4 q^2 [4 q^2 - (1+q^2)^2] = 4 q^2 [-(1-q^2)^2] = -4 q^2 (1-q^2)^2");
print("disc(A in x) = 0 - 4*1*q^2 = -4 q^2");
print();
print("Resultant Res_x(A, G) = 16 q^6 (computed in 03 script).");
print();

/* PCP condition: F is a square in Q at rational (x,y) on E_PCP(q).
 * F = A * G. Q-factorization is constant (A and G are both irreducible over Q(q)).
 *
 * For F to be a Q-square at rational x:
 *   Necessary: every prime p that divides A or G to odd power must be balanced.
 *   In particular, if gcd(A, G) = 1 over Q(x,q) (which it generally is, res = 16q^6),
 *   then F = A*G is a Q-square iff A = u^2*d and G = v^2*d for some squarefree d.
 *   The "twist" d can vary.
 */
print("=== Modular descent ===");
print();
print("For F = A*G with res = 16 q^6 (so gcd is supported at primes dividing 2q):");
print("F is a Q-square at rational (x, q)  ⟺  ∃ d square-free, A = d * u^2, G = d * v^2.");
print();
print("This is a 2-descent on the surface S! Equivalent to a Selmer-style computation.");
print();
print("The possible d's must divide 2 q at the level of bad primes.");
print();
print("So the descent is: for each d | 2 q, check if A(x,q) = d * u^2 and G(x,q) = d * v^2");
print("simultaneously have rational solutions (x, u, v).");
print();
print("=== The auxiliary curves ===");
print("• C_d^A: d * u^2 = x^2 + q^2  — a conic in (x, q, u)");
print("• C_d^G: d * v^2 = (1+q^2) x^2 + 4 q^2 x + q^2(1+q^2)  — a conic in (x, q, v)");
print();
print("For PCP, we need a SIMULTANEOUS rational point on C_d^A and C_d^G");
print("AND the (x, q) values must come from a rational point of E_PCP(q).");

print();
print("=== Specialization to specific q ===");
print();

/* Pick first Pythagorean q = 3/4 (m=4, n=3, h=5) */
q0 = 3/4;
print("--- q = 3/4 ---");
Aq = subst(A, q, q0);
Gq = subst(G, q, q0);
Fq = subst(F, q, q0);
print("A = x^2 + 9/16,  16 A = 16 x^2 + 9");
print("G = 25/16 x^2 + 9/4 x + 225/256,  256 G = 400 x^2 + 576 x + 225 = (20 x + ?)^2 ?");
print("disc(256 G) = 576^2 - 4*400*225 = ", 576^2 - 4*400*225);
print("256 G factors: ", factor(256*Gq));
print();
print("Hmm 256 G = 400 x^2 + 576 x + 225. Discriminant -28224 = -16 * 1764 = -16 * 42^2.");
print("So roots: (-576 ± 42*4*i)/800 = (-72 ± 21 i)/100. Imaginary, so G > 0 always at q=3/4.");
print();
print("F = A * G, both quadratics in x. Square iff A = d*u^2 AND G = d*v^2 for some d.");

print();
print("=== Local descent: 2-adic constraint ===");
print();
print("Mod 4: A = x^2 + q^2 mod 4. For x odd: A ≡ 1 + q^2. For x even: A ≡ q^2 mod 4.");
print("Mod 4: G = (1+q^2)x^2 + 4q^2 x + q^2(1+q^2) ≡ (1+q^2)(x^2 + q^2) mod 4.");
print("So G ≡ (1+q^2) * A mod 4, i.e., F = A*G ≡ (1+q^2) A^2 mod 4.");
print("Hence F a square mod 4 iff (1+q^2) is a square mod 4. Always: 1+q^2 ≡ 1 or 2 mod 4.");
print();

print("=== Brauer-Manin obstruction template ===");
print();
print("The 2-descent on F = (x^2+q^2) * G:");
print("For each (x, q), F is a Q-square iff ∃ d square-free with");
print("  d * u^2 = x^2 + q^2     ... (*)");
print("  d * v^2 = (1+q^2) x^2 + 4q^2 x + q^2(1+q^2)   ... (**)");
print();
print("Adding d * v^2 - (1+q^2) * d * u^2 = ...");
print("  d v^2 - d (1+q^2) u^2 = G - (1+q^2) A");
print("                      = -(1+q^2) x^2 - (1+q^2) q^2 + (1+q^2) x^2 + 4 q^2 x + q^2(1+q^2)");
print("Wait let me compute: G - (1+q^2)*A = (1+q^2)x^2 + 4q^2 x + q^2(1+q^2) - (1+q^2)(x^2+q^2)");
diff = G - (1+q^2)*A;
print("  = ", diff);
print("So d v^2 - d(1+q^2) u^2 = 4 q^2 x. Equivalently d(v^2 - (1+q^2)u^2) = 4 q^2 x.");

print();
print("This is becoming a structural identity. Combined with (*): u^2 d = x^2 + q^2,");
print("so x^2 = d u^2 - q^2. Substituting:");
print("  4 q^2 (d u^2 - q^2) = d^2 v^2 - d^2 (1+q^2) u^2 ... no that's wrong.");
print();
print("Better: multiply (*) by 4 q^2: 4 q^2 d u^2 = 4 q^2 (x^2 + q^2) = 4 q^2 x^2 + 4 q^4");
print("(**) - (1+q^2)*(*): d(v^2 - (1+q^2)u^2) = 4 q^2 x.  So x = d(v^2 - (1+q^2)u^2)/(4 q^2).");
print();
print("Combining: d u^2 - q^2 = x^2 = [d(v^2 - (1+q^2)u^2)/(4 q^2)]^2");
print("=> 16 q^4 (d u^2 - q^2) = d^2 (v^2 - (1+q^2) u^2)^2");
print();
print("This is a curve relation in (u, v, q, d). Degree-4 in u, v.");

quit;
