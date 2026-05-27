\\ Sanity check the whole chain.

\\ 1. Pick t = 0. Compute Z, w, q_plus, s, and check.
t0 = 0;
Z0 = -2*(t0+3)/((t0-1)*(t0+1));
w0 = t0*Z0 + 1;
print("t = ", t0);
print("Z = ", Z0);
print("w = ", w0);
print("w^2 - (Z^2 - 6Z + 1) = ", w0^2 - (Z0^2 - 6*Z0 + 1));

q_plus0 = 16*(t0+1)^2 / ((t0-1)^2 * (t0+3)^2);
print("q_plus = ", q_plus0);
s0 = 4*(t0+1)/((t0-1)*(t0+3));
print("s = ", s0);
print("s^2 = ", s0^2);

\\ Verify G1(q_plus * Z) = 0
q = q_plus0; Z_val = Z0; X_val = q*Z_val;
print("X = q*Z = ", X_val);
G1val = X_val^4 - 4*q*X_val^3 - (4*q^3 + 2*q^2 + 4*q)*X_val^2 - 4*q^3*X_val + q^4;
print("G1(X, q) = ", G1val);

\\ Verify 1 + q^2 = 1 + s^4
print("1 + q^2 = ", 1 + q^2);
print("1 + s^4 = ", 1 + s0^4);
print("Is 1 + q^2 a square? issquare(...) ", issquare(1 + q^2));
print("");

\\ Try t = 2:
t0 = 2;
Z0 = -2*(t0+3)/((t0-1)*(t0+1));
w0 = t0*Z0 + 1;
print("t = ", t0);
print("Z = ", Z0, ", w = ", w0);
print("w^2 - (Z^2-6Z+1) = ", w0^2 - (Z0^2 - 6*Z0 + 1));
q_plus0 = 16*(t0+1)^2 / ((t0-1)^2 * (t0+3)^2);
print("q_plus = ", q_plus0);
print("1 + q^2 = ", 1 + q_plus0^2);
print("Is 1 + q^2 a square? ", issquare(1 + q_plus0^2));
\\ Verify it's not a square - q_plus = 16*9/(1*25) = 144/25
\\ 1 + (144/25)^2 = 1 + 20736/625 = (625 + 20736)/625 = 21361/625
\\ 21361 = ? not a perfect square. sqrt(21361) ~ 146.16
print("21361 = ", factor(21361));

\\ Try t = 3:
t0 = 3;
q_plus0 = 16*(t0+1)^2 / ((t0-1)^2 * (t0+3)^2);
print("");
print("t = ", t0, ", q_plus = ", q_plus0);
print("1 + q^2 = ", 1 + q_plus0^2);
print("issquare? ", issquare(1 + q_plus0^2));

\\ Now verify Fermat's claim: u^2 = s^4 + 1 has no rational solution with s != 0.
\\ This is provable by 2-descent on elliptic curve y^2 = x^3 - x (congruent to s^4 + 1 = u^2 via standard transformations).
\\ Equivalently, the elliptic curve E: y^2 = x^4 + 1 has rank 0 over Q with only torsion y = ±1, x = 0.
\\
\\ This is Fermat's "right triangles" theorem -- one of his proofs. Or:
\\ The curve C: u^2 = s^4 + 1 over Q.
\\ Equivalent to "no four squares in AP except trivial" (Fermat).
\\ Mordell's book "Diophantine Equations" gives full proof p. 21-23 or so.
\\ Or: a^4 + b^4 = c^2 has only trivial solutions (Fermat).
\\ Setting (a,b,c) = (1, s, u) gives s^4 + 1 = u^2 with only s = 0.

\\ Verify computationally a few cases:
print("");
print("Verifying u^2 = s^4 + 1 has no small rational solution:");
{
for(num = 1, 50,
  for(den = 1, 50,
    if(gcd(num, den) == 1,
      s2 = (num/den)^4;
      val = 1 + s2;
      if(issquare(val), print("FOUND: s = ", num/den, ", u^2 = ", val));
    );
  );
);
}
print("(no output above = no solutions found)");

\\ Symbolic confirmation: the curve u^2 = s^4 + 1 is birational to the elliptic curve
\\ E: Y^2 = X^3 + 4X via standard transformations. PARI:
E_fermat = ellinit([0, 0, 0, 4, 0]);  \\ y^2 = x^3 + 4x
print("");
print("E: y^2 = x^3 + 4x");
print("Conductor: ", ellglobalred(E_fermat)[1]);
print("Analytic rank: ", ellanalyticrank(E_fermat)[1]);
print("Torsion: ", elltors(E_fermat));
\\ This is curve 32a, rank 0. So u^2 = s^4 + 1 has only finite rational points -- precisely the
\\ ones corresponding to torsion, all giving s = 0 (Fermat).

quit;
