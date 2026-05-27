/* Step 12: Parametrize each conic and search the resulting quartic for class 1 [15549, -5183, -3].
 *
 * Conic C: d1*z1^2 - d2*z2^2 - C12*t^2 = 0 with C12 = e2 - e1.
 * Use qfsolve point P0 = (z1_0, z2_0, t_0). Parametrize via lines through P0.
 * Then x = (d1 z1^2)/t^2 + e1; we need (x - e3)/d3 to be a square.
 * That's a quartic in the parametrization variable.
 *
 * For simpler approach: use the second conic to build a binary quartic.
 * Eliminate z2 via the first conic; we get a quartic z3^2 = polynomial in z1/t.
 *
 * Approach: parametrize as follows. Let u = z1/t. Then d2 z2^2 / t^2 = d1 u^2 - C12,
 * so z2/t = sqrt((d1 u^2 - C12)/d2). We need (x - e3)/d3 = (d1 u^2 + e1 - e3)/d3 to be square.
 * But x must be rational on the cover, so u is rational. Hence:
 *   d3*z3^2 = d1 u^2 + (e1 - e3)
 *   d2*z2^2 = d1 u^2 - (e2 - e1)
 *
 * Combined cover: rational u, with BOTH (d1 u^2 - C12)/d2 AND (d1 u^2 + e1 - e3)/d3 being rational squares.
 *
 * BUT wait: that's only with t = 1 (affine chart). The full cover has t in denominator.
 * Equivalent to: there exist integers (z1, z2, z3, t) with
 *   d1 z1^2 - d2 z2^2 = (e2 - e1) t^2
 *   d1 z1^2 - d3 z3^2 = (e3 - e1) t^2
 * which is a 1-dim variety (an elliptic curve).
 *
 * Parametrize first conic using qfsolve point, get rational map P1 -> conic,
 * substitute z1(s), t(s) (degree 2 in s) into d1 z1^2 - d3 z3^2 = (e3-e1) t^2,
 * giving d3 z3^2 = quartic in s.
 *
 * That's the GENUS-1 covering quartic.
 */
{
e1 = -336819173555216;
e2 =  148085289707295;
e3 =  188733883847920;
C12 = e2 - e1;
C13 = e3 - e1;

\\ Class 1: [15549, -5183, -3].
print("=== Class 1: [15549, -5183, -3] ===");
d1 = 15549; d2 = -5183; d3 = -3;

\\ qfsolve point on d1*z1^2 - d2*z2^2 - C12*t^2 = 0.
M = matdiagonal([d1, -d2, -C12]);
P0 = qfsolve(M);
print("P0 = ", P0);
z10 = P0[1]; z20 = P0[2]; t0 = P0[3];
print("verify: ", d1*z10^2 - d2*z20^2 - C12*t0^2);

\\ Parametrize the conic by lines through P0. Variables (s, u) -> P0 + s*(direction).
\\ Choose two tangent directions: write the homogeneous quadratic form,
\\ then a line through P0 in P^2 gives a second intersection rational in s.
\\
\\ Standard method: line through P0 = [z10, z20, t0] in direction [a, b, c]:
\\   (z1, z2, t) = (z10 + s*a, z20 + s*b, t0 + s*c)
\\ Substitute into Q = d1 z1^2 - d2 z2^2 - C12 t^2.
\\ Q(P0 + s D) = s * (linear in s) since Q(P0) = 0. So second intersection at s = -L/M.
\\
\\ The substitution: z1 = z10 + s*a, etc. gives Q = s*( ... ) = 0.
\\ Coefficient of s in Q: 2*(d1 z10 a - d2 z20 b - C12 t0 c).
\\ Coefficient of s^2: d1 a^2 - d2 b^2 - C12 c^2.
\\ Second intersection: s = -[2(d1 z10 a - d2 z20 b - C12 t0 c)] / [d1 a^2 - d2 b^2 - C12 c^2].
\\
\\ Choose 2-parameter family: vary direction [a, b, c] with one parameter,
\\ since the family of lines through P0 is P^1. Use (b, c) with a = 1 (or some chart).
\\
\\ Easier: introduce u, v as the parameters. Direction = (1, u, v) [generic plane].
\\ But that's 2D. The conic is curve, lines = pencil P^1.
\\ So use direction (alpha, 1, 0) and (alpha, 0, 1) -- two charts.
\\
\\ Or: use the slick formula. Standard parametrization:
\\   Choose direction D(s, r) = (alpha s + beta r, gamma s + delta r, epsilon s + zeta r)
\\ ... too abstract. Just do direct sub.
\\
\\ Use one parameter s with direction (s, 1, 0) (vary first vs second).
\\ Then intersection second point:
\\   k = -2*(d1*z10*s - d2*z20) / (d1*s^2 - d2)
\\ giving z1' = z10 + k*s, z2' = z20 + k, t' = t0.
\\ Hmm that fixes t.
\\
\\ Better: 2-variable directions. Use direction D = (s, r, 1) (with t-coord = 1).
\\   Q(P0 + lambda D) = lambda*[2(d1 z10 s - d2 z20 r - C12 t0)] + lambda^2*[d1 s^2 - d2 r^2 - C12]
\\ Set lambda = -2(d1 z10 s - d2 z20 r - C12 t0) / (d1 s^2 - d2 r^2 - C12).
\\ Resulting point on conic, homogeneous in (s, r, 1).
\\ Then x = (d1 (z10 + lambda s)^2) / (t0 + lambda)^2 + e1.
\\
\\ For ellratpoints, need genus-1 quartic in single parameter. Set r = 1 (chart):
\\
\\ With D = (s, 1, 1):
\\   L = 2*(d1*z10*s - d2*z20 - C12*t0)
\\   M = d1*s^2 - d2 - C12
\\   z1' = z10 - L*s/M
\\   z2' = z20 - L/M
\\   t'  = t0  - L/M
\\ Equivalently, scale by M:
\\   Z1 = z10*M - L*s    (polynomial of degree 2 in s, integer coeffs)
\\   Z2 = z20*M - L
\\   T  = t0*M  - L
\\ all polynomials in s of degree 2.
\\ Now require (d1*Z1^2 - d3*Z3^2*T^2_something) -- not quite, we need a third coord z3.

\\ Direct approach: Substitute (Z1(s), T(s)) into d1*z1^2 - d3*z3^2 = C13*t^2:
\\   d3 * z3^2 * (some denom)^2 = d1*Z1^2 - C13*T^2
\\ With Z1, T polynomials of degree 2 in s, the RHS is degree 4 polynomial Q(s),
\\ and we look for Q(s)/d3 = (rational)^2. That's exactly the genus-1 quartic cover.

print();
print("--- Parametrize conic with direction (s, 1, 1) through P0 ---");
\\ Symbolic in s.
\\ L(s) = 2*(d1*z10*s - d2*z20 - C12*t0)  - linear in s
\\ M(s) = d1*s^2 - d2 - C12                - quadratic in s
\\ Z1(s) = z10*M(s) - L(s)*s              - quadratic
\\ T(s)  = t0*M(s)  - L(s)                - quadratic

\\ As polynomials in s:
L_coef = [2*(-d2*z20 - C12*t0), 2*d1*z10];   \\ L(s) = L_coef[1] + L_coef[2]*s
M_coef = [-d2 - C12, 0, d1];                  \\ M(s) = M_coef[1] + M_coef[2]*s + M_coef[3]*s^2
\\ Z1(s) = z10*M(s) - L(s)*s
\\       = z10*(M_coef[1] + M_coef[3]*s^2) - (L_coef[1]*s + L_coef[2]*s^2)
\\       = z10*M_coef[1] - L_coef[1]*s + (z10*M_coef[3] - L_coef[2])*s^2
Z1_coef = [z10*M_coef[1], -L_coef[1], z10*M_coef[3] - L_coef[2]];

\\ T(s) = t0*M(s) - L(s)
\\      = t0*M_coef[1] - L_coef[1] + (-L_coef[2])*s + t0*M_coef[3]*s^2
T_coef = [t0*M_coef[1] - L_coef[1], -L_coef[2], t0*M_coef[3]];

\\ Now we want d1*Z1(s)^2 - C13*T(s)^2 = d3*z3^2 * (M(s))^2 -- wait no.
\\ Original homogeneous form: d1 z1^2 - d3 z3^2 = C13 t^2 with z1, z3, t projective.
\\ Replace z1 -> Z1(s), t -> T(s) (after clearing the lambda denominator M(s)).
\\ Then d1 Z1^2 - C13 T^2 = d3 z3^2 * (some scaling)
\\ The point on the original cover is [z1, z2, z3, t] = [Z1, Z2, z3, T] / M, but we cleared M.
\\ So d3 z3^2 = (d1 Z1^2 - C13 T^2) / M^? ...
\\ Actually since Z1, T are polynomials in s, and the cover requires d3 z3^2 = d1 z1^2 - C13 t^2
\\ in the projective sense, we get: d3 (z3')^2 = d1 Z1(s)^2 - C13 T(s)^2 where z3' is the projective coord scaled accordingly. The RHS is a degree-4 polynomial Q(s) in s.

\\ Compute Q(s) = d1*Z1(s)^2 - C13*T(s)^2 symbolically. Use polynomial in variable s.
P1 = Pol([Z1_coef[3], Z1_coef[2], Z1_coef[1]], s);
P2 = Pol([T_coef[3], T_coef[2], T_coef[1]], s);
Q_s = d1*P1^2 - C13*P2^2;
print("Q(s) = ", Q_s);
print("Degree of Q(s) = ", poldegree(Q_s));
print("Leading coeff = ", polcoeff(Q_s, poldegree(Q_s)));
print();

\\ We want d3 * z3^2 = Q(s), i.e., Q(s)/d3 = square.
\\ For d3 = -3, so we look for Q(s)/(-3) = square, i.e., -Q(s)/3 = z3^2.
\\ The quartic cover: y^2 = -Q(s)/3. Convert to ellratpoints-friendly form.

\\ Actually let's just look for small rational s such that Q(s)/d3 is a square.
print("=== Naive sweep over s for Q(s)/d3 = square ===");
for(num = -200, 200,
  qv = subst(Q_s, s, num);
  if(qv == 0, next);
  ratio = qv/d3;
  if(denominator(ratio) == 1 && issquare(ratio),
    print("HIT s=", num, "  Q(s)=", qv, "  Q/d3=", ratio, "  z3=", sqrtint(ratio));
  );
);
print("(done)");

\\ Also check rational s = p/q small heights
print();
print("=== Rational s = p/q sweep ===");
for(q=1, 30,
  for(p = -30*q, 30*q,
    if(gcd(p,q) != 1, next);
    \\ Substitute s = p/q in Q. Use polynomial eval.
    if(q==1, next);  \\ done above
    qv = subst(Q_s, s, p/q);
    \\ Q is polynomial of degree 4 with integer coefs, so denom is q^4.
    num_q = numerator(qv);
    den_q = denominator(qv);
    \\ ratio = qv/d3 = num_q / (den_q * d3)
    num2 = num_q;
    den2 = den_q * d3;
    \\ For square, need num2*den2 to be a square (rational square iff num/den is square after clearing)
    \\ Easier: just multiply by den2^2: we want num2*den2 to be a square (Z-sq).
    if(issquare(num2*den2),
      print("HIT s=", p, "/", q, "  Q/d3=", qv/d3);
    );
  );
);
print("(rational sweep done)");
}
