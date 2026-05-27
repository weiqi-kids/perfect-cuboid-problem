\\ 05_descent_enumerate.gp — Manual enumeration of Sel_2(E_PCP/Q(q))
\\
\\ Selmer ambient is (K(S,2))^2 where K = Q(q), S = {(q), (q-1), (q+1), inf, 2, R}.
\\ K(S, 2) has F_2-basis {-1, 2, q, q-1, q+1} — dim 5.
\\ So ambient (d_1, d_2): dim 10.
\\
\\ For each pair (d_1, d_2), check local solvability at each bad place:
\\   At v ∈ S: the conic C(d_1, d_2) has K_v-point iff certain Hilbert symbol conditions hold.
\\
\\ For E_PCP: conditions reduce to
\\   (d_2, -d_1)_v = 1                    [from T_{12} = T_{13}]
\\   (d_1, -d_2(q^2-1))_v = 1             [from T_{23}]
\\ at each place v of K.

default(parisize, 1000000000);

\\ STEP 1: Enumerate all candidate (d_1, d_2) in K(S, 2)^2.
\\
\\ K(S, 2) basis: g_1=-1, g_2=2, g_3=q, g_4=q-1, g_5=q+1.
\\ A square class is represented by exponent vector (a_1, a_2, a_3, a_4, a_5) in F_2^5.
\\ Total elements in K(S, 2): 2^5 = 32.
\\ Total pairs (d_1, d_2): 32^2 = 1024.
\\
\\ STEP 2: For each pair, check local conditions at each place.
\\
\\ Places of K = Q(q):
\\   v_q = q-adic       (irreducible q in Q[q])
\\   v_{q-1} = (q-1)-adic
\\   v_{q+1} = (q+1)-adic
\\   v_inf = infinity in Q(q) (degree valuation)
\\   v_2, v_R from Q
\\ Plus all other primes of Q where (d_1 or d_2 or q^2-1) could have non-trivial Hilbert symbol.
\\ Hmm: actually since d_1, d_2 are supported on S only, and q^2-1 = (q-1)(q+1) is in S,
\\ Hilbert symbols at "other" primes are trivial. So conditions only at the 6 places above.

\\ STEP 3: But this is OVER A FUNCTION FIELD. Hilbert symbols on function fields
\\         are computed differently than over Q.
\\
\\ For K = Q(q), the local field at place v = (q) is K_v = Q((q)) = Laurent series in q.
\\ Hilbert symbol on Q((q)): for π = q (uniformizer), residue field = Q,
\\ we have a similar formula to Q_p((π)) involving residue field Hilbert symbols and tame
\\ residue.
\\
\\ At v = (q): given α, β ∈ Q((q)), write α = q^a u, β = q^b w with u, w units.
\\   (α, β)_q = ((-1)^{ab} u^b / w^a |_{q=0}, ?)_residue_field
\\   The unit-unit part: ((-1)^{ab} u(0)^b / w(0)^a, residue)
\\
\\ For OUR pairs (d_1, d_2) with d_i in {-1, 2, q, q-1, q+1} (mod squares),
\\ all the residues at q=0 are well-defined units:
\\   -1 → -1
\\   2 → 2
\\   q → uniformizer (q-adic valuation 1)
\\   q-1 → -1 at q=0
\\   q+1 → 1 at q=0
\\
\\ So the residues at q=0: among {-1, 2, q, q-1, q+1}, the residue at q=0 is:
\\   -1: -1
\\   2: 2
\\   q-1: -1
\\   q+1: 1
\\ and q itself is the uniformizer.
\\
\\ This gives us the data for the local Hilbert symbol at v = (q).
\\
\\ For function fields, the SIMPLEST way to check local conditions is to specialize and
\\ use the standard Q_p Hilbert symbol PARI command. Specifically:
\\   At v = (q), substitute q = small prime p where reducible conditions match.
\\   But more directly: use the formula
\\     (q^a u, q^b w)_{v=(q)} = (-1)^{ab} * (u(0)^b w(0)^{-a}, infinity)_residue
\\                            * (q-independent terms from Hensel)
\\
\\ For Q((π)) with residue field F = Q, the Hilbert symbol formula:
\\   (π^a u, π^b w)_{(π)} = norm-residue symbol on F
\\   Specifically, the tame symbol gives:
\\     {α, β}_v = (-1)^{v(α) v(β)} α^{v(β)} / β^{v(α)} mod π
\\
\\ For our K = Q(q), the local field at v = (q) is Q((q)). This is NOT a local field
\\ in the usual sense (residue field is Q, infinite). So "Hilbert symbol" as a homomorphism
\\ to {±1} is NOT directly available.
\\
\\ Resolution: pass to a place of Q(q) lying OVER a prime p of Q. For each rational prime p,
\\ we have completions of Q(q) corresponding to places of Q(q) over p. The Hilbert symbol
\\ over these completions makes sense.
\\
\\ APPROACH: For function-field 2-descent, work with the BASE-CHANGE TO Q_p((q))
\\ at various primes p. The 2-Selmer condition over Q(q) is equivalent to all
\\ Q_p((q))-conditions for all primes p (in the Néron-Severi / specialization sense).

\\ This is getting complicated. Let me take a CLEANER approach.

print("=== A cleaner approach: PRIMES OF Q(q) as ARITHMETIC scheme ===");
print();
print("View E_PCP as elliptic curve over the DEDEKIND DOMAIN Q[q] (PID).");
print("The 'places' of Q(q) include both the geometric ones (irreducible q-poly factors)");
print("AND the arithmetic ones (rational primes p).");
print();
print("For the 2-descent SELMER GROUP, the relevant places are those where E has bad red.");
print("Bad red at v iff v | Disc(E) and reducing E mod v is not smooth.");
print("Disc(E) = 16 q^4 (q-1)^2 (q+1)^2 ∈ Q[q].");
print("Bad reduction at:");
print("  Geometric: v = (q), (q-1), (q+1).");
print("  Arithmetic: v = 2 (from coefficient 16) and all primes p of Q.");
print("  (Plus infinity-place of Q(q) and archimedean place of Q.)");
print();
print("For each such v, compute the local image and intersect to get global Selmer.");

\\ INSIGHT: Specialize to Q_p((q)) for various primes p.
\\ At a prime p, the curve E_PCP over Z_p[q] is smooth iff p doesn't divide Disc evaluated
\\ at any q-adic root. The only "bad" arithmetic prime is p = 2 (and the q-adic places
\\ over each p where (q), (q-1), or (q+1) hits).

\\ Let me now write the actual descent.
\\ ALGORITHM:
\\ 1. Enumerate all 1024 candidate pairs (d_1, d_2) with d_i ∈ K(S, 2) ⊂ K*/K*^2.
\\ 2. For each pair, check local solvability at each place.
\\ 3. The kernel of these conditions is Sel_2.

\\ For local solvability, we use the formula:
\\   At a place v, the conic
\\     C_1: d_1 z_1^2 + 1 = d_2 z_2^2     ⟹ d_1 X^2 - d_2 Y^2 + Z^2 = 0
\\   is locally solvable iff (the Hilbert symbol condition above) holds.
\\
\\ But we have ANOTHER, more elementary approach for function fields:
\\   The conic C_1 has a Q(q)-point iff it has a Q_p(q)-point for every prime p
\\   AND a Q((1/q))-point and a Q-point at each place of Q(q) above 2 and inf.
\\
\\ This is exactly Hasse principle for conics: a conic has a global Q(q)-point iff it has
\\ local points at every place. So we just need to check it has a K-point.
\\
\\ ACTUALLY: for function-field descent, the global Selmer-2 question is:
\\ Does C(d_1, d_2) have an Q(q)-point? Since C is a genus-1 curve over Q(q), this
\\ is generally undecidable. But we can check LOCAL solvability via Hilbert symbols.
\\
\\ HOWEVER, for our specific question about the GENERIC 2-Selmer dim over Q(q), it suffices to
\\ enumerate the candidates and check local conditions.

\\ Let me just compute this using a direct approach: check whether the conic
\\   d_1 z_1^2 + 1 = d_2 z_2^2
\\ has a Q(q)-point, which is equivalent (by Hasse-Minkowski for conics over Q(q))
\\ to local solvability at all places.

\\ For each pair (d_1, d_2), let me check Q(q)-rational solvability of the conic.

\\ STRATEGY: I'll work over Q[q] and use polynomial Hilbert symbols.
\\ For a, b ∈ Q[q] (or Q(q)), the conic a x^2 + b y^2 = z^2 over Q(q) has a Q(q)-point iff:
\\   (a, b)_v = 1 at every place v of Q(q), AND
\\   (a, b)_v = 1 at every place v of Q (regarded as scalars via Q ⊂ Q(q)).
\\
\\ The Hilbert symbol at a geometric place v of Q(q) over Q:
\\ - If v is finite, write v = (π) for some monic irreducible π ∈ Q[q].
\\   The residue field is K_v = Q[q]/(π).
\\   The tame symbol (a, b)_π = (-1)^{v(a)v(b)} * (a^v(b) / b^v(a)) mod π, viewed in K_v*/K_v*^2.
\\   This is an ELEMENT of K_v*/K_v*^2, not {±1}.
\\ - This makes function-field Hilbert symbol valued in K_v*/K_v*^2 (a quotient of an
\\   infinite group).
\\
\\ To get {±1}-valued, we further compose with another local symbol from K_v to {±1}.
\\
\\ OK, let me just enumerate by checking whether each candidate gives a solvable conic.
\\ I'll use the most direct approach: check Q(q)-solvability by finding actual rational
\\ functions, or proving non-existence via small-q specialization.

print();
print("=== Algorithmic approach: Q(q)-solvability via SPECIALIZATION + Hasse ===");
print();
print("For each candidate (d_1, d_2), check that the conic");
print("   C: d_1 X^2 - d_2 Y^2 + Z^2 = 0");
print("has a Q(q)-point. By Hasse-Minkowski for conics over Q(q):");
print("  - Local at all v of Q(q) (incl. arithmetic and geometric)");
print("  - Local at all arithmetic primes p of Q (since Q ⊂ Q(q))");
print();
print("Specialization argument: if the conic is unsolvable at q = q_0 ∈ Q (in Q_p for some p),");
print("then it's unsolvable over Q(q). Conversely, if solvable at the GENERIC point, then");
print("solvable for almost all specializations.");
print();
print("Decision procedure:");
print("  1. The conic d_1(q) X^2 - d_2(q) Y^2 + Z^2 = 0 has Q(q)-point iff its");
print("     'function field discriminant' is a square in Q(q).");
print("  2. For binary quadratic forms, solvability is determined by the local conditions.");

\\ Let me now CODE the function-field descent.
\\ The basis of K(S, 2) with S = {(q), (q-1), (q+1), inf, 2, R}:
\\   {-1, 2, q, q-1, q+1}    (5 elements)
\\
\\ Each element of K(S, 2) is encoded as a vector in F_2^5: (e_{-1}, e_2, e_q, e_{q-1}, e_{q+1}).

basis = [-1, 2, 'q, 'q-1, 'q+1];
n_basis = 5;
ambient_dim = 2 * n_basis;

print();
print("Basis of K(S, 2): ", basis);
print("F_2-dim of K(S, 2): ", n_basis);
print("F_2-dim of ambient (d_1, d_2) space: ", ambient_dim);
print("Total elements to enumerate: ", 2^ambient_dim, " = ", 2^ambient_dim);

\\ Construct an element from exponent vector v ∈ F_2^5
elt_from_vec(v) = {
  my(r = 1);
  for (i = 1, n_basis, if (v[i] != 0, r = r * basis[i]));
  return(r);
};

\\ Generate all 32 elements of K(S, 2)
{
all_elts = vector(32);
for (k = 0, 31,
  v = vector(5);
  for (i = 1, 5, v[i] = bittest(k, i-1));
  all_elts[k+1] = [v, elt_from_vec(v)];
);
print();
print("Sample elements of K(S, 2):");
for (k = 0, 9,
  print("  v=", all_elts[k+1][1], " ⟹ d = ", all_elts[k+1][2]);
);
}
