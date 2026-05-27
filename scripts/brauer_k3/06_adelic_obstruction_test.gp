\\ Script 06: Adelic Brauer-Manin obstruction test.
\\
\\ Construct local Q_p-points (P_p) of V' at small primes that are NOT
\\ derived from any Q-point. Test whether the Brauer-Manin sum
\\
\\   sum_p inv_p(alpha(P_p)) = 0  mod  1  for all alpha?
\\
\\ A NEGATIVE answer (some alpha forces sum != 0) means the adelic point
\\ is NOT in V'(A_Q)^Br -- giving a non-trivial Brauer-Manin obstruction.
\\
\\ Strategy:
\\   For each prime p in {2, 3, 5, 7, 11, 13}, enumerate all
\\   (a, b, c, d, e, f) mod p satisfying the 3 face equations mod p.
\\   For each combination of choices across primes, compute the BM sum.

default(parisize, 1000000000);

print("======================================================");
print("Script 06: Adelic BM obstruction enumeration");
print("======================================================");
print("");

\\ Step 1: Enumerate Q_p-points of V' modulo p, for several small primes.
\\ We use: V'(F_p) = {(a:b:c:d:e:f) in P^5(F_p): a^2+b^2=d^2, b^2+c^2=e^2, a^2+c^2=f^2}
\\
\\ Reduction-tree lift to V'(Z_p) via Hensel where smooth.
\\
\\ For BM purposes, the invariant inv_p((alpha_i)(P_p)) for alpha_i = (-1, s)
\\ depends on s = slot_i and the p-adic class of s.

\\ Sample points:  enumerate V'(F_p) reps.
\\ For each prime p, store a list of (a, b, c, d, e, f) reps.

enum_Vp(p) = {
  my(reps, a, b, c, d, e, f, sq);
  sq = vector(p);
  for(x = 0, p - 1, sq[(x^2) % p + 1] = x);
  reps = List();
  for(a = 0, p - 1,
    for(b = 0, p - 1,
      for(c = 0, p - 1,
        \\ (a, b, c) determines (d, e, f) up to signs (and existence).
        \\ d such that d^2 = a^2 + b^2 mod p
        d_test_val = Mod(a^2 + b^2, p);
        d_val = sqrt_modp(lift(d_test_val), p);
        if(d_val == -1, next);
        e_test_val = Mod(b^2 + c^2, p);
        e_val = sqrt_modp(lift(e_test_val), p);
        if(e_val == -1, next);
        f_test_val = Mod(a^2 + c^2, p);
        f_val = sqrt_modp(lift(f_test_val), p);
        if(f_val == -1, next);
        \\ Add primary representative (a, b, c, d_val, e_val, f_val)
        listput(reps, [a, b, c, d_val, e_val, f_val]);
      );
    );
  );
  return(Vec(reps));
}

\\ Return a square root of x mod p, or -1 if not a square.
sqrt_modp(x, p) = {
  my(s);
  x = lift(Mod(x, p));
  if(x == 0, return(0));
  if(!issquare(Mod(x, p)), return(-1));
  s = lift(sqrt(Mod(x, p)));
  return(s);
}

\\ Test the small primes:
{
for(p_idx = 1, 5,
  p = [2, 3, 5, 7, 11][p_idx];
  reps = enum_Vp(p);
  print("p = ", p, ": |V'(F_", p, ")| (affine reps with chosen sign of d,e,f) = ", length(reps));
);
}

print("");
print("======================================================");
print("Compute Hilbert symbols (-1, slot)_p for each rep at each prime");
print("======================================================");

\\ For a representative (a, b, c, d, e, f) mod p, compute the 3 slots
\\ and the inv_p((-1, slot))_p value.

\\ Issue: alpha is defined on V'(Q), not V'(F_p).  Lift via Hensel:
\\ if the slot s = b*(d+a) is non-zero mod p, then any p-adic lift gives the
\\ same Hilbert symbol value modulo squares mod p (for odd p > 2).
\\ For p = 2, need lifts mod 8.
\\
\\ Implementation: pick a "canonical" lift (integer 0..p-1) and compute
\\ hilbert(-1, slot) at p.

\\ For each prime p, count distinct (inv_1, inv_2, inv_3) tuples on V'(F_p).
\\ This tells us how varied the local Brauer invariants are.

table_invs_at_p(p, reps_list) = {
  my(inv_tuples, a, b, c, d, e, f, s1, s2, s3, inv1, inv2, inv3, tup);
  inv_tuples = List();
  for(k = 1, length(reps_list),
    pt = reps_list[k];
    a = pt[1]; b = pt[2]; c = pt[3]; d = pt[4]; e = pt[5]; f = pt[6];
    s1 = (b * (d + a));
    s2 = (c * (e + b));
    s3 = (c * (f + a));
    \\ Skip if any slot is 0 (degenerate / unclear local invariant)
    if(s1 == 0 || s2 == 0 || s3 == 0, next);
    \\ For odd p, use hilbert; for p=2, lift to mod 8.
    if(p == 2,
      \\ For p=2, the Hilbert symbol (-1, s)_2 depends on s mod 8.
      \\ s in {1,3,5,7} mod 8: (-1, s)_2 = 1 if s ≡ 1 mod 4, -1 if s ≡ 3 mod 4.
      \\ Specifically (−1, s)_2 = (−1)^((s-1)/2) for odd s, or based on 2-valuation.
      \\ Lift to integer odd via reps.
      inv1 = (1 - hilbert(-1, s1 + 0, 2)) / 2;
      inv2 = (1 - hilbert(-1, s2 + 0, 2)) / 2;
      inv3 = (1 - hilbert(-1, s3 + 0, 2)) / 2;
      ,
      inv1 = (1 - hilbert(-1, s1, p)) / 2;
      inv2 = (1 - hilbert(-1, s2, p)) / 2;
      inv3 = (1 - hilbert(-1, s3, p)) / 2;
    );
    tup = [inv1, inv2, inv3];
    listput(inv_tuples, tup);
  );
  inv_tuples = Vec(inv_tuples);
  \\ Count distinct tuples
  uniq = Set();
  for(j = 1, length(inv_tuples), uniq = setunion(uniq, Set([inv_tuples[j]])));
  return([length(inv_tuples), length(uniq), Vec(uniq)]);
}

{
for(p_idx = 1, 5,
  p = [2, 3, 5, 7, 11][p_idx];
  reps = enum_Vp(p);
  result = table_invs_at_p(p, reps);
  print("p = ", p, ":  # valid reps = ", result[1], ", # distinct (inv_1, inv_2, inv_3) tuples = ", result[2]);
  print("  Distinct tuples: ", result[3]);
);
}

print("");
print("======================================================");
print("Adelic obstruction check");
print("======================================================");
print("");
print("Brauer-Manin obstruction: exists if there is no adelic point");
print("(P_p) in V'(A_Q) with sum_p inv_p(alpha_i(P_p)) = 0 for i = 1, 2, 3.");
print("");
print("Each alpha_i is a (Z/2)-valued function on V'(Q_p).  At each p,");
print("the value set of (inv_p(alpha_1), inv_p(alpha_2), inv_p(alpha_3))");
print("is a subset of (Z/2)^3.");
print("");
print("Question: can we choose P_p at each prime such that the sum is (0,0,0)");
print("for ALL infinite-dim adelic conditions?");
print("");
print("For finite # primes: the sum constraint is a coset condition in (Z/2)^3");
print("at each prime.  As long as the local images cover (Z/2)^3 in any way that");
print("allows a global sum of zero, no obstruction.");

\\ Compute the FULL local image set at each prime, and check whether the sum
\\ over all primes (where alpha is potentially non-trivial) can be zero.
\\
\\ At primes where alpha is identically zero on V'(Q_p), no constraint.
\\ At primes where alpha takes both values 0 and 1/2: the local set is all of Z/2.
\\
\\ The obstruction arises if at some prime, the local image is STRICTLY a coset
\\ NOT containing 0 (e.g., always 1/2), AND the OTHER primes can't compensate.

print("");
print("======================================================");
print("Per-prime ANALYSIS: image of (inv_1, inv_2, inv_3) in (Z/2)^3");
print("======================================================");

local_images = matrix(5, 8);  \\ row = prime index, col = bit-encoded tuple

bit_encode(t) = t[1] + 2 * t[2] + 4 * t[3];

{
for(p_idx = 1, 5,
  p = [2, 3, 5, 7, 11][p_idx];
  reps = enum_Vp(p);
  for(k = 1, length(reps),
    pt = reps[k];
    a = pt[1]; b = pt[2]; c = pt[3]; d = pt[4]; e = pt[5]; f = pt[6];
    s1 = (b * (d + a));
    s2 = (c * (e + b));
    s3 = (c * (f + a));
    if(s1 == 0 || s2 == 0 || s3 == 0, next);
    if(p == 2,
      inv1 = (1 - hilbert(-1, s1 + 0, 2)) / 2;
      inv2 = (1 - hilbert(-1, s2 + 0, 2)) / 2;
      inv3 = (1 - hilbert(-1, s3 + 0, 2)) / 2;
      ,
      inv1 = (1 - hilbert(-1, s1, p)) / 2;
      inv2 = (1 - hilbert(-1, s2, p)) / 2;
      inv3 = (1 - hilbert(-1, s3, p)) / 2;
    );
    tup = [inv1, inv2, inv3];
    local_images[p_idx, bit_encode(tup) + 1] = 1;
  );
);
}

\\ Print the local image table
{
for(p_idx = 1, 5,
  p = [2, 3, 5, 7, 11][p_idx];
  print("Local image at p=", p, " (8 bits, 1 = tuple is in image):");
  print("  ", vector(8, j, local_images[p_idx, j]));
);
}

\\ Now: F_2-affine span of local images. If full (Z/2)^3, no obstruction from these primes.
{
local_image_set = matrix(0, 3);  \\ accumulate tuples globally seen
for(p_idx = 1, 5,
  for(j = 1, 8,
    if(local_images[p_idx, j] == 1,
      t = [j - 1, 0, 0]; t[1] = (j-1) % 2; t[2] = ((j-1) \ 2) % 2; t[3] = ((j-1) \ 4) % 2;
      local_image_set = matconcat([local_image_set; t]);
    );
  );
);
}

print("");
print("Combined local images (across all primes): rows are tuples");
print(local_image_set);

\\ Check if SOME element of (Z/2)^3 is NOT in this combined set
\\ i.e., is there a tuple that no local prime can produce.
all_tuples = Set([[0,0,0], [1,0,0], [0,1,0], [0,0,1], [1,1,0], [1,0,1], [0,1,1], [1,1,1]]);
seen = Set();
{
for(i = 1, matsize(local_image_set)[1],
  seen = setunion(seen, Set([Vec(local_image_set[i,])]));
);
}

missing = setminus(all_tuples, seen);
print("");
print("All possible (Z/2)^3 tuples: ", Vec(all_tuples));
print("Tuples produced at SOME prime: ", Vec(seen));
print("Tuples NEVER produced: ", Vec(missing));

print("");
print("======================================================");
print("INTERPRETATION");
print("======================================================");
print("If 'Tuples NEVER produced' is non-empty, this means no choice of");
print("(P_p)_p at the tested primes gives that tuple as a local invariant.");
print("This is INSUFFICIENT for a BM obstruction by itself (we need");
print("FORCED nonzero sum globally, not absence of one tuple), but");
print("a key combinatorial fact.");
print("");
print("PROPER BM check: enumerate possible sums sum_p inv_p(alpha_i)");
print("over adelic points and see if 0 is achievable.");

\\ The proper test: are there adelic points (P_p)_p such that the sum
\\ over all p of inv_p(alpha_i) is 0 in Z/2 for each i?
\\
\\ The local image at each prime is a subset I_p \subset (Z/2)^3.
\\ The set of achievable global sums is the Minkowski sum
\\   I_2 + I_3 + I_5 + I_7 + I_11 + ... (in (Z/2)^3).
\\
\\ This Minkowski sum is the F_2-linear hull of \bigcup_p I_p.
\\ If the hull is all of (Z/2)^3, then 0 (and every other tuple) is achievable
\\   (since 0 is the trivial sum and (Z/2)^3 contains 0).

\\ For a BM obstruction to exist, we'd need the local image at EVERY prime
\\ to be the SAME constant tuple t_0 != 0 (so the sum is forced
\\ to be t_0 * (# primes) in Z/2 = t_0 mod 2 if # primes is odd,
\\ 0 if even -- still possible).
\\
\\ This is very rare and equivalent to "the BM class is constant non-zero
\\ at every place."  Standard: needs computation of the kernel of
\\ Br(V')_loc -> (Br Q_p) at each place.

\\ Compute the F_2-linear hull:
hull_matrix = local_image_set;
print("");
print("F_2-rank of combined local images = ", matrank(Mod(hull_matrix, 2)));
print("If rank = 3, the Minkowski sum is full (Z/2)^3 => any tuple including 0 is achievable.");
print("If rank < 3, the achievable sums lie in a proper F_2-subspace of (Z/2)^3.");
print("In the latter case, BM obstruction exists if 0 is not in the F_2-image of");
print("the local-image union (counting multiplicities of local choices).");

quit;
