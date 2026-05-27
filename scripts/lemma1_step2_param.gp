\\ The conic C: w^2 = Z^2 - 6Z + 1 has rational point (Z, w) = (0, 1).
\\ Parametrize by lines w = t Z + 1 through (0, 1):
\\   (tZ + 1)^2 = Z^2 - 6Z + 1
\\   t^2 Z^2 + 2tZ + 1 = Z^2 - 6Z + 1
\\   (t^2 - 1) Z^2 + (2t + 6) Z = 0
\\   Z [(t^2 - 1) Z + 2(t + 3)] = 0
\\   Z = 0  or  Z = -2(t+3)/(t^2 - 1) = -2(t+3)/((t-1)(t+1))

\\ For t != 1, -1, Z(t) = -2(t+3)/((t-1)(t+1)).
\\ Compute the corresponding q from the quadratic 4Z^2 q^2 - R q + 4Z^2 = 0:
\\ q = (R ± sqrt(Delta)) / (8 Z^2)
\\ with R = Z^4 - 4Z^3 - 2Z^2 - 4Z + 1, sqrt(Delta) = (Z-1)^2 (Z+1) w.

\\ Recompute symbolically:
Z = -2*(t+3) / ((t-1)*(t+1));
w = t*Z + 1;
print("Z(t) = ", Z);
print("w(t) = ", w);

\\ Verify w^2 = Z^2 - 6Z + 1
chk = w^2 - (Z^2 - 6*Z + 1);
print("Check w^2 - (Z^2 - 6Z + 1) = ", chk);

R = Z^4 - 4*Z^3 - 2*Z^2 - 4*Z + 1;
sqrtDelta = (Z-1)^2 * (Z+1) * w;
\\ Verify sqrtDelta^2 = Delta
DeltaZ = (Z-1)^4 * (Z+1)^2 * (Z^2 - 6*Z + 1);
chk2 = sqrtDelta^2 - DeltaZ;
print("Check sqrtDelta^2 - Delta = ", chk2);

q_plus = (R + sqrtDelta) / (8 * Z^2);
q_minus = (R - sqrtDelta) / (8 * Z^2);
print("");
print("q_plus(t)  = ", q_plus);
print("q_minus(t) = ", q_minus);

\\ Simplify both:
print("");
print("q_plus  simplified: ", q_plus);
print("q_minus simplified: ", q_minus);

\\ Compute 1 + q^2 for q = q_plus to test if Pythagorean
oneplusq2_plus = 1 + q_plus^2;
print("");
print("1 + q_plus^2 = ", oneplusq2_plus);

oneplusq2_minus = 1 + q_minus^2;
print("1 + q_minus^2 = ", oneplusq2_minus);

\\ Check whether 1 + q^2 is a rational square in t
\\ i.e. is (numerator * denominator) a square as function of t?
\\ Compute as rational function
print("");
print("oneplusq2_plus as rational function:");
print(oneplusq2_plus);
\\ Try: get numerator and denominator
np = numerator(oneplusq2_plus);
dp = denominator(oneplusq2_plus);
print("numerator = ", np);
print("denominator = ", dp);
print("numerator factored: ", factor(np));
print("denominator factored: ", factor(dp));

quit;
