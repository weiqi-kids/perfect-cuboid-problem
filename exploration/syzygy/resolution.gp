\\ Minimal free resolution of R/I where I = (Q1,Q2,Q3,Q4)
\\ R = Q[a,b,c,d,e,f,g], all quadrics.
\\
\\ PARI/GP doesn't have direct syzygy/Buchberger packages; we compute by hand:
\\
\\ Step A: Verify codimension and degree.
\\ Step B: Identify Koszul-type syzygies (trivial: Q_j*Q_i - Q_i*Q_j = 0).
\\ Step C: Find non-Koszul linear syzygies if any.
\\ Step D: Compare with Eagon-Northcott complex of a candidate matrix.

\\ Define quadrics symbolically
Q1 = a^2 + b^2 - d^2;
Q2 = b^2 + c^2 - e^2;
Q3 = a^2 + c^2 - f^2;
Q4 = a^2 + b^2 + c^2 - g^2;

\\ Key observation: Q4 = Q1 + c^2 - g^2 + d^2  -- no wait:
\\ Q4 - Q1 = c^2 - g^2 + d^2 - 0 = c^2 + d^2 - g^2.
\\ This is a NEW quadric (not in original ideal generators!)
print("Q4 - Q1 = ", Q4 - Q1);
print("Q4 - Q2 = ", Q4 - Q2);
print("Q4 - Q3 = ", Q4 - Q3);

\\ Q4 - Q1 = c^2 + d^2 - g^2  -- this says d^2 + c^2 = g^2
\\ Q4 - Q2 = a^2 + e^2 - g^2  -- this says a^2 + e^2 = g^2
\\ Q4 - Q3 = b^2 + f^2 - g^2  -- this says b^2 + f^2 = g^2

\\ So the ideal I contains:
\\   Q5 = c^2 + d^2 - g^2 = Q4 - Q1
\\   Q6 = a^2 + e^2 - g^2 = Q4 - Q2
\\   Q7 = b^2 + f^2 - g^2 = Q4 - Q3
\\
\\ Together: g^2 = a^2+b^2+c^2 = a^2+e^2 = b^2+f^2 = c^2+d^2.
\\ So all of d,e,f are square roots of g^2 - (square), i.e., e^2 = g^2-a^2 etc.
\\
\\ Linear syzygies among the 4 quadrics?
\\ Look for (L1,L2,L3,L4) linear forms with L1*Q1 + L2*Q2 + L3*Q3 + L4*Q4 = 0
\\ Degree 3 syzygy.

\\ Trivial Koszul: Q_i * Q_j - Q_j * Q_i = 0 (degree 4, not linear).
\\
\\ Check: is there a degree-1 syzygy?
\\ Set L_i = sum of linear monomials. The relation has degree 3.
\\ For this we'd need L1*Q1+...+L4*Q4 = 0 as a polynomial identity.
\\
\\ Trick: use specific evaluations. If L1 = c, L2 = -a (say):
\\ c*Q1 - a*Q2 = c*(a^2+b^2-d^2) - a*(b^2+c^2-e^2)
\\           = a^2*c + b^2*c - c*d^2 - a*b^2 - a*c^2 + a*e^2
\\           = a*c*(a-c) + b^2*(c-a) - c*d^2 + a*e^2
\\           = (a-c)*(ac - b^2) + ... no clean cancellation.
\\
\\ Let me check via direct attempt. The ideal of 4 quadrics in 7 variables of
\\ codimension 4 is a COMPLETE INTERSECTION generically. To check whether our
\\ specific 4 quadrics form a regular sequence, verify codim = 4.
\\
\\ Codim 4 ⇔ V has dim 7 - 1 - 4 = 2 (projectively) ✓ matches.
\\ A complete intersection has Koszul resolution:
\\   0 -> R(-8) -> R(-6)^4 -> R(-4)^6 -> R(-2)^4 -> R -> R/I -> 0
\\
\\ Castelnuovo-Mumford regularity for CI of 4 quadrics: reg(R/I) = sum(deg) - 0
\\ Actually reg(R/I) = sum(d_i - 1) = sum(2-1) = 4.
\\ reg(I) = reg(R/I) + 1 = 5? Need careful definition.
\\
\\ Standard: for CI of c quadrics, reg(R/I) = c (sum of degrees - codim = 2c - c = c).
\\ So reg(R/I) = 4.

\\ ---- Verify regularity / Hilbert series ----
\\ Hilbert series H(R/I, t) = (1-t^2)^4 / (1-t)^7   (if CI)
\\                          = (1-t^2)^4 * (sum_{k>=0} C(6+k,6) t^k)
\\                          = ((1+t)^4) * (1-t)^4 / (1-t)^7
\\                          = (1+t)^4 / (1-t)^3
print("\nHilbert series of R/I (if complete intersection):");
print("H(R/I, t) = (1+t)^4 / (1-t)^3");
\\ Expand: (1+t)^4 = 1 + 4t + 6t^2 + 4t^3 + t^4
\\ 1/(1-t)^3 = sum C(k+2,2) t^k
HS = (1+t)^4 / (1-t)^3;
print("Numerator (1+t)^4 = ", (1+t)^4);
\\ Computer Taylor series:
print("HS to t^8: ", Pol(Vec(Ser((1+t)^4 / (1-t)^3 + O(t^9)))));

\\ Degree of V = (1+t)^4 / (1-t)^3 evaluated... degree = leading coeff of Hilbert poly.
\\ Hilbert poly of CI of 4 quadrics in P^6: H(n) = 2^4 * C(n+2,2)/1 / ...
\\ Actually degree(V) = product of degrees / (max degree thing)?
\\ For CI of degrees (d_1,...,d_c) the degree is d_1 * d_2 * ... * d_c = 2^4 = 16.
\\ Then K_V = (sum d_i - n - 1) H = (8 - 7)H = H, so V is canonically polarized.
\\ K_V = O_V(1), so K_V^2 = 16 ✓ matches "Already known K² = 16".
print("\nIf CI: degree(V) = 2^4 = 16, K_V = O_V(1), K_V^2 = 16.");

\\ Hilbert polynomial: H(n) = degree * n^2 / 2 + lower order  (since dim 2)
\\ Leading term: 16 * n^2 / 2 = 8 n^2.
\\ From HS = (1+t)^4/(1-t)^3, Hilbert poly is the polynomial extrapolation:
\\ HP(n) = sum from f(1)... numerator at t=1 is 16, denom (1-t)^3 gives n^2/2 * 16 = 8 n^2.
print("Hilbert polynomial leading term: 8 n^2 (dim 2, deg 16)");

\\ Compute first few HF values:
HF_target = Pol(Vec(Ser((1+t)^4 / (1-t)^3 + O(t^10))));
print("HF values (degrees 0..9): ", HF_target);

\\ Are our 4 quadrics a REGULAR SEQUENCE? Check by computing Hilbert function
\\ directly and comparing.
\\
\\ Direct HF computation in degree d:
\\ HF_{R/I}(d) = dim_Q (R_d / I_d)
\\ where R_d = polynomials of degree d in 7 vars = C(d+6, 6).
\\ I_d = sum_{i} R_{d-2} * Q_i.
\\ A regular sequence has HF given by the formula.
\\
\\ Check d=2: R_2 has dim C(8,6) = 28. I_2 = span(Q1,Q2,Q3,Q4) dim 4 (linearly indep).
\\ So HF_{R/I}(2) = 28 - 4 = 24.
\\ Expected from HS coefficient of t^2 in (1+t)^4/(1-t)^3:
\\ Coefficient = ?
HS_coeffs = Vec(Ser((1+t)^4 / (1-t)^3 + O(t^6)));
print("HS coeffs (deg 0..5): ", HS_coeffs);

\\ d=2 expected: coef of t^2 in HS.
\\ R_d dims: 1, 7, 28, 84, 210, 462
\\ HS coefs from (1+t)^4/(1-t)^3:
\\ (1+4t+6t^2+4t^3+t^4) * (1+3t+6t^2+10t^3+15t^4+21t^5+...)
\\ t^0: 1
\\ t^1: 4+3 = 7  (matches dim R_1)
\\ t^2: 6+12+6 = 24
\\ t^3: 4+18+24+10 = 56
\\ Verify: R_d - (we'll trust this)
print("\nExpected HF(R/I)(d) for d=0..5: 1, 7, 24, 56, ...");

\\ Are Q1,Q2,Q3,Q4 linearly independent in R_2? Yes obviously (each has a
\\ unique d^2, e^2, f^2, g^2 term). So I_2 has dim exactly 4. ✓
\\ Are there extra linear syzygies (so I_3 < expected)?
\\ I_3 expected dim = 7*4 - 0 = 28 (no linear syzygies if regular sequence).
\\ But total R_3 = C(9,6) = 84, so HF(3) should be 84 - 28 = 56. ✓ above.

\\ To verify NO linear syzygies among Q1..Q4:
\\ A linear syzygy is (L1,L2,L3,L4) with sum L_i Q_i = 0.
\\ Equivalently 4-tuple of linear forms with degree-3 polynomial = 0.
\\ Each L_i has 7 coefficients, so 28 unknowns. Map to degree-3 polys (dim 84).
\\ Generically, kernel has dim max(28 - 84, 0) = 0 unless there's special structure.
\\ Let's check: is there a linear syzygy? Look for "obvious" candidates.

\\ Q1 + Q2 + Q3 = 2a^2 + 2b^2 + 2c^2 - d^2 - e^2 - f^2
\\ 2 Q4 - (Q1+Q2+Q3) = 2(a^2+b^2+c^2-g^2) - (2a^2+2b^2+2c^2-d^2-e^2-f^2)
\\                    = -2g^2 + d^2 + e^2 + f^2
\\ This is QUADRATIC, not zero. So NOT a syzygy of just constants.
print("\nLinear combo check: 2 Q4 - Q1 - Q2 - Q3 = ", 2*Q4 - Q1 - Q2 - Q3);
\\ = d^2 + e^2 + f^2 - 2 g^2, which means this poly is in I.
\\ So d^2 + e^2 + f^2 = 2 g^2 holds on V. Nice known identity.

\\ Conclusion (tentative): I is a complete intersection.
\\ Koszul resolution: F_• : R <- R(-2)^4 <- R(-4)^6 <- R(-6)^4 <- R(-8)
\\ Betti table:
\\         0  1  2  3  4
\\ tot:    1  4  6  4  1
\\ 0:      1  .  .  .  .
\\ 1:      .  4  .  .  .
\\ 2:      .  .  6  .  .
\\ 3:      .  .  .  4  .
\\ 4:      .  .  .  .  1

print("\nIf complete intersection (Koszul):");
print("F_0 = R");
print("F_1 = R(-2)^4");
print("F_2 = R(-4)^6");
print("F_3 = R(-6)^4");
print("F_4 = R(-8)");
print("reg(R/I) = 4");

quit;
