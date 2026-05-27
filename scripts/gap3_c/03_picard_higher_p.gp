\\ GAP3-C task 3: Picard rank lower bound via Frobenius traces at p up to 100.
\\ Count #V'(F_p) projectively where V' is the Euler-brick K3:
\\   a^2 + b^2 = d^2
\\   b^2 + c^2 = e^2
\\   a^2 + c^2 = f^2
\\ Trace of Frobenius on H^2 satisfies #V'(F_p) = 1 + p^2 + t_p
\\ For K3, b_2 = 22; |alpha_i| = p for each eigenvalue.
\\ Algebraic eigenvalues are p*zeta with zeta a root of unity.
\\ For p such that t_p/p is an integer N, this gives rho_{Fp} >= N (when
\\ no transcendental eigenvalues conspire to be rational integers, which is generic).
\\
\\ This is the van Luijk-style lower bound.

default(parisize, 800000000);

print("=== GAP3-C task 3: Picard via Frobenius traces ===");
print("Counting #V'(F_p) for p in small primes...");

\\ Affine count + projective correction.
\\ V' = {(a:b:c:d:e:f) in P^5 : a^2+b^2=d^2, b^2+c^2=e^2, a^2+c^2=f^2}
\\ This is dim 2 K3 of degree 8.
\\ Affine model (a, b, c) in A^3 with three squareness conditions on (a^2+b^2, b^2+c^2, a^2+c^2);
\\ each squareness multiplies count by (1 + chi_p(s)) for s = a^2+b^2 etc.,
\\ where chi_p is the Legendre symbol (s/p) modified:
\\   #{d : d^2 = s} = 1 + chi_p(s) for s != 0; = 1 for s = 0.

count_Vprime(p) = {
  my(N, chi, sq, s);
  N = 0;
  \\ Precompute squares mod p: 1 if x is a nonzero square, 0 if x=0, -1 if non-square.
  chi = vector(p, i, 0);
  for(x=1, p-1, chi[x*x % p + 1]++);
  \\ chi[v+1] is now #{x : x^2 = v mod p}; for v=0 it counts only x=0 (we did x=1..p-1, missing 0)
  chi[1] = 1; \\ x=0 squared = 0; one solution
  \\ But actually #{x : x^2 = v} = 1 + (v/p) for v!=0, =1 for v=0.
  \\ My loop counts x=1..p-1 hits to v=x^2; so:
  \\   for v=0, chi count = 0, but truth = 1 (x=0). Fix: chi[1]=1.
  \\   for v non-square, chi=0, truth=0. OK.
  \\   for v=square (nonzero), chi=2 (both +sqrt and -sqrt), truth = 2. OK.
  \\ So now #{d : d^2 = s mod p} = chi[s+1].
  for(a=0, p-1, for(b=0, p-1, for(c=0, p-1,
    \\ Need d^2=a^2+b^2, e^2=b^2+c^2, f^2=a^2+c^2 each solvable
    my(sab = (a^2+b^2)%p, sbc = (b^2+c^2)%p, sac=(a^2+c^2)%p);
    N += chi[sab+1] * chi[sbc+1] * chi[sac+1];
  )));
  \\ N counts (a,b,c,d,e,f) in A^6 with the constraints; we want projective count.
  \\ V' lives in P^5; affine cone is one-dim higher.
  \\ Affine count = (p^2 - 1)/(p-1) * #V'(F_p) + correction at origin.
  \\ Hmm. Actually V' is a complete intersection in P^5. Its affine cone is dim 3.
  \\ #affine cone(F_p) = 1 + (p-1) * #V'(F_p)  (each projective point lifts to (p-1) affine points,
  \\   plus the origin (0,0,0,0,0,0)).
  \\ So #V'(F_p) = (N - 1) / (p - 1).
  print("  p=", p, " #cone(F_p)=", N, " #V'(F_p)=", (N-1)/(p-1), " trace=", (N-1)/(p-1) - 1 - p^2);
  return((N-1)/(p-1));
};

primes_list = [3, 5, 7, 11, 13, 17, 19, 23, 29, 31, 37, 41, 43];
for(i=1, length(primes_list), my(p=primes_list[i], N, trace); N = count_Vprime(p); trace = N - 1 - p^2; print("  ratio trace/p = ", trace/p+0.0));

quit;
