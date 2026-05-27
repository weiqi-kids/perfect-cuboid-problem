\\ Smoke test for Leg I components

default(parisize, 200000000);
default(parisizemax, 400000000);

A4 = -4296889542830417930548255320;
A6 = 69513195990628448299367172717433334517312;
E = ellinit([1, 0, 0, A4, A6]);

e1 = -289985899459969;
e2 =  69618111281856;
e3 =  220367788178112;

\\ Verify torsion points map back via process_candidate for d=(1,1,1) trivial class:
\\ For trivial: z_i = (X̃ - e_i)^(1/2)/1, so X̃ = e_i for the 2-torsion.

print("=== Smoke test ===");
print("E_Hm Y^2 = X^3 + X^2 + 16*A4*X + 64*A6 ?");
\\ Cross-check 2-torsion images: y_E = 0 at x_E = e_i/4 - 1/12 maybe? Skip — just want sanity.

\\ Check ellisoncurve on a known torsion point.
\\ The roots of Y^2 - X^3 - X^2 - 16 A4 X - 64 A6 = 0 with Y=0:
\\   X^3 + X^2 + 16 A4 X + 64 A6 = 0
\\ The 2-torsion x-coords on (a1,a2,a3,a4,a6) = (1,0,0,16 A4, 64 A6) are roots of
\\   4 X^3 + (a2)*4 X^2 + (2 a4)*4 X + 4 a6 = 0  but better use ellpointtoz/ell2torsion
\\ Let's just use elltors:
print("torsion structure of E:");
T = elltors(E);
print(T);

\\ Try a candidate from the ε class with very small q=1 in z_3 patch.
d1 = 1; d2 = 219; d3 = 219;
C13 = e1 - e3;
C23 = e2 - e3;
\\ For z_3 patch with (p,q)=(1,1): val1 = 1*(1 - C13), val2 = 219*(1 - C23). Both positive.
p = 1; q = 1;
val1 = d1 * (d3*p^2 - C13*q^2);
val2 = d2 * (d3*p^2 - C23*q^2);
print("z_3 patch (1,1):");
print("  val1 = ", val1, "  issquare = ", issquare(val1));
print("  val2 = ", val2, "  issquare = ", issquare(val2));

\\ Try (p,q)=(0,1) — this gives X̃ = e_3, which is the 2-torsion T_3.
p = 0; q = 1;
val1 = d1 * (d3*p^2 - C13*q^2);
val2 = d2 * (d3*p^2 - C23*q^2);
print("z_3 patch (0,1):");
print("  val1 = ", val1, "  issquare = ", issquare(val1));
print("  val2 = ", val2, "  issquare = ", issquare(val2));
\\ Note val1 = -C13 = -(e1-e3) = e3-e1 = C31 = 510353687638081
\\ For ε = [1,219,219], we need d3 z_3^2 = X̃ - e_3 = 0, so z_3 = 0, p = 0, q = 1.
\\ Then d1*(X̃-e_1) = d1*(e_3 - e_1) = C31 = 510353687638081. This is the 2-torsion T_3.
\\ For ε class, we need C31 to be 219 * (square), i.e. C31/219 = ?
print("  C31 = ", -C13, "  C31/d2 = ", (-C13) \ d2, "  C31/d2 mod d2 = ", (-C13) % d2);
\\ Actually for the 2-torsion the cover is the trivial class (1,1,1). For (1,219,219) we'd need
\\ X̃-e_2 = 219*z_2^2 and X̃-e_3 = 219*z_3^2. At T_3 (X̃ = e_3), X̃-e_3 = 0 = 219·0^2 ✓,
\\ X̃-e_2 = e_3 - e_2 = C32 = 150749676896256. We need C32 = 219·square.
\\ C32/219 = ?
C32 = e3 - e2;
print("  C32 = ", C32, "  C32/219 = ", C32 \ 219, "  C32 mod 219 = ", C32 % 219);
print("  is C32/219 a square? ", issquare(C32 \ 219));
\\ X̃-e_1 = e_3 - e_1 = C31 = 510353687638081. For ε class need d1·square = 1·square. So C31 must be square.
print("  is C31 a square? ", issquare(-C13));
print("  is C32/219 ", C32 \ 219, " a square? sqrt=", sqrtint(C32\219), "  sq=", sqrtint(C32\219)^2);

quit;
