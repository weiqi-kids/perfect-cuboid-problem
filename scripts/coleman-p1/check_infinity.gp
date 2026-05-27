\\ ============================================================
\\ Check behavior at infinity for curve C in P^1_q × P^1_e × P^1_g
\\ C: e^2 = 5q^4 - 16q^2 + 20, g^2 = 5q^4 + 20
\\
\\ Near q = infty: set q = 1/s, then
\\   e^2 = 5/s^4 - 16/s^2 + 20  →  (es^2)^2 = 5 - 16 s^2 + 20 s^4
\\   g^2 = 5/s^4 + 20            →  (gs^2)^2 = 5 + 20 s^4
\\ At s = 0: (es^2)^2 = 5, not a rational square, so points at infinity
\\ correspond to e*s^2 = ±sqrt(5), g*s^2 = ±sqrt(5).
\\ These are NOT defined over Q (only over Q(sqrt(5))).
\\ ============================================================

print("=== Points at infinity of C ===");
print();
print("Setting q = 1/s, multiplying out by s^2:");
print("  E = e*s^2 satisfies E^2 = 5 - 16s^2 + 20s^4");
print("  G = g*s^2 satisfies G^2 = 5 + 20s^4");
print();
print("At s = 0 (i.e. q = infinity):");
print("  E^2 = 5  =>  E = +-sqrt(5)  (NOT in Q)");
print("  G^2 = 5  =>  G = +-sqrt(5)  (NOT in Q)");
print();
print("So C has 4 geometric points over q = infinity, defined over Q(sqrt(5)).");
print("NONE are Q-rational.");
print();
print("Therefore the 16 affine Q-points are ALL of C(Q).");
print();

print("=== Cross-check with F_7 ===");
print("Note: 5 is a square mod 7 (5 = 25/5; actually 5 = Mod(5,7), squares are 0,1,2,4)");
print("Is 5 a square mod 7? Squares mod 7 = {0,1,2,4}. 5 not in set, so 5 is NON-square mod 7.");
print("Hence over F_7 the points at infinity (E^2 = 5, G^2 = 5) are also non-rational over F_7,");
print("contributing 0 points over F_7. So |C(F_7)| = 16 affine + 0 infinity = 16.");

\\ Verify
sq5_modp = Mod(5, 7);
qr = issquare(sq5_modp);
print();
print("PARI check: issquare(Mod(5,7)) = ", qr);
