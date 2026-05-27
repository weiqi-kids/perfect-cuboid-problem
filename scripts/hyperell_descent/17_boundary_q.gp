/* 17_boundary_q.gp
 *
 * Boundary specializations:
 *   q = 0: F(x, 0) = x^2 * x^2 = x^4. Always a square.
 *   q = 1: F(x, 1) = (x^2+1) * (2 x^2 + 4 x + 2) = 2 (x^2+1)(x+1)^2.
 *           Square iff 2(x^2+1) is a square.
 *   q = -1: same by symmetry.
 *   q = ∞: rescaled version.
 *
 * These are 'degenerate' fibers and give insight into Picard / discriminant structure.
 */
default(parisize, 1000000000);

A = x^2 + q^2;
G = (1+q^2)*x^2 + 4*q^2*x + q^2*(1+q^2);
F = A * G;

print("=== q = 0: F(x, 0) = ", subst(F, q, 0), " (= x^4, always square) ===");
print("So at q=0, EVERY rational x makes F a square. But q=0 means n=0 which is degenerate (not a primitive Pythagorean).");

print();
print("=== q = 1: F(x, 1) ===");
F1 = subst(F, q, 1);
print("F(x, 1) = ", F1);
fac = factor(F1);
print("Factorization: ", fac);
print();
print("F1/2 = ", F1/2);
print("Factor (F1/2): ", factor(F1/2));
print();
print("So F(x,1) = 2 (x+1)^2 (x^2+1) — square iff 2(x^2+1) is a square.");
print("Equivalent: 2(x^2+1) = z^2.");
print("This is the conic z^2 - 2 x^2 = 2.");
print("Has rational points: e.g., x = 1, z = 2 (then 2*2 = 4 = 2^2 ✓).");
print("Parametrize: z^2 - 2 x^2 = 2, Pell-like. Rational pts dense.");

print();
print("=== At q = 1, the elliptic curve y^2 = x(x+1)(x+1) = x(x+1)^2 is NODAL (singular). ===");
print("y^2 = x(x+1)^2  is a rational curve! (genus 0 nodal cubic.)");
print("So E_PCP(1) is degenerate, not relevant.");

print();
print("=== Symbolic factorization of F at general q vs q=1 ===");
print("Generic q (q != ±1, 0): F = (x^2+q^2)((1+q^2)x^2 + 4q^2 x + q^2(1+q^2)) — two irreducible quadratics.");
print("At q = ±1: F factors further (1+q^2 = 2, so 2nd factor = 2(x^2+1) = 2(x+i)(x-i) — over Q, just 2(x^2+1)).");
print("  Actually at q=1: ((1+q^2)x^2 + 4q^2 x + q^2(1+q^2)) = 2x^2 + 4x + 2 = 2(x+1)^2. SQUARE!");
print();
print("So special behavior at q = ±1: G(x, ±1) = 2(x±1)^2 is a square.");

print();
print("=== q = ±1 are SINGULAR fibers of the surface S. ===");
print("Let's see what other singular fibers there are.");
print("disc_x(F) = ", poldisc(F, x), " = 4096 q^16 (q-1)^2 (q+1)^2");
print("Singular fibers at q = 0, ±1, ∞.");

print();
print("=== Compute genus of generic fiber S_q ===");
print("S_q: w^2 = quartic(x) of degree 4, discriminant nonzero generic.");
print("So S_q has genus 1 generically. ✓");

print();
print("=== Picard rank / Mordell-Weil structure of S as elliptic surface ===");
print("Generic fiber genus 1, base P^1 (param by q). So S is an elliptic surface.");
print("Singular fibers at q = 0, ±1, ∞ -- 4 singular fibers.");
print();
print("Euler characteristic: chi(S) = (# of singular fiber components ) ... computed via Tate's algorithm");
print("at each q ∈ {0, ±1, ∞}.");

/* Compute Kodaira types at singular fibers */
print();
print("=== Local types of singular fibers ===");
qlist = [0, 1, -1];
print("Note: at q=0, F = x^4, fiber is w^2 = x^4 -- two double points at x = 0, x = ∞.");
print("So fiber at q=0 has type:");
print("  RHS = x^4. The genus-1 curve degenerates to a rational curve with a self-intersection.");
print("  Type: I_? or III etc. Need careful analysis.");
print();
print("At q=1: F(x,1) = 2(x+1)^2 (x^2+1).");
print("  w^2 = 2(x+1)^2(x^2+1). After w'=w/(x+1): w'^2 = 2(x^2+1).");
print("  Genus 0 conic -- fiber is rational. Type I_2 or similar?");
print();
print("These structural facts inform descent over Q(q).");

quit;
