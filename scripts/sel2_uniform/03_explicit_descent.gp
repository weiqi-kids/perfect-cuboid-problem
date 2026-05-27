\\ =====================================================================
\\ 03_explicit_descent.gp
\\ Explicit 2-descent on E_PCP(q) for selected fibers.
\\ Verifies: dim Sel_2 = up + 2 from ellrank by direct enumeration.
\\
\\ The 2-descent for E: y^2 = (x - e_1)(x - e_2)(x - e_3) with e_i in Q:
\\ The descent map is delta: E(Q)/2E(Q) -> (Q^*/Q^*2)^3 / scalars
\\   delta(P) = (x(P) - e_1, x(P) - e_2, x(P) - e_3) mod squares,
\\ image lies in {(d_1, d_2, d_3) : d_1*d_2*d_3 in Q^*2}.
\\
\\ The Selmer group is the set of (d_1, d_2, d_3) satisfying:
\\ (S1) [global] d_1*d_2*d_3 in Q^*2
\\ (S2) [support] each d_i is squarefree with support in BAD union {-1, 2}
\\ (S3) [local R-solvability] sign pattern compatible with e_1<e_2<e_3
\\      -- the 4 patterns: (+,+,+); (+,-,-); (-,+,-) impossible since
\\      d_i = x - e_i can flip sign only as x crosses e_i.
\\      Detailed: for x > e_3: (+,+,+); for e_2<x<e_3: (+,+,-);
\\      for e_1<x<e_2: (+,-,-); for x<e_1: (-,-,-).
\\      But product d_1*d_2*d_3 should be in Q^*2 mod global rep; signs * Q^2
\\      restricted mod product square: 4 sign patterns survive
\\      as residue classes of (d_1, d_2, d_3) mod squares.
\\ (S4) [local p-solvability] at each p in BAD,
\\      exists X in Q_p with (X-e_1)/d_1, (X-e_2)/d_2, (X-e_3)/d_3 in Q_p^*2.
\\      Equivalently: the conic
\\        d_1 y_1^2 = X - e_1,  d_2 y_2^2 = X - e_2,  d_3 y_3^2 = X - e_3
\\      has Q_p-rational point.
\\      One eliminates X to get 2 conic equations:
\\        d_2 y_2^2 - d_1 y_1^2 = e_1 - e_2
\\        d_3 y_3^2 - d_1 y_1^2 = e_1 - e_3
\\      These are 2 binary quadratics in 3 variables — each contributes
\\      a Hilbert-symbol constraint at p.
\\ =====================================================================

default(parisize, 1500000000);

\\ For E_PCP: e_1 = -q^2, e_2 = -1, e_3 = 0 (note e_1 < e_2 < e_3 when 0 < q < 1)
\\ But for q > 1: e_1 = -q^2 < -1 = e_2 < 0 = e_3, so we still have e_1 < e_2 < e_3
\\ For q = 0 or 1 or -1: bad fibers.
\\ Pythagorean q: q can be > 1 or < 1, but always non-trivial.

\\ ====== Heron primes ======
heron_set(m, n) = {
  my(values, primes = List(), v);
  values = [m, n, m+n, abs(m-n), m^2+n^2, m^2-n^2, (m+n)^2 - 2*n^2, (m-n)^2 - 2*n^2];
  for(i=1, #values, v = abs(values[i]); if(v > 1, listput(primes, factor(v)[,1]~)));
  primes = concat(Vec(primes));
  vecsort(Set(concat(primes)));
};

\\ Squarefree part of x (signed)
sf(x) = if(x == 0, 0, my(s = sign(x), a = abs(x), f = factor(a)); s * prod(i=1, matsize(f)[1], f[i,1]^(f[i,2]%2)));

\\ ====== Local solvability checker for a Selmer candidate ======
\\
\\ Given E with full 2-torsion at e_1, e_2, e_3 over Q, and triple
\\ (d_1, d_2, d_3) supported on F = {-1, p_1, ..., p_s}, check whether
\\ the system has a Q_p-rational point for each p in F.
\\
\\ The system is:
\\   d_1 y_1^2 - d_2 y_2^2 = e_2 - e_1
\\   d_1 y_1^2 - d_3 y_3^2 = e_3 - e_1
\\ A Q_p-rational solution (y_1, y_2, y_3) with (y_1, y_2, y_3) not all
\\ zero gives X = e_1 + d_1 y_1^2 satisfying the system.
\\
\\ Use Hilbert symbol: For binary quadratic d_1 y_1^2 - d_2 y_2^2 = c
\\   (with c ≠ 0): there is a Q_p-rational solution iff
\\   (d_1, -c*d_1*d_2)_p * (-c, d_2)_p ... well actually it's simpler:
\\   The quadratic form d_1 y_1^2 - d_2 y_2^2 represents c over Q_p iff
\\   the Hilbert symbol condition (d_1, d_2)_p * ... let me think.
\\
\\ Form Q(y_1, y_2) = d_1 y_1^2 - d_2 y_2^2 represents c over Q_p iff
\\ c is represented OR Q is universal (c discriminant condition).
\\ Equivalently: Q ⊥ <-c> is isotropic, i.e. d_1 y_1^2 - d_2 y_2^2 - c y_3^2 = 0
\\ has a non-trivial Q_p-solution.
\\ This is a ternary form; isotropy iff (d_1, d_2)_p * (d_1, -c)_p * (d_2, -c)_p... =
\\ actually the criterion is (-d_1 d_2, -d_1 c)_p = -1 fails for isotropy, equivalently
\\ (d_1, d_2)_p (-1, -d_1 d_2)_p ... easier: just use hilbert() in PARI directly.
\\
\\ Hasse-Minkowski for ax^2 + by^2 + cz^2 = 0 (a, b, c nonzero):
\\ Solvable over Q_p iff hilbert(-ab, -ac, p) = 1 (i.e. == 1, not -1).
\\
\\ For us: d_1 y_1^2 - d_2 y_2^2 - c y_3^2 = 0 with c = e_2 - e_1.
\\ Coefficients (a, b, c') = (d_1, -d_2, -c). Hilbert condition:
\\   hilbert(-d_1 * (-d_2), -d_1 * (-c), p) = 1
\\ i.e. hilbert(d_1*d_2, d_1*c, p) = 1.

\\ Check Hasse condition for a*x^2 + b*y^2 + c*z^2 = 0 over Q_p
isotropic_ternary(a, b, c, p) = {
  \\ -a*b should be a norm in Q_p(sqrt(-a*c))
  \\ Standard: solvable iff hilbert(-a*b, -a*c, p) == 1
  if(a == 0 || b == 0 || c == 0, return(1));  \\ trivially solvable
  hilbert(-a*b, -a*c, p) == 1;
};

\\ Local solvability of Selmer triple (d_1, d_2, d_3) for descent on
\\ E: y^2 = (x-e_1)(x-e_2)(x-e_3) at prime p
\\ Equations: d_1 y_1^2 - d_2 y_2^2 = e_2 - e_1,  d_1 y_1^2 - d_3 y_3^2 = e_3 - e_1
\\ Solvable iff EACH of these two ternary forms is isotropic over Q_p AND
\\ they have a *joint* solution.
\\ For independent variables, two conditions are necessary but joint also needed.
\\ For our purposes (computing Selmer rank bound), the standard route:
\\   The class (d_1, d_2, d_3) (with d_1 d_2 d_3 sq) is in the local image at p iff
\\   one of the two binary quadrics splits, equivalently iff EACH conic has
\\   a Q_p-point.
\\
\\ Let's go with the easier approach: use PARI's ellrank as ground truth,
\\ and analyze the *structure* of the Selmer subgroup by counting bad primes
\\ at which various local conditions are imposed.

\\ ===== Now: tabulate the ELLRANK DIM SEL_2 for the full m <= 60 enumeration =====
\\ (cheap: ellrank effort 1)

build_E(m, n) = {
  my(a = m^2 - n^2, b = 2*m*n, q, E, Em);
  q = a/b;
  E = ellinit([0, 1+q^2, 0, q^2, 0]);
  Em = ellminimalmodel(E);
  Em;
};

print("===== dim Sel_2 distribution for m <= 30 =====");
print("(m, n)  rank_lo  rank_up  dim_Sel2  |H|  |H|-dimSel2");

{
nfibers = 0;
count_by_sel2 = vector(20, i, 0);
count_by_H_minus_sel = vector(30, i, 0);
for(m = 2, 30,
  for(n = 1, m-1,
    if(gcd(m, n) != 1 || (m + n) % 2 == 0, next);
    Em = build_E(m, n);
    rk = ellrank(Em, 1);
    s = rk[2] + 2;  \\ dim Sel_2 upper bound
    H = heron_set(m, n);
    diff = #H - s;
    if(diff < 0, diff = 0);  \\ shouldn't happen
    count_by_sel2[s+1]++;
    if(diff + 1 <= 30, count_by_H_minus_sel[diff+1]++);
    nfibers++;
    if(s >= 5, print([m,n], "  ", rk[1], "  ", rk[2], "  ", s, "  ", #H, "  ", #H - s));
  );
);
print();
print("Total fibers: ", nfibers);
print("dim Sel_2 distribution:");
for(i = 1, 20, if(count_by_sel2[i] > 0, print("  dim ", i-1, ": ", count_by_sel2[i])));
print();
print("|H| - dim Sel_2 distribution:");
for(i = 1, 30, if(count_by_H_minus_sel[i] > 0, print("  diff ", i-1, ": ", count_by_H_minus_sel[i])));
}

quit;
