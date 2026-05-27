\\ Script 05: The PCP Brauer-Manin obstruction test.
\\
\\ Strategy: A perfect cuboid would satisfy
\\   a^2 + b^2 = d^2,  b^2 + c^2 = e^2,  a^2 + c^2 = f^2,
\\   a^2 + b^2 + c^2 = g^2.
\\
\\ The three Brauer classes alpha_1, alpha_2, alpha_3 on V'.
\\ For each, evaluate at a *hypothetical* PCP point.  Use the
\\ slot formulas:
\\   alpha_1 = (-1, b*(d+a)),  alpha_2 = (-1, c*(e+b)),  alpha_3 = (-1, c*(f+a)).
\\
\\ The g equation gives an EXTRA constraint: a^2 + b^2 + c^2 = g^2 means
\\ d^2 + c^2 = g^2, i.e. g is a hypotenuse of (d, c).  This is a 4th
\\ Pythagorean relation that imposes a NEW Hilbert symbol condition.
\\
\\ Consider the "diagonal" Brauer class alpha_4 = (-1, c*(g+d)):
\\   if g^2 = c^2 + d^2 has c+d as a slot, and the splitting c^2 + d^2 = (c+id)(c-id)
\\   gives an analogous orbit in Pic(V_bar) (NOT Pic(V'_bar) — V has the extra g coord).
\\
\\ However, we're focused on V'.  On V', the PCP additional constraint is "external":
\\
\\   PCP <=> Euler brick (a, b, c) with a^2 + b^2 + c^2 = g^2.
\\
\\ This g condition is NOT an equation of V' but a SQUARE-CLASS condition on
\\ the function a^2 + b^2 + c^2 restricted to V'(Q).
\\
\\ Translation: a Q-point P = (a, b, c, d, e, f) of V' lifts to a PCP iff
\\   a^2 + b^2 + c^2 ∈ (Q^*)^2.
\\
\\ Equivalently, the quadratic form sigma_4(P) := a^2 + b^2 + c^2 must be a square.
\\
\\ Now: BM evaluation of alpha_1, alpha_2, alpha_3 at adelic points of V'
\\ does NOT depend on the g lift.  The 3 alpha classes live on V', not V.
\\
\\ But we can ASK: does the Halcke-template c=0 baseline of V_q (the genus-5
\\ slice c=q^2-1 = something) correspond to a SPECIFIC adelic point of V'?
\\
\\ The Halcke-closed fibers (from FINAL-SYNTHESIS-2026-05-21): 12 specific
\\ (m, n) where E_Hm has rank 0.  For these, V_q(Q) only contains the
\\ degenerate c=0 points.  By the K3-V' relation, these descend to
\\ a^2+b^2+c^2 = 0 (with c = 0) on V': i.e., a^2+b^2 = 0, which means
\\ a = ±ib (NOT rational).  So no rational point of V' arises this way.
\\
\\ Therefore the Halcke-closed fibers do NOT contribute Q-points to V'.
\\ They contribute adelic points only.
\\
\\ Test: at each Halcke-closed (m, n), construct the adelic point of V'(A_Q)
\\ corresponding to (a, b, c) where (a, b) = (m^2-n^2, 2mn) (Pythagorean!)
\\ and c is a "generic" symbol.  Evaluate alpha_i and sum invariants.
\\
\\ But wait — V' is a SURFACE, so V'(A_Q) is much larger than the c=0 slice.
\\ An adelic point of V' is a tuple (P_v)_v with P_v ∈ V'(Q_v).
\\
\\ The BM condition: sum_v inv_v(alpha(P_v)) = 0 for any global Brauer class alpha.
\\ If this sum is FORCED NON-ZERO for every adelic point in some sub-locus,
\\ that sub-locus is BM-obstructed.

default(parisize, 1000000000);

print("======================================================");
print("Script 05: BM evaluation at hypothetical PCP candidates");
print("======================================================");

\\ Test 1: For (m, n) Pythagorean, take a = m^2-n^2, b = 2mn, d = m^2+n^2.
\\ Then for any rational c, the point (a, b, c, ., ., .) is on V' iff
\\   b^2 + c^2 = e^2 and a^2 + c^2 = f^2.
\\
\\ This is the "Euler-brick existence" condition.
\\ We KNOW that Euler bricks exist (e.g. brick 1: (a, b, c) = (44, 117, 240) ⇒ m=?
\\ Actually 44 = m^2-n^2, 117 = 2mn?  117 is odd so 2mn = even, contradiction.
\\ Try permutation: (a, b, c) = (117, 44, 240): 44 = 2mn forces mn = 22 = 2*11.
\\ (m,n) = (11, 2) gives m^2 - n^2 = 121 - 4 = 117. ✓
\\
\\ So brick 1 (oriented as (117, 44, 240)) corresponds to (m, n) = (11, 2).
\\ Let's use this orientation.

bricks_oriented = [[117, 44, 240, 11, 2], [85, 132, 720, -1, -1], [693, 140, 480, -1, -1], [231, 160, 792, -1, -1], [1020, 187, 1584, -1, -1], [275, 240, 252, -1, -1], [1155, 1008, 1100, -1, -1]];
\\ Format: (a, b, c, m, n) -- m, n = -1 if not direct Saunderson
\\ For most, we don't need (m, n); we just need (a, b, c).
\\
\\ Halcke-closed Saunderson (m, n) (from FINAL-SYNTHESIS-2026-05-21 Table):
\\   (8, 3), (205, 66), (341, 208), (451, 152), (506, 47), (538, 279),
\\   (592, 539), (737, 574), (834, 361), (943, 206), (988, 321), (88, 35).
\\
\\ For these, the Halcke fiber V_q (with q = 2mn/(m^2-n^2)) has only
\\ degenerate Q-points (c=0).  Hand-checked: PCP does not exist here.

halcke_closed = [[8, 3], [88, 35], [205, 66], [341, 208], [451, 152], [506, 47], [538, 279], [592, 539], [737, 574], [834, 361], [943, 206], [988, 321]];

print("Halcke-closed (m, n) fibers (12 known):");
{for(k = 1, length(halcke_closed), print("  ", halcke_closed[k]));}

\\ For each Halcke-closed (m, n): test if there is an adelic obstruction
\\ to a HYPOTHETICAL PCP point with these (m, n).
\\
\\ A "hypothetical PCP" at (m, n): (a, b, c, d, e, f, g) with
\\   a = m^2 - n^2, b = 2mn, d = m^2 + n^2,
\\   c, e, f, g such that b^2+c^2=e^2, a^2+c^2=f^2, a^2+b^2+c^2=g^2.
\\
\\ The 4 unknown rationals: c, e, f, g.
\\
\\ Note: a, b, c, d, e, f live on V'.  The Brauer-Manin sum for alpha_1, alpha_2, alpha_3
\\ is:
\\   sum_v inv_v((-1, b*(d+a)))   -- depends only on b, d, a, NOT on c, e, f.
\\   sum_v inv_v((-1, c*(e+b)))   -- depends on c, e, b.
\\   sum_v inv_v((-1, c*(f+a)))   -- depends on c, f, a.
\\
\\ For Halcke-closed fibers we ask:
\\   - alpha_1 only depends on (a, b, d), which are FIXED by (m, n).
\\     Reciprocity automatic (no obstruction from alpha_1 alone).
\\   - alpha_2, alpha_3 depend on c, e, f — varying with the unknown brick.
\\
\\ So the actionable test is: does alpha_1 EVALUATE CONSTANT at all (m, n)?
\\
\\ Compute inv_p(alpha_1) at primes p for each Halcke-closed (m, n):

print("");
print("======================================================");
print("alpha_1 = (-1, b*(d+a)) evaluation at the 12 Halcke-closed (m,n).");
print("Note: alpha_1 depends ONLY on the Pythagorean parameters, not on c.");
print("======================================================");

pp_list = [2, 3, 5, 7, 11, 13, 17, 19, 23];
npp = length(pp_list);

{
for(k = 1, length(halcke_closed),
  mn = halcke_closed[k];
  m = mn[1]; n = mn[2];
  a = m^2 - n^2;
  b = 2 * m * n;
  d = m^2 + n^2;
  s1 = b * (d + a);
  print("(m,n)=(", m, ",", n, "): a=", a, ", b=", b, ", d=", d);
  print("  s1 = b(d+a) = ", s1, "    (factored: ", factor(abs(s1)), ")");
  inv_vec = vector(npp);
  for(j = 1, npp,
    p = pp_list[j];
    inv_vec[j] = (1 - hilbert(-1, s1, p)) / 2;
  );
  arch_inv1 = if(s1 < 0, 1, 0);
  print("  Arch inv: ", arch_inv1);
  print("  inv @ primes ", pp_list, ": ", inv_vec);
  \\ Full reciprocity:
  full_pp = Set([2]);
  fs = factor(abs(s1));
  for(r = 1, matsize(fs)[1], full_pp = setunion(full_pp, Set([fs[r,1]])));
  full_pp = Vec(full_pp);
  sum_inv = arch_inv1;
  for(j = 1, length(full_pp),
    sum_inv = sum_inv + (1 - hilbert(-1, s1, full_pp[j])) / 2;
  );
  recip_check = lift(Mod(sum_inv, 2));
  print("  Reciprocity (full primes ", full_pp, "): sum mod 2 = ", recip_check);
);
}

print("");
print("=== KEY OBSERVATION ===");
print("For all (m,n), alpha_1 has reciprocity sum = 0 mod 2 (built-in).");
print("This is because the slot b*(d+a) is a specific function of (m,n)");
print("whose Hilbert reciprocity is automatic.");
print("");
print("THE OBSTRUCTION (if any) comes from the COMBINATION alpha_1+alpha_2+alpha_3");
print("evaluated at a hypothetical PCP point with (m,n)-Pythagorean data.");
print("Since alpha_2, alpha_3 depend on c, e, f, the test is whether");
print("a CONSISTENT choice of c, e, f exists making the BM sum vanish.");

print("");
print("======================================================");
print("Test: BM sum of (alpha_1 + alpha_2 + alpha_3) over Q-points");
print("======================================================");

\\ For each Euler brick (which is a Q-point of V'):
{
for(k = 1, length(bricks_oriented),
  b_data = bricks_oriented[k];
  a = b_data[1]; b = b_data[2]; c = b_data[3];
  d = sqrtint(a^2 + b^2);
  e = sqrtint(b^2 + c^2);
  f = sqrtint(a^2 + c^2);
  s1 = b * (d + a);
  s2 = c * (e + b);
  s3 = c * (f + a);
  s_combined = s1 * s2 * s3;
  \\ The product of three (-1, x) is (-1, x_1*x_2*x_3) in Br[2].
  full_pp = Set([2]);
  fs = factor(abs(s_combined));
  for(r = 1, matsize(fs)[1], full_pp = setunion(full_pp, Set([fs[r,1]])));
  full_pp = Vec(full_pp);
  arch_inv = if(s_combined < 0, 1, 0);
  sum_inv = arch_inv;
  for(j = 1, length(full_pp),
    sum_inv = sum_inv + (1 - hilbert(-1, s_combined, full_pp[j])) / 2;
  );
  recip = lift(Mod(sum_inv, 2));
  print("Brick ", k, " (a,b,c)=(", a, ",", b, ",", c, "): alpha_1+alpha_2+alpha_3 (= (-1, s1*s2*s3)) reciprocity = ", recip);
);
}

print("");
print("======================================================");
print("alpha_4 = (-1, g*(?+?)) candidate for PCP candidate");
print("======================================================");
print("");
print("For a HYPOTHETICAL PCP, there's a 4th relation a^2+b^2+c^2=g^2.");
print("Equivalently d^2+c^2=g^2 (since d^2=a^2+b^2).");
print("So (d, c, g) is a Pythagorean triple, giving");
print("  alpha_4 = (-1, c*(g+d)) ∈ Br(V)/Br_0 (NOT V', since g is a V-only coord)");
print("");
print("BM evaluation: for a candidate PCP, all 4 alpha_i must have local invariant");
print("sums = 0 mod 1. If any has SUM ≠ 0 forced over all adelic V'(A_Q) ∩ {g exists}");
print("then PCP is BM-blocked.");
print("");
print("Test: hypothetical PCP with d^2 + c^2 = g^2 imposed.");
print("Pick (d, c) from a Halcke parameter and check if g exists locally.");

\\ For Halcke (m, n) we have d = m^2+n^2, and we ask: for what c is c^2+d^2 a square?
\\ Trivial: c = 0 gives g = d. c = ±d * (Pythagorean ratio)...
\\ Hmm, this is a CONIC problem: parametrize Pythagorean triples (d, c, g) at fixed d.

print("");
print("--- For each Halcke-closed (m, n), find c values s.t. (d, c, g) is a Pythagorean triple ---");
{
for(k = 1, length(halcke_closed),
  mn = halcke_closed[k];
  m = mn[1]; n = mn[2];
  a = m^2 - n^2; b = 2*m*n; d = m^2 + n^2;
  print("");
  print("(m, n) = (", m, ",", n, ") => d = ", d, " (a=", a, ", b=", b, ")");
  print("  Need c such that d^2 + c^2 = g^2.");
  print("  Pythagorean triples with d=", d, " as a leg:");
  \\ Pythagorean triples (d, c, g) with d as a leg:
  \\ d^2 + c^2 = g^2 => (g-c)(g+c) = d^2.  Let g-c = u, g+c = v with uv = d^2.
  \\ Then g = (u+v)/2, c = (v-u)/2.  Both integer iff u, v same parity.
  \\ If d is odd: u, v factor d^2 (odd), so both odd ⇒ same parity. ✓
  \\ If d is even: d^2 = 4*(d/2)^2.  Divisor pairs include 1*d^2 (different parity if d even).
  \\
  \\ For (m,n)=(8,3): d = 73 (odd prime). d^2 = 5329. Divisors: 1, 73, 5329.
  \\ (u, v): (1, 5329), (73, 73), (5329, 1).
  \\ (1, 5329) -> c = 2664, g = 2665.
  \\ Pythagorean triple: (73, 2664, 2665).
  d_sq = d^2;
  divs = divisors(d_sq);
  cs = List();
  for(j = 1, length(divs),
    u = divs[j];
    v = d_sq / u;
    if(u >= v, next);  \\ avoid duplicates
    if((u + v) % 2 == 1, next);  \\ different parity
    c = (v - u) / 2;
    g = (u + v) / 2;
    if(c > 0, listput(cs, [c, g]));
  );
  print("  c-values: ", Vec(cs));
  \\ For each such c, check if (b^2 + c^2) is a square (i.e. e exists)
  \\ AND (a^2 + c^2) is a square (i.e. f exists).
  \\ If YES, then this would be a Euler brick AND a PCP candidate.
  for(jj = 1, length(cs),
    cg = cs[jj];
    c = cg[1]; g = cg[2];
    e2 = b^2 + c^2;
    f2 = a^2 + c^2;
    is_e_sq = issquare(e2);
    is_f_sq = issquare(f2);
    print("    c=", c, ", g=", g, ": e^2=", e2, " is_square?=", is_e_sq, ", f^2=", f2, " is_square?=", is_f_sq);
  );
);
}

print("");
print("======================================================");
print("End of script 05");
print("======================================================");
quit;
