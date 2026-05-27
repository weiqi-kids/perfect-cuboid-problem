/* 13_PCP_via_twist.gp
 *
 * Explicit reformulation of PCP via twist:
 *
 * The descent surface S has fibers S_q ≅ E_PCP(q)^(-1).
 * The reduction: PCP closure ⟺ for every Pythagorean q, every Q-rational point
 *  of E_PCP(q)^(-1) gives a "degenerate" point of S_q.
 *
 * Each rational point P on E_PCP(q)(Q) gives an x-coordinate x(P).
 * For PCP, F(x(P), q) must be a non-square (for the cuboid to not exist).
 *
 * The descent map: rational point P_curve on E_PCP(q) gives a value F(x_P, q),
 * which is "in Q^*2" iff there's a corresponding point on E_PCP(q)^(-1) (Q).
 *
 * But there's ALWAYS a rational point on E_PCP(q)^(-1) (Q) -- the base (0, q^2*h/m).
 * So we need to compare images:
 *   Map P ∈ E_PCP(q)(Q) to S_q via (x, w) = (x_P, sqrt(F(x_P, q)))
 *   - This is rational iff F(x_P, q) is a Q-square.
 *
 * Map E_PCP(q)(Q) → group structure of E_PCP(q)^(-1)(Q) via what map?
 *
 * Let me check: do MW generators of E_PCP(q)(Q), viewed as rational x's,
 * give rational points on E_PCP(q)^(-1)?
 *
 * Test on q = 3/4 (E_PCP rank 0, E_twist rank 1).
 */
default(parisize, 1000000000);

print("=== q = 3/4, E_PCP rank 0, E_twist rank 1 ===");

m = 4; n = 3; q0 = 3/4;
Epcp = ellinit([0, m^2+n^2, 0, m^2*n^2, 0]);  /* [0,25,0,144,0] */
Etw  = ellinit([0, -(m^2+n^2), 0, m^2*n^2, 0]);  /* [0,-25,0,144,0] */

print("E_PCP gens: ", ellrank(Epcp)[4]);
gens_tw = ellrank(Etw)[4];
print("E_twist gens: ", gens_tw);

print();
print("MW generator of E_PCP^(-1) at q=3/4: ");
print("  Original model [0,-25,0,144,0]: gen = ", gens_tw[1]);
P = gens_tw[1];
print("  Point P = (", P[1], ", ", P[2], ")");
print("  Verify y^2 = x^3 - 25 x^2 + 144 x: ", P[2]^2 - (P[1]^3 - 25*P[1]^2 + 144*P[1]));

/* In original x_orig = X/m^2 = X/16 coordinates: */
print();
print("Coordinate translation to original (q,x) world:");
print("E_PCP integer model [0, m^2+n^2, 0, m^2*n^2, 0] uses X = m^2 x, Y = m^3 y.");
print("So MW gen at X = ", P[1], " has 'rational' x = ", P[1]/16);

/* Verify: x = -1/16 hits which special locus? Probably not a degenerate point of E_PCP. */
print();
print("Is x = ", P[1]/16, " a torsion x-coordinate of E_PCP? (0, -1, -q^2)?");
print("  0 = ", P[1]/16 == 0);
print("  -1 = ", P[1]/16 == -1);
print("  -q^2 = -9/16 ? ", P[1]/16 == -9/16);

/* Now check: is F(x, q) at this x value a perfect square? */
A = 'x^2 + 'q^2;
G = (1+'q^2)*'x^2 + 4*'q^2*'x + 'q^2*(1+'q^2);
F = A*G;

x_eval = P[1]/16;  /* this is rational x in original model */
Fval = subst(subst(F, 'q, q0), 'x, x_eval);
print();
print("F(x = ", x_eval, ", q = 3/4) = ", Fval);
print("issquare? ", issquare(Fval));
if(issquare(Fval),
  print("  sqrt = ", sqrtrat(Fval));
);

/* Hmm, but x_eval comes from E_twist, not E_PCP. Let me reconsider. */
print();
print("Better question: does each rational point of E_PCP(q) (not the twist!)");
print("give F(x_P, q) = square? Already verified empirically: NO.");
print();
print("And: does each rational point of E_PCP(q)^(-1) give a rational point of S_q?");
print("Yes — via the very definition of Jacobian.");
print();
print("So the 'rational points on S_q' come from E_PCP(q)^(-1), NOT from E_PCP(q).");
print();
print("The PCP relevant question is: which of these rational points on S_q");
print("have (x, w) such that x is the x-coordinate of an E_PCP(q) rational point?");

print();
print("=== Compute base point Q0 on E_twist ===");
print("S_q has 'standard' base point P0_S = (x=0, w=q^2 h/m) = (0, 9/4 * 5/4) = (0, 45/16)");
print("Hmm but Epcp integer model gives (x_orig, w_orig)?");
print("Let me trace: S_q with original q = 3/4, F(0, q) = q^4(1+q^2) = (3/4)^4 (1+9/16)");
print("  = 81/256 * 25/16 = 2025/4096. sqrt = 45/64.");
print("So P0_S = (0, ±45/64). Mapping to J(S_q) under canonical iso...");
print("In integer model [0,-25,0,144,0]: P0_S goes to which point?");

/* The map S_q → J(S_q): standard derivation. Use ellfromeqn properly. */
/* PARI's ellfromeqn returns [E, map] but the map info is not always exposed. */
/* For now, just check torsion of E_twist */
print();
print("Torsion of E_PCP(q)^(-1) at q=3/4: ", elltors(Etw));
print("Torsion points: ", elltors(Etw)[3]);
print();
print("Mapping back: which torsion points correspond to 'degenerate' points of S?");
print("Degenerate = (x = 0) and (x = ±q) and (x = -q^2) and (x = -1) and x = ∞.");
print("Compute F at these (in integer model, x = X/16):");
print("  F(0, 3/4)  = ", subst(subst(F, 'q, q0), 'x, 0), " = (45/64)^2 = ", (45/64)^2);
print("  F(-1, 3/4) = ", subst(subst(F, 'q, q0), 'x, -1), " = ?");
Fm1 = subst(subst(F, 'q, q0), 'x, -1);
print("    issquare? ", issquare(Fm1));
print("  F(-q^2 = -9/16, 3/4) = ", subst(subst(F, 'q, q0), 'x, -9/16));
Fm916 = subst(subst(F, 'q, q0), 'x, -9/16);
print("    issquare? ", issquare(Fm916));
print("  F(q = 3/4, 3/4) = ", subst(subst(F, 'q, q0), 'x, 3/4));
print("    issquare? ", issquare(subst(subst(F, 'q, q0), 'x, 3/4)));
print("  F(-q = -3/4, 3/4) = ", subst(subst(F, 'q, q0), 'x, -3/4));
print("    issquare? ", issquare(subst(subst(F, 'q, q0), 'x, -3/4)));

quit;
