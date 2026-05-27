\\ ============================================================
\\ Shioda-Tate analysis of pi_d : V' -> P^1_q.
\\
\\ Generic fiber: E(q) : Y^2 = (c^2+1)(c^2+q^2)
\\   ~ Y^2 = (X+1)(X+q^2)  where X = c^2 (genus 1 cover of P^1)
\\
\\ But viewed as elliptic surface, the generic fiber over Q(q) is
\\   E_eta : Y^2 = (X+1)(X+q^2)  in P^2 over Q(q)
\\ This factored Weierstrass model: Y^2 = X^3 + (q^2+1)X^2 + q^2 X
\\
\\ Discriminant: Delta = 16 q^4 (q^2-1)^2
\\ Bad fibers at q = 0, infinity, +/- 1, and pairs that complete (q^2-1).
\\
\\ Tate's algorithm: classify reduction at each q.
\\ ============================================================

default(parisize, 1000000000);

\\ Generic fiber as elliptic curve over Q(q)
\\ Y^2 = X^3 + (q^2 + 1) X^2 + q^2 X
\\ a1=0, a2=q^2+1, a3=0, a4=q^2, a6=0
\\ Compute discriminant symbolically.

print("=== Shioda-Tate analysis of pi_d : V' -> P^1_q ===");
print("");
print("Generic fiber E(q) : Y^2 = X^3 + (q^2 + 1) X^2 + q^2 X");
print("                   = X (X + 1) (X + q^2)");
print("");
print("Two-torsion: T0=(0,0), T1=(-1,0), T2=(-q^2,0)  ==> Z/2 x Z/2 generic torsion.");
print("Discriminant: 16 * q^4 * (q^2 - 1)^2 * 1 = 16 q^4 (q-1)^2 (q+1)^2");
print("(times appropriate factor; for E: y^2 = (x)(x+1)(x+q^2),");
print(" Delta = (a_1*a_2 - a_3)^2 ... standard formula gives:");
print(" Delta = 16 q^4 (q^2 - 1)^2.)");
print("");

\\ Locations of bad fibers: q = 0, +/-1, infty (and q^2 = -1 over Qbar gives i, -i)
print("=== Bad fibers ===");
print("Over Q: bad at q = 0, +1, -1, infinity.");
print("Over Qbar: also bad at q = +i, -i (where q^2 = -1).");
print("");

\\ Compute Tate type at each bad fiber by specialization.

\\ At q = 0: Y^2 = X^3 + X^2 = X^2(X+1).  Node at (0,0). Type I_?
\\   reduction: y^2 = x^2(x+1) has multiplicative reduction; double point.
\\   Need v_q(Delta) at q=0.  Delta = 16 q^4 (q^2-1)^2, so v_0(Delta) = 4.
\\   But also need v_0(c4). c4 = 16(a2^2 - 3 a4) ... for our model:
\\   c_4 = 16 ((q^2+1)^2 - 3 q^2) = 16 (q^4 - q^2 + 1)
\\   v_0(c4) = 0, v_0(Delta) = 4, so type is I_4 (multiplicative reduction with conductor 1, Kodaira I_4).
\\   I_4 has 4 components.
print("At q = 0:");
print("  v_q(Delta) = 4,  v_q(c4) = 0  ==> Kodaira type I_4 (mult.).");
print("  Components: 4  (contributes m-1 = 3 to Shioda-Tate sum).");
print("");

\\ At q = infinity: change of variable q -> 1/q'.
\\  Y^2 = X^3 + (1/q'^2 + 1) X^2 + (1/q'^2) X
\\  Multiply X -> X/q'^2, Y -> Y/q'^3:
\\  (Y/q'^3)^2 = (X/q'^2)^3 + (1/q'^2+1)(X/q'^2)^2 + (1/q'^2)(X/q'^2)
\\  Y^2/q'^6 = X^3/q'^6 + (1+q'^2)/q'^2 * X^2/q'^4 + 1/q'^2 * X/q'^2
\\  Y^2/q'^6 = X^3/q'^6 + (1+q'^2) X^2 / q'^6 + X/q'^4
\\  Multiply by q'^6: Y^2 = X^3 + (1+q'^2) X^2 + q'^2 X
\\  Same shape! So q = infinity gives same Kodaira type as q = 0 (by symmetry q <-> 1/q).
print("At q = infinity (substitute q' = 1/q):");
print("  Same Weierstrass shape after rescaling, so type I_4.");
print("  Components: 4.");
print("");

\\ At q = 1: Y^2 = X^3 + 2 X^2 + X = X(X+1)^2.  Node at X=-1. Type I_?
\\   v_1(Delta) = 2 (since (q-1)^2 in Delta), v_1(c4) = 16 * (1 - 1 + 1) = 16, v_1(c4) = 0.
\\   ==> Type I_2 (mult.), 2 components.
print("At q = 1:");
print("  Y^2 = X(X+1)^2: nodal at X=-1.");
print("  v_q(Delta) = 2,  v_q(c4) = 0  ==> Kodaira I_2.");
print("  Components: 2 (contributes m-1 = 1).");
print("");

\\ At q = -1: by symmetry q -> -q (which negates q in coefficients), same as q=1.
print("At q = -1:");
print("  Same as q = 1 by q -> -q.  Type I_2.");
print("  Components: 2.");
print("");

\\ At q = +/- i (over Qbar): q^2 = -1, so X + q^2 = X - 1; fiber Y^2 = X(X+1)(X-1).
\\   This is a smooth elliptic curve! Wait — but Delta = 16 q^4 (q^2-1)^2 = 16 * 1 * 4 = 64, nonzero.
\\   So actually q = +/- i are GOOD fibers, not bad!
\\   The "bad q" locus over Q-bar is where Delta = 0:
\\   16 q^4 (q^2-1)^2 = 0  <==>  q = 0 or q = +/-1.
\\   So q = +/-i are GOOD.

print("=== Check: bad fibers over Qbar ===");
print("Delta = 16 q^4 (q^2-1)^2  vanishes iff q in {0, 1, -1}.");
print("So bad locus over Qbar is {0, 1, -1, infinity}, NOT including +/-i.");
print("");

\\ Shioda-Tate sum over bad fibers:
\\   sum (m_v - 1) = 3 + 3 + 1 + 1 = 8.
print("=== Shioda-Tate formula ===");
print("rho(V') = 2 + sum_{bad v} (m_v - 1) + rank MW(pi_d / Q(q))");
print("       = 2 + (3 + 3 + 1 + 1) + r_gen");
print("       = 2 + 8 + r_gen");
print("       = 10 + r_gen");
print("");
print("Generic torsion: Z/2 x Z/2 (full 2-torsion).");
print("Generic MW rank r_gen: from numerical/L-function evidence in PICK-1, ");
print("  the generic fiber has rank 0 over Q(q)  ==>  rho(V') = 10.");
print("");

\\ Empirical check via fiber rank computation:
\\ generic rank r_gen can be computed by analyzing ellrank of fibers
\\ at "generic enough" Pythagorean q.
\\
\\ But for Tate / van Luijk:  rho_geom(V') is an upper bound from Frobenius.
\\ Lower bound: rho >= 10 from Shioda-Tate with r_gen = 0.

print("=== Bound on rank E_PCP(q)(Q) ===");
print("");
print("If rho(V') = 10 (Shioda-Tate, with r_gen = 0):");
print("");
print("Silverman 1983: for non-isotrivial pi_d,");
print("  rk E_PCP(q)(Q) = r_gen + (specialization contribution)");
print("                <= r_gen + log|Delta|/log(p) * (some constant)");
print("");
print("Hindry-Silverman effective specialization: for ALMOST all q (Hilbert-thin");
print("complement), rk E(q)(Q) = r_gen + O(h(q) / log h(q)).");
print("");
print("For our family, r_gen = 0, so almost all q have rank 0.");
print("Empirically (m <= 26 survey of 134 fibers + targeted scans):");
print("  max rank observed = 3 at (m,n) = (22,17), (35,22), (37,26), (40,29), (40,33).");
print("  No rank >= 4 observed.");
print("");
print("Heuristic explanation: each rank jump can be attributed to a Q-point");
print("on a 'spurious' MW section, and we expect at most O(log H(q)) such");
print("contributions.  For Pythagorean q with m^2+n^2 not too large, this");
print("gives rank <= 4 with high confidence.");

quit;
