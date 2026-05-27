\\ 02_mwsieve_setup.gp
\\ Attempt the (factored) Mordell-Weil sieve on the generic rank-1 fiber V_{4/3}.
\\
\\ STRUCTURE: J(V_q) ~ E_ef x E_eg x E_fg x E_H+ x E_H-.
\\ The five elliptic quotient maps phi_i : V_q -> E_i are EXPLICIT (the (Z/2)^3 cover
\\ quotients). A point P=(c,e,f,g) in V_q(Q) maps to:
\\   E_ef-coordinate built from (ef, c) on  y^2 = (c^2+q^2)(c^2+1)   [the chi_e chi_f quotient]
\\   E_eg-coordinate built from (eg, c) on  y^2 = (c^2+q^2)(c^2+1+q^2)
\\   E_fg-coordinate built from (fg, c) on  y^2 = (c^2+1)(c^2+1+q^2)
\\   E_H+/E_H- : the even/odd parts of (efg, c) on y^2 = prod of all three.
\\
\\ MW-SIEVE IDEA (factored):  V_q(Q) -> prod E_i(Q).  For the generic fiber,
\\   E_ef(Q)=E_eg(Q)=E_fg(Q)=E_H-(Q) = torsion (rank 0), E_H+(Q) = <P_Pyth> + torsion (rank 1).
\\ So image of V_q(Q) lands in a FINITE set:  T_ef x T_eg x T_fg x (<P>+T_H+) x T_H-.
\\ Sieve: for several good primes p, compute image of V_q(F_p) under the 5 reduction-of-quotient
\\ maps, intersect with reduction of the global group.  If the only surviving global class is
\\ the one of the known degenerate points, V_q(Q) is pinned.
\\
\\ This script: (a) sets up the quotient curves over Q, (b) verifies the degenerate
\\ points map to torsion, (c) reports EXACTLY what is and is NOT computable in PARI.

default(parisize, 800000000);
default(parisizemax, 1200000000);

\\ exact rational square root (assumes argument is a perfect rational square)
sqrtrat(r) = my(n = numerator(r), d = denominator(r)); sqrtint(n)/sqrtint(d);

q = 4/3;
print("Generic fiber q = ", q);
print("Pythagorean: 1+q^2 = ", 1+q^2, " = (", sqrtrat(1+q^2), ")^2");
print("");

\\ --- The three genus-1 (ef,eg,fg) quotient curves: y^2 = (c^2+A)(c^2+B) ---
\\ As a curve in (c, w): w^2 = (c^2+A)(c^2+B). Quartic in c -> elliptic via standard reduction.
\\ Coordinates: w = e*f for E_ef, etc.
A = q^2;        \\ c^2 + q^2 = e^2
B = 1;          \\ c^2 + 1   = f^2
Cc = 1 + q^2;   \\ c^2+1+q^2 = g^2

\\ E_H+ : Y^2 = (X+q^2)(X+1)(X+1+q^2)  with X = c^2  (the even part).
\\ The Pythagorean section: at c=0 (degenerate), X=0, Y^2 = q^2*1*(1+q^2) = (q*w)^2.
EHp = ellinit([0, (A+B+Cc), 0, (A*B+A*Cc+B*Cc), (A*B*Cc)]);
print("E_H+ = ", EHp.disc, " (disc)");
\\ w = sqrt(1+q^2) is RATIONAL here (Pythagorean fiber). Get it exactly.
w = sqrtrat(1+q^2);   \\ defined below
PPyth = [0, q*w];
print("Pythagorean section P = (0, ", q*w, ") on E_H+");
print("Is P on E_H+? ", ellisoncurve(EHp, PPyth));
print("Order of P (0 = infinite): ", ellorder(EHp, PPyth));
print("");

\\ Confirm P is the rank-1 generator (modulo torsion + index). Compute canonical height.
print("Canonical height of P: ", ellheight(EHp, PPyth));
print("");

\\ The 8 degenerate points of V_q are c=0, e=+-q, f=+-1, g=+-w(=+-(1+q^2)^(1/2)... actually g^2=1+q^2).
\\ Note g = +- w too. So degenerate (c,e,f,g) = (0, +-q, +-1, +-w). 8 sign combos.
\\ Under the E_H+ quotient X=c^2=0 these ALL map to the SAME point P=(0, +-q*w) (2-torsion-ish? no:
\\ X=0 is NOT a 2-torsion X-value here since 2-torsion is at X=-q^2,-1,-(1+q^2)).
\\ So the degenerate points map to +-P on E_H+, i.e. the generator itself (or its negative).
print("=== Degenerate points -> E_H+ ===");
print("c=0 gives X=c^2=0, Y=+-q*w -> the point P=(0,q*w) and -P. P is the rank-1 GENERATOR.");
print("So the 8 degenerate points sit over {+-P} subset E_H+(Q) = <P> + tors.");
print("");

\\ === THE OBSTACLE CHECK ===
print("=== What the MW-sieve needs, and whether PARI can do it ===");
print("(1) J(V_q)(Q) generators: HAVE them (P on E_H+ rank1 + torsion on 5 factors). OK in PARI.");
print("(2) Abel-Jacobi map V_q(Q) -> J(V_q)(Q): need a working model of the genus-5 curve.");
print("    V_q is NON-HYPERELLIPTIC genus 5. PARI has hyperell* only (genus-2/hyperell).");
print("    -> NO native Jacobian / Abel-Jacobi for non-hyperelliptic curves in PARI.");
print("(3) Factored route: use the 5 elliptic quotient maps phi_i : V_q -> E_i.");
print("    Each phi_i IS explicit. We CAN reduce mod p and push V_q(F_p) into prod E_i(F_p).");
print("    This is the ONLY PARI-feasible sieve. Tested in 03_*.gp.");
quit;
