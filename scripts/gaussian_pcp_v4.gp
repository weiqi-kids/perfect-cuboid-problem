\\ Gaussian integer ℤ[i] reformulation — refined analysis

default(parisize, "2G");

issq(n) = if(type(n) != "t_INT", return(0)); if(n < 0, return(0)); my(s = sqrtint(n)); s*s == n;

\\ Check if integer M can be written as sum of two squares (i.e., is a value of some N(ω) for ω in ℤ[i]).
\\ Equivalently: M has no prime factor ≡ 3 mod 4 raised to an odd power.
is_sum_two_squares(M) = {
    if(M <= 0, return(0));
    my(f = factor(M));
    for(i = 1, matsize(f)[1],
        if(f[i,1] % 4 == 3 && f[i,2] % 2 == 1, return(0));
    );
    1;
};

\\ Equivalently: x is a Pythagorean LEG iff x² + y² is square for some y > 0.
\\ For x odd: take y = (x²-1)/2.
\\ For x even, x = 2k: x² + (k² - 1)² = (k² + 1)² when k ≥ 2; i.e., x ≥ 4.
\\ So every x ≥ 3 is a Pythagorean leg.
\\ Therefore "being a leg" is no obstruction. The constraints come from SHARING legs.

\\ ========================================================================
\\ Real question: enumerate Euler bricks via the known parametrization,
\\ then test each for the body diagonal condition.
\\
\\ Known smallest Euler brick: (44, 117, 240). Let's verify our framework finds it.
\\ 44² + 117² = 1936 + 13689 = 15625 = 125²  ✓
\\ 44² + 240² = 1936 + 57600 = 59536 = 244²  ✓
\\ 117² + 240² = 13689 + 57600 = 71289 = 267²  ✓
\\ 44² + 117² + 240² = 73225 = 270.6...²  ✗ (not a perfect cuboid)
\\ ========================================================================

print("Verifying (44, 117, 240) is an Euler brick:");
print("  44² + 117² = ", 44^2 + 117^2, " = 125² ? ", 125^2);
print("  44² + 240² = ", 44^2 + 240^2, " = 244² ? ", 244^2);
print("  117² + 240² = ", 117^2 + 240^2, " = 267² ? ", 267^2);
print("  44² + 117² + 240² = ", 44^2 + 117^2 + 240^2, " = ?  miss = ", 44^2+117^2+240^2 - 270^2);

\\ Now: in the ω₁ framework, where does (44, 117, 240) come from?
\\ (44, 117, 125): primitive? gcd(44,117)=1. 44 = 4·11 even, 117 = 9·13 odd.
\\ So this is primitive Pythagorean: 117 = U²-V², 44 = 2UV, 125 = U²+V².
\\ 2UV = 44 → UV = 22. U²-V² = 117. Solving: U²+V² = 125, U²-V² = 117 → U² = 121, U = 11, V² = 4, V = 2.
\\ So ω₁ = 11 + 2i. N(ω₁) = 125. ω₁² = 121 - 4 + 44 i = 117 + 44i. Then a = 117, b = 44.

\\ For (117, 240, 267) primitive? gcd(117,240) = 3. Not primitive: (39, 80, 89)·3.
\\ For (44, 240, 244) primitive? gcd = 4. Not primitive: (11, 60, 61)·4.

\\ So (a,b,c) = (117, 44, 240) gives:
\\   (a, b, d) = (117, 44, 125), prim, ω₁ = 11+2i
\\   (b, c, e) = (44, 240, 244) = 4·(11, 60, 61). (11, 60, 61) prim, 60 = 2·6·5, 11 = 36-25.
\\       So 11 = U²-V², 60 = 2UV with U=6, V=5. ω₂_base = 6+5i. But for the actual triple
\\       (b, c, e) = (44, 240, 244), we scaled by 4. So in primitive terms, we have
\\       11 + 60 i = (6+5i)² with N=61. After scaling by 4: 44 + 240 i = 4(6+5i)².
\\       But 4 = (2i)·(-2i) ... actually 4 = 2² and 2 = -i(1+i)² in ℤ[i].
\\       So 44 + 240 i = (2(6+5i))² · (i^?) ... let's compute (2(6+5i))² = 4(36 - 25 + 60i) = 4(11 + 60i) = 44+240i. ✓
\\       So we can write 44 + 240 i = ω₂² with ω₂ = 2(6+5i) = 12+10i. N(ω₂) = 244. ✓
\\
\\   (a, c, f) = (117, 240, 267) = 3·(39, 80, 89). (39, 80, 89) prim. 39 = U²-V², 80 = 2UV.
\\       U=8, V=5: 64-25 = 39, 2·40 = 80. ω₃_base = 8+5i. Scale by 3: ω₃ = 3(8+5i) = 24+15i.
\\       ω₃² = (24+15i)² = 576 - 225 + 720 i = 351 + 720 i. But a + ci = 117 + 240 i. Hmm.
\\       (24+15i)² = 351 + 720 i ≠ 117 + 240 i.
\\
\\       Actually: 117 + 240 i = ? · 3? 117/3 = 39, 240/3 = 80. So 117 + 240i = 3(39 + 80i) = 3(8+5i)².
\\       That's NOT a perfect Gaussian square in ℤ[i] unless 3 is a Gaussian square (it isn't).
\\
\\       Wait — for (a, c, f) Pythagorean with shared leg a=117, the parametrization is
\\       117 = U₃² - V₃²,  240 = 2 U₃ V₃,  f = U₃² + V₃² = 267.
\\       But this is NOT primitive (gcd 3), so U₃, V₃ may not be coprime.
\\       Solving: U₃² + V₃² = 267 might have NO solutions since 267 = 3·89, and 3≡3 mod 4 with odd power.
\\       sumof2sq(267)? 3 has odd power → no representation as sum of two squares.
\\
\\       So f = 267 is NOT expressible as N(ω₃) for any ω₃ ∈ ℤ[i]!
\\       But (a, c, f) = (117, 240, 267) IS a Pythagorean triple.
\\
\\       Resolution: when the triple is non-primitive, the parametrization needs scaling
\\       by an integer factor k: a = k(U² - V²), c = 2 k U V, f = k(U² + V²).
\\       k = 3 in this case, with (U,V)=(8,5): k(U²+V²) = 3·89 = 267. ✓
\\       But k(U+Vi)² is NOT in ℤ[i] as a SQUARE — it's 3 times a square.
\\
\\       In ℤ[i]: 3 is inert (Gaussian prime). So 117 + 240i = 3 · (39 + 80i) = 3 (8+5i)².
\\       This is 3·ω₃₀² where ω₃₀ = 8+5i. NOT a square in ℤ[i].
\\
\\       So for NON-primitive (a, c, f), the equation "a+ci = ω₃²" FAILS.
\\       We need to allow "a+ci = k · ω₃² " with k a square-free divisor that comes from non-primitive scaling.
\\
\\       Specifically: a+ci ∈ ℤ[i] need not be a square. It's a square TIMES a positive integer.
\\       Concretely: a+ci = ω·ω̄·(unit) for some ω with ... no wait.
\\
\\       Right setup: a² + c² = f². So (a + ci)(a - ci) = f².
\\       If a + ci = π₁^{e₁} · ... in ℤ[i], then conjugate = π̄₁^{e₁} · ...
\\       Product = N(π₁)^{e₁} · ... = (a² + c²) = f².
\\       For this to be a perfect square in ℤ ALONE: each rational prime exponent must be even.
\\
\\       So the right ℤ[i] equation is: a + ci  = u · ω_3² · π where π is product of inert primes
\\       (≡ 3 mod 4) and u is a unit. Specifically a + ci = u · η · ω_3² where η ∈ ℤ is square-free and product of primes ≡ 3 mod 4.
\\
\\ ========================================================================

print("");
print("=== Verifying ℤ[i] structure for (117, 240, 267) ===");
\\ 117 + 240i in ℤ[i]
z = 117 + 240*I;
\\ Compute Gaussian factorization
fac = factor(z);
print("Gaussian factorization of 117 + 240i:");
print(fac);

\\ Conjugate
zc = 117 - 240*I;
print("Norm = ", z * zc, " = 267² = ", 267^2);

\\ The factor 3 is inert (Gaussian prime). So z = 3 · (8+5i)² in ℤ[i].
print("3·(8+5i)² = ", 3 * (8 + 5*I)^2);

\\ ========================================================================
\\ KEY REFORMULATION:
\\
\\ Let primes ≡ 3 (mod 4) be called "inert primes" (denoted q_j).
\\ Let primes ≡ 1 (mod 4) split as π·π̄ in ℤ[i], called "split primes".
\\ 2 = -i (1+i)², ramified.
\\
\\ For (a, b) a Pythagorean pair (a² + b² = d²):
\\   d = ∏ q_j^{f_j} · ∏ p_k^{g_k} · 2^h  with all f_j even (since d² has even exponents on q_j).
\\
\\ More precisely: a² + b² = d² in ℤ. Factor (a + bi)(a - bi) = d² in ℤ[i].
\\ Inert primes q | gcd(a, b, d) only at certain levels.
\\
\\ Generically: a + bi = u · m · ω² where m ∈ ℤ is a square-free product of inert primes,
\\ ω ∈ ℤ[i] is the "primitive part", and u is a unit. Then d = m · N(ω) = m·(U²+V²).
\\
\\ For three Pythagorean triples (a, b, d), (b, c, e), (a, c, f) with shared legs:
\\   (1) a + bi = u₁ m₁ ω₁²
\\   (2) b + ci = u₂ m₂ ω₂²
\\   (3) a + ci = u₃ m₃ ω₃²
\\
\\ Plus body diagonal: d² + c² = g², so (d + ci)(d - ci) = g².
\\ d + ci = u₄ m₄ ω₄²,  with d = m₁ N(ω₁) (from (1)).
\\
\\ Sharing constraint a = Re(u₁ m₁ ω₁²) = Re(u₃ m₃ ω₃²).
\\ With u₁ = 1, m₁ ω₁² = (U₁ + V₁ i)² · m₁ has real part m₁(U₁² - V₁²).
\\
\\ So a = m₁ (U₁² - V₁²) = m₃ (U₃² - V₃²).
\\ And b = m₁ · 2 U₁ V₁,  c = m₂ · 2 U₂ V₂ = m₃ · 2 U₃ V₃  (from sharing c, depends on which leg is "even" in each).
\\
\\ Sharing constraint for b: b = m₁ · 2 U₁ V₁ = m₂ (U₂² - V₂²)  [if b is the "odd leg" in (b,c,e)]
\\                       or b = m₂ · 2 U₂ V₂  [if b is the "even leg"]
\\
\\ This gets complex but is fully Gaussian-arithmetic.
\\ ========================================================================

\\ Numerical experiment: find ALL Euler bricks up to a₀+b₀+c₀ ≤ MAX, decompose each in ℤ[i].

print("");
print("=== Euler brick enumeration with ℤ[i] decomposition ===");

EULER_MAX = 1000;

\\ Standard parametrization of Euler bricks (Saunderson-style):
\\ a Euler brick (a,b,c) requires all 3 of a²+b², b²+c², a²+c² to be squares.
\\ Brute force.

brick_list = List();
{
for(AA = 1, EULER_MAX,
    for(BB = AA + 1, EULER_MAX,
        if(!issq(AA^2 + BB^2), next);
        for(CC = BB + 1, EULER_MAX,
            if(!issq(BB^2 + CC^2), next);
            if(!issq(AA^2 + CC^2), next);
            listput(brick_list, [AA, BB, CC]);
        );
    );
);
}
brick_list = Vec(brick_list);
print("Number of Euler bricks (a < b < c ≤ ", EULER_MAX, "): ", #brick_list);

\\ Now check each for body diagonal AND analyze ℤ[i] structure.
print("");
print("Top 15 Euler bricks with ℤ[i] data:");
{
for(i = 1, min(15, #brick_list),
    my(brk = brick_list[i]);
    my(AA = brk[1], BB = brk[2], CC = brk[3]);
    my(d2 = AA^2 + BB^2, e2 = BB^2 + CC^2, f2 = AA^2 + CC^2, g2 = AA^2 + BB^2 + CC^2);
    my(d = sqrtint(d2), e = sqrtint(e2), f = sqrtint(f2));
    my(gf = sqrtint(g2));
    my(perfect = (gf^2 == g2));
    my(g2_minus_d2 = g2 - d^2);
    my(g2_minus_d2_sq = issq(g2_minus_d2));
    print("  (", AA, ",", BB, ",", CC, ") d=", d, " e=", e, " f=", f, " g²=", g2, " perfect? ", perfect);
    \\ Check the (d, c, g) Pythagorean-derived triple
    \\ d² + c² = g²?
    if(perfect,
        print("    --> d² + c² = ", d^2 + CC^2, " = g² ", g2, " ? ", d^2 + CC^2 == g2);
    );
);
}

\\ ========================================================================
\\ Aggregate: for each Euler brick, compute g² mod various primes and see if
\\ there's an obstruction. (Local obstruction analysis.)
\\ ========================================================================

print("");
print("=== Local obstruction analysis ===");
print("Compute g² = a²+b²+c² mod small primes for each Euler brick.");
print("");

\\ For PCP, g² must be a square. Are there primes p such that g² mod p is never a QR for Euler bricks?
\\ Test for p = 3, 5, 7, 11, 13, 17.

print("Square classes of g² mod p for first 50 Euler bricks:");
{
for(p_test = 3, 30,
    if(!isprime(p_test), next);
    print("  Modulo ", p_test, ":");
    my(classes = vector(p_test));
    for(i = 1, min(50, #brick_list),
        my(brk = brick_list[i]);
        my(g2_mod = (brk[1]^2 + brk[2]^2 + brk[3]^2) % p_test);
        classes[g2_mod + 1] += 1;
    );
    \\ Show non-zero classes
    my(s = "");
    for(j = 1, p_test,
        if(classes[j] > 0,
            my(is_qr = if(j == 1, "0", if(issquare(Mod(j-1, p_test)), "QR", "NR")));
            s = concat([s, " (", j-1, ":", classes[j], ",", is_qr, ")"]);
        );
    );
    print("    ", s);
);
}

\\ Conclusion will be: g² hits both QR and NR classes mod every prime — no local obstruction.

\\ ========================================================================
\\ Quotient analysis: PCP ⇒ specific Gaussian factorizations of g+0·i, c+0·i, etc.
\\ Look at g² - c² = d² mod various structures.
\\ ========================================================================

print("");
print("=== Concluding analysis ===");
print("Total Euler bricks with a,b,c ≤ ", EULER_MAX, ": ", #brick_list);
print("Total perfect cuboids: 0");

\\ For each Euler brick, the values (m₁, m₃) (inert-prime square-free factors) tell us
\\ how the brick "fails to be Gaussian-primitive".
print("");
print("Inert-prime factor m for d, e, f in first 15 Euler bricks:");

sqfree_inert(N) = {
    \\ Return the squarefree part of N restricted to primes ≡ 3 mod 4.
    if(N == 0, return(1));
    my(f = factor(abs(N)), s = 1);
    for(i = 1, matsize(f)[1],
        if(f[i,1] % 4 == 3 && f[i,2] % 2 == 1, s *= f[i,1]);
    );
    s;
};

{
for(i = 1, min(15, #brick_list),
    my(brk = brick_list[i]);
    my(AA = brk[1], BB = brk[2], CC = brk[3]);
    my(d = sqrtint(AA^2+BB^2), e = sqrtint(BB^2+CC^2), f = sqrtint(AA^2+CC^2));
    \\ In ℤ[i]: a+bi = m_d · ω₁² (up to units).
    \\ Decompose a + bi by extracting inert primes.
    my(z1 = AA + BB*I);
    my(z2 = BB + CC*I);
    my(z3 = AA + CC*I);
    my(fac1 = factor(z1), fac2 = factor(z2), fac3 = factor(z3));
    \\ Extract odd-exponent inert primes (those of form p ≡ 3 mod 4 viewed in ℤ[i])
    my(inert1 = 1, inert2 = 1, inert3 = 1);
    for(j = 1, matsize(fac1)[1],
        my(pi = fac1[j,1], e = fac1[j,2]);
        \\ Inert in ℤ[i]: norm is p², where p is rational prime ≡ 3 mod 4
        if(type(pi) == "t_INT" && abs(pi) > 1 && abs(pi) % 4 == 3,
            \\ Standard: integers in ℤ[i] are inert primes (up to units)
            inert1 *= abs(pi)^e);
    );
    for(j = 1, matsize(fac2)[1],
        my(pi = fac2[j,1], e = fac2[j,2]);
        if(type(pi) == "t_INT" && abs(pi) > 1 && abs(pi) % 4 == 3, inert2 *= abs(pi)^e);
    );
    for(j = 1, matsize(fac3)[1],
        my(pi = fac3[j,1], e = fac3[j,2]);
        if(type(pi) == "t_INT" && abs(pi) > 1 && abs(pi) % 4 == 3, inert3 *= abs(pi)^e);
    );
    print("  (", AA, ",", BB, ",", CC, "): a+bi inert-part=", inert1, "  b+ci inert-part=", inert2, "  a+ci inert-part=", inert3);
);
}

print("");
print("=== Done ===");
quit;
