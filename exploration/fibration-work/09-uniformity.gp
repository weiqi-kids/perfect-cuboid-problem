\\ Step 9: The key uniformity question
\\
\\ We have V → P^1_q, each fiber is genus 5 curve.
\\ Rank varies; at q_0 = 4/3 rank = 3; at q_0 = 20/21 rank = 8.
\\
\\ Question: can Chabauty work uniformly?
\\
\\ FACT (Stoll's specialization theorem 2007, refining Silverman 1985):
\\ For a 1-parameter family of curves with abelian variety fibration,
\\ the rank is "Mordell-Weil rank" which can be computed in terms of the family.
\\ As q_0 varies, rank generically equals the GEOMETRIC RANK
\\ (rank of the generic fiber's Jacobian over the function field Q(q)).
\\
\\ Key insight: the generic fiber J_η (over Q(q)) has some rank r_η.
\\ For generic q_0 ∈ Q, rank(J_{q_0}) = r_η (the geometric rank).
\\ For special q_0, rank(J_{q_0}) ≥ r_η.
\\
\\ Silverman's specialization theorem: rank can only INCREASE on specializations.
\\ Stoll's strengthening: for "most" specializations, rank equals generic rank.
\\
\\ So we need to compute the generic rank r_η for the family E_H+(q).

\\ Family E_H+(q): Y^2 = X^3 + (3 + 2q^2) X^2 + (1 + 3q^2 + q^4) X + (q^2 + q^4)

\\ This is a quartic in q (coefficients linear in q^2). It's an elliptic surface over P^1_q.
\\ We need its Mordell-Weil rank as an elliptic curve over Q(q).

\\ Method: compute the L-function via PARI's ellap, or use 2-descent on the function field model.
\\ Alternatively, check if it has specific structure.

\\ Let's factor: Y^2 = (X + q^2)(X + 1)(X + 1 + q^2)
\\ which equals (X + q^2)(X + 1)(X + (1 + q^2))
\\ So 3 rational 2-torsion points over Q(q): X = -q^2, X = -1, X = -(1+q^2).
\\ Torsion subgroup contains (Z/2)^2 over Q(q).

\\ Mordell-Weil generators over Q(q): need to find rational sections P: P^1_q → E.

\\ Rational sections come from rational solutions (X(q), Y(q)) where X is a rational function of q.

\\ Quick check: try X = something polynomial in q.
\\ X = 0: Y^2 = 0 · 1 · (1+q^2) = 0. So (0, 0) is on the curve always — but X = 0 is between roots, so this is 2-torsion? No, X = 0 isn't a root unless q = 0 or q = ±1.
\\ Let me check: at X = 0, Y^2 = (0 + q^2)(0 + 1)(0 + 1 + q^2) = q^2(1+q^2). So Y = q·√(1+q^2). Rational iff 1 + q^2 is a square — which is exactly our Pythagorean condition!
\\
\\ So (X = 0, Y = q*√(1+q^2)) is a section ONLY over the base curve {1 + q^2 = □}.
\\
\\ Other tries:
\\ X = -q (not a root): Y^2 = (q^2 - q)(1 - q)(1 - q + q^2) = q(q - 1)(1 - q)(1 - q + q^2). Doesn't simplify.

\\ Let me actually compute generic rank of this family using PARI's elliptic surface tools.

\\ Convert E_H+(q) to a curve over Q(q):
\\ Coefficients:
\\   a4 = 1 + 3q^2 + q^4 (constant term wrt X^2)... wait the equation is Y^2 = X^3 + (3+2q^2) X^2 + (1+3q^2+q^4) X + (q^2+q^4)
\\ Use 'q as formal variable

E_qq = ellinit([0, 3 + 2*'q^2, 0, 1 + 3*'q^2 + 'q^4, 'q^2 + 'q^4]);
print("E_H+(q) over Q(q):");
print("  Discriminant (poly in q): ", E_qq.disc);
print("  j-invariant (poly in q): ", E_qq.j);
print("  Factored disc: ", factor(E_qq.disc));

\\ The discriminant is a poly in q; bad reduction primes are where disc = 0
\\ Need to count Kodaira fibers and use Shioda-Tate or direct computation.

\\ Approach 2: use ellfromj or look up.
\\ Approach 3: brute force find sections over Q(q).
print("\nLook for sections (X, Y) with X, Y polynomial in q:");
print("Try X = aq^2 + bq + c, Y = dq^3 + ... and solve.");

\\ Quick: try X linear in q^2: X = α + β q^2
\\ Then need X^3 + (3+2q^2) X^2 + (1+3q^2+q^4) X + (q^2+q^4) = Y^2 in Q[q].
\\ This is a polynomial in q of degree 6.
\\ For Y to be polynomial in q (rather than rational function), need leading coeff to be square.
\\ Leading coeff (q^6 from X^3 = β^3 q^6 + ..., plus (...)(X^2 q^2)(...)):
\\ Computing more carefully via PARI:

X_try(a, b) = a + b * 'q^2;
RHS(a, b) = subst(X_try(a, b)^3 + (3 + 2*'q^2) * X_try(a, b)^2 + (1 + 3*'q^2 + 'q^4) * X_try(a, b) + 'q^2 + 'q^4, 'q, 'q);
print("RHS(1, 0) = ", RHS(1, 0));
print("RHS(0, 1) = ", RHS(0, 1));
print("RHS(0, -1) = ", RHS(0, -1));
print("RHS(-1, 0) = ", RHS(-1, 0));

\\ Try X = -q^2 (one 2-torsion): RHS = 0 ✓ (Y = 0)
\\ Try X = q^2:
print("RHS(0, 1): X = q^2 → ", RHS(0, 1));
\\ Need this to be a square in Q[q]
fact_q2 = factor(RHS(0, 1));
print("Factored: ", fact_q2);

\\ Hmm look more systematically. The torsion subgroup over Q(q) is (Z/2)^2 (or maybe larger).
\\ The free part rank is what we need to bound.

\\ Heuristic: count integer points on E_H+(q_0) for many q_0 with bounded denominators
\\ to estimate generic rank.
