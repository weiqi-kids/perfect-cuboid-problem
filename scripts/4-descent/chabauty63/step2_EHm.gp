/* Reconstruct E_Hm at (63, 38) directly from the genus-2 curve.
 *
 * H_{(m,n)}: y^2 = (Y^2 - dab^2)(Y^2 - a^2)(Y^2 - b^2).
 * Bielliptic involutions:
 *   sigma : (Y,y) -> (-Y, y),   pi_+ : (Y,y) -> (X=Y^2, y)  ==>  E_PCP : y^2 = f(X) = (X - dab^2)(X - a^2)(X - b^2).
 *   tau   : (Y,y) -> (-Y,-y),   pi_- : (Y,y) -> (s=Y^2, t=Y y)  ==> E_Hm : t^2 = s*f(s)  (quartic in s, sextic in Y).
 *
 * The quartic curve  t^2 = s (s - X1)(s - X2)(s - X3)   has the rational point s=0 (t=0)
 * already in the model, so we can put it in Weierstrass form with a Mobius transformation:
 *   Set s = 1/u, multiply by u^4:  (t u^2)^2 = u (1 - X1 u)(1 - X2 u)(1 - X3 u).
 * Let v = t u^2.  Then v^2 = u (1 - X1 u)(1 - X2 u)(1 - X3 u).
 * Expand RHS:  u * (1 - (X1+X2+X3) u + (X1 X2 + X1 X3 + X2 X3) u^2 - X1 X2 X3 u^3).
 *   = u - S1 u^2 + S2 u^3 - S3 u^4,   where S1 = sum, S2 = pairsum, S3 = product.
 * Put w = -X1 X2 X3 * u  (rescale).  Try the standard substitution v = w^2 X + .... easier:
 *
 * Use ellfromeqn — PARI tool to convert a polynomial equation into a Weierstrass model.
 */

m = 63; n = 38;
a = m^2 - n^2;        \\ 2525
b = 2*m*n;            \\ 4788
dab = m^2 + n^2;      \\ 5413
X1 = dab^2; X2 = a^2; X3 = b^2;
S1 = X1 + X2 + X3;
S2 = X1*X2 + X1*X3 + X2*X3;
S3 = X1*X2*X3;
print("S1=",S1, "  S2=",S2, "  S3=",S3);
print("S1 factor: ", factor(S1));
print("S3 factor: ", factor(S3));

\\ E_Hm in quartic form Y_t^2 = s * (s - X1)(s - X2)(s - X3).
\\ Use ellfromeqn to convert.
EHm_eqn = y^2 - x*(x-X1)*(x-X2)*(x-X3);
\\ ellfromeqn returns [a1,a2,a3,a4,a6] of a Weierstrass model birational to the curve.
EHm_W = ellfromeqn(EHm_eqn);
print("Weierstrass coefficients of E_Hm (from ellfromeqn): ", EHm_W);
E_Hm = ellinit(EHm_W);
print("E_Hm disc = ", factor(abs(E_Hm.disc)));
print("E_Hm cond bad primes via lazy factor: try ellglobalred or just factor disc...");
print("torsion = ", elltors(E_Hm));

\\ Now identify rank-1 generator search:
\\ The known MW-supported triple from selmer_63_38.txt has d_1 = 19.
\\ Check rational points with small s satisfying s * (s - X1)(s - X2)(s - X3) = square.
\\ Try the 2-torsion s = 0, X1, X2, X3 (these are 2-torsion).
print();
print("=== 2-torsion in quartic model ===");
print("s=0:  product = 0");
print("s=X1: product = 0");
print("s=X2: product = 0");
print("s=X3: product = 0");

\\ Now hunt for a non-torsion rational point on the quartic.
\\ The Selmer class d_1 = 19 means: rational point (s, t) with s/19 a square-free direction.
\\ I.e. s = 19 * (rational square) is one of the candidate parametrizations.
print();
print("=== Hunt for points on t^2 = s(s-X1)(s-X2)(s-X3), with s = 19 r^2/u^2 etc. ===");

\\ Direct small-search:
goodpts = [];
for(num = -2000, 2000,
  s = num;
  if(s == 0 || s == X1 || s == X2 || s == X3, next);
  val = s * (s - X1) * (s - X2) * (s - X3);
  if(val > 0 && issquare(val),
    print("HIT integer s=", num, "  t=", sqrtint(val));
    goodpts = concat(goodpts, [[num, sqrtint(val)]]);
  );
);
print("integer hits = ", goodpts);
