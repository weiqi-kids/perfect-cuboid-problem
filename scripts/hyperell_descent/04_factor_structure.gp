/* 04_factor_structure.gp
 *
 * KEY FINDING: F(x,q) = (x^2 + q^2) * G(x,q), with
 *   G(x,q) = (1+q^2) x^2 + 4 q^2 x + q^2 (1+q^2)
 *
 * Hence the PCP condition "F(x,q) is a square" decomposes (since x^2+q^2 and G
 * may share content via x). Resultant / GCD analysis follows.
 */
default(parisize, 1000000000);

A = x^2 + q^2;
G = (1+q^2)*x^2 + 4*q^2*x + q^2*(1+q^2);

print("=== F = A * G ===");
F = A * G;
F_expect = (1+q^2)*x^4 + 4*q^2*x^3 + 2*q^2*(1+q^2)*x^2 + 4*q^4*x + q^4*(1+q^2);
print("A*G - F_expect = ", F - F_expect);

print("\n=== Compute resultant Res_x(A, G) ===");
R = polresultant(A, G, x);
print("Res = ", R);
print("Factored: ", factor(R));

print("\n=== Discriminants ===");
print("disc_x(A) = ", poldisc(A, x), " = -4 q^2");
print("disc_x(G) = ", poldisc(G, x), "");
factG_disc = factor(poldisc(G, x));
print("Factor: ", factG_disc);

print("\n=== Key observation ===");
print("A = x^2 + q^2 — this is the equation defining when -q^2 = x^2, i.e.");
print("  for A to be a square in Q at rational x: x^2 + q^2 = square");
print("  which is the Pythagorean condition (q, x, sqrt(x^2+q^2)) form a triple!");
print("");
print("G = (1+q^2) x^2 + 4q^2 x + q^2(1+q^2) — equivalent to a conic.");
print("  G is a square when ... let's see:");
print("  G(x,q) = (1+q^2) x^2 + 4 q^2 x + q^2 (1+q^2)");
print("  = (1+q^2) [ x^2 + (4q^2/(1+q^2)) x + q^2 ]");
print("  = (1+q^2) [ (x + 2q^2/(1+q^2))^2 + q^2 - 4q^4/(1+q^2)^2 ]");
print("  = (1+q^2) (x + 2q^2/(1+q^2))^2 + q^2 (1+q^2) - 4 q^4 / (1+q^2)");
print("  Setting u = x + 2q^2/(1+q^2):");
print("  G = (1+q^2) u^2 + q^2 [(1+q^2)^2 - 4 q^2]/(1+q^2)");
print("    = (1+q^2) u^2 + q^2 (1 - q^2)^2 / (1+q^2)");
print("    = [ (1+q^2)^2 u^2 + q^2 (1-q^2)^2 ] / (1+q^2)");
print("So:  (1+q^2) G = (1+q^2)^2 (x + 2q^2/(1+q^2))^2 + q^2 (1-q^2)^2");
print("   = ((1+q^2) x + 2 q^2)^2 + q^2 (1-q^2)^2");
print("   = ((1+q^2) x + 2 q^2)^2 + (q(1-q^2))^2");
print("");
print("So: (1+q^2) G = ((1+q^2) x + 2q^2)^2 + (q(1-q^2))^2.  ★");

/* Verify */
S = ((1+q^2)*x + 2*q^2)^2 + (q*(1-q^2))^2;
print("\nVerify: (1+q^2)*G = ((1+q^2)x + 2q^2)^2 + q^2(1-q^2)^2 ?");
print("(1+q^2)*G - S = ", expand((1+q^2)*G - S));

print("\n=== Reformulation of PCP condition ===");
print("PCP at (x,q): F(x,q) = (x^2 + q^2) * G(x,q) is a rational square.");
print("Equivalently (multiplying both sides by (1+q^2)^2):");
print("  (1+q^2)^2 * F = (1+q^2)^2 (x^2+q^2) G = (x^2+q^2) [((1+q^2)x+2q^2)^2 + (q(1-q^2))^2]");
print("");
print("So the PCP condition becomes:");
print("  (x^2 + q^2) * [ A^2 + B^2 ]  is a rational square,");
print("where A = (1+q^2) x + 2q^2,  B = q(1-q^2).");
print("");
print("Since (x^2+q^2) is itself x^2 + q^2, and A^2 + B^2 is sum of two squares...");
print("this has classical structure (Gaussian integers).");

print("\n=== Strategy: Brauer/sums-of-squares descent ===");
print("(x^2+q^2)(A^2+B^2) is sum of 4 squares (Lagrange), more usefully:");
print("(x^2+q^2)(A^2+B^2) = (xA + qB)^2 + (xB - qA)^2  OR  (xA - qB)^2 + (xB + qA)^2");
print("So PCP condition = (xA ± qB)^2 + (xB ∓ qA)^2 ∈ Q^*2");
print("i.e. P^2 + Q^2 = square for explicit polynomials P, Q in (x, q).");

P1 = x*((1+q^2)*x + 2*q^2) + q*(q*(1-q^2));
P2 = x*(q*(1-q^2)) - q*((1+q^2)*x + 2*q^2);
print("\nP1 = x*A + q*B = ", expand(P1));
print("P2 = x*B - q*A = ", expand(P2));
print("Verify P1^2 + P2^2 = (x^2+q^2)(A^2+B^2):");
LHS = P1^2 + P2^2;
RHS = (x^2+q^2)*(((1+q^2)*x + 2*q^2)^2 + (q*(1-q^2))^2);
print("LHS - RHS = ", expand(LHS - RHS));

print("\n=== Refined factorization ===");
print("P1 = x A + q B = (1+q^2) x^2 + 2 q^2 x + q^2 (1 - q^2) = (1+q^2) x^2 + 2q^2 x + q^2 - q^4");
print("P2 = x B - q A = -((1+q^2) q x + 2 q^3 - q(1-q^2) x) = -[2 q^3 x + 2 q^3]? let me recompute");
print("Actually let's just see explicit:");
print("  xB = q x (1-q^2) = q x - q^3 x");
print("  qA = q(1+q^2) x + 2 q^3 = q x + q^3 x + 2 q^3");
print("  xB - qA = (q x - q^3 x) - (q x + q^3 x + 2 q^3) = -2 q^3 x - 2 q^3 = -2 q^3 (x + 1)");
print("So P2 = -2 q^3 (x+1). Square: P2^2 = 4 q^6 (x+1)^2 — already a square!");
P2_actual = expand(x*(q*(1-q^2)) - q*((1+q^2)*x + 2*q^2));
print("P2 (computed) = ", P2_actual);

print("\n=== This is the magic! P2 = -2q^3(x+1), so P2^2 = 4 q^6 (x+1)^2 ===");
print("So (1+q^2)^2 F(x,q) = P1^2 + 4 q^6 (x+1)^2");
print("");
print("PCP condition: (1+q^2)^2 F = P1^2 + (2 q^3 (x+1))^2 is a square.");
print("With q Pythagorean, (1+q^2)^2 = h^4/m^4 (a 4th power!).");

quit;
