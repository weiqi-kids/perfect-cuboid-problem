\\ Step 4: Sanity check the uniruling computation
\\ Pick concrete (X_0, Y_0) on E_PCP(q) for some q, verify fiber is rational

print("====================================================");
print(" Step 4: Verify uniruling of W via explicit examples");
print("====================================================");

\\ Pick q = 3/4 (m=2, n=1): E_PCP(3/4): Y^2 = X(X+1)(X+9/16)
\\ Find rational point. Try X = 0 (gives Y=0). X=-1 (Y=0). X=-9/16 (Y=0). All 2-torsion.
\\ Non-torsion needs rank > 0; q=3/4 generic rank 0, only 2-torsion.

\\ Let's instead pick a known rank-1 fiber: q = 20/21 (m=?,n=?)
\\ q = (m^2-n^2)/(2mn) = 20/21
\\ Try m=5, n=2: (25-4)/(20) = 21/20. No.
\\ m=6, n=2: (36-4)/24 = 32/24 = 4/3. No.
\\ Try m=7, n=3: (49-9)/42 = 40/42 = 20/21. Yes!
\\ So q=20/21, m=7, n=3.

m0 = 7; n0 = 3;
q = (m0^2 - n0^2)/(2*m0*n0);
print("q = ", q);
\\ q^2 = 400/441

\\ E_PCP(q): Y^2 = X*(X+1)*(X + q^2)
\\ In rational form
qsq = q^2;
print("q^2 = ", qsq);

\\ Find rational points via ellrank... but easier: use elliptic curve PARI form
\\ Y^2 = X^3 + (1+q^2) X^2 + q^2 X
\\ ellinit:
E = ellinit([0, 1+qsq, 0, qsq, 0]);
print("E_PCP(20/21) initialized");
print("Conductor: ", ellglobalred(E)[1]);

\\ Search for points
pts = ellsearch(E, 10^4);
print("Integer points (small height): ", pts);

\\ Use ellratpoints or Heegner
\\ With analytic rank...
\\ Just compute rank if feasible
\\ \\ default(parisize, "200M");
r = ellrank(E);
print("Rank analysis: ", r);

\\ Let's just take a 2-torsion point first
\\ Two-torsion at X=0, X=-1, X=-q^2
\\ (X0, Y0) = (0, 0)
print();
print("=== Sanity check with (X_0, Y_0) = (0, 0) (2-torsion) ===");
\\ Then the fiber equation:
\\ 4 m^2 n^2 * 0 = 0 * (...) * (...) ==> 0 = 0
\\ Degenerate (whole A^2_{m,n}); skip.

\\ Try (X0, Y0) where Y0 != 0. We need to test with a non-torsion point.
\\ For our purpose: pick a generic random (X0, Y0) and verify the fiber is reducible/rational.
\\ Mathematically we showed:
\\   F|_{X=X0,Y=Y0} (m,n) = (m^2-n^2)^2 (X_0+1) X_0  +  4 m^2 n^2 (X_0(X_0+1)(X_0-?) +...)
\\ Wait, set up directly:
\\
\\ F(X0, Y0, m, n) = 4 m^2 n^2 Y_0^2 - X_0(X_0+1) [(m^2-n^2)^2 + 4 m^2 n^2 X_0]
\\
\\ Let's verify this matches our F:
\\   F = 4 m^2 n^2 Y^2 - 4 m^2 n^2 X^2(X+1) - (m^2-n^2)^2 X(X+1)
\\   F|_{X=X0,Y=Y0} = 4 m^2 n^2 Y_0^2 - X_0(X_0+1) [4 m^2 n^2 X_0 + (m^2-n^2)^2]
\\
\\ Yes. So fiber = 4 m^2 n^2 (Y_0^2 - X_0^2(X_0+1)) - X_0(X_0+1)(m^2-n^2)^2 = 0
\\
\\ Let alpha = Y_0^2 - X_0^2(X_0+1) and beta = X_0(X_0+1).
\\ Fiber: 4 alpha m^2 n^2 = beta (m^2-n^2)^2
\\
\\ This is HUGELY simpler than I had before! It's:
\\   sqrt(beta) (m^2-n^2) = ± 2 sqrt(alpha) m n
\\
\\ Two conics in (m,n):
\\   sqrt(beta) m^2 - 2 sqrt(alpha) m n - sqrt(beta) n^2 = 0   AND
\\   sqrt(beta) m^2 + 2 sqrt(alpha) m n - sqrt(beta) n^2 = 0
\\
\\ Over Q the fiber is irreducible iff alpha/beta is NOT a square in Q.
\\ But each component is a conic (degree 2 in m,n homogeneous).

print();
print("Clean factorization of pi_2 fiber:");
print("  F|_{X=X_0,Y=Y_0} = 4*alpha*m^2*n^2 - beta*(m^2-n^2)^2");
print("  where alpha = Y_0^2 - X_0^2(X_0+1), beta = X_0(X_0+1).");
print();
print("Note: alpha/beta = (Y_0^2 - X_0^2(X_0+1)) / (X_0(X_0+1))");
print("    = Y_0^2/(X_0(X_0+1)) - X_0");
print("    = Y_0^2/(X_0(X_0+1)) - X_0");
print();
print("On E_PCP: Y^2 = X(X+1)(X+q^2), so Y_0^2 = X_0(X_0+1)(X_0+q^2).");
print("=> Y_0^2 / (X_0(X_0+1)) = X_0 + q^2.");
print("=> alpha/beta = (X_0 + q^2) - X_0 = q^2.");
print();
print("**KEY: alpha/beta = q^2 for any point (X_0,Y_0) on E_PCP(q)!**");

\\ Verify numerically
X0 = 1; \\ random
Y0sq = X0*(X0+1)*(X0+qsq);
alpha = Y0sq - X0^2*(X0+1);
beta = X0*(X0+1);
ratio = alpha/beta;
print();
print("Verify with X_0 = 1, q^2 = ", qsq);
print("  alpha/beta = ", ratio);
print("  q^2 = ", qsq);
print("  Match: ", ratio == qsq);

\\ So the fiber over (X_0, Y_0) ON E_PCP(q) is:
\\   4 q^2 beta m^2 n^2 - beta (m^2-n^2)^2 = 0
\\   beta [4 q^2 m^2 n^2 - (m^2-n^2)^2] = 0
\\   (m^2-n^2)^2 = 4 q^2 m^2 n^2
\\   m^2 - n^2 = ± 2 q m n
\\
\\ This is EXACTLY the Pythagorean conic parametrization!
\\
\\ q = (m^2-n^2)/(2mn) is the ORIGINAL definition.
\\ So the fiber over any point on E_PCP(q) is exactly the locus
\\   {(m,n) : (m^2-n^2)/(2mn) = ±q}
\\
\\ This is the Pythagorean conic - degree-2 curve in (m,n), genus 0.

print();
print("=== KEY GEOMETRIC INSIGHT ===");
print();
print("For (X_0, Y_0) on E_PCP(q), the pi_2 fiber is:");
print("  (m^2-n^2)^2 = 4 q^2 m^2 n^2");
print("  <=> m^2 - n^2 = ±2 q m n");
print("  <=> q = ±(m^2-n^2)/(2mn).");
print();
print("This is just the Pythagorean conic { (m,n) : q(m,n) = ±q }.");
print();
print("Geometric structure of W:");
print("  W = { (X, Y, m, n) : (X,Y) in E_PCP(q(m,n)) }");
print("  pi_2 fiber over (X_0,Y_0) = preimage of q^2 = q(X_0,Y_0)^2 under q-map.");
print();
print("Equivalently, W is a fiber product:");
print("  W = E_total ×_{q-line} Pyth_total");
print("where:");
print("  E_total -> A^1_q is the elliptic fibration with fiber E_PCP(q)");
print("  Pyth_total -> A^1_q is the Pythagorean conic fibration (m,n) -> q(m,n)");
print();
print("Both are 2-folds. W is a 3-fold (fiber product of 2 fibrations of dim 2 over dim 1).");

print();
print("=== Birational type: W is uniruled ===");
print();
print("The pi_2 fibers are conics — rational curves.");
print("Through every point of W there passes a rational curve.");
print("=> W is uniruled, Kodaira dimension κ(W) = -∞.");
print();
print("Equivalently: W is birational to E_q × P^1 — a P^1-bundle over the elliptic surface E_q.");
print("More precisely:");
print("  W is birational to the elliptic surface S := { (X,Y,q) : E_PCP(q) }");
print("  product with P^1 (the Pythagorean conic parametrized by t=m/n).");

print();
print("=== Mordell-Weil / Lang implications ===");
print();
print("Faltings 1991: needs subvariety of abelian variety.");
print("  W is UNIRULED => Albanese(W) = 0 => Faltings 1991 INAPPLICABLE.");
print();
print("Lang conjecture (general type): not applicable since κ(W) = -∞.");
print();
print("Bombieri-Lang for uniruled: rational points are Zariski-dense in general.");
print("  Specifically: rational points cover the entire surface S_pyth × E");
print("  for any rank-positive q.");
print();
print("=> The 3-fold lift W does NOT give PCP closure.");
print("=> No new global finiteness from this direction.");

print();
print("=== Why this is NOT a setback ===");
print();
print("The pi_2 fibration reveals a deep structural fact:");
print("the (m,n) parameters and the (X,Y) coordinates are INDEPENDENT directions.");
print("Fixing (X_0,Y_0) gives only the Pythagorean conic constraint on (m,n).");
print();
print("This was already implicit in the existing framework:");
print("the closure relies on PER-FIBER analysis (Silverman+Ingram-Mahe)");
print("plus rank-jump locus density 0, NOT on global 3-fold finiteness.");
print();
print("The 3-fold W does NOT add new control; it just packages the existing structure.");
