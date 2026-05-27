/* 03_julia_set_estimate.gp
   p-adic Julia set estimate via period-bounded periodic points (Track T1).

   For a self-map f: P^1(Q_p) -> P^1(Q_p), the (non-archimedean) Julia
   set J_p(f) is the closure of repelling periodic points.  For the
   c-map, "f" is not a self-map of P^1 globally, but under the first-
   generator policy it IS a partial function on the rank-jump Pythagorean
   set.  We identify the *periodic orbits* found in CMAP-DYNAMICS §2.2
   (the 2-cycles) and probe their p-adic structure:

     - For each 2-cycle {a, b}: compute |a - b|_p for p in {2,3,5,7,11}
       (proximity of the two cycle points in Q_p)
     - Compute the "multiplier" lambda = derivative at fixed point of f^2,
       which here we approximate by:
           lambda_p(a) = ratio of |b - a|_p at the cycle level
       i.e., how does the 2-cycle "look" p-adically.

   We also count, in a "near a" sense, points q' = a + p^k * unit that map
   under one c-map step to a point close to b -- this is a coarse local-
   degree estimate (since c-map is NOT a function of q alone, we restrict
   to the canonical generator-1 evaluation).
*/

default(parisize, 500000000);

canonical_q(qv) = my(n=abs(numerator(qv)), d=abs(denominator(qv))); if (n<=d, n/d, d/n);
log_height(qv) = log(max(abs(numerator(qv)), abs(denominator(qv))));
vp(x, p) = valuation(numerator(x), p) - valuation(denominator(x), p);

PRIMES = [2, 3, 5, 7, 11];

/* Known 2-cycles from CMAP-DYNAMICS §4.2 */
{
cycles = [ [20/21, 48/55], [7/24, 20/99], [11/60, 39/80], [225/272, 52/165], [27/364, 120/209], [60/91, 1881/4720], [132/475, 5425/14832], [96/247, 315/572], [11/60, 17/144], [104/153, 55/1512] ];
}

print("=== p-adic 2-cycle structure ===");
print("");
print("For each known 2-cycle {a, b}:");
print("  - vp(a - b) for p in 2,3,5,7,11");
print("  - vp(a + b) ");
print("  - vp(a*b)  ");
print("  - vp(F_3(a->b)) = ord_p(1 + a^2 + b^2)");
print("  - vp(a^2 - b^2) = vp(a-b) + vp(a+b)");
print("");

{
for (i = 1, length(cycles),
  my(c = cycles[i], a = c[1], b = c[2], diff, summ, prod, F3, diffsq);
  diff = a - b;
  summ = a + b;
  prod = a * b;
  F3 = 1 + a^2 + b^2;
  diffsq = a^2 - b^2;
  print("Cycle ", i, ": a = ", a, ", b = ", b);
  print("  F_3 = ", F3, "  (issq=", issquare(F3), ")");
  print("  vp(a-b):  ", vector(length(PRIMES), j, vp(diff, PRIMES[j])));
  print("  vp(a+b):  ", vector(length(PRIMES), j, vp(summ, PRIMES[j])));
  print("  vp(a*b):  ", vector(length(PRIMES), j, vp(prod, PRIMES[j])));
  print("  vp(F_3):  ", vector(length(PRIMES), j, vp(F3, PRIMES[j])));
  print("  vp(a^2-b^2): ", vector(length(PRIMES), j, vp(diffsq, PRIMES[j])));
  print("");
);
}

/* Repelling vs attracting:
   At an n-periodic point a of f, the multiplier is lambda = (f^n)'(a).
   If |lambda|_p > 1 -> repelling (in J_p); |lambda|_p < 1 -> attracting (in Fatou);
   |lambda|_p = 1 -> indifferent.

   For our c-map, "f" is not a polynomial, so the multiplier is computed
   indirectly.  We use the empirical formula:
     If a -> b -> a is a 2-cycle, then locally near a,
       f(a + eps) = b + eps * (df/dq)|_a + O(eps^2)
       f^2(a + eps) = a + eps * (df/dq)|_a * (df/dq)|_b + O(eps^2)
     so lambda_a = (df/dq)|_a * (df/dq)|_b.
   We do not have a closed-form for df/dq (it depends on the chosen
   generator on E).  Instead, we report the SIZE of the 2-cycle relative
   to each prime, which is a coarse cocycle invariant.
*/

print("=== 2-cycle distances in Q_p ===");
print("");
print("Cycle | log_p (|a-b|_p)^{-1}=vp(a-b)  archimedean h(a)+h(b)");

{
for (i = 1, length(cycles),
  my(c = cycles[i], a = c[1], b = c[2], harch);
  harch = log_height(a) + log_height(b);
  print(i, " | a=", a, " b=", b,
        " | vp(a-b)=", vector(length(PRIMES), j, vp(a-b, PRIMES[j])),
        " | h_arch=", strprintf("%.3f", harch));
);
}

print("");
print("Repelling check: a cycle is 'p-adically tight' iff vp(a-b) is HIGH");
print("                 (meaning a and b are p-adically close)");
print("");

/* For each prime, list 2-cycles with high vp(a-b): these are the prime-p");
   'attracting' regions of Q_p where cycles cluster. */
print("=== Per-prime tightness of 2-cycles ===");
{
for (j = 1, length(PRIMES),
  my(p = PRIMES[j], tight, scores);
  scores = vector(length(cycles), i, vp(cycles[i][1] - cycles[i][2], p));
  print("p = ", p, ": vp(a-b) scores across cycles = ", scores,
        " | max=", vecmax(scores), " min=", vecmin(scores),
        " | mean=", strprintf("%.2f", 1.0*vecsum(scores)/length(scores)));
);
}

/* Stronger Julia set estimate via period-2 fixed-point detection:
   A point q is in a 2-cycle iff (cmap o cmap)(q) = q.  Approaching this
   from the dynamical viewpoint: in Q_p, the c-map periodic points are
   solutions of polynomial equations of bounded degree.  The squarefree
   *resultant* of F_2(q) = f(f(q)) - q with itself (treating it as a
   polynomial in q with E-derived coefficients) would give the periodic
   locus.  We do not have a closed form for f, so we report the EXPLICIT
   periodic points found in CMAP-DYNAMICS and compute their p-adic
   "Berkovich diameter" via the Gauss-norm of the polynomial vanishing
   on them.  */

print("");
print("=== Berkovich diameter / Gauss norm of 2-cycle locus ===");
print("");

{
for (i = 1, length(cycles),
  my(c = cycles[i], a = c[1], b = c[2], P, coeffs_nonz, contents);
  /* Polynomial (X - a)(X - b) */
  P = (x - a) * (x - b);
  print("Cycle ", i, ": (x-", a, ")(x-", b, ") = ", P);
  /* Get nonzero coefficients */
  coeffs_nonz = select(z -> z != 0, Vec(P));
  contents = vector(length(PRIMES), j,
    vecmin(vector(length(coeffs_nonz), k, vp(coeffs_nonz[k], PRIMES[j])))
  );
  print("  Gauss vp's (min coef vp): ", contents);
);
}

quit;
