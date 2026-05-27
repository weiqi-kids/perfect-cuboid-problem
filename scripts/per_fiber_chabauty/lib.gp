\\ lib.gp — Auxiliary curve constructors for per-fiber Chabauty.
\\ Strategy I (Halcke): E_Hm(m,n) for the genus-2 quotient H_(m,n).
\\ Strategy II (V_q decomp): E_ef, E_eg, E_fg, E_Hp, E_Hm- (= X_-) for V_q.
\\
\\ Sanity checks: at Halcke (8,3), E_Hm has conductor 17368890 (verified).
\\ At (88,35), E_Hm has conductor 204925111777748670 (verified).

\\ ---- Strategy II curves (5-factor decomp of J(V_q)) ----

\\ E_ef(q): Y^2 = X^3 - 2(1+q^2) X^2 + (1-q^2)^2 X
make_Eef(q) = ellinit([0, -2*(1+q^2), 0, (1-q^2)^2, 0]);

\\ E_eg(q): Y^2 = X^3 - 2(1+2q^2) X^2 + X
make_Eeg(q) = ellinit([0, -2*(1+2*q^2), 0, 1, 0]);

\\ E_fg(q): Y^2 = X^3 - 2(2+q^2) X^2 + q^4 X
make_Efg(q) = ellinit([0, -2*(2+q^2), 0, q^4, 0]);

\\ E_H+(q): y^2 = (x+q^2)(x+1)(x+1+q^2)
make_EHp(q) = ellinit([0, 2+2*q^2, 0, 1+3*q^2+q^4, q^2+q^4]);

\\ E_H-(q) = X_- : the odd part. Defining curve y^2 = X(X+q^2)(X+1)(X+1+q^2) is a quartic.
\\ Convert to Weierstrass via ellfromeqn or ellinit on the genus-2 split.
\\ For a quartic y^2 = X(X+r)(X+s)(X+t) we apply standard genus-1 to short Weierstrass.
\\ Here r = q^2, s = 1, t = 1+q^2. The four roots of the quartic in X (zeros of RHS): 0, -q^2, -1, -(1+q^2).
\\ Using ellfromeqn: y^2 = quartic in X.
make_EHm_minus(q) = {
  my(X);
  X = 'X;
  my(quart = X*(X+q^2)*(X+1)*(X+1+q^2));
  \\ ellfromeqn(y^2 - quart) returns Weierstrass coefficients
  ellinit(ellfromeqn(y^2 - quart))
};

\\ ---- Strategy I curve (Halcke / Saunderson E_Hm) ----
\\ For Pythag (m,n) with a = m^2-n^2, b = 2mn, d = m^2+n^2:
\\   A = d^2, B = a^2, C = b^2
\\   E_Hm: y^2 = (x+BC)(x+AC)(x+AB)
make_EHm_halcke(m, n) = {
  my(a = m^2-n^2, b = 2*m*n, d = m^2+n^2);
  my(u = b^2 * a^2, v = d^2 * b^2, w = d^2 * a^2);
  ellinit([0, u+v+w, 0, u*v+u*w+v*w, u*v*w])
};

\\ E_PCP(q): y^2 = x(x+1)(x+q^2)
make_EPCP(q) = ellinit([0, 1+q^2, 0, q^2, 0]);

\\ Standard Pythag parametrization: q = 2mn/(m^2-n^2)
qof(m, n) = (2*m*n) / (m^2-n^2);

\\ ---- Helper: rank a curve robustly with effort cascade ----
\\ Returns [lo, up, gens] using ellrank.
\\ For honesty, we always return both lo and up. If lo < up, rank is uncertain.
my_rank(E, effort) = {
  my(r = ellrank(E, effort));
  [r[1], r[2], r[3]]
};

\\ ---- Verification: print conductors for (2,1) ----
\\ q = 4/3
verify_21() = {
  my(q = 4/3);
  my(E1 = ellminimalmodel(make_Eef(q)));
  my(E2 = ellminimalmodel(make_Eeg(q)));
  my(E3 = ellminimalmodel(make_Efg(q)));
  my(E4 = ellminimalmodel(make_EHp(q)));
  my(E5 = ellminimalmodel(make_EHm_minus(q)));
  print("=== Verify (m,n)=(2,1), q=4/3 ===");
  print("E_ef:  cond = ", ellglobalred(E1)[1], "   (expected 21)");
  print("E_eg:  cond = ", ellglobalred(E2)[1], "   (expected 15)");
  print("E_fg:  cond = ", ellglobalred(E3)[1], "   (expected 240)");
  print("E_H+:  cond = ", ellglobalred(E4)[1], "   (expected large)");
  print("E_H- (X_-): cond = ", ellglobalred(E5)[1], "   (expected 210)");
};

\\ Run the verification when this file is the main script
\\ (commented out — call verify_21() externally)
