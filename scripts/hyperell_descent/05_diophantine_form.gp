/* 05_diophantine_form.gp
 *
 * Key derivation:
 *   F(x,q) = (x^2+q^2) * G(x,q)
 *   (1+q^2) G(x,q) = ((1+q^2)x + 2q^2)^2 + (q(1-q^2))^2
 *   (x^2+q^2)(A^2+B^2) = P1^2 + P2^2  with P2 = -2q^3(x+1)
 *
 * Hence (1+q^2)^2 * F(x,q) = P1(x,q)^2 + 4 q^6 (x+1)^2 with P1 explicit.
 */
default(parisize, 1000000000);

A = x^2 + q^2;
G = (1+q^2)*x^2 + 4*q^2*x + q^2*(1+q^2);
F = A * G;

/* Form Brahmagupta-Fibonacci: (a^2+b^2)(c^2+d^2) = (ac+bd)^2 + (ad-bc)^2 */
/* x^2 + q^2 = x^2 + q^2 (sum of two squares: x, q) */
/* A^2 + B^2 = ((1+q^2)x + 2q^2)^2 + (q(1-q^2))^2 */
/* So (x^2+q^2)*((1+q^2)x + 2q^2)^2 + ...) = ... */
/* Form 1: (xA + qB)^2 + (xB - qA)^2 */
Avar = (1+q^2)*x + 2*q^2;
Bvar = q*(1-q^2);

P1_form1 = x*Avar + q*Bvar;
P2_form1 = x*Bvar - q*Avar;

print("P1 = x*A + q*B  expanded:");
print("  expansion: ", P1_form1);
print("  numeric x^0 coeff: ", subst(P1_form1, x, 0));
print("  numeric x^1 coeff: ", polcoef(P1_form1, 1, x));
print("  numeric x^2 coeff: ", polcoef(P1_form1, 2, x));

print("\nP2 = x*B - q*A expanded:");
print("  ", P2_form1);

/* Check that P1^2 + P2^2 = (x^2+q^2) (A^2 + B^2) = (1+q^2) F */
LHS = P1_form1^2 + P2_form1^2;
RHS = (1+q^2) * F;
print("\nVerify: P1^2 + P2^2 - (1+q^2)*F = ", LHS - RHS);

/* Form 2: (xA - qB)^2 + (xB + qA)^2 */
P1_form2 = x*Avar - q*Bvar;
P2_form2 = x*Bvar + q*Avar;
print("\nForm 2:");
print("P1' = x*A - q*B = ", P1_form2);
print("P2' = x*B + q*A = ", P2_form2);

LHS2 = P1_form2^2 + P2_form2^2;
print("Verify form 2: P1'^2 + P2'^2 - (1+q^2)*F = ", LHS2 - RHS);

/* See if P2_form1 or P2_form2 factors nicely */
print("\n=== Factor P2_form1 ===");
print("P2_form1 = ", P2_form1);
/* Treat as polynomial in x */
P2v = Pol(Vecrev([polcoef(P2_form1,0,x), polcoef(P2_form1,1,x), polcoef(P2_form1,2,x)]), x);
print("P2v = ", P2v);
print("factor in x: ", factor(P2v));

print("\n=== Factor P2_form2 ===");
P2v2 = Pol(Vecrev([polcoef(P2_form2,0,x), polcoef(P2_form2,1,x), polcoef(P2_form2,2,x)]), x);
print("P2v2 = ", P2v2);
print("factor in x: ", factor(P2v2));

print("\n=== Factor P1_form1 ===");
P1v = Pol(Vecrev([polcoef(P1_form1,0,x), polcoef(P1_form1,1,x), polcoef(P1_form1,2,x)]), x);
print("P1v = ", P1v);
print("factor in x: ", factor(P1v));

print("\n=== Factor P1_form2 ===");
P1v2 = Pol(Vecrev([polcoef(P1_form2,0,x), polcoef(P1_form2,1,x), polcoef(P1_form2,2,x)]), x);
print("P1v2 = ", P1v2);
print("factor in x: ", factor(P1v2));

quit;
