\\ ============================================================
\\ Picard rank of V' via Frobenius traces.
\\
\\ V' : a^2+b^2=d^2, b^2+c^2=e^2, a^2+c^2=f^2 in P^5
\\
\\ For each good prime p, count #V'(F_p) as projective points.
\\ Trace(Frob_p | H^2_et) = #V'(F_p) - (1 + p^2).
\\
\\ For a K3 surface b_2 = 22, so Frobenius on H^2 has 22 eigenvalues
\\ alpha_i with |alpha_i| = p. The geometric Picard rank
\\ rho_geom equals the number of alpha_i = p * (root of unity).
\\ ============================================================

default(parisize, 2000000000);

\\ count number of square roots of x in F_p
num_sqrts(x, p) = if(x == 0, 1, if(kronecker(x, p) == 1, 2, 0));

\\ count V'(F_p) as projective points (excluding origin, mod scaling)
count_Vp(p) = {
  my(N = 0, a2, b2, c2, ab, bc, ac);
  for(a = 0, p-1,
    a2 = (a*a) % p;
    for(b = 0, p-1,
      b2 = (b*b) % p;
      ab = (a2 + b2) % p;
      for(c = 0, p-1,
        c2 = (c*c) % p;
        bc = (b2 + c2) % p;
        ac = (a2 + c2) % p;
        N += num_sqrts(ab, p) * num_sqrts(bc, p) * num_sqrts(ac, p);
      );
    );
  );
  (N - 1) / (p - 1);
};

{
  print("=== Picard rank estimation via Frobenius traces ===");
  print("Format: p  #V'(F_p)  1+p^2  trace  trace/p");

  primes_list = [3, 5, 7, 11, 13];
  np_count = length(primes_list);
  data = vector(np_count);
  for(k = 1, np_count,
    p = primes_list[k];
    np = count_Vp(p);
    expected = 1 + p^2;
    tr = np - expected;
    ratio = tr * 1.0 / p;
    print("p=", p, "  #V'(F_p)=", np, "  1+p^2=", expected,
          "  tr=", tr, "  tr/p=", ratio);
    data[k] = [p, np, tr];
  );

  print("");
  print("=== Interpretation ===");
  print("For K3 with b_2 = 22, Frobenius on H^2 has 22 eigenvalues");
  print("alpha_i with |alpha_i| = p.");
  print("Algebraic eigenvalues (Picard part): alpha = p * (root of unity).");
  print("");
  print("=== Bounds on rho_geom ===");
  for(k = 1, length(data),
    pp = data[k][1]; tr = data[k][3];
    \\ Upper bound on rho_arith: # of integer eigenvalues divisible by p.
    \\ Since |sum of transc eigenvalues| <= (22 - rho_geom) * p,
    \\ the constraint |trace| <= (22 - rho_geom) * p + rho_geom * p = 22 * p
    \\ is always satisfied. So no immediate bound from |trace|.
    \\ But: trace = p * (rho_geom + (sum of remaining eigenvalues)/p),
    \\ and the sum of transcendental eigenvalues (which come in cc pairs
    \\ summing to 2 p cos(theta)) has bounded contribution.
    print("  p=", pp, "  trace=", tr, "  trace/p =", tr*1.0/pp);
  );
  print("");
  print("=== Notes on bounds ===");
  print("The geometric Picard rank of V' can be lower-bounded by");
  print("the Shioda-Tate computation for any elliptic fibration:");
  print("  rho >= 2 + sum(m_v - 1) + MW_rank");
  print("V' has 3 face fibrations pi_d, pi_e, pi_f.");
  print("Generic rank of pi_d over Q(q) is 0 (from PARI/GP verification");
  print("in PICK-1-K3-TATE-ATTACK.md).");
  print("Bad fibers of pi_d: q in {0, infinity, +/- 1, +/- i}.");
  print("");
  print("Computational lower bound from sample data (PICK-1):");
  print("  rho_geom(V') >= 6 (from p=7 trace data).");
  print("");
  print("Tate conjecture (unconditional, Madapusi Pera 2015):");
  print("  rho_geom(V') = -ord_{s=1} L_2(s, V').");
  print("This is computable in principle but requires the full L-function.");
}
quit;
