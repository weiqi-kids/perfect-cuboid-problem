\\ ============================================================
\\ PICK-18 FAST: Use Gaussian integers to enumerate
\\ representations g^2 = x^2 + y^2 quickly.
\\ ============================================================

\\ For prime p ≡ 1 mod 4, factor p = a^2+b^2 via factor(p) in Z[i].
\\ More direct: idealfactor on nfinit(x^2+1), or use Polrootsmod / specialised.
\\ Simplest: use the explicit algorithm of Cornacchia (PARI: qfbsolve).
\\
\\ For composite g = product of primes, use the fact that x+iy in Z[i].
\\ Build all sums-of-two-squares for g^2 via multiplicative combination.

\\ ----- Get Gaussian prime for p ≡ 1 mod 4: p = a^2 + b^2 -----
gauss_prime(p) = {
  \\ Returns [a,b] with a^2+b^2=p, 0<a<b.
  my(sol = qfbsolve(Qfb(1,0,1), p));
  if(type(sol) == "t_INT", error("not representable: ", p));
  if(sol[1]^2 + sol[2]^2 != p, error("bad qfbsolve"));
  my(a = abs(sol[1]), b = abs(sol[2]));
  if(a > b, [b, a], [a, b]);
}

\\ Multiply Gaussian integers (a+bi)*(c+di) = (ac-bd) + (ad+bc)i
gmul(z1, z2) = [z1[1]*z2[1] - z1[2]*z2[2], z1[1]*z2[2] + z1[2]*z2[1]];
gconj(z) = [z[1], -z[2]];

\\ ----- All representations of g^2 = x^2+y^2 for squarefree g = ∏ p_i (≡ 1 mod 4) -----
\\
\\ g in Z[i] = prod (pi_i * pibar_i). So g^2 = prod (pi_i^2 * pibar_i^2).
\\ A representation x+iy with x^2+y^2=g^2 corresponds to choosing
\\ exponents e_i in {0,1,2} for pi_i (the rest go to pibar_i).
\\ Two choices give the same {x,y} up to sign/conjugation iff related by
\\ overall complex conjugation. So distinct (|x|,|y|) modulo swap: 3^k options,
\\ identify (e_1,...,e_k) with (2-e_1,...,2-e_k). When all e_i=1: self-conjugate
\\ pair, gives one (|x|,|y|) pair with x = 0 or y = 0? Let's check.
\\ Actually e_i = 1 for all i gives g itself (real), giving x=g, y=0. We exclude this.
\\
\\ For squarefree g, distinct (x,y) with 0 < x < y and x^2+y^2=g^2 number (3^k-1)/2.

all_reps_g2_squarefree(plist) = {
  \\ plist = list of primes ≡ 1 mod 4, all distinct
  my(k = #plist, reps = List());
  \\ For each exponent vector (e_1,...,e_k) in {0,1,2}^k:
  \\ compute z = prod pi_i^{e_i} * pibar_i^{2-e_i}, take (|Re|, |Im|)
  my(gprimes = vector(k, i, gauss_prime(plist[i])));
  forvec(E = vector(k, i, [0, 2]),
    my(z = [1, 0]);
    for(i = 1, k,
      my(pi = gprimes[i], pibar = gconj(pi));
      my(ei = E[i]);
      \\ multiply by pi^ei
      for(t = 1, ei, z = gmul(z, pi));
      \\ multiply by pibar^(2-ei)
      for(t = 1, 2 - ei, z = gmul(z, pibar));
    );
    my(x = abs(z[1]), y = abs(z[2]));
    if(x > y, my(t = x); x = y; y = t);
    if(x > 0, listput(reps, [x, y]));
  );
  \\ De-duplicate
  reps = Set(Vec(reps));
  reps;
}

\\ Generic version: works for arbitrary g whose prime factorization is given.
\\ Allow non-squarefree, and primes ≡ 3 mod 4 (which must appear with even
\\ exponent — but in g^2 they always do; they contribute a fixed real factor).

all_reps_g2(g) = {
  my(fac = factor(g), k = matsize(fac)[1]);
  my(g2 = g^2);
  \\ Split primes into ≡1 mod 4 (split), ≡3 mod 4 (inert), and 2 (ramified)
  my(splits = List(), inert_factor = 1, ram_exp_in_g = 0);
  for(i = 1, k,
    my(p = fac[i,1], e = fac[i,2]);
    if(p == 2, ram_exp_in_g = e,
      if(p % 4 == 1, listput(splits, [p, e]),
        \\ p ≡ 3 mod 4: must contribute p^{2e} to g^2, all goes into real factor
        inert_factor *= p^e;
      );
    );
  );
  splits = Vec(splits);
  \\ For Gaussian prime 1+i (norm 2), exponent in g^2 is 2*ram_exp_in_g.
  \\ Multiplication by (1+i)^2 = 2i: rotates and scales by 2.
  \\ For enumeration, we can pull out factor (1+i)^{2*ram_exp_in_g} which equals
  \\ (2i)^{ram_exp_in_g} — a unit times 2^{ram_exp_in_g}. So it scales by 2^{ram_exp_in_g} and rotates.
  \\ Effectively: solutions get scaled by 2^{ram_exp_in_g} * inert_factor.

  \\ For each split prime p_i with exponent e_i in g, its exponent in g^2 is 2*e_i.
  \\ Choose split: pi^{a_i} * pibar^{2e_i - a_i} with 0 <= a_i <= 2e_i.

  my(reps = List());
  my(scale = 2^ram_exp_in_g * inert_factor);
  my(k2 = #splits);
  my(gprimes = vector(k2, i, gauss_prime(splits[i][1])));
  my(maxs = vector(k2, i, 2 * splits[i][2]));
  forvec(A = vector(k2, i, [0, maxs[i]]),
    my(z = [1, 0]);
    for(i = 1, k2,
      my(pi = gprimes[i], pibar = gconj(pi));
      my(ai = A[i]);
      for(t = 1, ai, z = gmul(z, pi));
      for(t = 1, maxs[i] - ai, z = gmul(z, pibar));
    );
    \\ Multiply by (1+i)^{2*ram_exp_in_g} = (2i)^{ram_exp_in_g}
    \\ Just compute scalar absolute value contribution:
    my(x = abs(z[1]) * scale, y = abs(z[2]) * scale);
    if(x > y, my(t = x); x = y; y = t);
    if(x > 0, listput(reps, [x, y]));
  );
  reps = Set(Vec(reps));
  reps;
}

\\ Sanity tests
print("g=1105: ", #all_reps_g2(1105), " reps (expected 13)");
print("g=1885: ", #all_reps_g2(1885), " reps (expected 13)");
print("g=2210: ", #all_reps_g2(2210), " reps");
print("g=32045: ", #all_reps_g2(32045), " reps (expected 40)");
print("g=5525: ", #all_reps_g2(5525), " reps (5^2*13*17)");

\\ Cross-check vs brute force for g=1105
brute_reps(g) = {
  my(sols = List(), g2 = g^2, lim = sqrtint(g2 \ 2));
  for(x = 1, lim,
    my(y2 = g2 - x^2);
    if(issquare(y2), my(y = sqrtint(y2)); if(x < y, listput(sols, [x, y])));
  );
  Vec(sols);
}

R1 = vecsort(all_reps_g2(1105));
R2 = vecsort(brute_reps(1105));
print("g=1105 match: ", R1 == R2);

R1 = vecsort(all_reps_g2(1885));
R2 = vecsort(brute_reps(1885));
print("g=1885 match: ", R1 == R2);

R1 = vecsort(all_reps_g2(2210));
R2 = vecsort(brute_reps(2210));
print("g=2210 match: ", R1 == R2);

quit;
