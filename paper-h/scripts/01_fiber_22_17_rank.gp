/* 01_fiber_22_17_rank.gp
   Certify the Mordell-Weil rank of the perfect-cuboid fiber E_PCP(q) for the
   Pythagorean parameter (m,n)=(22,17), and exhibit three independent points
   with a nonsingular height-pairing (regulator != 0).

   Parametrization. For coprime opposite-parity m>n>=1 set
       a = m^2 - n^2,  b = 2 m n,  q = a/b   (the leg ratio of a Pythagorean triple).
   The per-fiber curve is  E_PCP(q): Y^2 = X (X+1)(X+q^2).
   Scaling X = x/b^2, Y = y/b^3 gives the Q-isomorphic integral model
       E(m,n): y^2 = x (x + b^2)(x + a^2) = x^3 + (a^2+b^2) x^2 + (a b)^2 x.

   PARI/GP 2.15.4.
*/
default(parisize, 4000000000);
default(realprecision, 38);

m = 22; n = 17;
a = m^2 - n^2;
b = 2*m*n;
q = a/b;
print("(m,n) = (", m, ",", n, ")");
print("a = m^2-n^2 = ", a, ",  b = 2mn = ", b, ",  q = a/b = ", q);

E = ellinit([0, a^2 + b^2, 0, a^2*b^2, 0]);
Emin = ellminimalmodel(E);
gr  = ellglobalred(Emin);
print("minimal model a-invariants: [", Emin.a1, ",", Emin.a2, ",", Emin.a3, ",", Emin.a4, ",", Emin.a6, "]");
print("conductor N = ", gr[1]);
print("conductor factorization: ", factor(gr[1]));
print("torsion structure: ", elltors(Emin));

print("");
print("=== ellrank on the minimal model ===");
r0 = ellrank(Emin, 0);
print("ellrank(Emin, 0): lo = ", r0[1], ",  hi = ", r0[2]);
print("   gens = ", r0[4]);

r1 = ellrank(Emin, 1);
print("ellrank(Emin, 1): lo = ", r1[1], ",  hi = ", r1[2]);
print("   gens = ", r1[4]);

G = r1[4];
print("");
print("=== verify each generator lies on Emin ===");
for(i = 1, #G, print("   P", i, " = ", G[i], "   on curve: ", ellisoncurve(Emin, G[i])));

print("");
print("=== height-pairing matrix and regulator ===");
H = ellheightmatrix(Emin, G);
print("height pairing matrix H =");
print(H);
reg = matdet(H);
print("regulator (det H) = ", reg);
print("numeric rank of H (tol 1e-10): ", matrank(H * 1.0));

print("");
print("=== canonical heights of generators ===");
for(i = 1, #G, print("   hhat(P", i, ") = ", ellheight(Emin, G[i])));

print("");
print("=== CONCLUSION ===");
cert = (r1[1] == r1[2]) && (r1[1] == 3) && (abs(reg) > 1e-10);
if(cert, print("rank E(22,17) = 3 CERTIFIED (lo=hi=3); regulator nonzero => 3 generators independent."), print("NOT fully certified: lo=", r1[1], " hi=", r1[2], " reg=", reg));
quit;
