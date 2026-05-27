\\ Verify that the 3 "fibrations" (pi_d, pi_e, pi_f) give the same Jacobian
\\ decomposition formulas at the same numerical q value.
\\
\\ V: a^2+b^2=d^2, b^2+c^2=e^2, a^2+c^2=f^2, a^2+b^2+c^2=g^2
\\
\\ pi_d: parameter q = b/a; a=1, b=q. Fiber in (c, e, f, g):
\\   c^2 + q^2 = e^2, c^2 + 1 = f^2, c^2 + 1 + q^2 = g^2
\\
\\ pi_f: parameter q = c/a; a=1, c=q. Fiber in (b, d, e, g):
\\   b^2 + q^2 = e^2, b^2 + 1 = d^2, b^2 + 1 + q^2 = g^2
\\   (with d, g, e named; this is c->b, e<->e, f->d. Same form by b<->c symmetry!)
\\
\\ pi_e: parameter q = c/b; b=1, c=q. Fiber in (a, d, f, g) using:
\\   a^2 + 1 = d^2  (from a^2+b^2=d^2)
\\   a^2 + q^2 = f^2  (from a^2+c^2=f^2)
\\   a^2 + 1 + q^2 = g^2  (from a^2+b^2+c^2=g^2)
\\   (face e: 1 + q^2 = e^2 is scalar — q must be Pythag — handled like pi_d's face d condition.)
\\
\\ In all 3 cases, the 3 fiber equations have the form:
\\   X^2 + Q^2 = Y^2, X^2 + 1 = Z^2, X^2 + 1 + Q^2 = W^2
\\ where X is the fiber-variable and Q = q is the parameter.

\\ Therefore the 5 elliptic factor curves are IDENTICAL as functions of q for all 3 fibrations.
\\ Let's verify with q = 4636/2277 (from (m,n)=(61,38)):

q = 4636/2277;
qsq = q^2;

\\ pi_d Jacobian factors:
E_ef = ellinit([0, -2*(1 + qsq), 0, (1 - qsq)^2, 0]);
E_eg = ellinit([0, -2*(1 + 2*qsq), 0, 1, 0]);
E_fg = ellinit([0, -2*(2 + qsq), 0, qsq^2, 0]);
\\ E_Hp: Y^2 = (X+qsq)(X+1)(X+1+qsq). Expand to standard form.
\\ a2 = qsq + 1 + (1+qsq) = 2 + 2*qsq
\\ a4 = qsq*1 + qsq*(1+qsq) + 1*(1+qsq) = qsq + qsq + qsq^2 + 1 + qsq = 1 + 3*qsq + qsq^2
\\ a6 = qsq*1*(1+qsq) = qsq + qsq^2
E_Hp = ellinit([0, 2 + 2*qsq, 0, 1 + 3*qsq + qsq^2, qsq + qsq^2]);

print("=== pi_d at q = 4636/2277 ===");
print("E_ef: j = ", ellj(E_ef));
print("E_eg: j = ", ellj(E_eg));
print("E_fg: j = ", ellj(E_fg));
print("E_Hp: j = ", ellj(E_Hp));

\\ pi_f at q' = same numerical value: by b<->c relabeling, the fiber equations are
\\   b^2 + q'^2 = e^2 (same form as c^2+q^2=e^2)
\\   b^2 + 1 = d^2   (same form as c^2+1=f^2)
\\   b^2 + 1 + q'^2 = g^2  (same form as c^2+1+q^2=g^2)
\\ So the Jacobian factors are LITERALLY identical (just rename labels).

\\ pi_e at q'' = same numerical value: a^2+1=d^2, a^2+q''^2=f^2, a^2+1+q''^2=g^2
\\ Same form again.

\\ Conclusion: at any numerical q, all 3 fibrations have isomorphic Jacobian decompositions.
\\ Verified by inspection of equations.

print("\n=== Conclusion ===");
print("pi_d, pi_e, pi_f all give the SAME 5 elliptic curves at the same numerical q.");
print("Hence rank computation is identical; the 'alternative fibration' offers no gain.");

quit;
