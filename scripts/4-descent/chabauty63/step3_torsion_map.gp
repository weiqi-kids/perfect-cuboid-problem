/* Step 3: Map E_Hm torsion (size 16) to quartic (s,t) coords and check which s is a rational square.
 *
 * The Weierstrass shifted model is  y^2 = (x + X1*X2)(x + X1*X3)(x + X2*X3),
 * where X1 = dab^2, X2 = a^2, X3 = b^2.
 * (Compare Halcke (8,3): X1=73^2=5329, X2=55^2=3025, X3=48^2=2304, products give 2640^2, 3504^2, 4015^2.)
 *
 * Conversion: s = -X1 X2 X3 / x  ;   x = -X1 X2 X3 / s.
 * (Halcke template §1: " s = -ABC/x_un".)
 *
 * For each torsion point P_i = (x_i, y_i), compute s_i = -X1 X2 X3 / x_i, then check issquare(s_i).
 */

m = 63; n = 38;
a  = m^2 - n^2;       X2 = a^2;     \\ 2525^2
b  = 2*m*n;           X3 = b^2;     \\ 4788^2
dab= m^2 + n^2;       X1 = dab^2;   \\ 5413^2
ABC = X1*X2*X3;       \\ = (a b dab)^2

\\ The exact shifted Weierstrass model:
\\   y^2 = (x + X1*X2)(x + X1*X3)(x + X2*X3)
\\   = x^3 + (X1X2 + X1X3 + X2X3) x^2 + X1 X2 X3 (X1 + X2 + X3) x + (X1 X2 X3)^2
S = X1+X2+X3; P = X1*X2 + X1*X3 + X2*X3; Q = X1*X2*X3;
print("S=", S, "  P=", P, "  Q=", Q);

E = ellinit([0, P, 0, Q*S, Q^2]);
print("E disc factor = ", factor(abs(E.disc))[,1]);
T = elltors(E);
print("torsion = ", T[1], "   structure ", T[2]);

\\ Get full torsion subgroup (16 points)
print();
print("===  full 16-element torsion list  ===");
\\ generators
G1 = T[3][1];  \\ order 8
G2 = T[3][2];  \\ order 2
torslist = vector(16);
idx = 1;
torslist[idx] = [0]; idx += 1;  \\ identity at infinity
for(j = 1, 7,
  torslist[idx] = ellmul(E, G1, j);
  idx += 1;
);
\\ now add G2 and combine
torslist[idx] = G2; idx += 1;
for(j = 1, 7,
  torslist[idx] = elladd(E, ellmul(E, G1, j), G2);
  idx += 1;
);

for(k = 1, 16,
  P = torslist[k];
  if(length(P) < 2,
    print(k, "  O  (infinity)");
  ,
    xP = P[1]; yP = P[2];
    s_q = -Q / xP;     \\ s = -X1 X2 X3 / x
    \\ t = ?  From the birational, t = something/...  not needed yet, only need s square.
    issqs = issquare(s_q);
    print(k, "  x=", xP, "  y=", yP, "  s=-Q/x=", s_q, "  issquare(s)=", issqs);
    if(issqs && s_q > 0,
      Y_root = sqrtint(numerator(s_q)*denominator(s_q));   \\ symbolic
      print("    --> s is a positive rational square");
    );
  );
);
