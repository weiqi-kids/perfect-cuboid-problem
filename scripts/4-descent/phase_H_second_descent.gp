\\ Phase H: Second descent on Cover #2 of E_Hm.
\\ Cover #2: y^2 = 4 x^4 - 204082277351567 x^2 + 3334014193367081497693717504
\\
\\ Since q(x) is biquadratic (only even powers of x), the cover has an
\\ involution x -> -x, so it covers an elliptic curve E' birationally:
\\   Let u = x^2, then y^2 = 4 u^2 - 204082277351567 u + 3334014193367081497693717504
\\   This is a conic in (u, y). It has rational points (e.g. u=0, y=±57740923038752).
\\
\\ The Jacobian J(C_2) of C_2 is an elliptic curve. For biquadratic y^2 = Au^2 + Bu + C
\\ (with u = x^2), the Jacobian is computed via the standard map.
\\
\\ For y^2 = a*x^4 + b*x^2 + c (no odd-power terms), the curve C: y^2 = a*x^4 + b*x^2 + c is genus 1.
\\ Its Jacobian E' is: Y^2 = X^3 + b*X^2 + a*c*X*4 ... actually use ellfromeqn.
\\
\\ For a general quartic y^2 = f(x), the Jacobian can be obtained via PARI's
\\ ellfromj or by Connell's formula:
\\   For y^2 = a4 x^4 + a3 x^3 + a2 x^2 + a1 x + a0:
\\   Jacobian E: Y^2 = X^3 - (I/3) X - J/27   (?)
\\   Cassels: y^2 = quartic => Jac has c4 = I, c6 = -J/2 in some normalization.

default(parisize, 1500000000);
default(realprecision, 38);

\\ Cover #2 quartic
A4 = 4;
A3 = 0;
A2 = -204082277351567;
A1 = 0;
A0 = 3334014193367081497693717504;

\\ Invariants of the quartic (Cassels notation):
\\   I = 12 a4 a0 - 3 a3 a1 + a2^2
\\   J = 72 a4 a2 a0 - 27 a4 a1^2 - 27 a3^2 a0 + 9 a3 a2 a1 - 2 a2^3
\\ Then Jacobian E_J has c4 = I, c6 = -J/2 (up to twists).
\\ The "naive Jacobian" model is y^2 = x^3 - 27 I x - 27 J  (using the form y^2 = x^3 - c4/48 x - c6/864 ...).

I_inv = 12 * A4 * A0 - 3 * A3 * A1 + A2^2;
J_inv = 72 * A4 * A2 * A0 - 27 * A4 * A1^2 - 27 * A3^2 * A0 + 9 * A3 * A2 * A1 - 2 * A2^3;

print("Quartic of Cover #2:");
print("  a4 = ", A4, ", a3 = ", A3, ", a2 = ", A2, ", a1 = ", A1, ", a0 = ", A0);
print("  Invariant I = ", I_inv);
print("  Invariant J = ", J_inv);
print();

\\ Jacobian model: Y^2 = X^3 - 27 I X - 27 J (over Q)
\\ This is the universal model. Construct as elliptic curve.
E_jac = ellinit([0, 0, 0, -27 * I_inv, -27 * J_inv]);
print("Jacobian E_jac (naive): y^2 = x^3 + ", -27*I_inv, " x + ", -27*J_inv);
print("Discriminant: ", E_jac.disc);
print("j-invariant: ", E_jac.j);
print();

\\ Minimal model (try to get a better integer model)
print("Trying ellminimalmodel:");
E_jac_min = ellminimalmodel(E_jac);
print("Minimal model coeffs: ", E_jac_min[1..5]);
print("Disc: ", E_jac_min.disc);
print("Conductor: ");
N = ellglobalred(E_jac_min)[1];
print("  N = ", N);
print("  N factored = ", factor(N));
print();

\\ Try ellrank on the Jacobian
print("Computing ellrank(E_jac_min, 5) ...");
t0 = getwalltime();
r5 = ellrank(E_jac_min, 5);
t1 = getwalltime();
print("ellrank(E_jac_min, 5) = ", r5);
print("Wall: ", (t1 - t0)/1000.0, " s");
print();

\\ Higher effort if rank is uncertain
if(r5[1] < r5[2],
  print("Trying ellrank(E_jac_min, 7) ...");
  t0 = getwalltime();
  r7 = ellrank(E_jac_min, 7);
  t1 = getwalltime();
  print("ellrank(E_jac_min, 7) = ", r7);
  print("Wall: ", (t1 - t0)/1000.0, " s");
  print();
);

\\ Torsion
print("Torsion subgroup: ");
T = elltors(E_jac_min);
print("  Order = ", T[1]);
print("  Structure = ", T[2]);
print("  Generators = ", T[3]);
print();

\\ Root number for parity
print("Root number: ", ellrootno(E_jac_min));
print();

\\ Note: rank of Jac(C_2). If rk = 0, then C_2 has only finitely many rational points
\\ (by Chabauty/Coleman bounds since genus 1 and Mordell-Weil is finite).
\\ But C_2 is genus 1 (it IS its own Jacobian as a torsor); the relevant question is
\\ whether C_2 has any rational point at all.
\\
\\ Since Cover #2 has rational point (x=0, y=±57740923038752), it lifts as a Q-point.
\\ The Jacobian's rank tells us about the size of the Mordell-Weil group of the Jacobian,
\\ which is isomorphic to the group of Q-points on C_2 if C_2 has a rational point.
\\
\\ INTERPRETATION:
\\   The 2-Selmer class of Cover #2 maps to the order-2 torsion class of E_Hm
\\   (the 2-torsion point (e2, 0)). So Cover #2's Selmer class IS the image
\\   of a torsion point, not a Sha class. Hence rk(Jac(C_2)) provides info
\\   about Mordell-Weil of E_Hm itself, specifically the (Z/2)^? part.
\\
\\   If rk(Jac(C_2)) = rk(E_Hm), this confirms what we already know.
\\
\\ For a more decisive test, we want to do this on Cover #3 (no rational point, ambiguous).
\\ But Cover #3 lacks the biquadratic symmetry.

print();
print("===========================================");
print("Also: try second descent on Cover #3:");
print("===========================================");
\\ Cover #3: 57671190729 x^4 + 7637223231630 x^3 + 369980514571393 x^2 - 2622679029765680 x + 6801085520209984
A4_3 = 57671190729;
A3_3 = 7637223231630;
A2_3 = 369980514571393;
A1_3 = -2622679029765680;
A0_3 = 6801085520209984;

I3 = 12 * A4_3 * A0_3 - 3 * A3_3 * A1_3 + A2_3^2;
J3 = 72 * A4_3 * A2_3 * A0_3 - 27 * A4_3 * A1_3^2 - 27 * A3_3^2 * A0_3 + 9 * A3_3 * A2_3 * A1_3 - 2 * A2_3^3;
print("I(C_3) = ", I3);
print("J(C_3) = ", J3);

E_jac3 = ellinit([0, 0, 0, -27 * I3, -27 * J3]);
print("Disc = ", E_jac3.disc);
E_jac3_min = ellminimalmodel(E_jac3);
print("Min model: ", E_jac3_min[1..5]);
N3 = ellglobalred(E_jac3_min)[1];
print("Conductor: ", factor(N3));
print();
print("Computing ellrank(E_jac3_min, 5) ...");
t0 = getwalltime();
r5_3 = ellrank(E_jac3_min, 5);
t1 = getwalltime();
print("ellrank(E_jac3_min, 5) = ", r5_3);
print("Wall: ", (t1 - t0)/1000.0, " s");
print("Torsion: ", elltors(E_jac3_min));

\\ Cover #4
print();
print("Also Cover #4:");
A4_4 = 233255117704;
A3_4 = -18448548462004;
A2_4 = 215570186881597;
A1_4 = 2581276743401202;
A0_4 = 4411951949354301;
I4 = 12 * A4_4 * A0_4 - 3 * A3_4 * A1_4 + A2_4^2;
J4 = 72 * A4_4 * A2_4 * A0_4 - 27 * A4_4 * A1_4^2 - 27 * A3_4^2 * A0_4 + 9 * A3_4 * A2_4 * A1_4 - 2 * A2_4^3;
E_jac4 = ellinit([0, 0, 0, -27 * I4, -27 * J4]);
E_jac4_min = ellminimalmodel(E_jac4);
print("Min model: ", E_jac4_min[1..5]);
N4 = ellglobalred(E_jac4_min)[1];
print("Conductor: ", factor(N4));
print("Computing ellrank(E_jac4_min, 5) ...");
t0 = getwalltime();
r5_4 = ellrank(E_jac4_min, 5);
t1 = getwalltime();
print("ellrank(E_jac4_min, 5) = ", r5_4);
print("Wall: ", (t1 - t0)/1000.0, " s");
print("Torsion: ", elltors(E_jac4_min));

print();
print("===========================================");
print("Phase H summary:");
print("===========================================");
print("rk J(C_2) bounds: ", r5);
print("rk J(C_3) bounds: ", r5_3);
print("rk J(C_4) bounds: ", r5_4);
print();
print("Theory: C_α is a torsor under E_Hm, so Jac(C_α) is isomorphic to E_Hm (over Q-bar).");
print("However, the J-invariant is preserved, so j(Jac(C_α)) = j(E_Hm) always.");
print("Conductors should equal N(E_Hm) (up to local twist).");
print();
print("Useful fact: if Jac(C_α) is Q-isomorphic to E_Hm, then ellrank(J(C_α)) = ellrank(E_Hm).");
print("Twist analysis: J(C_α) is a 2-isogenous quadratic twist of E_Hm.");

quit;
