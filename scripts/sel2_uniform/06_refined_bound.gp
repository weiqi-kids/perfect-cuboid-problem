\\ =====================================================================
\\ 06_refined_bound.gp
\\
\\ The standard Schaefer 2-descent bound for E with full 2-torsion:
\\   dim_{F_2} Sel_2(E/Q) <= dim_{F_2} E(Q)[2] + 2 * ω(supp(Δ))
\\                       = 2 + 2 * ω(disc)
\\ where ω is the number of primes in the support of the (minimal) disc.
\\ This is generally MUCH too weak.
\\
\\ A sharper bound (Cassels, "Mordell's finite basis theorem revisited", 1991):
\\ For E: y^2 = (x-e_1)(x-e_2)(x-e_3) with e_i in Z,
\\   dim Sel_2(E/Q) <= 2 + ω(sf(e_2-e_1)*sf(e_3-e_1)*sf(e_3-e_2))
\\                  + 2 (the local-at-2 fudge)
\\ For us sf(e_3-e_1) = sf(e_3-e_2) = 1, so it reduces to:
\\   dim Sel_2 <= 2 + ω(sf(e_2 - e_1)) + 2 = 4 + ω(sf(P)*sf(Q))
\\
\\ But we need to be careful with the e_i being non-integer (rationals)
\\ and the minimal model. Let me work on the minimal model directly.
\\
\\ Actually the cleanest standard bound: for E with full 2-torsion,
\\   dim Sel_2(E/Q) <= 2 + sum_{p | N} dim_F2 (E(Q_p)/2E(Q_p))
\\ This is the standard Cassels-Tate bound. For p odd:
\\   dim_F2 (E(Q_p)/2E(Q_p)) = dim E(Q_p)[2] = number of 2-torsion roots split in Q_p.
\\ Since all 2-torsion is in Q already, dim = 2 for every prime p of bad reduction.
\\
\\ So we get  dim Sel_2 <= 2 + 2 * #(bad primes for E)
\\
\\ For our family with full 2-torsion, ω(N) bad primes => bound 2 + 2ω(N).
\\ This is WAY too weak for our needs (would give bound 22 at the worst fiber).
\\
\\ The TRUE sharper bound comes from the fact that the local image at p
\\ has dim = 2 ONLY at primes of MULTIPLICATIVE reduction with split toric;
\\ at primes of additive reduction it's smaller.
\\
\\ Let me COMPUTE local images explicitly and combine.
\\
\\ =====================================================================

default(parisize, 1500000000);

sf(x) = if(x == 0, 0, my(s = sign(x), a = abs(x), f = factor(a)); s * prod(i=1, matsize(f)[1], f[i,1]^(f[i,2]%2)));

\\ Compute the local 2-Selmer dim contribution at prime p for E.
\\ Specifically: dim_F2 image(E(Q_p)/2E(Q_p)) inside (Q_p^*/Q_p^*^2)^2
\\ which by local Tate is rank E(Q_p) + dim E[2](Q_p).
\\ For E with full 2-torsion in Q, dim E[2](Q_p) = 2.
\\ rank E(Q_p) = 0 (it's compact mod p), so dim = 2.
\\ But the SELMER local condition is dim of this image = 2 for every p.
\\ The GLOBAL Selmer is the kernel in the global thing of the prod_p res_p,
\\ codimension = total local dim. Hmm.
\\
\\ The actual formula (Schaefer-Stoll, "How to do a p-descent on an elliptic curve"):
\\   |Sel_p(E/K)| = |K(S, p)|^something * |E(K)[p]| / prod_v |E(K_v)/p E(K_v)|^something
\\ It's a Tate global duality computation.
\\
\\ For our purpose let's just GET dim Sel_2 from PARI ellrank and analyze.
\\ We have established:
\\   For m <= 60 (737 fibers), dim Sel_2 <= 5, achieved at (22,17).
\\   For m <= 30 (186 fibers), dim Sel_2 <= 5, achieved at (22,17).

\\ Sanity check: what's the worst bound 2 + 2*ω(N) on each fiber?
\\ Compare to actual dim Sel_2.

build_E_min(m, n) = {
  my(a = m^2 - n^2, b = 2*m*n, q, E, Em);
  q = a/b;
  E = ellinit([0, 1+q^2, 0, q^2, 0]);
  Em = ellminimalmodel(E);
  Em;
};

print("===== A refined empirical bound (saturating prime-by-prime contributions) =====");
print("For each fiber, compute:");
print("  N_min = ω(conductor)");
print("  L_loc = sum over bad primes p of dim image (E(Q_p)/2E(Q_p)) in (Q_p*/Q_p*^2)^2");
print("Theory: dim Sel_2 = 2 + ω(Heron) - (codim of global in ambient)");
print();
print("(m,n)   ω(N)  predict_2+2omN  dim_Sel2  diff");

{
nfibers = 0;
maxbad = 0;
for(m = 2, 30,
  for(n = 1, m-1,
    if(gcd(m, n) != 1 || (m + n) % 2 == 0, next);
    nfibers++;
    Em = build_E_min(m, n);
    N = ellglobalred(Em)[1];
    omN = omega(N);
    rk = ellrank(Em, 1);
    s2 = rk[2] + 2;
    if(omN > maxbad, maxbad = omN);
  );
);
print("Tested ", nfibers, " fibers");
print("max ω(N) seen: ", maxbad);
}

\\ Let me instead try: dim Sel_2 = (theoretical structural bound)
\\
\\ I conjecture: for E_PCP(q), we have
\\   dim Sel_2 = 2 + ω(sf(P)) + ω(sf(Q)) - dim_{F_2}(global obstructions)
\\
\\ where "global obstructions" come from Hilbert reciprocity links between
\\ the 3 conics. Let me TEST this directly.

print();
print("===== Test: dim Sel_2 vs 2 + ω(sf(P*Q)) over LARGER range =====");
print();

{
results = vector(10, j, 0);   \\ count by diff = s2 - (2 + ω(sf(PQ)))
nfibers = 0;
max_observed = 0;
max_pq_omega = 0;
\\ Walk all fibers m <= 60
for(m = 2, 60,
  for(n = 1, m-1,
    if(gcd(m, n) != 1 || (m + n) % 2 == 0, next);
    nfibers++;
    P = (m+n)^2 - 2*n^2;
    Q = (m-n)^2 - 2*n^2;
    sPQ = sf(P * Q);
    omPQ = if(abs(sPQ) > 1, omega(abs(sPQ)), 0);
    Em = build_E_min(m, n);
    rk = ellrank(Em, 1);
    s2 = rk[2] + 2;
    if(s2 > max_observed, max_observed = s2);
    if(omPQ > max_pq_omega, max_pq_omega = omPQ);
    diff = s2 - (2 + omPQ);
    if(diff >= -5 && diff <= 4, results[diff + 6]++);
  );
);
print("Tested ", nfibers, " fibers (m <= 60)");
print("Max dim Sel_2: ", max_observed);
print("Max ω(sf(P*Q)): ", max_pq_omega);
print();
print("dim Sel_2 - (2 + ω(sf(PQ)))   count");
for(d = -5, 4, if(results[d+6] > 0, print(d, "    ", results[d+6])));
}

quit;
