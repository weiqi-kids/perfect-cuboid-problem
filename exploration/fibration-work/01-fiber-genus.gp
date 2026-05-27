\\ Step 1: Verify generic fiber genus of C_q : e^2 = 5q^4 - 16q^2 + 20, g^2 = 5q^4 + 20
\\ Two hyperelliptic-style conditions; the curve C_q lies in (e,g) for fixed q (a point)
\\ But the fibration we want is V -> P^1_q where q is the Saunderson parameter
\\ Each fiber over q = q0 is C_{q0} which is the simultaneous solution of two quartic conditions

\\ The curve C parametrized by q is a 1-parameter family
\\ For fixed q = q0 in Q, the fiber is a 0-dim variety (4 points: (+/-e, +/-g))
\\ This is NOT what we want. We want C as a curve in (q, e, g)-space.

\\ The "Case B genus-5 curve" is C : {e^2 = 5q^4 - 16q^2 + 20, g^2 = 5q^4 + 20} in A^3
\\ This is the intersection of two surfaces in A^3, of dim 1.
\\ Let's compute its genus.

\\ Approach: project to the (q,e) curve E^* : e^2 = 5q^4 - 16q^2 + 20 (genus 1)
\\ and the (q,g) curve G^* : g^2 = 5q^4 + 20 (genus 1)
\\ C = E^* x_{P^1_q} G^* is a 2-to-1 cover of each over q

\\ By Riemann-Hurwitz on C -> E^* (deg 2, with ramification where g = 0)
\\ g = 0 iff 5q^4 + 20 = 0 → q^4 = -4 → 4 complex q (no real branch over Q-points of E^*)
\\ But over alg closure: 4 branch points on E^*, so Riemann-Hurwitz:
\\ 2g(C) - 2 = 2*(2*g(E^*) - 2) + 4 = 2*0 + 4 = 4
\\ → g(C) = 3 ?

\\ Hmm, but we are told g(C) = 5. Let me reconsider.

\\ Actually C is the smooth completion of {(q,e,g) : both equations}
\\ The map (q,e,g) -> q is degree 4 (4 points for each q, except branch)
\\ Branch loci: 5q^4 - 16q^2 + 20 = 0 OR 5q^4 + 20 = 0
\\ Discriminant of 5q^4 - 16q^2 + 20: roots of 5x^2 - 16x + 20: x = (16 ± sqrt(256-400))/10 = (16 ± 12i)/10
\\ So 5q^4 - 16q^2 + 20 = 0 has 4 complex roots (2 pairs)
\\ 5q^4 + 20 = 0 has 4 complex roots q^4 = -4 → q = (1+i), etc.
\\ So 8 simple branch points on P^1_q

\\ Map C -> P^1_q is degree 4 (Galois group (Z/2)^2)
\\ Each of e=0 and g=0 gives degree-2 branch
\\ Riemann-Hurwitz: 2g(C) - 2 = 4*(0-2) + sum(e_P - 1)
\\ Each branch point of e=0 (4 of them) has e_P = 2 (ramification index of one factor)
\\ Same for g=0 (4 of them)
\\ Each branch point contributes 2 ramified preimages out of 4, each with e=2
\\ Contribution per branch point of e=0: 2 preimages × (e-1) = 2 × 1 = 2
\\ Total ramification: 4 × 2 + 4 × 2 = 16

\\ 2g - 2 = -8 + 16 = 8 → g(C) = 5 ✓

print("Genus computation check:")
print("Branch points of e^2 = 5q^4 - 16q^2 + 20 over P^1_q: 4 (complex roots)");
print("Branch points of g^2 = 5q^4 + 20 over P^1_q: 4 (complex roots, q^4 = -4)");
print("Degree of C -> P^1_q: 4");
print("Riemann-Hurwitz: 2g-2 = 4*(-2) + 16 = 8 → g(C) = 5 ✓");

\\ Now compute the discriminants explicitly
f1 = 5*q^4 - 16*q^2 + 20;
f2 = 5*q^4 + 20;
print("\nf1 = ", f1);
print("disc(f1) = ", poldisc(f1));
print("f2 = ", f2);
print("disc(f2) = ", poldisc(f2));

\\ Roots over C
print("\nRoots of f1 = 5q^4 - 16q^2 + 20:");
print(polroots(f1));
print("\nRoots of f2 = 5q^4 + 20:");
print(polroots(f2));

\\ Are the two branch loci disjoint? Check gcd
print("\ngcd(f1, f2) = ", gcd(f1, f2));
print("→ disjoint branch loci, total 8 distinct branch points");
