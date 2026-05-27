\\ Gaussian integer ℤ[i] reformulation search for PCP
\\ (Avoid PARI default polynomial variable names a,b,c,d,e,f,g,x,y,z,t,u,v,w)

default(parisize, "512M");

issq(n) = if(type(n) != "t_INT", return(0)); if(n < 0, return(0)); my(s = sqrtint(n)); s*s == n;

\\ For each leg A (the odd leg of a Pythagorean triple), the set of (UU, VV) with
\\ UU² - VV² = A, UU > VV > 0, gcd(UU,VV)=1, UU+VV odd, parametrizes the primitive
\\ Pythagorean triples (A, 2*UU*VV, UU²+VV²) with leg A.

\\ Enumerate primitive Pythagorean triples with hypotenuse ≤ DMAX
\\ Return list of [A_odd, B_even, D, UU, VV]

prim_pyth_triples(DMAX) = {
    my(L = List());
    for(UU = 2, sqrtint(DMAX),
        for(VV = 1, UU - 1,
            if(gcd(UU, VV) != 1, next);
            if((UU + VV) % 2 == 0, next);
            my(DD = UU^2 + VV^2);
            if(DD > DMAX, next);
            my(AA = UU^2 - VV^2, BB = 2*UU*VV);
            listput(L, [AA, BB, DD, UU, VV]);
        );
    );
    Vec(L);
};

\\ Find all c such that A² + c² is a square, c ≥ 1, c ≤ CMAX.
\\ A² + c² = F² ⇒ (F-c)(F+c) = A². So F-c = K, F+c = A²/K for divisor K of A² with K < A.
\\ Need K and A²/K same parity, c = (A²/K - K)/2.

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
\\ MAIN SEARCH: enumerate (A, B, D) primitive with D ≤ DMAX, scale by K,
\\ then find c such that B²+c² and A²+B²+c² are also squares.
\\ ========================================================================

DMAX = 300;
CMAX = 5000;

print("Generating primitive Pythagorean triples up to D = ", DMAX, "...");
ptriples = prim_pyth_triples(DMAX);
print("Number of primitive triples: ", #ptriples);

print("");
print("Searching for cuboid candidates...");
print("(a, b, c) with a²+b², a²+c², b²+c², a²+b²+c² all squares");
print("(Euler bricks excluded — those have a²+c² etc square but NOT body diagonal)");
print("");

cuboid_count = 0;
brick_count = 0;
for(idx = 1, #ptriples,
    my(trp = ptriples[idx]);
    my(A0 = trp[1], B0 = trp[2], D0 = trp[3], U1 = trp[4], V1 = trp[5]);
    my(K_max = CMAX \ max(A0, B0));
    for(KK = 1, K_max,
        my(AA = KK * A0, BB = KK * B0);
        my(c_list = c_squares_for_A(AA, CMAX));
        for(jj = 1, #c_list,
            my(cc = c_list[jj]);
            \\ Need B² + c² square
            if(!issq(BB^2 + cc^2), next);
            \\ This is an Euler brick (face diagonals all integer)
            brick_count += 1;
            \\ Check body diagonal
            if(issq(AA^2 + BB^2 + cc^2),
                cuboid_count += 1;
                print("*** CUBOID: a=", AA, " b=", BB, " c=", cc);
            );
            if(brick_count <= 10,
                print("Euler brick: (", AA, ", ", BB, ", ", cc, ") d=", sqrtint(AA^2+BB^2), " e=", sqrtint(BB^2+cc^2), " f=", sqrtint(AA^2+cc^2));
            );
        );
    );
);

print("");
print("Euler bricks found: ", brick_count);
print("Perfect cuboids found: ", cuboid_count);

\\ ========================================================================
\\ ANALYSIS: Coupling conditions in ℤ[i]
\\ ========================================================================

print("");
print("=== Coupling analysis ===");
print("");
print("If (a,b,d), (a,c,f), (b,c,e) all primitive Pythagorean:");
print("a is shared between (a,b,d) and (a,c,f):");
print("  a = U1²-V1² = U3²-V3²  -->  (U1-V1)(U1+V1) = (U3-V3)(U3+V3)");
print("  i.e., a has ≥ 2 essentially different factorizations as product of");
print("  coprime odd factors. Number = 2^(ω_odd(a)-1).");
print("");

\\ Demo: count a such that a has multiple factorizations
print("Count of a ≤ 200 with ≥ 2 essentially different odd factorizations:");
count = 0;
for(AA = 3, 200,
    if(AA % 2 == 0, next);
    \\ Count factorizations a = K*Q with K<Q, gcd(K,Q)=1, both odd
    my(nfact = 0);
    fordiv(AA, K,
        if(K^2 > AA, break);
        if(K == AA, break);
        my(Q = AA/K);
        if(gcd(K, Q) == 1, nfact += 1);
    );
    if(nfact >= 2, count += 1);
);
print("  Count: ", count);

\\ ========================================================================
\\ Test the Pythagorean-quadruple condition: U1² + V1² + V4² = U4²
\\ where ω₁ parametrizes (a,b,d) and ω₄ parametrizes (d,c,g).
\\
\\ If PCP existed, then d = N(ω₁) = U1²+V1² and (d,c,g) Pythagorean means
\\ d = U4²-V4², so U1² + V1² + V4² = U4².
\\ ========================================================================

print("");
print("=== Pythagorean quadruple test ===");
print("Counts of (U1,V1) with U1²+V1² = d, d ≤ 100, having v4,u4 such that");
print("U1²+V1²+v4² = u4² (i.e., d is leg of some Pythagorean triple)...");

\\ d is a leg of a Pythagorean triple iff d² + something = square iff d ≥ 3.
\\ In fact every integer ≥ 3 is a leg of some Pythagorean triple. So this is no obstruction.

\\ Check: for every d ≥ 3, ∃ K such that d²+K² is a square.
\\ E.g. d odd: d² = (K+1)/... actually if d odd, d² = (K+1) - K with K = (d²-1)/2,
\\ so (d, (d²-1)/2, (d²+1)/2) is a triple.
\\ d even, d ≥ 4: (d, (d/2)²-1, (d/2)²+1) works.

print("Every d ≥ 3 is a leg of some Pythagorean triple. So this condition alone is no obstruction.");
print("But the COUPLED system (all three triples sharing legs) is restrictive.");

\\ ========================================================================
\\ Search at the (ω₁, ω₂, ω₃) level: pure Gaussian integer enumeration
\\ Look for triples (ω₁, ω₂, ω₃) with the coupling
\\   Re(ω₁²) = Re(ω₃²)  (= a)
\\   Im(ω₁²) = Re(ω₂²)  (= b)  [if b is "u²-v²" type in (b,c,e)]
\\   Im(ω₂²) = Im(ω₃²)  (= c)
\\ ========================================================================

print("");
print("=== Direct (ω₁, ω₂, ω₃) enumeration ===");

\\ Brute force over Gaussian integers with N(ω) ≤ NBOUND
NBOUND = 5000;

\\ Map: for each (Re, Im) of ω², record [ω]
\\ Then for each (a, b), find ω₁ with Re=a, Im=b
\\         for each (a, c), find ω₃ with Re=a, Im=c
\\         for each (b, c), find ω₂ with Re=b, Im=c

\\ Build a hash from (Re(ω²), Im(ω²)) → list of (UU, VV)
\\ Note ω = UU+VV*I, ω² = (UU²-VV²) + (2*UU*VV)*I.
\\ We allow UU, VV ∈ ℤ (positive integers, or zero for VV).
\\ Sign and unit choices: we may also consider i·ω², which gives (-2UV) + (U²-V²)i,
\\ effectively swapping the role of the two legs.

\\ For simplicity: enumerate over UU ≥ 0, VV ≥ 0 (not both zero), and store all
\\ (U²-V², 2UV) and (2UV, U²-V²) and (U²-V², -2UV) etc. as "Pythagorean leg pairs".

print("Building Pythagorean-pair map for N ≤ ", NBOUND, "...");

\\ Map (P, Q) with P² + Q² = N(ω)² → (UU, VV)
\\ We focus on P, Q ≥ 0 (signs handled by choosing orientation).

pmap = Map();
for(UU = 0, sqrtint(NBOUND),
    for(VV = 0, sqrtint(NBOUND - UU^2),
        if(UU == 0 && VV == 0, next);
        \\ ω² = (U²-V²) + (2UV)i
        my(P = UU^2 - VV^2, Q = 2*UU*VV);
        \\ Two orientations: (P,Q) and (Q,-P) [from i·ω²].
        \\ Consider all sign flips: (|P|, |Q|) is enough since we want positive legs.
        my(P1 = abs(P), Q1 = abs(Q));
        \\ Also (Q1, P1) from i·ω² (where (Re, Im) → (-Im, Re)). Same magnitudes.
        \\ Record the unordered pair {P1, Q1}.
        if(P1 > 0 && Q1 > 0 && gcd(P1, Q1) >= 1,
            my(key = if(P1 < Q1, [P1, Q1], [Q1, P1]));
            if(!mapisdefined(pmap, key),
                mapput(pmap, key, [[UU, VV]]),
                my(L = mapget(pmap, key));
                mapput(pmap, key, concat(L, [[UU, VV]]));
            );
        );
    );
);
print("Distinct (leg, leg) pairs: ", #pmap);

\\ Now search: pick (a, b) from map keys; find c such that (a,c) and (b,c) also in map.
\\ Then test body diagonal a²+b²+c² square.

keys = Mat(pmap)[,1];
\\ keys is a t_COL of pairs. Convert.
nkeys = #keys;
print("Searching ", nkeys, " (a,b) pairs for shared-c coupling...");

\\ Build inverse map: a → list of legs paired with a
\\ For each key [P,Q], add Q to leglist[P] and P to leglist[Q]
leglist = Map();
for(idx = 1, nkeys,
    my(kk = keys[idx]);
    my(P = kk[1], Q = kk[2]);
    if(!mapisdefined(leglist, P), mapput(leglist, P, [Q]), mapput(leglist, P, concat(mapget(leglist, P), [Q])));
    if(!mapisdefined(leglist, Q), mapput(leglist, Q, [P]), mapput(leglist, Q, concat(mapget(leglist, Q), [P])));
);

\\ For each (a, b) pair, look at legs paired with a (other than b) and legs paired with b (other than a).
\\ Intersect to find shared c.

cuboid_cands = List();
brick_cands = List();
checked_pairs = 0;
for(idx = 1, nkeys,
    my(kk = keys[idx]);
    my(AA = kk[1], BB = kk[2]);
    if(!mapisdefined(leglist, AA) || !mapisdefined(leglist, BB), next);
    my(legsA = Set(mapget(leglist, AA)));
    my(legsB = Set(mapget(leglist, BB)));
    my(shared = setintersect(legsA, legsB));
    \\ Remove BB from legsA-pairings (don't count (AA,BB) itself)
    for(j = 1, #shared,
        my(cc = shared[j]);
        if(cc == AA || cc == BB, next);
        if(cc > CMAX, next);
        \\ (AA, BB, ?), (AA, cc, ?), (BB, cc, ?) all Pythagorean - this is an Euler brick.
        listput(brick_cands, [AA, BB, cc]);
        if(issq(AA^2 + BB^2 + cc^2),
            listput(cuboid_cands, [AA, BB, cc]);
            print("*** CUBOID via ℤ[i] map: (", AA, ", ", BB, ", ", cc, ")");
        );
    );
    checked_pairs += 1;
);

brick_cands = Vec(brick_cands);
cuboid_cands = Vec(cuboid_cands);

print("");
print("Euler bricks (a,b,c) all face-diagonals integer (with a,b,c ≤ ", CMAX, "): ", #brick_cands);
print("Perfect cuboids: ", #cuboid_cands);
print("");
print("First 10 Euler bricks (unsorted, may have duplicates):");
\\ Dedupe
brick_set = Set();
for(i=1, #brick_cands,
    my(b = brick_cands[i]);
    my(sb = vecsort(b));
    brick_set = setunion(brick_set, [sb]);
);
brick_set = Vec(brick_set);
print("Unique Euler bricks: ", #brick_set);
for(i = 1, min(15, #brick_set), print("  ", brick_set[i]));

\\ ========================================================================
\\ Theoretical observation: smallest Euler brick is (44, 117, 240).
\\ Its body diagonal² = 44² + 117² + 240² = 1936 + 13689 + 57600 = 73225.
\\ sqrt(73225) = 270.6... not integer. ✓ (no perfect cuboid found here)
\\ ========================================================================

print("");
print("Theoretical body-diagonal check for found Euler bricks:");
miss_dist = List();
for(i = 1, #brick_set,
    my(brk = brick_set[i]);
    my(g2 = brk[1]^2 + brk[2]^2 + brk[3]^2);
    my(gflr = sqrtint(g2));
    my(miss = g2 - gflr^2);
    listput(miss_dist, miss);
);
\\ Distribution of miss
miss_dist = Vec(miss_dist);
print("Body-diagonal 'miss' (g² - floor(√g²)²) values:");
miss_dist_sorted = vecsort(miss_dist);
print("  min: ", miss_dist_sorted[1]);
print("  max: ", miss_dist_sorted[#miss_dist_sorted]);
zeros = sum(i=1, #miss_dist, if(miss_dist[i] == 0, 1, 0));
print("  # zeros (= # perfect cuboids): ", zeros);

print("");
print("=== Done ===");
quit;
