\\ Independent verification of Track A's new generator on (88,35).
\\ P = (392040, 25389425160) on integer model y^2 = x(x+u^2)(x+v^2)
\\ with u = 2*88*35 = 6160, v = 88^2 - 35^2 = 6519.

default(parisize, 500000000);
default(realprecision, 60);

mm = 88; nn = 35;
uu = 2*mm*nn;
vv = mm^2 - nn^2;
qq = vv/uu;
print("(m,n) = (", mm, ",", nn, ")");
print("u = ", uu, ", v = ", vv, ", q = ", vv, "/", uu, " = ", qq*1.0);

X = 392040;
Y = 25389425160;

rhs = X * (X + uu^2) * (X + vv^2);
print("\nrhs = X*(X+u^2)*(X+v^2) = ", rhs);
print("Y^2 = ", Y^2);
print("rhs == Y^2 ? ", rhs == Y^2);

\\ Build the integer model E_int : y^2 = x^3 + (u^2+v^2)x^2 + u^2*v^2*x
E_int = ellinit([0, uu^2 + vv^2, 0, (uu*vv)^2, 0]);
P_int = [X, Y];
print("ellisoncurve(E_int, [X,Y]) = ", ellisoncurve(E_int, P_int));
print("ellorder = ", ellorder(E_int, P_int));
print("ellheight = ", ellheight(E_int, P_int));

\\ Map to q-model
\\ Integer model: y^2 = x(x+u^2)(x+v^2), Substituting x = u^2 X', y = u^3 Y':
\\   u^6 Y'^2 = u^2 X' (u^2 X' + u^2)(u^2 X' + v^2)
\\            = u^4 X' (X' + 1)(u^2 X' + v^2)
\\   So Y'^2 = X'(X'+1)(X' + v^2/u^2) = X'(X'+1)(X' + q^2)
\\   Hence x_q = X/u^2, y_q = Y/u^3.
xq = X / uu^2;
yq = Y / uu^3;
print("\nq-model: x_q = ", xq, ", y_q = ", yq);

E_q = ellinit([0, 1 + qq^2, 0, qq^2, 0]);
print("ellisoncurve(E_q, [x_q, y_q]) = ", ellisoncurve(E_q, [xq, yq]));

\\ Face-3 condition: c(P) = 2 q y_q / (q^2 - x_q^2), F3 = c^2 + 1 + q^2
if(qq^2 - xq^2 == 0,
  print("\nPOLE: q^2 - x_q^2 = 0"); quit
);
cc = 2*qq*yq / (qq^2 - xq^2);
F3 = cc^2 + 1 + qq^2;
print("\nc(P) = ", cc);
print("F3 = c^2 + 1 + q^2 = ", F3);
print("F3 numerator = ", numerator(F3));
print("F3 denominator = ", denominator(F3));
print("issquare(F3) = ", issquare(F3));

\\ Decompose F3
print("\nfactor numerator = ", factor(numerator(F3)));
print("factor denominator = ", factor(denominator(F3)));

\\ Compare against the 3 known Track D generators on (88,35) — is this new gen independent?
\\ Track D iso[1] gens (E_PCP minimal model coords): need transformation to integer model.
\\ Or compute heights of P relative to known generators.
print("\n--- Independence check vs Track D generators ---");
\\ Build E in PARI's minimal form for direct compare:
Emin = ellminimalmodel(E_q, &V);
print("Minimal model: ", Emin[1..5]);
print("V (q -> min) = ", V);
\\ Map our P_q to Emin
P_min_new = ellchangepoint([xq, yq], V);
print("Our new P in Emin coords = ", P_min_new);
print("ellisoncurve(Emin, ...) = ", ellisoncurve(Emin, P_min_new));

\\ Track D gens on (88,35) in Emin coords:
{ trackD_gens = [
  [94215620, 912659713370],
  [-2343500920/841, 4930454141290/24389],
  [3564505145/64, 211583341526545/512]
]; }
print("\nTrack D height matrix:");
for(k = 1, #trackD_gens,
  hk = ellheight(Emin, trackD_gens[k]);
  print("  G", k, " height = ", hk);
);

\\ Compute height of new point
h_new = ellheight(Emin, P_min_new);
print("h(P_new) = ", h_new);

\\ Compute height pairing matrix of [G1, G2, G3, P_new]
print("\n4x4 height pairing matrix:");
M = matrix(4, 4, i, j,
  if(i == 4 && j == 4,
    ellheight(Emin, P_min_new),
    if(i == 4,
      0.5*(ellheight(Emin, elladd(Emin, P_min_new, trackD_gens[j])) - ellheight(Emin, P_min_new) - ellheight(Emin, trackD_gens[j])),
      if(j == 4,
        0.5*(ellheight(Emin, elladd(Emin, P_min_new, trackD_gens[i])) - ellheight(Emin, P_min_new) - ellheight(Emin, trackD_gens[i])),
        if(i == j,
          ellheight(Emin, trackD_gens[i]),
          0.5*(ellheight(Emin, elladd(Emin, trackD_gens[i], trackD_gens[j])) - ellheight(Emin, trackD_gens[i]) - ellheight(Emin, trackD_gens[j]))
        )
      )
    )
  )
);
print(M);
print("det(M) = ", matdet(M));
print("(if det != 0, the 4 points are independent ⇒ rank ≥ 4 contradiction with effort-5 [3,3])");
print("(if det == 0, the new point lies in the lattice spanned by G1,G2,G3 — as expected)");

quit;
