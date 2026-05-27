\\ Independent verification of Track A's new generator on (88,35).

default(parisize, 500000000);
default(realprecision, 60);

mm = 88; nn = 35;
uu = 2*mm*nn;
vv = mm^2 - nn^2;
qq = vv/uu;
print("(m,n) = (", mm, ",", nn, "), u=", uu, " v=", vv, " q=", vv, "/", uu);

X = 392040;
Y = 25389425160;

rhs = X * (X + uu^2) * (X + vv^2);
print("rhs == Y^2 ? ", rhs == Y^2);

E_int = ellinit([0, uu^2 + vv^2, 0, (uu*vv)^2, 0]);
print("ellisoncurve(E_int, P_int) = ", ellisoncurve(E_int, [X, Y]));
print("ellorder = ", ellorder(E_int, [X, Y]));
print("ellheight = ", ellheight(E_int, [X, Y]));

xq = X / uu^2;
yq = Y / uu^3;
print("x_q = ", xq);
print("y_q = ", yq);

E_q = ellinit([0, 1 + qq^2, 0, qq^2, 0]);
print("ellisoncurve(E_q, P_q) = ", ellisoncurve(E_q, [xq, yq]));

print("q^2 - xq^2 = ", qq^2 - xq^2);
cc = 2*qq*yq / (qq^2 - xq^2);
F3 = cc^2 + 1 + qq^2;
print("c(P) = ", cc);
print("F3 = ", F3);
print("issquare(F3) = ", issquare(F3));
print("F3 num = ", numerator(F3));
print("F3 den = ", denominator(F3));

\\ Independence vs Track D
Emin = ellminimalmodel(E_q, &V);
print("Emin = ", Emin[1..5]);
P_min_new = ellchangepoint([xq, yq], V);
print("P_min_new = ", P_min_new);
print("ellisoncurve(Emin, P_min_new) = ", ellisoncurve(Emin, P_min_new));

trackD_g1 = [94215620, 912659713370];
trackD_g2 = [-2343500920/841, 4930454141290/24389];
trackD_g3 = [3564505145/64, 211583341526545/512];

\\ pairing helper
pair(P, Q) = 0.5 * (ellheight(Emin, elladd(Emin, P, Q)) - ellheight(Emin, P) - ellheight(Emin, Q));

h1 = ellheight(Emin, trackD_g1);
h2 = ellheight(Emin, trackD_g2);
h3 = ellheight(Emin, trackD_g3);
h_new = ellheight(Emin, P_min_new);
print("h(G1) = ", h1);
print("h(G2) = ", h2);
print("h(G3) = ", h3);
print("h(P_new) = ", h_new);

\\ 4x4 height pairing matrix [G1 G2 G3 P_new]
M = matrix(4, 4);
gens = [trackD_g1, trackD_g2, trackD_g3, P_min_new];
for(i = 1, 4, for(j = 1, 4,
  if(i == j, M[i,j] = ellheight(Emin, gens[i]), M[i,j] = pair(gens[i], gens[j]))
));
print("\nHeight pairing matrix (G1, G2, G3, P_new):");
print(M);
print("det(M) = ", matdet(M));

\\ Try expressing P_new as Z-combination of G1, G2, G3 (using nearest-vector heuristic)
print("\nTrying small Z-linear combinations:");
N3 = matrix(3, 3, i, j, if(i == j, ellheight(Emin, gens[i]), pair(gens[i], gens[j])));
v = vector(3, j, pair(P_min_new, gens[j]));
\\ Find a such that |P_new - a1 G1 - a2 G2 - a3 G3| has small height
print("3x3 sub-regulator det = ", matdet(N3));
sol = matsolve(N3, v~);
print("Best real-valued a (from height pairing): ", sol~);
\\ Round each component to small integer near sol
ai = vector(3, i, round(sol[i]));
print("Nearest integer ai = ", ai);
Q = ellmul(Emin, gens[1], ai[1]);
Q = elladd(Emin, Q, ellmul(Emin, gens[2], ai[2]));
Q = elladd(Emin, Q, ellmul(Emin, gens[3], ai[3]));
diff = ellsub(Emin, P_min_new, Q);
print("P_new - (a1 G1 + a2 G2 + a3 G3) = ", diff);
print("height(diff) = ", ellheight(Emin, diff));
print("ellorder(Emin, diff) = ", ellorder(Emin, diff));

quit;
