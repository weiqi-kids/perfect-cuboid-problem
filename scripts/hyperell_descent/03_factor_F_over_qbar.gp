/* 03_factor_F_over_qbar.gp
 *
 * F(x,q) factors over Q(q). Let's compute its factorization explicitly.
 */
default(parisize, 1000000000);

F = (1+q^2)*x^4 + 4*q^2*x^3 + 2*q^2*(1+q^2)*x^2 + 4*q^4*x + q^4*(1+q^2);

print("=== F(x,q) over Q(q) ===");
print("F = ", F);

print("\n=== Factor over Q(q)[x] ===");
/* Treat as polynomial in x over Q(q) */
Fx = Pol(Vec(F), x);
print("Fx = ", Fx);

/* Use factornf or factor over Q(q) */
print("\nFactor over Q(q):");
fac = factor(F);
print(fac);

/* Try to factor by hand: F = A(x) * B(x) where A, B are quadratics */
/* Generic factorization F = ((1+q^2)x^2 + a x + b)(x^2 + c x + d) ??
 * or maybe F = (x^2 + a*x + b)(x^2 (1+q^2) + c*x + d) ...
 *
 * Let's try F = ((1+q^2) x^2 + r x + s)(x^2 + u x + t) with rational coefs in q
 */

print("\n=== Try to factor F as (alpha x^2 + beta x + gamma)(delta x^2 + eps x + zeta) ===");
print("Use the fact that 1+q^2 = (m^2+n^2)/m^2 should appear naturally");

/* Look at specific q to deduce structure */
/* q = 3/4: F factored as (16x^2+9)(400x^2+576x+225)/256
 *   = ((4x)^2 + 3^2) * (...)
 *   Hmm 16x^2 + 9 = 16x^2 + 9
 *   400 x^2 + 576 x + 225, disc = 576^2 - 4*400*225 = 331776 - 360000 = -28224
 *   sqrt(-28224) = 12 sqrt(-196) = 12 * 14 i = 168 i
 *   roots: (-576 ± 168 i)/800 = (-72 ± 21 i)/100
 */
print("\nq = 3/4 case: F = (16x^2+9)(400x^2+576x+225)/256");
print("  factor1: 16x^2 + 9 = (4x)^2 + 3^2 — looks like related to Pythagorean (3,4,5)");
print("  factor2: 400x^2 + 576x + 225 = (20x)^2 + 2*20x*(72/5) + 225  → disc < 0");

/* Try q = 5/12 (next Pythagorean) */
print("\n=== q = 5/12 case ===");
q0 = 5/12;
Fq = subst(F, q, q0);
print("F = ", Fq);
print("Factor: ", factor(144*144*Fq));

/* q = 8/15 */
print("\n=== q = 8/15 case ===");
q0 = 8/15;
Fq = subst(F, q, q0);
fac = factor(15^4 * Fq);
print("F * 15^4: factorization:");
print(fac);

/* Try to detect a general factorization */
print("\n=== Symbolic factor attempt ===");
print("Assume F = (A x^2 + B x + C)(D x^2 + E x + F') with all coefs in Q(q).");
print("Leading: A D = 1 + q^2");
print("Constant: C F' = q^4 (1+q^2)");
print("Conjecture: try A = 1, D = 1+q^2 (or some Pythagorean split).");

/* Best to do polynomial factorization manually */
/* (x^2 + b x + q^2)(c x^2 + d x + (1+q^2))? Let's check the form */
print("\n=== Try F = ( x^2 + b(q) x + q^2 ) * ( (1+q^2) x^2 + d(q) x + q^2 (1+q^2) ) ?? ===");
/* Expand: leading = 1+q^2 ✓, constant = q^2 * q^2 (1+q^2) = q^4 (1+q^2) ✓
 * x^3 term: d + b(1+q^2) = 4q^2
 * x^2 term: (1+q^2) + b d + q^2(1+q^2) = 2 q^2 (1+q^2)
 *   => (1+q^2)(1+q^2) + b d = 2 q^2 (1+q^2)  => b d = (1+q^2)(2q^2 - 1 - q^2) = (1+q^2)(q^2-1)
 * x^1 term: b q^2 (1+q^2) + q^2 d = 4 q^4
 *   => q^2 [b(1+q^2) + d] = 4 q^4  =>  b(1+q^2) + d = 4 q^2 ✓ same as x^3 condition
 *
 * Together: b(1+q^2) + d = 4 q^2,  b d = (q^2-1)(1+q^2)
 * Solve: b, d are roots of T^2 - (4 q^2 - b q^2 ... hmm)
 * Let u = b(1+q^2), v = d. Then u + v = 4q^2, and u v / (1+q^2) = (q^2-1)(1+q^2)
 *   => u v = (q^2-1)(1+q^2)^2
 * So u, v roots of T^2 - 4q^2 T + (q^2-1)(1+q^2)^2 = 0
 * Discriminant: 16 q^4 - 4(q^2-1)(1+q^2)^2
 *   = 4 [4 q^4 - (q^2-1)(1+q^2)^2]
 *   = 4 [4 q^4 - (q^2-1)(1+2q^2+q^4)]
 *   = 4 [4 q^4 - (q^2 + 2 q^4 + q^6 - 1 - 2q^2 - q^4)]
 *   = 4 [4 q^4 - (q^6 + q^4 - q^2 - 1)]
 *   = 4 [-q^6 + 3 q^4 + q^2 + 1]
 *   = -4(q^6 - 3 q^4 - q^2 - 1)
 * Hmm need to check sign. Let's compute symbolically.
 */
D_uv = 16*q^4 - 4*(q^2-1)*(1+q^2)^2;
print("\nDiscriminant of T^2 - 4q^2 T + (q^2-1)(1+q^2)^2: ", D_uv);
print("Simplified: ", simplify(D_uv));
print("Factor: ", factor(D_uv));

print("\n=== Hence F factors over Q(q)(sqrt(D_uv)) ===");
print("D_uv is not a perfect polynomial square unless we go to a quadratic extension.");
print("So F is generically IRREDUCIBLE over Q(q)? Let me re-check via factor():");

print("\n=== factor(F) at type 'pol in x with coefs in Q(q)' ===");
Fpol = Pol(Vecrev([q^4*(1+q^2), 4*q^4, 2*q^2*(1+q^2), 4*q^2, 1+q^2]), x);
print("Fpol = ", Fpol);
print(factor(Fpol));

quit;
