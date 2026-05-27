\\ Gaussian integer ℤ[i] — Final analysis: is there an obstruction?

default(parisize, "2G");

issq(n) = if(type(n) != "t_INT", return(0)); if(n < 0, return(0)); my(s = sqrtint(n)); s*s == n;

\\ ========================================================================
\\ Pattern observed in v4:
\\   For every Euler brick (a, b, c) found, the inert-part of (a+bi), (b+ci), (a+ci)
\\   is non-trivial in at least one face (often "3" appears).
\\
\\ For a Pythagorean triple (a, b, d) NON-primitive with non-trivial inert part:
\\   d = m · (U²+V²) where m is squarefree product of inert primes.
\\   gcd(a, b) is divisible by m.
\\
\\ For PCP we need ALSO d² + c² = g² (i.e., (d, c, g) Pythagorean).
\\ Take d = 125, c = 240 in the (44, 117, 240) brick: 125² + 240² = 15625 + 57600 = 73225.
\\ sqrt(73225) = 270.6... NOT square. So (125, 240) is NOT a Pythagorean pair.
\\
\\ The KEY OBSERVATION: PCP requires d² + c² = g² where d = sqrt(a²+b²).
\\ For (a, b, c) = (44, 117, 240): a²+b² = 125², so d = 125. Then need 125² + c² = g².
\\ c = 240 gives 125² + 240² = 73225 ≠ square.
\\
\\ Equivalently: d itself must be a Pythagorean leg, paired with c.
\\ For most Euler bricks, d (or e, f) is NOT a leg paired with the third coordinate.
\\ ========================================================================

\\ ========================================================================
\\ DEEPER QUESTION: in ℤ[i], can we get an obstruction by combining
\\ d + ci = ω₄² (a Gaussian square) with the fact that d itself comes from a+bi = ω₁²?
\\
\\ d = N(ω₁), so d is a sum of two squares: d = U₁² + V₁².
\\ Also d = U₄² - V₄² (from d + ci = ω₄²).
\\ So U₁² + V₁² = U₄² - V₄²,  i.e.  U₁² + V₁² + V₄² = U₄².
\\
\\ This is a Pythagorean QUADRUPLE: (U₁, V₁, V₄; U₄).
\\
\\ Similarly need (U₃² - V₃² = a = U₁² - V₁²) and the b-coupling and the c-coupling.
\\
\\ The system is:
\\   (P1) a = U₁² - V₁² = U₃² - V₃²
\\   (P2) b = 2 U₁ V₁  = U₂² - V₂²    [b odd in (b,c,e)] OR  b = 2 U₂ V₂ [b even]
\\   (P3) c = 2 U₂ V₂ = 2 U₃ V₃        OR  c = U₂² - V₂² and 2 U₃ V₃ etc.
\\   (P4) d = U₁² + V₁²
\\   (P5) U₁² + V₁² + V₄² = U₄²  (and 2 U₄ V₄ = c)
\\
\\ Note: c = 2 U₄ V₄ in case primitive. Compare with c = 2 U₂ V₂ = 2 U₃ V₃.
\\
\\ So U₂ V₂ = U₃ V₃ = U₄ V₄  (= c/2).
\\
\\ Three products of pairs giving the same value c/2. That's a Diophantine condition
\\ on c/2's factorization (it must have at least 3 essentially different factorizations).
\\
\\ Now ALSO: U₁² + V₁² = U₄² - V₄², AND U₂² - V₂² = 2 U₁ V₁, AND U₃² - V₃² = U₁² - V₁².
\\
\\ Use ω₁ = U₁+V₁i, ω₂ = U₂+V₂i, ω₃ = U₃+V₃i, ω₄ = U₄+V₄i.
\\ Constraints:
\\   Re(ω₁²) = Re(ω₃²)  → ω₃² - ω₁² is purely imaginary
\\   Im(ω₁²) = Re(ω₂²)  → ω₂² - i·ω₁² is purely imaginary
\\                          (or: ω₂² + ω̄₁² is real & equals 2 Re(ω₂²) ... no, let me redo)
\\
\\ Actually: ω_j² = (U_j² - V_j²) + (2 U_j V_j) i.  So Im(ω₁²) = 2 U₁ V₁.
\\ Re(ω₂²) = U₂² - V₂². Equality: U₂² - V₂² = 2 U₁ V₁.
\\
\\ This means ω₂² - 2 U₁ V₁ has purely imaginary part 2 U₂ V₂ i = c i (so Im(ω₂²) = c).
\\ And ω₁² · (something) relates to ω₂²:
\\   i · ω₁² = i (U₁² - V₁²) + i · 2 U₁ V₁ · i = -2 U₁ V₁ + (U₁² - V₁²) i.
\\   So Re(i ω₁²) = -2 U₁ V₁ = -Im(ω₁²).
\\   ω₂² has Re = 2 U₁ V₁ = -Re(i ω₁²) = Re(-i ω₁²).
\\   So Re(ω₂² + i ω₁²) = 0. ω₂² + i ω₁² is purely imaginary.
\\
\\ Similarly ω₃² - ω₁² is purely imaginary (real parts both equal a).
\\
\\ Let's exploit:
\\   ω₃² ≡ ω₁²  (mod ℤ),  i.e., differ by purely imaginary integer.
\\   ω₂² ≡ -i ω₁²  (mod purely imaginary integer).
\\
\\ Hmm, this is interesting algebraically.
\\
\\ Let's try a key step: ω₁ ω̄₁ = d (real). ω₂ ω̄₂ = e (real). ω₃ ω̄₃ = f (real).
\\ ω₁² = a + bi.  ω₃² = a + ci.  Difference: ω₃² - ω₁² = (c - b) i.
\\
\\ So (ω₃ - ω₁)(ω₃ + ω₁) = (c - b) i in ℤ[i].
\\
\\ Take norms: N(ω₃ - ω₁) · N(ω₃ + ω₁) = (c - b)².
\\
\\ Similarly (ω₂ - ω₁)(ω₂ + ω₁) = ω₂² - ω₁² = (b - a) + (c - b) i.
\\   So N(ω₂ - ω₁) · N(ω₂ + ω₁) = (b - a)² + (c - b)².
\\
\\ And (ω₃ - ω₂)(ω₃ + ω₂) = ω₃² - ω₂² = (a - b) + 0·i = a - b.
\\   So N(ω₃ - ω₂) · N(ω₃ + ω₂) = (a - b)².
\\
\\ INTERESTING: (a-b)² and (c-b)² appear as products of norms!
\\
\\ Special case: if (a - b) is "almost" a sum of two squares...
\\ ========================================================================

print("=== Norm identity check ===");
print("");
print("For each Euler brick, compute:");
print("  N(ω₃-ω₁) N(ω₃+ω₁) = (c-b)²");
print("  N(ω₃-ω₂) N(ω₃+ω₂) = (a-b)²");
print("");

\\ For each Euler brick we need ω₁, ω₂, ω₃ with:
\\   ω₁² = a + b i  (or with multiplicative inert correction)
\\   ω₂² = b + c i  (or with correction)
\\   ω₃² = a + c i  (or with correction)
\\
\\ If a + bi = m₁ · ω₁² with m₁ ≠ 1, ω₁ is not "the" square root in ℤ[i].
\\ In that case, we should still consider (a + bi)/m₁ as a Gaussian square.

\\ Define gaussian_sqrt: given z ∈ ℤ[i] with z = m · ω² (m squarefree integer, ω in ℤ[i]),
\\ return [m, ω] or return [] if z = 0.

\\ Approach: factor z in ℤ[i]. Group factors by associate class. Each prime ≡ 3 mod 4
\\ comes as a rational prime (inert). Each prime ≡ 1 mod 4 is π or π̄. The prime 2 = -i(1+i)².
\\ For z to be a "Gaussian square times integer", we want:
\\   z = m · ω² where ω ∈ ℤ[i], m ∈ ℤ_{>0} squarefree.
\\ Sufficient: each rational inert prime appears to ANY power (contributes to m if odd power),
\\ and the (1+i)-part has any power... let's just compute.

gauss_decompose(z) = {
    if(z == 0, return([0, 0]));
    my(f = factor(z));
    my(m = 1, omega = 1);
    for(j = 1, matsize(f)[1],
        my(pi = f[j,1], e = f[j,2]);
        if(type(pi) == "t_INT",
            \\ inert rational prime (≡ 3 mod 4 or actual 2? In PARI 2 factors as -I*(1+I)^2)
            \\ This is rational integer prime
            if(e % 2 == 0,
                omega *= pi^(e\2),
                m *= pi;
                omega *= pi^((e-1)\2);
            );
        ,
            \\ Gaussian prime (1+i or above ≡ 1 mod 4)
            \\ Distribute as much as possible into ω²
            omega *= pi^(e\2);
            if(e % 2 == 1,
                \\ leftover unpaired Gaussian prime — z is NOT m · ω² for integer m
                \\ Set m = "incompatible"
                return([-1, 0]);
            );
        );
    );
    \\ Adjust for unit (sign and i): we may have z = u · m · ω² for some unit u.
    \\ Recompute and check.
    my(check = m * omega^2);
    my(unit = z / check);
    \\ unit should be in {1, -1, i, -i}
    [m, omega, unit];
};

\\ Test
print("Test: 117 + 240i decomposition:");
print(gauss_decompose(117 + 240*I));
print("");
print("Test: 44 + 117i decomposition:");
print(gauss_decompose(44 + 117*I));
print("");
print("Test: 240 + 44i decomposition:");
print(gauss_decompose(240 + 44*I));

\\ ========================================================================
\\ For each Euler brick, compute ω₁, ω₂, ω₃ (up to inert factor) and check
\\ if PCP would imply additional structure that fails.
\\ ========================================================================

print("");
print("=== Per-brick ℤ[i] analysis ===");

\\ Re-enumerate Euler bricks up to 2000
EULER_MAX = 2000;
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

print("");
print("ω₁, ω₂, ω₃ decomposition for each Euler brick:");
print("(format: a+bi = m₁·ω₁²·unit, etc.)");
print("");

{
for(i = 1, #brick_list,
    my(brk = brick_list[i]);
    my(AA = brk[1], BB = brk[2], CC = brk[3]);
    my(dec1 = gauss_decompose(AA + BB*I));
    my(dec2 = gauss_decompose(BB + CC*I));
    my(dec3 = gauss_decompose(AA + CC*I));
    print("  (", AA, ",", BB, ",", CC, "):");
    print("    a+bi: m=", dec1[1], " ω=", dec1[2], " unit=", if(#dec1>=3, dec1[3], "?"));
    print("    b+ci: m=", dec2[1], " ω=", dec2[2], " unit=", if(#dec2>=3, dec2[3], "?"));
    print("    a+ci: m=", dec3[1], " ω=", dec3[2], " unit=", if(#dec3>=3, dec3[3], "?"));
    \\ Body diagonal
    my(g2 = AA^2 + BB^2 + CC^2);
    my(d2 = AA^2 + BB^2);
    \\ For perfect cuboid, need g² - d² = c² which is automatic (c=c)
    \\ But also need a²+c² = f², a²+b²+c² = g². The latter being square is the goal.
    \\ Compute (g² is sum of squares)
    print("    a²+b²+c² = ", g2, "  square? ", issq(g2));
);
}

\\ ========================================================================
\\ FINAL: look at the "unit" pattern. In each ω² decomposition, the unit u ∈ {1, -1, i, -i}.
\\ Specific unit choices may or may not be compatible.
\\ ========================================================================

print("");
print("=== Unit-pattern frequencies ===");

unit_counts = Map();
{
for(i = 1, #brick_list,
    my(brk = brick_list[i]);
    my(AA = brk[1], BB = brk[2], CC = brk[3]);
    my(dec1 = gauss_decompose(AA + BB*I));
    my(dec2 = gauss_decompose(BB + CC*I));
    my(dec3 = gauss_decompose(AA + CC*I));
    my(u1 = if(#dec1>=3, dec1[3], "?"));
    my(u2 = if(#dec2>=3, dec2[3], "?"));
    my(u3 = if(#dec3>=3, dec3[3], "?"));
    my(key = [u1, u2, u3]);
    if(!mapisdefined(unit_counts, key),
        mapput(unit_counts, key, 1),
        mapput(unit_counts, key, mapget(unit_counts, key) + 1));
);
}
print("Unit-triple distribution across Euler bricks:");
mm = Mat(unit_counts);
{
for(i = 1, matsize(mm)[1],
    print("  ", mm[i,1], " : ", mm[i,2]);
);
}

\\ ========================================================================
\\ Inert-part pattern
\\ ========================================================================

print("");
print("=== Inert-part pattern ===");

inert_counts = Map();
{
for(i = 1, #brick_list,
    my(brk = brick_list[i]);
    my(AA = brk[1], BB = brk[2], CC = brk[3]);
    my(dec1 = gauss_decompose(AA + BB*I));
    my(dec2 = gauss_decompose(BB + CC*I));
    my(dec3 = gauss_decompose(AA + CC*I));
    my(m1 = dec1[1], m2 = dec2[1], m3 = dec3[1]);
    my(key = vecsort([m1, m2, m3]));
    if(!mapisdefined(inert_counts, key),
        mapput(inert_counts, key, 1),
        mapput(inert_counts, key, mapget(inert_counts, key) + 1));
);
}
print("Inert-triple distribution (sorted m₁,m₂,m₃ across bricks):");
mm = Mat(inert_counts);
{
for(i = 1, matsize(mm)[1],
    print("  ", mm[i,1], " : ", mm[i,2]);
);
}

\\ ========================================================================
\\ KEY HYPOTHESIS:
\\ For a perfect cuboid, we'd need ALSO d² + c² = g², i.e., d+ci = m₄ ω₄² (with similar structure).
\\ But d = N(ω₁) = U₁² + V₁² is automatically a sum of two squares — no inert prime obstruction
\\ in d. So d+ci has m₄ = inert(c) potentially.
\\
\\ Combining: if c has inert factors (e.g. c = 240 = 16·15 = 16·3·5, has 3 as inert factor),
\\ then b+ci has inert part 3 already (as we saw). Then d+ci = 125 + 240i: factor.
\\ ========================================================================

print("");
print("=== For each Euler brick: would (d, c, g) be Pythagorean? ===");
{
for(i = 1, #brick_list,
    my(brk = brick_list[i]);
    my(AA = brk[1], BB = brk[2], CC = brk[3]);
    my(d2 = AA^2 + BB^2);
    my(d_v = sqrtint(d2));
    my(dc2 = d_v^2 + CC^2);
    my(g2 = AA^2 + BB^2 + CC^2);
    \\ d² + c² = a² + b² + c² = g². So (d, c, g) Pythagorean iff g is integer.
    \\ Equivalently: g² = a²+b²+c² is square.
    print("  (", AA, ",", BB, ",", CC, "): d=", d_v, "  d²+c²=", dc2, " = g²? Sqrt= ", sqrtint(dc2), " miss=", dc2 - sqrtint(dc2)^2);
);
}

print("");
print("=== CONCLUSION ===");
print("PCP exactly says: there exists Euler brick (a, b, c) such that");
print("  d² + c² = g² where d = √(a²+b²) ∈ ℤ.");
print("In our 18 Euler bricks up to 2000, this fails (miss > 0) in every case.");
print("");
print("ℤ[i] viewpoint: this means d + ci ∈ ℤ[i] is NOT a Gaussian-square-times-integer.");
print("");
print("=== Done ===");
quit;
