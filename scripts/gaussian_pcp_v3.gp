\\ Gaussian integer ℤ[i] reformulation search for PCP

default(parisize, "1G");

issq(n) = if(type(n) != "t_INT", return(0)); if(n < 0, return(0)); my(s = sqrtint(n)); s*s == n;

\\ Find all c such that A² + c² is a square, c ≥ 1, c ≤ CMAX.
c_squares_for_A(AA, CMAX) = {
    my(L = List(), A2 = AA^2);
    fordiv(A2, K,
        if(K >= AA, break);
        my(Q = A2/K);
        if((Q - K) % 2 != 0, next);
        my(cc = (Q - K) / 2);
        if(cc >= 1 && cc <= CMAX, listput(L, cc));
    );
    Vec(L);
};

\\ ========================================================================
\\ APPROACH 1: enumerate primitive Pythagorean (A,B,D), scale by K, search c
\\ ========================================================================

DMAX = 400;
CMAX = 10000;

ptriples = List();
{
for(UU = 2, sqrtint(DMAX),
    for(VV = 1, UU - 1,
        if(gcd(UU, VV) != 1, next);
        if((UU + VV) % 2 == 0, next);
        my(DD = UU^2 + VV^2);
        if(DD > DMAX, next);
        my(AA = UU^2 - VV^2, BB = 2*UU*VV);
        listput(ptriples, [AA, BB, DD, UU, VV]);
    );
);
}
ptriples = Vec(ptriples);
print("Primitive Pythagorean triples with D ≤ ", DMAX, ": ", #ptriples);

cuboid_count = 0;
brick_count = 0;
brick_list = List();
{
for(idx = 1, #ptriples,
    my(trp = ptriples[idx]);
    my(A0 = trp[1], B0 = trp[2], D0 = trp[3], U1 = trp[4], V1 = trp[5]);
    my(K_max = CMAX \ max(A0, B0));
    for(KK = 1, K_max,
        my(AA = KK * A0, BB = KK * B0);
        my(c_list = c_squares_for_A(AA, CMAX));
        for(jj = 1, #c_list,
            my(cc = c_list[jj]);
            if(!issq(BB^2 + cc^2), next);
            brick_count += 1;
            if(#brick_list < 30, listput(brick_list, [AA, BB, cc, U1, V1, KK]));
            if(issq(AA^2 + BB^2 + cc^2),
                cuboid_count += 1;
                print("*** PERFECT CUBOID FOUND: a=", AA, " b=", BB, " c=", cc, " (from ω1=", U1, "+", V1, "i, scale=", KK, ")");
            );
        );
    );
);
}

print("");
print("Total Euler bricks (a,b,c face-diagonals integer, a,b,c ≤ ", CMAX, ") found via this enumeration: ", brick_count);
print("Total perfect cuboids: ", cuboid_count);

brick_list = Vec(brick_list);
print("");
print("First Euler bricks (with ω1 parametrization):");
{
for(i = 1, #brick_list,
    my(b = brick_list[i]);
    my(AA = b[1], BB = b[2], cc = b[3]);
    my(g2 = AA^2 + BB^2 + cc^2);
    my(gf = sqrtint(g2));
    print("  (", AA, ", ", BB, ", ", cc, ") | ω1=", b[4], "+", b[5], "i | k=", b[6], " | g²=", g2, " | miss=", g2-gf^2);
);
}

\\ ========================================================================
\\ APPROACH 2: ω₁, ω₂, ω₃ coupling enumeration
\\ Build map: (P, Q) ordered with P<Q, where P²+Q² = square, → list of ω = U+Vi
\\ that yield this (P, Q) as |Re(ω²)|, |Im(ω²)|.
\\ Then for each (a, b), search for c shared.
\\ ========================================================================

print("");
print("=== Approach 2: Direct ℤ[i] coupling enumeration ===");

NBOUND_UV = 200;  \\ U, V each ≤ 200 → ω² has magnitude up to ~80000

\\ Build map key → list of (U, V)
\\ The key is the UNORDERED pair {|U²-V²|, 2UV} (since Pythagorean leg pair).
pmap = Map();
{
for(UU = 1, NBOUND_UV,
    for(VV = 0, UU,
        if(UU == 0 && VV == 0, next);
        if(UU == VV, next);  \\ would give P = 0
        my(P = abs(UU^2 - VV^2), Q = 2*UU*VV);
        if(P == 0 || Q == 0, next);
        my(key = if(P < Q, [P, Q], [Q, P]));
        if(!mapisdefined(pmap, key),
            mapput(pmap, key, [[UU, VV]]),
            my(L = mapget(pmap, key));
            mapput(pmap, key, concat(L, [[UU, VV]]));
        );
    );
);
}
print("Number of distinct Pythagorean leg-pairs in map: ", #pmap);

\\ Build leg → {legs it can pair with} map
leglist = Map();
{
mm = Mat(pmap);
ks = mm[,1];
for(idx = 1, #ks,
    my(kk = ks[idx]);
    my(P = kk[1], Q = kk[2]);
    if(!mapisdefined(leglist, P),
        mapput(leglist, P, [Q]),
        mapput(leglist, P, concat(mapget(leglist, P), [Q]))
    );
    if(!mapisdefined(leglist, Q),
        mapput(leglist, Q, [P]),
        mapput(leglist, Q, concat(mapget(leglist, Q), [P]))
    );
);
}
print("Number of distinct legs that appear in some Pythagorean pair: ", #leglist);

\\ Now for each pair (a, b) where (a, b) is a key in pmap, search for c such that
\\ (a, c) and (b, c) are also keys. Then check body diagonal.
brick_set = Set();
cuboid_set = Set();
mm = Mat(pmap);
ks = mm[,1];
{
for(idx = 1, #ks,
    my(kk = ks[idx]);
    my(AA = kk[1], BB = kk[2]);
    my(legsA = Set(mapget(leglist, AA)));
    my(legsB = Set(mapget(leglist, BB)));
    my(shared = setintersect(legsA, legsB));
    for(j = 1, #shared,
        my(cc = shared[j]);
        if(cc == AA || cc == BB, next);
        my(sorted = vecsort([AA, BB, cc]));
        brick_set = setunion(brick_set, [sorted]);
        if(issq(AA^2 + BB^2 + cc^2),
            cuboid_set = setunion(cuboid_set, [sorted]);
            print("*** CUBOID candidate: ", sorted);
        );
    );
);
}

brick_set = Vec(brick_set);
cuboid_set = Vec(cuboid_set);
print("");
print("Unique Euler bricks (face-diagonal-only, a,b,c representable as legs in pmap): ", #brick_set);
print("Perfect cuboids: ", #cuboid_set);

print("");
print("First 20 Euler bricks (sorted):");
brick_sorted = vecsort(brick_set, 1);
{
for(i = 1, min(20, #brick_sorted),
    my(b = brick_sorted[i]);
    my(g2 = b[1]^2 + b[2]^2 + b[3]^2);
    my(gf = sqrtint(g2));
    my(miss = g2 - gf^2);
    print("  ", b, "  g²=", g2, "  miss=", miss, "  g²/floor(√g²)² ratio close to 1: ", g2*1.0/(gf^2));
);
}

\\ ========================================================================
\\ STATISTICAL: distribution of "miss" g² - floor(√g²)²
\\ This tells us how "close" Euler bricks come to being cuboids.
\\ ========================================================================

print("");
print("=== Statistical analysis of body-diagonal deficiency ===");

miss_dist = List();
{
for(i = 1, #brick_sorted,
    my(b = brick_sorted[i]);
    my(g2 = b[1]^2 + b[2]^2 + b[3]^2);
    my(gf = sqrtint(g2));
    listput(miss_dist, g2 - gf^2);
);
}
miss_dist = Vec(miss_dist);

\\ Count of zeros = # perfect cuboids
zeros = sum(i=1, #miss_dist, if(miss_dist[i] == 0, 1, 0));
print("  Perfect cuboids (miss = 0): ", zeros);
print("  Total Euler bricks: ", #miss_dist);
print("  Fraction = ", zeros*1.0/max(#miss_dist,1));

\\ ========================================================================
\\ KEY OBSERVATION: in the ℤ[i] framework, what does PCP become?
\\
\\ a + bi = ω₁², b + ci = ω₂', a + ci = ω₃².
\\ where ω₂' is either ω₂² or i·ω₂² depending on parity of b in (b,c,e).
\\
\\ The four conditions:
\\   (1) a + bi = ω₁²
\\   (2) b + ci = ω₂²  (or i·ω₂²)
\\   (3) a + ci = ω₃²  (or i·ω₃²)
\\   (4) d² + c² = g²  where d = ω₁ω̄₁ = N(ω₁)
\\
\\ Equation (4) says d+ci = ω₄² for some ω₄.
\\
\\ Now: d = N(ω₁) = ω₁·ω̄₁. And d = Re(ω₄²) = u₄² - v₄².
\\ So ω₁·ω̄₁ = ω₄² - (i v₄)² = (ω₄ - i v₄)(ω₄ + i v₄).
\\
\\ Note ω₄ - i v₄ = u₄ + v₄ i - i v₄ = u₄.  (Real!)
\\ And  ω₄ + i v₄ = u₄ + v₄ i + i v₄ = u₄ + 2 v₄ i.  (Hmm, not factoring nicely.)
\\ Actually: ω₄ = u₄ + v₄ i.  iv₄ = i v₄ = v₄ i (yes).
\\ So ω₄ - i v₄ = u₄ + v₄ i - v₄ i = u₄.  Yes real.
\\ ω₄ + i v₄ = u₄ + 2 v₄ i.
\\
\\ So d = u₄ · (u₄ + 2 v₄ i)?? But d is real, and RHS has imaginary part. Mistake.
\\
\\ Let me redo: d = u₄² - v₄². As real factorization: d = (u₄-v₄)(u₄+v₄). Standard.
\\
\\ In ℤ[i]: d = u₄² - v₄² = u₄² + (i v₄)². Wait that's u₄² - v₄² = (u₄+iv₄)(u₄-iv₄) − but
\\ (u₄+iv₄)(u₄-iv₄) = u₄² + v₄². That's d = u₁²+v₁², the OTHER one.
\\
\\ Recall d = N(ω₁) = u₁²+v₁² = (u₁+v₁i)(u₁-v₁i).
\\ And d = u₄²-v₄² in ℤ.
\\
\\ So (u₁+v₁i)(u₁-v₁i) = u₄²-v₄² = (u₄-v₄)(u₄+v₄)
\\
\\ In ℤ[i]: LHS is a Gaussian prime factorization (if d is prime ≡ 1 mod 4).
\\ RHS is two real integers. So u₄-v₄ and u₄+v₄ must split between Gaussian primes.
\\
\\ Specifically: u₁+v₁i is "the" Gaussian prime above d (unique up to unit & conj).
\\ Then u₄-v₄ = (u₁+v₁i)(unit/conj-choice) ... but u₄-v₄ is REAL.
\\ So u₄-v₄ must be a product where complex factors pair with their conjugates.
\\ But d = (u₁+v₁i)(u₁-v₁i), so the only way to split d into two real positive
\\ factors with gcd 1 is d = 1 · d.
\\
\\ Thus if d is prime ≡ 1 mod 4: u₄ - v₄ = 1, u₄ + v₄ = d, so u₄ = (d+1)/2, v₄ = (d-1)/2.
\\ This is unique.
\\
\\ Therefore: if d (the hypotenuse of (a,b,d)) is PRIME (and ≡ 1 mod 4), then
\\ ω₄ = (d+1)/2 + (d-1)/2 · i is forced (up to unit). Then:
\\   c = 2 u₄ v₄ = 2 · (d+1)/2 · (d-1)/2 = (d²-1)/2.
\\
\\ So c is determined by d! Let's check if PCP can hold with this c.
\\
\\ For PCP we need (a, c, f) and (b, c, e) Pythagorean. Substituting c = (d²-1)/2.
\\ ========================================================================

print("");
print("=== Forced c when d is prime ≡ 1 mod 4 ===");
{
for(idx = 1, min(20, #ptriples),
    my(trp = ptriples[idx]);
    my(A0 = trp[1], B0 = trp[2], D0 = trp[3]);
    if(!isprime(D0), next);
    if(D0 % 4 != 1, next);
    my(c_forced = (D0^2 - 1) / 2);
    my(check_a = issq(A0^2 + c_forced^2));
    my(check_b = issq(B0^2 + c_forced^2));
    my(check_g = issq(A0^2 + B0^2 + c_forced^2));
    print("  D=", D0, " (prime ≡ 1 mod 4): a=", A0, " b=", B0, " forced c=", c_forced,
          "  | a²+c² sq? ", check_a, "  | b²+c² sq? ", check_b, "  | g² sq? ", check_g);
);
}

\\ Note: if D is NOT prime, there are MORE choices of ω₄ (and possibly other ω₁'s
\\ giving the same N(ω₁)=d). This is when PCP could potentially survive.

print("");
print("=== Multi-factor d analysis (composite d allows more ω₄ choices) ===");
print("Counting ω₄ choices for various d values:");
{
for(DD = 5, 100,
    \\ Number of ways to write DD = u₄² - v₄² with u₄ > v₄ > 0:
    my(nways = 0);
    fordiv(DD, K,
        if(K^2 >= DD, break);
        my(Q = DD/K);
        if((Q - K) % 2 != 0, next);
        nways += 1;
    );
    \\ Number of ω₁ = u₁+v₁i with u₁²+v₁² = DD and u₁,v₁ ≥ 0:
    my(nway1 = 0);
    for(uu = 0, sqrtint(DD),
        my(vv2 = DD - uu^2);
        if(vv2 >= 0 && issq(vv2), nway1 += 1);
    );
    if(nway1 > 0 && nways >= 1,
        print("  d=", DD, ": #(ω₁ rep) = ", nway1, ", #(ω₄ rep, i.e. d=u²-v²) = ", nways);
    );
);
}

print("");
print("=== Done ===");
quit;
