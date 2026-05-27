/* 02_correct_LD_poly.gp
 *
 * The previous run revealed: f_claim(x,q) = 2x^4 + ... is NOT
 * (1+q^2+c^2)(q^2-x^2)^2 on the curve. Let me derive the correct
 * LD polynomial.
 *
 * On E_PCP(q): y^2 = x(x+1)(x+q^2).
 * c = 2qy/(q^2 - x^2).
 * c^2 = 4 q^2 y^2 / (q^2 - x^2)^2.
 * (1+q^2+c^2)(q^2-x^2)^2 = (1+q^2)(q^2-x^2)^2 + 4 q^2 y^2.
 *
 * Substituting y^2 = x(x+1)(x+q^2):
 *  = (1+q^2)(q^2-x^2)^2 + 4 q^2 x (x+1)(x+q^2).
 *
 * Call this F(x,q). The PCP condition is F(x,q) ∈ Q^*2 (since
 * (q^2-x^2)^2 is automatically a square at any rational x ≠ ±q).
 *
 * Note 1+q^2 is a square (= h^2 where (m,n,h) is Pythagorean for q=n/m).
 *
 * So if we set q = n/m, 1+q^2 = (m^2+n^2)/m^2 = h^2/m^2 with h^2 = m^2+n^2.
 * F(x,q) factors with 1+q^2 = h^2/m^2 a known square.
 *
 * Let us compute F(x,q) and study its structure.
 */
default(parisize, 1000000000);

print("=== Step 1: Compute F(x,q) = (1+q^2)(q^2-x^2)^2 + 4 q^2 x(x+1)(x+q^2) ===");
F = (1+q^2)*(q^2 - x^2)^2 + 4*q^2*x*(x+1)*(x+q^2);
print("F = ", F);

print("\n=== Step 2: Expand fully ===");
F2 = (1+q^2)*x^4 + 4*q^2*x^3 + (2*q^4 + 2*q^2)*x^2 + 4*q^4*x + (q^6 + q^4);
print("F2 = ", F2);
print("F - F2 = ", F - F2);

print("\n=== Step 3: Check degrees in x ===");
print("F has degree 4 in x.");
print("Leading coefficient (in x): 1+q^2 -- which is a SQUARE when q is Pythagorean.");

/* Substitute q = n/m, multiply through */
print("\n=== Step 4: After multiplying by m^4 and using m^2 + n^2 = h^2 ===");
/* F(x,q) = (1+q^2) x^4 + 4 q^2 x^3 + (2q^4+2q^2) x^2 + 4 q^4 x + q^6+q^4
 * Multiply by m^4: m^4 F = (m^2+n^2) x^4 + 4 n^2 m^2 x^3 + ...
 * Actually with q = n/m, let X = m x (integer parameter):
 * m^4 (1+q^2) x^4 = m^4 (1+n^2/m^2) x^4 = m^2(m^2+n^2) x^4 = m^2 h^2 x^4
 * Hmm let's just do it with q = n/m.
 */

print("\n=== Step 5: Test specialization q = 1 ===");
F_q1 = subst(F, q, 1);
print("F(x, 1) = ", F_q1);
print("Discriminant of F(x,1) as poly in x: ", poldisc(F_q1));
print("Factor over Q: ", factor(F_q1));

print("\n=== Step 6: Test q = 0 ===");
F_q0 = subst(F, q, 0);
print("F(x, 0) = ", F_q0);

print("\n=== Step 7: Test q = 3/4 (smallest Pythagorean) ===");
F_q34 = subst(F, q, 3/4);
print("F(x, 3/4) = ", F_q34);
print("Numerator polynomial × 256: ", 256*F_q34);
fac = factor(256*F_q34);
print("Factor: ", fac);

print("\n=== Step 8: Polynomial identity check ===");
print("Is F a perfect square as a polynomial in x?");
print("  Trying F = (a x^2 + b x + c)^2 ansatz...");

/* The condition for ax^4 + bx^3 + ... to be a square is rigid. Let's check
 * if F(x,q) has any structural square pattern.
 *
 * F(x,q) = (1+q^2) x^4 + 4 q^2 x^3 + 2 q^2 (1+q^2) x^2 + 4 q^4 x + q^4 (1+q^2)
 *
 * If F = (sqrt(1+q^2) x^2 + B x + C)^2 = (1+q^2) x^4 + 2 sqrt(1+q^2) B x^3 + ...
 * 2 sqrt(1+q^2) B = 4 q^2  =>  B = 2 q^2 / sqrt(1+q^2)
 * Coeff of x^2: B^2 + 2 sqrt(1+q^2) C = 4 q^4/(1+q^2) + 2 sqrt(1+q^2) C
 *   = 2 q^2 (1+q^2)
 * => 2 sqrt(1+q^2) C = 2 q^2(1+q^2) - 4 q^4/(1+q^2) = 2 q^2 [(1+q^2)^2 - 2 q^2]/(1+q^2)
 *   = 2 q^2 (1 + q^4)/(1+q^2)
 * Coeff of x^1: 2 B C = 4 q^4
 *   B C = 2 q^4
 *   B = 2 q^2 / sqrt(1+q^2)
 *   So 2 q^2 C / sqrt(1+q^2) = 2 q^4  =>  C = q^2 sqrt(1+q^2)
 * Then constant: C^2 = q^4 (1+q^2) ✓ matches!
 * So F = (sqrt(1+q^2) x^2 + B x + q^2 sqrt(1+q^2))^2 IFF
 *   2 sqrt(1+q^2) C = 2 (1+q^2) q^2  matches RHS  2 q^2 (1+q^4)/(1+q^2) ?
 * No: 2 sqrt(1+q^2) * q^2 sqrt(1+q^2) = 2 q^2 (1+q^2).
 * For square: 2 q^2 (1+q^2) = 2 q^2 (1+q^4)/(1+q^2) ?  =>  (1+q^2)^2 = 1+q^4  =>  2q^2 = 0
 * So F is NOT a square as a polynomial in x. ✓
 */
print("F is NOT identically a square polynomial in x (as expected).");
print("The discriminant in x must be nonzero generically.");
disc_F = poldisc(F, x);
print("disc_x(F) = ", disc_F);
print("\nfactor of disc:");
print(factor(disc_F));

quit;
