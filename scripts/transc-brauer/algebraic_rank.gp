\\ ============================================================
\\ Determine the algebraic Picard rank of V'_min from Frobenius data.
\\
\\ Setup recap:
\\   V' ⊂ P^5 cut out by Q1=a^2+b^2-d^2, Q2=b^2+c^2-e^2, Q3=a^2+c^2-f^2.
\\   V' has 12 nodes (Q-rational) at [0:0:1:0:±1:±1], [0:1:0:±1:±1:0], [1:0:0:±1:0:±1].
\\   Minimal resolution V'_min is a smooth K3, b_2 = 22.
\\
\\ Lefschetz on V'_min:
\\   #V'_min(F_{p^k}) = 1 + sum_{i=1..22} α_i^k + p^{2k}
\\ where α_i are Frob eigenvalues on H^2(V'_min, Q_ell), |α_i|=p.
\\
\\ Algebraic part: 12 exceptional P^1's give 12 eigenvalues = +p
\\ (each Q-rational, so Frob acts as +1 on the class, scaled by Tate twist => +p).
\\ Plus hyperplane H => 1 more eigenvalue = +p.
\\ Plus 3 fibration classes F_1, F_2, F_3 (defined over Q) => 3 more = +p.
\\ Plus a^2+b^2+c^2 = ... no, V' doesn't have g.
\\
\\ Initial bound: at least 12 + 1 (H) + 3 (F_i) = 16 eigenvalues = +p.
\\
\\ Hence algebraic Picard rank ρ_alg ≥ 16, and transcendental ≤ 22 - 16 = 6.
\\
\\ Note: the original problem statement said ρ_geom ≥ 6, which is the count
\\ BEFORE resolving the 12 nodes. After resolution, ρ_geom ≥ 18.
\\ Transcendental rank ≤ 4 (after subtracting H, F_1, F_2, F_3 from "6").
\\
\\ But we need to verify this against actual Frobenius traces.
\\ ============================================================

countV_smart(p) = {
  my(N = 0);
  for(a = 0, p-1,
    for(b = 0, p-1,
      for(c = 0, p-1,
        my(s1 = (a*a + b*b) % p);
        my(s2 = (b*b + c*c) % p);
        my(s3 = (a*a + c*c) % p);
        my(nd, ne, nf);
        if(s1 == 0, nd = 1, nd = if(issquare(Mod(s1, p)), 2, 0));
        if(s2 == 0, ne = 1, ne = if(issquare(Mod(s2, p)), 2, 0));
        if(s3 == 0, nf = 1, nf = if(issquare(Mod(s3, p)), 2, 0));
        N += nd * ne * nf;
      )
    )
  );
  N;
}

countVmin(p) = (countV_smart(p) - 1) / (p - 1) + 12 * p;

\\ ============================================================
\\ Analysis: compute t_1(p) for several p, then divide by p to get
\\ "Frobenius unit-trace" u_1(p) = t_1(p)/p ∈ Q.
\\ Round to nearest integer; the difference is bounded by (b_2 - ρ_alg).
\\
\\ Specifically: t_1(p) = ρ_alg(p) · p + (transcendental contribution).
\\ The trans contribution is sum of (b_2 - ρ_alg) eigenvalues of abs value p,
\\ so |trans contribution| ≤ (22 - ρ_alg) · p.
\\
\\ Hence: t_1(p)/p - ρ_alg ∈ [-(22-ρ_alg), 22-ρ_alg].
\\ ============================================================

{
  print("=== Frobenius analysis on V'_min ===");
  print("");
  print("p   | t_1     | t_1/p (≈)  | algebraic +p count guess");
  print("----+---------+------------+-------------------------");
  forprime(p = 3, 23,
    my(N = countVmin(p));
    my(t = N - 1 - p^2);
    my(r = t / p * 1.0);
    print(p, "  | ", t, "  | ", r);
  );
  print("");

  \\ For p=13, t_1 = 182 = 14*13 exactly. Suggests algebraic count = 14 + maybe extras.
  \\ For p=7, t_1 = 126 = 18*7. Suggests algebraic count = 18.
  \\ Hmm — these "exact" cases give upper estimate of algebraic eigenvalues = +p.
  \\ For p where t_1/p is not integer, we need both +p and -p eigenvalues + transcendental.
  \\
  \\ Try to fit: t_1(p) = (n_+ - n_-) · p + transc(p)
  \\ where n_+ + n_- = ρ_alg(p) and transc(p) is sum of transcendental eigvals.
  \\ For generic p (away from primes splitting things), n_- = 0 typically.

  print("=== Newton sum: compute t_2 = tr(Frob^2|H^2) ===");
  print("");
  print("For algebraic eigenvalues p*ζ where ζ^k=1, we have (pζ)^2 = p^2 * ζ^2.");
  print("For ρ_alg eigvals all = +p: sum_alg (α_i)^2 = ρ_alg * p^2");
  print("For complex pairs ±p*i: each pair contributes (pi)^2 + (-pi)^2 = -2p^2");
  print("");
  print("If we ASSUME algebraic part is k eigvals = +p, and we can compute t_2,");
  print("the transcendental contribution to t_2 has |trans2| ≤ (22-k)*p^2.");
}
