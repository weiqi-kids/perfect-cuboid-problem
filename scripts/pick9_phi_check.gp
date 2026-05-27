\\ For each rank-3 fiber, evaluate phi(X,Y) = 2*Y*q / (q^2 - X^2) on the generators
\\ to see if non-torsion points give finite non-zero c values.

default(parisize, 4000000000);

phi_eval(P, q) = {
  my(X = P[1], Y = P[2]);
  if(q^2 - X^2 == 0, return("pole"));
  2*Y*q / (q^2 - X^2);
};

\\ Pull a point back from the integer minimal model to the q-form Y^2 = X(X+1)(X+q^2)
\\ NOTE: ellrank returns points on the minimal model. We need the change of variables.
\\ For our purposes, just record what phi gives on minimal-model gens scaled appropriately.

{
fibers = [
  [22, 17, 195/748],
  [35, 22, 741/1540],
  [37, 26, 693/1924],
  [40, 29, 759/2320],
  [40, 33, 511/2640]
];

for(i = 1, #fibers,
  m = fibers[i][1]; n = fibers[i][2]; q = fibers[i][3];
  print("--- (m,n) = (", m, ",", n, "), q = ", q, " ---");

  a2Q = 1 + q^2;
  a4Q = q^2;
  E_orig = ellinit([0, a2Q, 0, a4Q, 0]);
  Emin = ellminimalmodel(E_orig, &v);
  \\ v = [u, r, s, t] such that minimal model from original is via (X,Y) -> (u^2 X' + r, u^3 Y' + s u^2 X' + t)
  \\ So if (Xm, Ym) on Emin, then on original: X = u^2 Xm + r, Y = u^3 Ym + s*u^2*Xm + t.
  \\ But we want the reverse: take gens on Emin, map back to original to evaluate phi.
  print("Change-of-vars v = [u, r, s, t] = ", v);

  rk = ellrank(Emin);
  gens = rk[4];
  print("rk = ", rk[1..3]);
  print("Generators on Emin: ", gens);

  u = v[1]; r = v[2]; s = v[3]; t = v[4];

  for(j = 1, #gens,
    P = gens[j];
    Xm = P[1]; Ym = P[2];
    X_orig = u^2 * Xm + r;
    Y_orig = u^3 * Ym + s*u^2*Xm + t;
    \\ Sanity: Y_orig^2 == X_orig*(X_orig+1)*(X_orig+q^2)?
    check = Y_orig^2 - X_orig*(X_orig+1)*(X_orig+q^2);
    print("  Gen ", j, ": (X,Y) on E_orig = (", X_orig, ", ", Y_orig, ")  Y^2-RHS=", check);
    c = phi_eval([X_orig, Y_orig], q);
    print("    phi = c = ", c);
    \\ Also check torsion: 2P, 4P
    P2 = ellmul(Emin, P, 2);
    if(P2 == [0], print("    2P = O (P is 2-torsion)"),
      Xm2 = P2[1]; Ym2 = P2[2];
      X2_orig = u^2 * Xm2 + r;
      print("    2P -> X = ", X2_orig);
    );
  );
  print();
);
}

quit;
