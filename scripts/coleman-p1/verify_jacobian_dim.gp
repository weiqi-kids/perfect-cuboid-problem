\\ ============================================================
\\ Verify dim J(C) = 5 via genus computation
\\ C: e^2 = 5q^4 - 16q^2 + 20, g^2 = 5q^4 + 20  (fiber product)
\\ Both component curves are genus-1 hyperelliptic (quartic in q)
\\ Fiber product C → P^1_q is genus-5 generic
\\ Test via Riemann-Hurwitz: ramification?
\\ ============================================================

print("=== Verify g(C) = 5 ===\n");

\\ The two factors:
\\ C_1: e^2 = 5q^4 - 16q^2 + 20  (E_1 isogenous, genus 1 over Q after weierstrass)
\\ C_2: g^2 = 5q^4 + 20            (E_2 isogenous, genus 1)

\\ Fiber product C → P^1_q is degree 4 (2 in each factor)
\\ Generic genus formula for fiber product of two double covers of P^1
\\ with branch loci of size b_1, b_2 (disjoint): g(C) = b_1/2 + b_2/2 - 3

\\ f_1 = 5q^4 - 16q^2 + 20 — discriminant?
\\ f_2 = 5q^4 + 20

f1 = 5*q^4 - 16*q^2 + 20;
f2 = 5*q^4 + 20;

print("Discriminant of f_1 in q: ", poldisc(f1, q));
print("Discriminant of f_2 in q: ", poldisc(f2, q));
print();

print("Roots of f_1 over C:");
print(polroots(f1));
print();
print("Roots of f_2 over C:");
print(polroots(f2));
print();

\\ GCD test
print("gcd(f_1, f_2) = ", gcd(f1, f2));
print("resultant(f_1, f_2) = ", polresultant(f1, f2));
print();

\\ Number of branch points
\\ f_1: 4 finite branch points + maybe infinity → check parity
\\ Leading coeff 5 — square? No. So infinity is a branch point.
\\ f_1: 5 branch points total
\\ f_2: similarly 5 branch points
\\ But infinity is shared, so disjoint branch loci: 4 + 4 finite + 1 each at infinity = ?

\\ Each genus-1 component:
\\ E_1: e^2 = f_1(q) with deg f_1 = 4, leading coeff 5 non-square → 4+1=5 branch points wait need correct count
\\ Actually for y^2 = f(x) deg f = 4: g = (4-2)/2 = 1 if 4 simple roots; if leading not square at infinity treat ∞ as branched.

\\ The fiber product genus formula for two quadratic covers of P^1 with disjoint branch:
\\ g(C) = (#B_1 + #B_2)/2 - 3 where #B_i = number of branch points of cover i
\\ For f_1 deg 4 not-square leading: branch = 4 finite simple roots → no ramification at infinity (deg even, leading coeff makes ∞ unramified IF leading coeff is a square, otherwise still even rank but branched). Standard: y^2=f(x) with deg f = 4, leading non-square → 4 finite branch points; ∞ is a single point of cover of P^1.
\\ Actually for hyperelliptic y^2=f(x): if deg f = 2g+2, then both ∞ points unramified; if deg = 2g+1, one ∞ point ramified. For deg=4, g=1; so #branch = 4.

\\ So #B_1 = #B_2 = 4 finite. Disjoint (since resultant ≠ 0). Then:
\\ Fiber product genus: g(C) = (4 + 4)/2 - 3 = 1 (NO — formula needs revision)

\\ Use Hurwitz directly: C → P^1_q is degree 4, ramification points are where f_1 = 0 OR f_2 = 0 (8 such points)
\\ At each f_1 = 0 point: the e-cover ramifies (2 points become 1), g-cover unramified (2 points): contribution to ramification divisor of degree 4 map = 2 (one ramification index 2)
\\ Wait, ramification divisor for degree-d cover at point P: e_P - 1 summed.

\\ At each root of f_1: e^2 = 0, e = 0 (single value, ramified); g^2 = f_2(root) ≠ 0, two values for g (unramified in g)
\\ So over each root of f_1 in P^1_q: 2 points in C (one for each g-value), each with ramification index 2 in the e-direction
\\ Contribution: 2 points × (2-1) = 2

\\ Similar for each of 4 roots of f_2: contribution 2
\\ Total ram divisor degree from finite roots: 8 × 2 = 16, no wait
\\ Each root of f_1: 2 points in C, each contributes ram_index - 1 = 1. So 2.
\\ 4 roots of f_1: 4 × 2 = 8.
\\ Same for f_2: 8.
\\ At infinity: q = ∞. Leading coeffs 5 for f_1 and f_2. Behavior: e ~ sqrt(5) q^2, g ~ sqrt(5) q^2. Both unramified at ∞ (since q^2 is even power). Then fiber over ∞ has 4 points (2 sign choices each for e, g), all unramified.
\\ So total ramification divisor degree on C: 16
\\ Riemann-Hurwitz: 2g(C) - 2 = 4 (2 g(P^1) - 2) + 16 = 4(-2) + 16 = 8 → g(C) = 5. ✓

print("Riemann-Hurwitz: 2g(C) - 2 = 4(-2) + 16 = 8, so g(C) = 5 ✓");
print();
print("Jacobian dim = genus = 5, matching factorization E_1 × E_2 × E_3 × X_+ × X_-");
print();

\\ Now verify the three "extra" elliptic factors arise from quotients
\\ C/<sigma_q>: q → -q symmetry. f_1, f_2 both even in q, so quotient lives.
\\ Under q → -q: e → e, g → g. Quotient curve: let u = q^2.
\\ e^2 = 5u^2 - 16u + 20, g^2 = 5u^2 + 20 — fiber product of two CONICS!
\\ Now each is a smooth conic = P^1, fiber product over P^1_u (also = P^1 via projection)
\\ Generically genus 0? But quotient genus = 5/2 ≈ 2.5 — must be integer.
\\ Actually under involution acting on genus-5 with FIXED POINTS, quotient genus changes by 1/2 of fixed point count.
\\ σ_q fixes points where q = -q, i.e. q=0. f_1(0)=20, not square; f_2(0)=20. So no F_1 fixed points? Actually need points fixed in C, not F_1
\\ Over q=0: e^2=20, g^2=20: 2 × 2 = 4 points, σ_q fixes all of them since q→-q preserves them.
\\ So σ_q has 4 fixed points. Hurwitz: 2g(C) - 2 = 2(2g(C/σ_q) - 2) + 4 → 8 = 2(2g' - 2) + 4 → 2g' = 4, g' = 2

print("Quotient C/<sigma_q>: g = 2 (curve has 4 σ_q-fixed points over q=0)");
print();

\\ This genus-2 quotient should have Jacobian E_3 × something. Actually:
\\ Quotient genus 2, and E_3 is one of two factors there.
\\ Other quotients C/<sigma_e>, C/<sigma_g>:
\\ σ_e: e → -e, sends C to C_2: g^2 = 5q^4 + 20 (just the g-curve = E_2). So C/σ_e ≅ C_2 of genus 1.
\\ Similarly C/σ_g ≅ C_1 of genus 1.
\\ Sanity: g(C/σ_e) = 1, Hurwitz: 8 = 2(0) + #fix(σ_e). σ_e fixes points where e=0: 4 roots of f_1 over q, each having one value of g (if f_2 there is square) or 0 (if not). Roots of f_1 are α with 5α^4-16α^2+20=0. At each root, f_2 = 5α^4+20 = 16α^2+20+20 = 16α^2+40. Need square. Over Q not generally, but # of fixed points in C(C-bar): each root gives ±g where g^2 = 16α^2+40, so 2 points if f_2(α) ≠ 0 and 1 if =0. 4 roots × 2 = 8 fixed pts. Hurwitz: 8 = 2(0) + 8 ✓.

print("Quotient C/<sigma_e>: g = 1 → E_2 (the g-curve y^2 = 5q^4+20)");
print("Quotient C/<sigma_g>: g = 1 → E_1 (the e-curve y^2 = 5q^4-16q^2+20)");
print();

\\ Identify E_1 (e-curve) Weierstrass: y^2 = 5q^4-16q^2+20
\\ Standard substitution for y^2=ax^4+bx^2+c → elliptic curve E
\\ Use PARI's elliptic from quartic
print("=== E_1: y^2 = 5q^4 - 16q^2 + 20 → Weierstrass ===");
print("Putting in form y^2 = quartic: PARI quartic-to-elliptic");
\\ y^2 = a x^4 + b x^2 + c. Substitute x^2 = u: conic. Discriminant approach:
\\ For y^2 = ax^4 + bx^2 + c with point (x_0, y_0) = (1, 3) [since 5-16+20=9=3^2]
\\ Use ellfromeqn? Try direct:
E1_check = ellfromeqn(y^2 - (5*q^4 - 16*q^2 + 20));
print("ellfromeqn output: ", E1_check);
\\ Now construct elliptic curve from this and compare
if(#E1_check >= 5,
  E1_test = ellinit(E1_check);
  E1_min = ellminimalmodel(E1_test);
  print("Minimal model: ", E1_min.a1, " ", E1_min.a2, " ", E1_min.a3, " ", E1_min.a4, " ", E1_min.a6);
  print("Conductor: ", ellglobalred(E1_min)[1]);
);

print();
print("=== E_2: y^2 = 5q^4 + 20 → Weierstrass ===");
E2_check = ellfromeqn(y^2 - (5*q^4 + 20));
print("ellfromeqn output: ", E2_check);
if(#E2_check >= 5,
  E2_test = ellinit(E2_check);
  E2_min = ellminimalmodel(E2_test);
  print("Minimal model: ", E2_min.a1, " ", E2_min.a2, " ", E2_min.a3, " ", E2_min.a4, " ", E2_min.a6);
  print("Conductor: ", ellglobalred(E2_min)[1]);
);
