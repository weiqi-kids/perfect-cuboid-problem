\\ Step 4: Jacobian decomposition of V_{q_0} for general q_0
\\
\\ Fiber V_{q_0} ⊂ A^4 = (c, e, f, g):
\\   E_eq: c^2 + q_0^2 = e^2
\\   F_eq: c^2 + 1 = f^2
\\   G_eq: c^2 + 1 + q_0^2 = g^2
\\
\\ (Together with 1 + q_0^2 = d^2 fixing d as scalar.)
\\
\\ This is a (Z/2)^3-cover of A^1_c branched at 6 points.
\\
\\ Decomposition by characters of (Z/2)^3:
\\   χ_e: cover c → (c, e) — genus 0 quotient (c^2 + q_0^2 = e^2 is a P^1 over Q for q_0 rational)
\\   χ_f: cover c → (c, f) — genus 0 (c^2 + 1 = f^2 is P^1)
\\   χ_g: cover c → (c, g) — genus 0 (c^2 + 1 + q_0^2 = g^2 is P^1 over Q since 1+q_0^2 = d^2 = □)
\\   χ_e χ_f: cover c → (c, ef): (ef)^2 = (c^2+q_0^2)(c^2+1), genus 1 (elliptic curve in c, ef)
\\   χ_e χ_g: (eg)^2 = (c^2 + q_0^2)(c^2 + 1 + q_0^2), genus 1
\\   χ_f χ_g: (fg)^2 = (c^2 + 1)(c^2 + 1 + q_0^2), genus 1
\\   χ_e χ_f χ_g: (efg)^2 = (c^2+q_0^2)(c^2+1)(c^2+1+q_0^2), genus 2 (degree-6 hyperelliptic)
\\
\\ So J(V_{q_0}) ~ E_1 × E_2 × E_3 × J_2  where J_2 = Jacobian of genus-2 curve.
\\ But J_2 might further decompose.
\\
\\ Hmm wait — sum of genera: 1 + 1 + 1 + 2 = 5 = g(V_{q_0}). ✓ Perfect.
\\
\\ So J(V_{q_0}) ~ E_a × E_b × E_c × J_H  where J_H is 2-dim and might split.
\\
\\ Let's see if J_H splits for generic q_0:
\\ J_H is the Jacobian of y^2 = (c^2 + q_0^2)(c^2 + 1)(c^2 + 1 + q_0^2)
\\           = (c^2 - α)(c^2 - β)(c^2 - γ) where α = -q_0^2, β = -1, γ = -(1+q_0^2)
\\
\\ This is a degree-6 polynomial in c, with the involution c → -c.
\\ The quotient by c → -c is the elliptic curve y^2 = (x - α)(x - β)(x - γ) with x = c^2.
\\ So J_H has a (1+1) decomposition:
\\   E_H+ : y^2 = (x - α)(x - β)(x - γ) (genus 1, "even" part)
\\   E_H- : the "odd" part (also genus 1)
\\
\\ Total: J(V_{q_0}) ~ E_1 × E_2 × E_3 × E_H+ × E_H-  (5 elliptic factors)
\\
\\ MATCHES the case B decomposition pattern in case-b-final.md!

\\ Let me write down the 5 elliptic factors explicitly as a function of q_0.

\\ E_1 = E_{ef}: y^2 = (c^2 + q_0^2)(c^2 + 1)
\\ Standard form: substitute c → x, y^2 = (x^2 + q_0^2)(x^2 + 1)
\\ This is a genus-1 hyperelliptic; convert to Weierstrass.
\\ Let u = x^2. Then y^2 = (u + q_0^2)(u + 1) is a conic in (u, y) — but we lost half.
\\ Actually y^2 = (x^2 + q_0^2)(x^2 + 1) has the curve E_{ef} as genus 1 in (x, y).
\\ Set z = y/x, then z^2 = (x + q_0^2/x)(x + 1/x) ... messy.

\\ Standard: for y^2 = quartic in x, take 2-isogeny to elliptic.
\\ y^2 = x^4 + (1 + q_0^2) x^2 + q_0^2
\\ Set X = x^2, then y^2 = X^2 + (1+q_0^2) X + q_0^2 — a conic, but with X = x^2 constraint.

\\ Use Cassels' transform: y^2 = quartic in x with leading coeff a^2.
\\ Here y^2 = x^4 + Ax^2 + B with A = 1+q_0^2, B = q_0^2.
\\ Then there's a 2-iso to E: Y^2 = X(X^2 - AX + B - 1/4 · ...) — actually for y^2 = x^4 + Ax^2 + B
\\ E: Y^2 = X^3 - 2A X^2 + (A^2 - 4B) X

\\ Verify for q_0 = 1: A = 2, B = 1, so E_{ef}: Y^2 = X^3 - 4X^2 + 0·X = X^2(X-4). Singular! At q_0 = 1, E_{ef} degenerates.
\\ This makes sense because at q_0 = 1, b = a, so the cuboid degenerates.

\\ General formula:
\\ E_{ef}(q): Y^2 = X^3 - 2(1+q_0^2) X^2 + ((1+q_0^2)^2 - 4q_0^2) X
\\               = X^3 - 2(1+q_0^2) X^2 + (1 - q_0^2)^2 X

\\ Discriminant of cubic in X:
\\   Δ = X · cubic, ... Let me just plug q_0 = 1 above: 1 + 1 = 2, (1-1)^2 = 0, so Y^2 = X(X^2 - 4X) = X^2(X-4) — singular.

\\ Now do E_{eg} and E_{fg}:
\\ E_{eg}: y^2 = (c^2 + q_0^2)(c^2 + 1 + q_0^2). Let A = (q_0^2) + (1+q_0^2) = 1 + 2q_0^2, B = q_0^2(1+q_0^2)
\\ → E_{eg}: Y^2 = X^3 - 2(1+2q_0^2) X^2 + ((1+2q_0^2)^2 - 4 q_0^2 (1+q_0^2)) X
\\          = X^3 - 2(1+2q_0^2) X^2 + (1 + 4q_0^2 + 4q_0^4 - 4q_0^2 - 4q_0^4) X
\\          = X^3 - 2(1+2q_0^2) X^2 + X
\\
\\ E_{fg}: y^2 = (c^2 + 1)(c^2 + 1 + q_0^2). A = 1 + (1+q_0^2) = 2+q_0^2, B = 1+q_0^2.
\\ → E_{fg}: Y^2 = X^3 - 2(2+q_0^2) X^2 + ((2+q_0^2)^2 - 4(1+q_0^2)) X
\\          = X^3 - 2(2+q_0^2) X^2 + (4 + 4q_0^2 + q_0^4 - 4 - 4q_0^2) X
\\          = X^3 - 2(2+q_0^2) X^2 + q_0^4 X
\\
\\ Now for the hyperelliptic χ_e χ_f χ_g: y^2 = (c^2 + q_0^2)(c^2 + 1)(c^2 + 1 + q_0^2)
\\ Genus 2. Decompose by c → -c into two elliptic curves:
\\ E_H+: Y^2 = (X + q_0^2)(X + 1)(X + 1 + q_0^2)  where X = c^2
\\ E_H-: y^2 = c^2 · (c^2 + q_0^2)(c^2 + 1)(c^2 + 1 + q_0^2) restricted to the odd part... hmm
\\ Standard for genus 2 with hyperelliptic involution AND c → -c:
\\ Let X = c^2, Y = y. Then Y^2 = (X+q_0^2)(X+1)(X+1+q_0^2) defines E_+ (this is genus 1).
\\ The OTHER quotient by c → -c (with antisymmetric forms) gives E_- with equation
\\ c^2 Y^2 = ... let Z = c·y, X = c^2. Z^2/X = Y^2/c^0·... no let me restart.
\\ Genus-2 curve y^2 = (c^2-a)(c^2-b)(c^2-d) (degree 6 even polynomial).
\\ Involution σ: c → -c, y → y. Quotient curve E_+: y^2 = (X-a)(X-b)(X-d), X = c^2. Genus 1.
\\ Other involution τ: c → -c, y → -y. Quotient E_-: ?
\\ Let u = c, v = y. The σ-anti-invariant forms: c·dc (from c → -c gives -c·dc·(-1) = c·dc; nope wait dc → -dc).
\\ This is getting confused. Use Magma-style formula: for y^2 = f(c^2), genus 2,
\\ E_+ : v^2 = X·f_red(X) where f_red is rad of f, X = c^2 — wait my f is already f(X)=(X-a)(X-b)(X-d).
\\ E_- : V^2 = X·F(X) for the same X = c^2.
\\
\\ Actually the rule: J(C) ~ E_+ × E_- where
\\   E_+ : y^2 = (X-a)(X-b)(X-d)
\\   E_- : y^2 = X(X-a)(X-b)(X-d) (degree 4) — convert to Weierstrass.

\\ For our case (substituting a = -q_0^2, b = -1, d = -1-q_0^2):
\\ E_H+: Y^2 = (X + q_0^2)(X + 1)(X + 1 + q_0^2)
\\        → Translate X → X - mean root, etc., gives short Weierstrass.

\\ E_H-: Y^2 = X(X + q_0^2)(X + 1)(X + 1 + q_0^2)  (degree 4)

\\ Let me check at q_0 = 1 if these match case-b-final.md's E_1, E_2, E_3, X+, X-.

\\ Recall case-b-final.md gives (at q ≈ generic in Case B curve C):
\\   E_1: v^2 = u^3 - 16u^2 + 100u   (conductor 480)
\\   E_2: v^2 = u^3 + 100u            (conductor 800, CM)
\\   E_3: y^2 = ...                    (conductor 1200)
\\   X+: y^2 = x^3 + 4x^2 - 320x       (conductor 120)
\\   X-: y^2 = x^3 - 36x^2 + 320x      (conductor 80)

\\ But case B is a DIFFERENT curve from V_{q_0}! Case B was the curve C : e^2 = 5q^4-16q^2+20, g^2 = 5q^4+20.
\\ It's NOT a fiber of V over P^1_q. It's a SUB-CURVE of V transverse to the fibration.

\\ Let me explicitly write down the 5 elliptic factors of V_{q_0} for several q_0 and check ranks.

\\ q_0 = 4/3 (since 1 + (4/3)^2 = 25/9 = (5/3)^2; the first Pythagorean triple)
\\ Actually clean: take a = 3, b = 4, d = 5; then "q_0" in our normalized setting (a=1) is q_0 = 4/3.

q0 = 4/3;
print("q_0 = ", q0);

\\ E_{ef}(q): Y^2 = X^3 - 2(1+q_0^2) X^2 + (1 - q_0^2)^2 X
A_ef = 1 + q0^2; B_ef = q0^2;
print("E_ef: Y^2 = X^3 - ", 2*A_ef, " X^2 + ", (1-q0^2)^2, " X");
E_ef = ellinit([0, -2*A_ef, 0, (1-q0^2)^2, 0]);
print("E_ef discriminant: ", E_ef.disc);
print("E_ef j-invariant: ", E_ef.j);

\\ E_{eg}: Y^2 = X^3 - 2(1+2q_0^2) X^2 + X
print("\nE_eg: Y^2 = X^3 - ", 2*(1+2*q0^2), " X^2 + X");
E_eg = ellinit([0, -2*(1+2*q0^2), 0, 1, 0]);
print("E_eg discriminant: ", E_eg.disc);
print("E_eg j-invariant: ", E_eg.j);

\\ E_{fg}: Y^2 = X^3 - 2(2+q_0^2) X^2 + q_0^4 X
print("\nE_fg: Y^2 = X^3 - ", 2*(2+q0^2), " X^2 + ", q0^4, " X");
E_fg = ellinit([0, -2*(2+q0^2), 0, q0^4, 0]);
print("E_fg discriminant: ", E_fg.disc);
print("E_fg j-invariant: ", E_fg.j);

\\ E_H+: Y^2 = (X + q_0^2)(X + 1)(X + 1 + q_0^2)
\\ Expanded: Y^2 = X^3 + (1 + q_0^2 + 1 + q_0^2 + 1)X^2 + ((q_0^2)(1) + (q_0^2)(1+q_0^2) + (1)(1+q_0^2))X + q_0^2 (1+q_0^2)
\\         = X^3 + (3 + 2q_0^2) X^2 + (q_0^2 + q_0^2 + q_0^4 + 1 + q_0^2)X + q_0^2 + q_0^4
\\         = X^3 + (3 + 2q_0^2) X^2 + (1 + 3q_0^2 + q_0^4)X + (q_0^2 + q_0^4)

c2 = 3 + 2*q0^2;
c1 = 1 + 3*q0^2 + q0^4;
c0 = q0^2 + q0^4;
print("\nE_H+: Y^2 = X^3 + ", c2, " X^2 + ", c1, " X + ", c0);
EHp = ellinit([0, c2, 0, c1, c0]);
print("E_H+ discriminant: ", EHp.disc);
print("E_H+ j-invariant: ", EHp.j);

\\ E_H-: y^2 = X(X+q_0^2)(X+1)(X+1+q_0^2) → degree 4
\\ Convert via Cassels': y^2 = X^4 + a_3 X^3 + a_2 X^2 + a_1 X + a_0 with a_0 = 0.
\\ Expand X(X+q_0^2)(X+1)(X+1+q_0^2):
\\ (X+q_0^2)(X+1+q_0^2) = X^2 + (1+2q_0^2)X + q_0^2(1+q_0^2)
\\ Multiply by X(X+1):
\\ X(X+1) = X^2 + X
\\ (X^2 + X)(X^2 + (1+2q_0^2)X + q_0^2(1+q_0^2)) = X^4 + (1+2q_0^2)X^3 + q_0^2(1+q_0^2) X^2 + X^3 + (1+2q_0^2)X^2 + q_0^2(1+q_0^2) X
\\ = X^4 + (2+2q_0^2)X^3 + (1+2q_0^2 + q_0^2 + q_0^4)X^2 + q_0^2(1+q_0^2) X
\\ = X^4 + (2+2q_0^2)X^3 + (1+3q_0^2+q_0^4)X^2 + (q_0^2 + q_0^4) X

\\ y^2 = quartic. Cassels: y^2 = X^4 + e3 X^3 + e2 X^2 + e1 X + e0 (e0 = 0)
\\ With e0 = 0, we can substitute z = X to get y^2 = X (X^3 + e3 X^2 + e2 X + e1)
\\ Then (y, X) is on a singular point at X = 0; better is to make explicit elliptic equation.
\\ Standard 2-isogeny: from y^2 = X(X^3 + AX^2 + BX + C) to Weierstrass.

\\ Or: y^2 = X^4 + e3 X^3 + e2 X^2 + e1 X (after multiplying through). Hmm.

\\ Actually y^2 = X · (X+q_0^2)(X+1)(X+1+q_0^2). Set y = X·w, then X^2 w^2 = X · cubic ⇒ X w^2 = cubic.
\\ Or X·w^2 = (X+q_0^2)(X+1)(X+1+q_0^2). This is a genus-1 curve in (X, w).
\\ Let me just use Magma-form: y^2 = X^4 + ... gives elliptic via standard transform.

\\ Use Pari to compute the Jacobian of the quartic:
print("\nE_H-: y^2 = X·(X+q_0^2)(X+1)(X+1+q_0^2)");
print("    expanded: y^2 = X^4 + ", 2+2*q0^2, " X^3 + ", 1+3*q0^2+q0^4, " X^2 + ", q0^2+q0^4, " X");

\\ For y^2 = f(X) with deg f = 4 and f(0) = 0, factor X out:
\\ y^2 = X · g(X) where g(X) = X^3 + (2+2q_0^2)X^2 + (1+3q_0^2+q_0^4) X + (q_0^2+q_0^4)
\\ Set t = y/X, then t^2 = g(X)/X = X^2 + (2+2q_0^2) X + (1+3q_0^2+q_0^4) + (q_0^2+q_0^4)/X
\\ Multiply: X t^2 = X^3 + (2+2q_0^2) X^2 + (1+3q_0^2+q_0^4) X + (q_0^2+q_0^4) = g(X) = y^2 / X
\\
\\ So (y/X)^2 = g(X)/X. Set X' = X, then we have something singular.

\\ Use standard formula for 2-isogeny:
\\ y^2 = X(X-α)(X-β)(X-γ) has Jacobian = E: Y^2 = (X - α)(X - β)(X - γ) and one other factor.
\\ Wait no, this is genus 1 directly (deg 4 in X with leading X^4 = (X)(X-..)(X-..)(X-..)?).
\\ Yes degree 4 in X is genus 1 ALREADY (quartic).
\\ So E_H- is JUST one elliptic curve, not pair.

\\ Convert y^2 = quartic to Weierstrass.
\\ For y^2 = X(X+q_0^2)(X+1)(X+1+q_0^2), use cross-ratio.
\\ Roots: 0, -q_0^2, -1, -(1+q_0^2). Send 0 → ∞, -q_0^2 → 0, -1 → 1.
\\ Set u = -(X+q_0^2)/(X(1-q_0^2)) ... getting messy.

\\ Easier: substitute X = 1/T. Then dX = -dT/T^2 and
\\ X(X+q_0^2)(X+1)(X+1+q_0^2) = (1/T)(1/T + q_0^2)(1/T + 1)(1/T + 1+q_0^2)
\\ Multiply by T^4: (T^3)(1 + q_0^2 T)(1 + T)(1 + (1+q_0^2)T) / T^4 ...
\\ Equivalent to T·(1+q_0^2 T)(1+T)(1+(1+q_0^2)T) = T + ... (cubic in T)
\\ So (y/X^2)^2 = T · (1 + q_0^2 T)(1+T)(1+(1+q_0^2)T)

\\ Just compute via pari ellinit with quartic-to-Weierstrass converter.
\\ Pari has hyperelltohyperell but no direct quartic-to-Weierstrass.
\\ Manual: For y^2 = aX^4 + bX^3 + cX^2 + dX + e with a rational pt (X0, y0), can transform.
\\ X0 = 0 is a rational point: y0 = 0. We can use this as 2-torsion to deduce E_H-:

\\ Actually y^2 = X · cubic(X) means (X, y) = (0, 0) is on the curve. It's a singular Weierstrass.
\\ Use: (X, y) → (X, y) means y^2/X^2 = cubic(X)/X = ...

\\ Forget it; let me just compute the j-invariant of the quartic directly using PARI:
\\ For y^2 = f(X), genus 1, the j-invariant is:
\\ I = (1/12) (a4^2 - 3 a3 a5 + 12 a6 a2)  ... hmm specific formula needed.

\\ Use pari's hyperellcharpoly or pure: there's pari function for genus 1 from quartic.
\\ Actually use ellfromj or just figure manually.

\\ For y^2 = X(X-α)(X-β)(X-γ), this is a binary quartic with 4 distinct roots (one at 0).
\\ Invariants of quartic ax^4 + ... + e:
\\ I = a e - 4 b d / 4 + c^2 / 3 — has specific formulas.

\\ I'll just compute numerically at q_0 = 4/3 to confirm.

\\ At q_0 = 4/3: roots of f are 0, -16/9, -1, -25/9. So f(X) = X(X+16/9)(X+1)(X+25/9).
\\ Multiply out: take expansion.
f_quart = X * (X + 16/9) * (X + 1) * (X + 25/9);
print("\nE_H- quartic at q_0=4/3: ", f_quart);

\\ Use Pari's hyperellratpoints, hyperellcharpoly etc.
\\ For genus 1 from y^2 = degree-4: use Cremona's formula.
\\ y^2 = a x^4 + b x^3 + c x^2 + d x + e
\\ Has J-invariant... we'll use ellfromeqn:
EHm_eqn = y^2 - f_quart;
print("E_H- as ellfromeqn(y^2 - quartic): ");
\\ ellfromeqn takes plane curve f(x,y) = 0 and returns elliptic coefficients
E_Hm_coef = ellfromeqn(EHm_eqn);
print(E_Hm_coef);
E_Hm = ellinit(E_Hm_coef);
print("E_H- minimal model: ", E_Hm);
print("E_H- discriminant: ", E_Hm.disc);
print("E_H- j-invariant: ", E_Hm.j);
print("E_H- conductor: ", ellglobalred(E_Hm)[1]);
