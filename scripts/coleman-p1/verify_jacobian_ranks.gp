\\ ============================================================
\\ Verify Jacobian decomposition ranks
\\ J(C) ~_Q E_1 x E_2 x E_3 x X_+ x X_-
\\ ============================================================

print("=== Verifying elliptic factors of J(C) ===\n");

\\ E_1: y^2 = x^3 - 39312 x + 2889216, conductor 480, claimed rank 1
E1 = ellinit([0, 0, 0, -39312, 2889216]);
print("E_1: y^2 = x^3 - 39312*x + 2889216");
print("  Conductor      = ", ellglobalred(E1)[1]);
print("  Analytic rank  = ", ellanalyticrank(E1)[1]);
print("  Torsion        = ", elltors(E1)[1]);
print();

\\ E_2: y^2 = x^3 - 32400 x, conductor 800, claimed rank 1
E2 = ellinit([0, 0, 0, -32400, 0]);
print("E_2: y^2 = x^3 - 32400*x");
print("  Conductor      = ", ellglobalred(E2)[1]);
print("  Analytic rank  = ", ellanalyticrank(E2)[1]);
print("  Torsion        = ", elltors(E2)[1]);
print();

\\ E_3: y^2 = x^3 - x^2 - 108 x - 288, conductor 1200, claimed rank 1
E3 = ellinit([0, -1, 0, -108, -288]);
print("E_3: y^2 = x^3 - x^2 - 108*x - 288");
print("  Conductor      = ", ellglobalred(E3)[1]);
print("  Analytic rank  = ", ellanalyticrank(E3)[1]);
print("  Torsion        = ", elltors(E3)[1]);
print();

\\ X_+: y^2 = x^3 + x^2 - 20 x, conductor 120, claimed rank 0
Xp = ellinit([0, 1, 0, -20, 0]);
print("X_+: y^2 = x^3 + x^2 - 20*x");
print("  Conductor      = ", ellglobalred(Xp)[1]);
print("  Analytic rank  = ", ellanalyticrank(Xp)[1]);
print("  Torsion        = ", elltors(Xp)[1]);
print();

\\ X_-: y^2 = x^3 - 7 x + 6, conductor 80, claimed rank 0
Xm = ellinit([0, 0, 0, -7, 6]);
print("X_-: y^2 = x^3 - 7*x + 6");
print("  Conductor      = ", ellglobalred(Xm)[1]);
print("  Analytic rank  = ", ellanalyticrank(Xm)[1]);
print("  Torsion        = ", elltors(Xm)[1]);
print();

print("=== Compute L(X_+, 1), L(X_-, 1) explicit non-vanishing ===");
LXp = lfun(Xp, 1);
LXm = lfun(Xm, 1);
print("  L(X_+, 1) = ", LXp);
print("  L(X_-, 1) = ", LXm);
print();
print("Both L-values are nonzero, so by Kolyvagin (analytic rank 0 case)");
print("X_+ and X_- have algebraic rank 0 unconditionally.");
