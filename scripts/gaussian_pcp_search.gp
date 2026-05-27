\\ Gaussian integer ℤ[i] reformulation search for PCP
\\ ===================================================
\\
\\ Setup:
\\ For each Pythagorean triple (x,y,z) with x²+y²=z², primitive with x odd y even,
\\ there exists (u,v) coprime, u>v>0, u+v odd, such that:
\\   x = u² - v², y = 2uv, z = u² + v²
\\ Equivalently: x+yi = (u+vi)² and z = N(u+vi) = u²+v²
\\
\\ For PCP we need (a,b), (b,c), (a,c) all Pythagorean, plus a²+b²+c²=g².
\\ The hardest constraint: legs are SHARED. This is the source of difficulty.
\\
\\ Strategy: enumerate ω₁ = u₁+v₁i with N(ω₁) ≤ B.
\\ Get (a,b) from ω₁² (with possible swap, sign, *i adjustments).
\\ Then search ω₂, ω₃ with matching legs.

default(parisize, "512M");

\\ Generate list of (u,v) representations for Pythagorean leg encodings.
\\ A Pythagorean triple (x,y,z) primitive has many parameterizations depending on
\\ which leg is "u²-v²" type and which is "2uv" type. We consider both legs as
\\ candidate values for a, b, or c.

\\ For each primitive Pythagorean triple, list possible (smaller_leg, larger_leg, hyp).
\\ But for shared-leg analysis we need NON-primitive triples too (since a,b,c may
\\ have any GCD structure).

\\ Approach: directly enumerate (a, b) pairs with a²+b² square, then check shared-leg
\\ constraints. Use ℤ[i] to recognize a²+b² = N(ω₁²) structure.

is_square(n) = if(n<0, return(0); ); my(s=sqrtint(n)); s*s == n;

\\ List all c in [1, B] for which a²+c² and b²+c² are both squares,
\\ given a Pythagorean pair (a, b, d).

\\ FAST: list all (a, b) with a²+b² square and max(a,b) ≤ B.
gen_pyth_pairs(B) = {
    my(L = List(), d2);
    for(a=3, B,
        for(b=4, B,
            if(b<=a, next);
            d2 = a^2 + b^2;
            if(is_square(d2),
                listput(L, [a, b, sqrtint(d2)]);
            );
        );
    );
    Vec(L);
};

\\ Check PCP candidate (a, b, c)
check_pcp(a, b, c) = {
    is_square(a^2+b^2) && is_square(b^2+c^2) && is_square(a^2+c^2) && is_square(a^2+b^2+c^2);
};

\\ Verify the ℤ[i] reduction: if (a,b,d) Pythagorean and (a,c,f) Pythagorean,
\\ what does sharing leg a impose on the Gaussian integers ω₁, ω₃?
\\
\\ ω₁² has Re = ±a or ±b (depending on convention), Im = ±b or ±a.
\\ Take convention: a = u₁² - v₁², b = 2 u₁ v₁ (so a odd if primitive, b even).
\\ Then ω₁ = u₁ + v₁ i with N(ω₁) = u₁²+v₁² = d.
\\
\\ For (a,c,f) Pythagorean with shared a: a = u₃² - v₃², c = 2 u₃ v₃.
\\ Both u₁²-v₁² = u₃²-v₃² = a. So (u₁-v₁)(u₁+v₁) = (u₃-v₃)(u₃+v₃).

\\ This is the key Diophantine condition. Let's investigate it.

\\ Coupling: a = u₁² - v₁² = u₃² - v₃²
\\ Let s₁ = u₁+v₁, t₁ = u₁-v₁ (both positive, both odd since u₁+v₁ odd in primitive case).
\\ Then a = s₁ t₁ = s₃ t₃ — same product, different factorizations.
\\ So a admits two distinct factorizations as product of two coprime odd numbers
\\ (one being the difference, one the sum, of two coprime integers).

\\ Equivalently: a must have at least 2 distinct ways to be written as (u-v)(u+v).
\\ This happens iff a has multiple factorizations a = s·t with s<t, gcd(s,t)=1, both odd.
\\ Number of such factorizations = 2^(ω(a)-1) where ω(a) = number of distinct odd prime factors.

\\ Since (a,b,d) and (a,c,f) are BOTH Pythagorean with leg a, we need a to have
\\ ≥ 2 prime factors (each ≡ 1 or 3 mod 4 doesn't matter for THIS factorization).

\\ This is a NEW reformulation insight: a must be "composite enough".

\\ Now: what about the OTHER conditions?
\\ b shared by (a,b,d) and (b,c,e): b = 2 u₁ v₁ = u₂² - v₂² OR b = 2 u₁ v₁ = 2 u₂ v₂
\\ depending on whether b is the "even" leg or "odd" leg in (b,c,e).
\\
\\ If (b,c,e) primitive: exactly one of b, c is even. Since b is already even in (a,b,d)
\\ (assuming primitive), and c could be even or odd...
\\
\\ Case analysis gets complex. Let's just brute-force search.

\\ ========================================================================
\\ MAIN SEARCH
\\ ========================================================================

\\ Enumerate ω₁ = u₁+v₁i with u₁>v₁≥1, gcd(u₁,v₁)=1, u₁+v₁ odd:
\\ This generates primitive Pythagorean triples (a,b,d).

\\ Then search for c such that (a,c) and (b,c) are both Pythagorean legs of integer triples.

bound_d = 200;  \\ N(ω₁) ≤ 200, gives d ≤ 200

\\ Generate primitive (a, b, d):
prim_triples = List();
for(u=2, sqrtint(bound_d),
    for(v=1, u-1,
        if(gcd(u,v) != 1, next);
        if((u+v) % 2 == 0, next);
        my(d = u^2 + v^2);
        if(d > bound_d, next);
        my(a = u^2 - v^2, b = 2*u*v);
        \\ Convention: a is odd leg, b is even leg
        listput(prim_triples, [a, b, d, u, v]);
    );
);
prim_triples = Vec(prim_triples);
print("Primitive Pythagorean triples with d ≤ ", bound_d, ": ", #prim_triples);

\\ For each primitive (a,b,d), we want to find c such that:
\\   a²+c² is square (call f)
\\   b²+c² is square (call e)
\\   a²+b²+c² is square (call g)
\\
\\ We allow multiples k·(a,b,d) and arbitrary c.
\\ But the structure is preserved under scaling, so let's first search at primitive level
\\ then think about scaling.

\\ Step: for each primitive (a₀, b₀, d₀), and each scale factor k:
\\   a = k·a₀, b = k·b₀
\\ Then search c.

\\ Note: c may share GCD with k. We need a, b, c with GCD = 1 (primitive cuboid case).

cuboid_search(a, b, c_max) = {
    my(found = List(), c);
    for(c=1, c_max,
        if(!is_square(b^2 + c^2), next);
        if(!is_square(a^2 + c^2), next);
        if(!is_square(a^2 + b^2 + c^2), next);
        listput(found, c);
    );
    Vec(found);
};

\\ More efficient: enumerate c such that a²+c² square, then check others.
\\ a²+c² = f² means (f-c)(f+c) = a². So c = (a²/k - k)/2 for divisor k of a² with k < a, k same parity as a²/k.

c_candidates_for_a(a) = {
    my(L = List(), a2 = a^2);
    fordiv(a2, k,
        if(k >= a, break);
        my(q = a2/k);
        if((q-k) % 2 != 0, next);
        my(c = (q-k)/2);
        if(c >= 1, listput(L, c));
    );
    Vec(L);
};

\\ For each (a, b, d), find common c such that both a²+c² and b²+c² are squares.

print("Searching primitive base + scaling for cuboid...");

c_max = 1000;
results = List();

for(idx=1, #prim_triples,
    my(trp = prim_triples[idx]);
    my(a0=trp[1], b0=trp[2], d0=trp[3], uu=trp[4], vv=trp[5]);
    \\ Try scales k from 1 to bound such that k*max(a0,b0) ≤ c_max
    my(k_max = c_max \ max(a0, b0));
    for(k=1, k_max,
        my(a = k*a0, b = k*b0);
        \\ Find c such that a²+c² square (intersect with b²+c² square)
        my(c_list_a = c_candidates_for_a(a));
        for(j=1, #c_list_a,
            my(c = c_list_a[j]);
            if(c > c_max, next);
            if(!is_square(b^2 + c^2), next);
            if(!is_square(a^2 + b^2 + c^2), next);
            listput(results, [a, b, c, "ω1=", uu+vv*I, "k=", k]);
        );
    );
);

results = Vec(results);
print("PCP candidates found: ", #results);
for(i=1, min(20, #results), print("  ", results[i]));

\\ ========================================================================
\\ Now: theoretical structure
\\ ========================================================================

print("");
print("=== Coupling analysis ===");

\\ For shared leg a between (a,b,d) and (a,c,f):
\\ a = u₁²-v₁² = u₃²-v₃²
\\ This means a admits two factorizations a = (u-v)(u+v).
\\ Each such factorization is parametrized by writing a = s·t with s<t, s≡t mod 2, gcd(s,t)/2?...
\\
\\ For primitive triple: u, v coprime, opposite parity → s=u-v, t=u+v both odd, gcd(s,t)=1.
\\ So number of primitive Pythagorean parametrizations of a is 2^(ω(a)-1) where ω = # distinct odd primes.

\\ Verify: a=15 = 3·5. Factorizations into coprime odd s<t:
\\ 1·15 → u=8, v=7 → triple (15, 112, 113)
\\ 3·5 → u=4, v=1 → triple (15, 8, 17)
\\ So a=15 gives 2 primitive triples: (15,112,113) and (15,8,17). Check: 2^(2-1)=2. ✓

\\ For (a,b,d) and (a,c,f) sharing a, with primitive d≠f:
\\ Both arise from different factorizations of a.
\\ Each factorization gives even leg b = 2uv.

\\ Now: a=15 case. (a,b,d) = (15,8,17), (a,c,f) = (15,112,113).
\\ Then b=8, c=112. (b,c)=(8,112) gcd=8. b²+c² = 64 + 12544 = 12608. sqrt = 112.28... NOT square.
\\ So this doesn't yield a cuboid, but illustrates the structure.

\\ ========================================================================
\\ Question: does the ℤ[i] structure give a deeper obstruction?
\\ ========================================================================
\\
\\ Consider the system over ℤ[i]:
\\   ω₁² has real part a, imag part b
\\   ω₂² has real part b, imag part c  (b = u₂²-v₂², c = 2u₂v₂)
\\   ω₃² has real part a, imag part c  (a = u₃²-v₃², c = 2u₃v₃)
\\
\\ Then:
\\   Re(ω₁²) = Re(ω₃²): u₁²-v₁² = u₃²-v₃²  →  (u₁-v₁)(u₁+v₁) = (u₃-v₃)(u₃+v₃)
\\   Im(ω₁²) = Re(ω₂²): 2u₁v₁ = u₂²-v₂²  →  2u₁v₁ = (u₂-v₂)(u₂+v₂)
\\   Im(ω₂²) = Im(ω₃²): 2u₂v₂ = 2u₃v₃   →  u₂v₂ = u₃v₃
\\
\\ Plus body diagonal: a²+b²+c² = g²
\\   (u₁²+v₁²)² + c² = g² (since a²+b² = (u₁²+v₁²)²)
\\   So (u₁²+v₁², c, g) is Pythagorean: d²+c²=g².
\\
\\ Iterating: d+ci = ω₄² for some ω₄ = u₄+v₄i. Then:
\\   d = u₄²-v₄² = u₁²+v₁²
\\   c = 2u₄v₄
\\
\\ From u₂v₂ = u₃v₃ AND c = 2u₂v₂ = 2u₃v₃ = 2u₄v₄:
\\   u₂v₂ = u₃v₃ = u₄v₄
\\
\\ Three different factorizations of c/2 = u·v with u,v coprime opposite parity?
\\ NOT necessarily coprime opposite parity (only if primitive).
\\
\\ Also u₂²-v₂² = b = 2u₁v₁, and u₁²+v₁² = u₄²-v₄².

\\ Let's write the system more cleanly. Substitute:
\\   d = u₁²+v₁² = u₄²-v₄²
\\
\\ This is a NEW Diophantine equation: u₁²+v₁²+v₄² = u₄².
\\ Three squares summing to a square — a classical "Pythagorean quadruple"!

\\ So PCP forces (u₁, v₁, v₄, u₄) to be a Pythagorean quadruple.

print("");
print("=== Key insight: PCP implies Pythagorean quadruple (u₁, v₁, v₄, u₄) ===");
print("    where ω₁ = u₁+v₁i parametrizes Pythagorean triple (a,b,d),");
print("    and ω₄ = u₄+v₄i parametrizes Pythagorean triple (d,c,g).");
print("");

\\ Pythagorean quadruples are well-understood and infinite. So this is NOT an obstruction.
\\ But combined with the other coupling conditions, it may be.

\\ Pythagorean quadruples parametrization: every primitive quadruple (x,y,z,w)
\\ with x²+y²+z²=w² has form
\\   x = m² + n² - p² - q²
\\   y = 2(mq + np)
\\   z = 2(nq - mp)
\\   w = m² + n² + p² + q²
\\ (Lebesgue parametrization).

\\ Our quadruple is (u₁, v₁, v₄, u₄): u₁²+v₁²+v₄² = u₄².
\\ So u₄ = m²+n²+p²+q², and {u₁, v₁, v₄} = {m²+n²-p²-q², 2(mq+np), 2(nq-mp)} in some order.

\\ Adds another layer: PCP requires consistent parametrizations at TWO levels.

\\ ========================================================================
\\ Let's also test: does ω₁² ω₂² ω₃² have special structure?
\\ ========================================================================
\\
\\ ω₁² · conj(ω₂²) · ω₃² ... random multiplications won't reveal much.
\\
\\ But: a + bi = ω₁², b + ci = ω₂², a + ci = ω₃².
\\ Then ω₃² - ω₁² = (a+ci) - (a+bi) = (c-b)i = i(c-b).
\\ So (ω₃-ω₁)(ω₃+ω₁) = i(c-b).
\\
\\ Similarly ω₂² - ω₁² = (b+ci)-(a+bi) = (b-a) + (c-b)i.
\\ And ω₃² - ω₂² = (a-b) + 0·i (Wait, both have imag part c, so ω₃² - ω₂² = a-b real).
\\ So (ω₃-ω₂)(ω₃+ω₂) = a-b ∈ ℤ.

\\ Interesting! a - b is the norm of (ω₃-ω₂)(ω₃+ω₂)/... let's think.
\\ If (ω₃-ω₂)(ω₃+ω₂) = a-b is a REAL integer, then in ℤ[i] this means
\\ ω₃² - ω₂² is purely real, which we already knew (both have imag part c).

\\ So Im(ω₃² - ω₂²) = 0 says c is the same in both — tautology.

\\ Let's try ω₃² · conj(ω₂²) = (a+ci)(b-ci) = ab + c² + (bc-ac)i = (ab+c²) + c(b-a)i.
\\ Norm of this is N(ω₃)² · N(ω₂)² = f²·e².
\\ Also (ab+c²)² + c²(b-a)² = f²e² ... interesting identity but not obviously useful.

print("=== Done ===");
quit;
