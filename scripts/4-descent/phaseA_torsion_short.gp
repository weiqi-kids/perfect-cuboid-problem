\\ Phase A: minimal model, torsion structure, short Weierstrass for E_Hm,
\\ extract (e1, e2, e3) if full 2-torsion is rational.

default(parisize, 1500000000);
default(realprecision, 38);

E_Hm = ellinit([1, 0, 0, -4201713691887954766021162410, 103564307677747011646913552825626935447972]);

print("===========================================");
print("Phase A: Minimal model + torsion + e_i");
print("===========================================");
print();

print("E_Hm coefficients [a1,a2,a3,a4,a6] = ", E_Hm[1..5]);
print();

\\ Minimal model
Emin = ellminimalmodel(E_Hm);
print("Minimal model [a1,a2,a3,a4,a6] = ", Emin[1..5]);
print("Conductor   N = ", ellglobalred(Emin)[1]);
print("Discriminant factored:");
print("  disc(Emin) = ", factor(abs(Emin.disc)));
print();

\\ Torsion
T = elltors(Emin);
print("Torsion: order = ", T[1], "  structure = ", T[2]);
print("  generators (full): ", T[3]);
print();

\\ Convert to y^2 = x^3 + A2 x^2 + A4 x + A6 (kill a1, a3) via b2, b4, b6
\\ y |-> y - (a1 x + a3)/2.  This gives Y^2 = X^3 + (b2/4) X^2 + (b4/2) X + (b6/4)
\\ but we want INTEGER form Y^2 = 4X^3 + b2 X^2 + 2 b4 X + b6, or scaled.
\\ Standard: y^2 = x^3 + b2/4 x^2 + b4/2 x + b6/4 after y -> y - (a1 x + a3)/2.
\\ Multiply by 4 we get (2y)^2 = 4x^3 + b2 x^2 + 2 b4 x + b6.

b2 = Emin.b2;
b4 = Emin.b4;
b6 = Emin.b6;
b8 = Emin.b8;

print("b2 = ", b2);
print("b4 = ", b4);
print("b6 = ", b6);
print();

\\ Now do x = X/4, y = Y/8 trick: classical "depressed" form:
\\ Y^2 = X^3 + a X + b where  X = 4*x + b2/3 etc.
\\ Easier: factor f(x) = x^3 + (b2/4) x^2 + (b4/2) x + b6/4 over Q.

print("Cubic in 2-torsion x-coord: x^3 + (b2/4) x^2 + (b4/2) x + b6/4 = 0");
print("Equivalently, 4 x^3 + b2 x^2 + 2 b4 x + b6 = 0");
print();

f_2tors = 4*'x^3 + b2*'x^2 + 2*b4*'x + b6;
print("f(x) = ", f_2tors);
print();

\\ Factor over Q
fac = factor(f_2tors);
print("Factorization over Q:");
print(fac);
print();

\\ Check rational roots
roots_q = polrootsmod(f_2tors, 0);  \\ won't work for Q; use roots over real then test rationality
\\ Instead, factor:
my(deg1factors = []);
{ for(i = 1, matsize(fac)[1],
    pol = fac[i,1];
    if(poldegree(pol) == 1,
      \\ root is -constant/leading
      r = -polcoeff(pol, 0) / polcoeff(pol, 1);
      deg1factors = concat(deg1factors, [r]);
    );
  );
}
print("Rational roots of 4 x^3 + b2 x^2 + 2 b4 x + b6 = ", deg1factors);
print();

\\ If 3 rational roots, we have FULL 2-torsion. Get e1, e2, e3.
\\ Now, these are roots in the (1/2-shifted) coordinate. The actual 2-torsion
\\ of E_Hm has x-coords as the roots of the 2-division polynomial.

\\ Standard way: 2-division polynomial of E
psi2 = elldivpol(Emin, 2);
print("psi_2(x) = ", psi2);
print();
psi2_fac = factor(psi2);
print("psi_2 factorization:");
print(psi2_fac);
print();

\\ Read rational roots from factorization
{
my(twotors_x = []);
for(i = 1, matsize(psi2_fac)[1],
    pol = psi2_fac[i,1];
    if(poldegree(pol) == 1,
      r = -polcoeff(pol, 0) / polcoeff(pol, 1);
      twotors_x = concat(twotors_x, [r]);
    );
);
print("Rational 2-torsion x-coordinates: ", twotors_x);
print("(These are e_1, e_2, e_3 in the form (X-e1)(X-e2)(X-e3) after kill a1)");
}

\\ Validate: substitute back
\\ E_Hm: y^2 + a1 x y = x^3 + a2 x^2 + a4 x + a6 (a3=0).
\\ y = -a1 x/2  =>  a1^2 x^2 / 4 = x^3 + ...
\\ So:  x^3 + (a2 + a1^2/4) x^2 + a4 x + a6 = 0
\\ Multiplied by 4:  4 x^3 + (4 a2 + a1^2) x^2 + 4 a4 x + 4 a6
a1 = Emin.a1; a2 = Emin.a2; a3 = Emin.a3; a4 = Emin.a4; a6 = Emin.a6;
g = 4*'x^3 + (4*a2 + a1^2)*'x^2 + 4*a4*'x + 4*a6;
print("Sanity (should be == b2 etc): ", g);
print();

quit;
