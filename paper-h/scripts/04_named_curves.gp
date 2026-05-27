/* 04_named_curves.gp
   Identify the named elliptic curves arising in the project's reformulation
   catalogue, and record the basic geometry of the per-fiber family.

   (i)  E_PCP geometric data: the universal curve E_PCP(q): Y^2=X(X+1)(X+q^2)
        over Q(q). We record the discriminant and c4 as polynomials in q^2,
        confirming the I4(0),I2(1),I2(-1),I4(infty) singular fibers and the
        Z/4 x Z/2 generic torsion (so the family is a rational elliptic surface,
        generic Mordell-Weil rank 0).
   (ii) Saunderson "cleanest formulation" curve:  the project records the
        PCP-on-Saunderson squareness condition reducing to a curve identified
        as Cremona 160a2, rank 1.  We build E: y^2 = x^3 + x^2 - x + 15 and run
        ellidentify + ellrank.
   (iii) The rank-0 cover 80a1 (the auxiliary X_- curve y^2=x^3-36x^2+320x).
   (iv) Express the three (22,17) generators in the q-fiber coordinate
        (X,Y) = (x/b^2, y/b^3) with q=a/b.

   PARI/GP 2.15.4.
*/
default(parisize, 4000000000);
default(realprecision, 30);

print("=== (i) E_PCP(q) universal geometry ===");
\\ work symbolically in t = q^2
E0 = ellinit([0, 1 + 't, 0, 't, 0]);     \\ Y^2 = X(X+1)(X+t), t = q^2
print("E_PCP with t=q^2: a-invariants [0, 1+t, 0, t, 0]");
print("discriminant Delta(t) = ", E0.disc, "   (= 16 q^4 (q^2-1)^2 with t=q^2)");
print("c4(t) = ", E0.c4, "   (= 16(q^4 - q^2 + 1) with t=q^2)");

print("");
print("=== (ii) Saunderson cleanest-formulation curve ===");
S = ellinit([0, 1, 0, -1, 15]);          \\ y^2 = x^3 + x^2 - x + 15
print("y^2 = x^3 + x^2 - x + 15");
print("conductor: ", ellglobalred(S)[1]);
id = ellidentify(S);
print("ellidentify (Cremona label): ", id[1][1]);
rs = ellrank(S, 1);
print("ellrank: lo=", rs[1], " hi=", rs[2], "  generators=", rs[4]);

print("");
print("=== (iii) auxiliary rank-0 cover 80a1 (X_-) ===");
X = ellinit([0, -36, 0, 320, 0]);        \\ y^2 = x^3 - 36 x^2 + 320 x
print("y^2 = x^3 - 36 x^2 + 320 x");
print("conductor: ", ellglobalred(X)[1]);
idX = ellidentify(X);
print("ellidentify (Cremona label): ", idX[1][1]);
rX = ellrank(X, 1);
print("ellrank: lo=", rX[1], " hi=", rX[2]);

print("");
print("=== (iv) (22,17) generators in q-fiber coordinates ===");
m = 22; n = 17; a = m^2 - n^2; b = 2*m*n; q = a/b;
print("q = ", q, "  (q^2 = ", q^2, ")");
\\ Run ellrank on the RAW integral model y^2 = x(x+b^2)(x+a^2); its generators
\\ map to E_PCP(q) by X = x/b^2, Y = y/b^3 (no minimal-model rescaling needed).
Eraw = ellinit([0, a^2 + b^2, 0, a^2*b^2, 0]);
rr = ellrank(Eraw, 1);
print("ellrank on raw model: lo=", rr[1], " hi=", rr[2]);
gens = rr[4];
EP = ellinit([0, 1 + q^2, 0, q^2, 0]);   \\ E_PCP(q): Y^2 = X(X+1)(X+q^2)
qg = vector(#gens, i, [gens[i][1]/b^2, gens[i][2]/b^3]);
{
for(i = 1, #gens,
  print("   Q", i, " = (", qg[i][1], ", ", qg[i][2], ")   on E_PCP(q): ", ellisoncurve(EP, qg[i]))
);
}
print("regulator on E_PCP(q): ", matdet(ellheightmatrix(EP, qg)));
quit;
