\\ Phase A.2: produce an INTEGER short Weierstrass model with full 2-tors rational integer roots.

default(parisize, 1500000000);
default(realprecision, 38);

E_Hm = ellinit([1, 0, 0, -4201713691887954766021162410, 103564307677747011646913552825626935447972]);
a1 = E_Hm.a1; a2 = E_Hm.a2; a3 = E_Hm.a3; a4 = E_Hm.a4; a6 = E_Hm.a6;

\\ Transformation: (x, y) -> (x, y - (a1 x + a3)/2).
\\ Then  Y^2 = x^3 + (a2 + a1^2/4) x^2 + (a4 + a1 a3/2) x + (a6 + a3^2/4)
\\ With a3 = 0:  Y^2 = x^3 + (a2 + 1/4) x^2 + a4 x + a6
\\ Substitute x = X/4, Y = Z/8:
\\   Z^2/64 = X^3/64 + (a2 + 1/4) X^2/16 + a4 X/4 + a6
\\   Z^2 = X^3 + 4(a2 + 1/4) X^2 + 16 a4 X + 64 a6
\\        = X^3 + (4 a2 + 1) X^2 + 16 a4 X + 64 a6

A2 = 4*a2 + 1;
A4 = 16*a4;
A6 = 64*a6;

print("Integer short Weierstrass (after substitution x=X/4, y -> (Z - X/4)/8):");
print("E': Z^2 = X^3 + (", A2, ") X^2 + (", A4, ") X + (", A6, ")");
print();

\\ Verify by ellinit
E_short = ellinit([0, A2, 0, A4, A6]);
print("E_short [a1..a6] = ", E_short[1..5]);
print("disc(E_short) = ", factor(abs(E_short.disc)));
print("j-invariant equal?  ", E_short.j == E_Hm.j);
print();

\\ 2-tors x-coords from cubic X^3 + A2 X^2 + A4 X + A6 = 0
cubic = 'X^3 + A2*'X^2 + A4*'X + A6;
fac = factor(cubic);
print("Factorization of X^3 + A2 X^2 + A4 X + A6:");
print(fac);
print();

\\ Extract integer roots
{
my(roots_int = []);
for(i = 1, matsize(fac)[1],
    pol = fac[i,1];
    if(poldegree(pol) == 1 && polcoeff(pol,1) == 1,
      r = -polcoeff(pol, 0);
      roots_int = concat(roots_int, [r]);
    );
);
print("Integer roots e_1, e_2, e_3 = ", roots_int);
print();

\\ Sort
roots_sorted = vecsort(roots_int);
e1 = roots_sorted[1]; e2 = roots_sorted[2]; e3 = roots_sorted[3];
print("e_1 = ", e1);
print("e_2 = ", e2);
print("e_3 = ", e3);
print("e_1 + e_2 + e_3 = ", e1+e2+e3, "  (should = -A2 = ", -A2, ")");
print("e_1*e_2 + e_1*e_3 + e_2*e_3 = ", e1*e2+e1*e3+e2*e3, "  (should = A4 = ", A4, ")");
print("e_1*e_2*e_3 = ", e1*e2*e3, "  (should = -A6 = ", -A6, ")");
print();

\\ Differences (needed for descent)
print("e_2 - e_1 = ", e2-e1);
print("  factored: ", factor(abs(e2-e1)));
print("e_3 - e_1 = ", e3-e1);
print("  factored: ", factor(abs(e3-e1)));
print("e_3 - e_2 = ", e3-e2);
print("  factored: ", factor(abs(e3-e2)));
print();

\\ Save for Phase B
write("/root/proof/perfect-cuboid-problem/scripts/4-descent/EHm_short_data.gp",
  "\\\\ Short Weierstrass data for E_Hm (61,38)\nA2_short = ", A2,
  ";\nA4_short = ", A4, ";\nA6_short = ", A6, ";\n",
  "e1_short = ", e1, ";\ne2_short = ", e2, ";\ne3_short = ", e3, ";\n");
}

quit;
