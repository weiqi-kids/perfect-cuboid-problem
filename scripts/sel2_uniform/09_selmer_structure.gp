\\ =====================================================================
\\ 09_selmer_structure.gp
\\
\\ Try the function-field 2-descent style analysis: write down explicit
\\ Selmer generators for several fibers and inspect their structure.
\\
\\ Schaefer 1996: For E: y^2 = (x-e_1)(x-e_2)(x-e_3) with all e_i rational,
\\ delta: E(Q)/2E(Q) -> (Q*/Q*^2)^2 given by P -> (x(P)-e_1, x(P)-e_2)
\\ The image satisfies (x-e_1)*(x-e_2)*(x-e_3) = y^2, so the "third"
\\ coordinate is determined.
\\
\\ Selmer = {(d_1, d_2) : Q^*/Q^*2 supported on S, satisfying
\\           the homogeneous space C(d_1, d_2):
\\             d_1 z_1^2 = x - e_1,  d_2 z_2^2 = x - e_2,  d_1 d_2 z_3^2 = x - e_3
\\           has Q_v-rational point for every place v}
\\
\\ For E_PCP: e_1 = -q^2, e_2 = -1, e_3 = 0 (use this ordering; signs
\\ adjusted so e_1 < e_2 < e_3).
\\
\\ Equations:
\\   d_1 z_1^2 = x + q^2
\\   d_2 z_2^2 = x + 1
\\   d_1 d_2 z_3^2 = x
\\ Subtracting first two: d_1 z_1^2 - d_2 z_2^2 = q^2 - 1 = (sf(P) * sf(Q)) * (square)
\\ First minus third: d_1 z_1^2 - d_1 d_2 z_3^2 = q^2, so z_1^2 - d_2 z_3^2 = q^2/d_1
\\                  divided by d_1: z_1^2/d_1 - d_2 z_3^2/d_1 = q^2/d_1^2
\\                  multiplied by d_1: z_1^2 - d_2 (z_3 sqrt(d_1))^2 = q^2 (over Q(sqrt(d_1)))
\\                  Hmm, easier: d_1 z_1^2 - d_1 d_2 z_3^2 = q^2 says
\\                  d_1(z_1^2 - d_2 z_3^2) = q^2, so z_1^2 - d_2 z_3^2 = q^2/d_1
\\                  for this to be solvable over Q (modulo d_1 being a sq class):
\\                  d_1 must be in same square class as q^2 (i.e. d_1 sq in Q).
\\                  Wait no — d_1 in Q*/Q*^2, q^2/d_1 in Q*/Q*^2, equation makes sense.
\\
\\ Let me restate the LOCAL conditions for (d_1, d_2):
\\ At each place v, the system C(d_1, d_2) has Q_v-point iff each of three
\\ "pair" conditions hold:
\\   (a) z_1^2/d_1 - z_2^2/d_2 = (q^2 - 1)/(d_1 d_2) has Q_v-rep solution
\\   (b) similarly for other pairs
\\
\\ Modular arithmetic: scaling appropriately, (a) is the ternary form
\\   d_2 X^2 - d_1 Y^2 = d_1 d_2 (q^2 - 1) Z^2... let's get this right.
\\
\\ Multiplying the FIRST minus SECOND by d_1 d_2:
\\   d_1 d_2 (d_1 z_1^2 - d_2 z_2^2) = d_1 d_2 (q^2 - 1)
\\   d_2 (d_1 z_1)^2 - d_1 (d_2 z_2)^2 = d_1 d_2 (q^2 - 1)  ...substitute u = d_1 z_1, v = d_2 z_2:
\\   d_2 u^2 / d_1 - d_1 v^2 / d_2 ... not quite.
\\
\\ Let me just write the standard form. The ternary in (z_1, z_2, c):
\\   d_1 z_1^2 - d_2 z_2^2 = (q^2 - 1) c^2
\\ has Q_v-point (z_1, z_2, c not all zero) iff (using Hilbert symbol)
\\   (d_1, d_2)_v = ?... actually the criterion for the ternary
\\     A x^2 + B y^2 + C z^2 = 0
\\   to be isotropic at v is hilbert(-AB, -AC, v) = 1 (in F_2).
\\   Here A = d_1, B = -d_2, C = -(q^2-1). So criterion:
\\     hilbert(d_1 * d_2, d_1*(q^2-1), v) = 1
\\
\\ For each place v in BAD ∪ {2, ∞}, this is the local condition.
\\ Hilbert reciprocity: prod_v (a, b)_v = 1 for any a, b in Q*.
\\
\\ So the LOCAL conditions at all bad places + ∞ + 2 are NOT all
\\ independent — there's exactly ONE F_2-linear dependence among them
\\ (Hilbert reciprocity for the pair (d_1, d_2)).
\\
\\ But wait: we have THREE ternaries (one for each pair (i, j)):
\\   d_1 z_1^2 - d_2 z_2^2 = (q^2 - 1) (giving Hilbert relation 1)
\\   d_1 z_1^2 - d_1 d_2 z_3^2 = q^2     (relation 2)
\\   d_2 z_2^2 - d_1 d_2 z_3^2 = 1       (relation 3)
\\ But:  (relation 2) - (relation 1) - (relation 3) = ... they are
\\       linearly related, so only 2 independent.
\\
\\ For OUR E_PCP, relations 2 and 3 have RHS = q^2 and 1 respectively,
\\ both perfect squares. This means:
\\
\\ Relation 2:  d_1 z_1^2 - d_1 d_2 z_3^2 = q^2
\\              Divide by d_1: z_1^2 - d_2 z_3^2 = q^2/d_1
\\              In Q*/Q*^2: this requires d_1 to be a sum of two squares mod-d_2,
\\              with the sum equaling q^2/d_1 mod sq.
\\              Equivalent ternary: z_1^2 - d_2 z_3^2 - (q^2/d_1) c^2 = 0
\\              Or scaling by d_1: d_1 z_1^2 - d_1 d_2 z_3^2 - q^2 c^2 = 0
\\              Hilbert criterion: hilbert(d_1 * d_1 d_2, d_1 * (-q^2), v) = 1
\\                              ~= hilbert(d_2, -d_1, v) = 1 (mod squares)
\\              i.e. (d_2, -d_1)_v = 1 (in mult notation).
\\
\\ Relation 3:  d_2 z_2^2 - d_1 d_2 z_3^2 = 1
\\              Divide by d_2: z_2^2 - d_1 z_3^2 = 1/d_2 = d_2/d_2^2
\\              In Q*/Q*^2: requires (d_1, d_2)_v = 1 (Pell-style).
\\              Hilbert criterion: (d_1, d_2)_v = 1 for all v.
\\
\\ Relation 1:  d_1 z_1^2 - d_2 z_2^2 = (q^2 - 1)
\\              Hilbert criterion: hilbert(d_1 d_2, d_1 (q^2 - 1), v) = 1
\\              i.e. (d_1 d_2, d_1 (q^2-1))_v = 1
\\              Using bilinearity: (d_1, d_1)_v * (d_1, q^2-1)_v * (d_2, d_1)_v * (d_2, q^2-1)_v
\\                = (d_1, -1)_v * (d_1, q^2-1)_v * (d_1, d_2)_v * (d_2, q^2-1)_v
\\                (using (a, a)_v = (a, -1)_v)
\\
\\ ===== KEY SIMPLIFICATION =====
\\
\\ Relation 3 gives (d_1, d_2)_v = 1 for all v. This is the FIRST local
\\ condition. Hilbert reciprocity makes this NOT independent (one dependence)
\\ across all v. So this gives  |S_bad|+1 - 1 = |S_bad| independent constraints.
\\
\\ Relation 2 gives (d_2, -d_1)_v = 1 for all v. Equivalently
\\   (d_2, -1)_v * (d_2, d_1)_v = 1
\\   (d_2, -1)_v = 1 (using Relation 3)
\\ Which is automatic if d_2 > 0, otherwise it's the sign condition at infinity
\\ and the (d_2, -1)_p = 1 at 2-adic primes (i.e. d_2 ≡ 1 mod 8 in some sense).
\\
\\ Relation 1 then is a CONSEQUENCE of the other two if (q^2 - 1) factors nicely.
\\ Specifically, (q^2 - 1) ≡ sf(P) * sf(Q) (mod squares).
\\
\\ So the LOCAL CONDITIONS reduce to:
\\   For all v:  (d_1, d_2)_v = 1
\\   For all v:  (d_2, -1)_v = 1   [redundant with Rel 1?]
\\   For all v:  (d_1, sf(P*Q))_v = 1  [from Rel 1 minus Rel 3]
\\
\\ Hmm, let me re-derive. The 3 ternary equations are not independent;
\\ they form a 2-dimensional space. So we have:
\\   (d_1, d_2)_v = 1 for all v  [from one ternary]
\\   (d_1, sf(P*Q))_v = 1 for all v  [from another]
\\ The second is implied if we know d_1 is a norm from Q(sqrt(d_2)).
\\
\\ For our Selmer F_2-counting:
\\ ambient = pairs (d_1, d_2) in Q(S, 2)^2 of dim 2(|S|+1)
\\ Local conditions:
\\   C1 = {(d_1, d_2) : (d_1, d_2)_p = 1 for all p in S ∪ {2, ∞, -1}}
\\        - codim at each prime p contributes 1 bit (or 0 if always true)
\\        - by Hilbert reciprocity prod_p (d_1, d_2)_p = 1, so |S|+1
\\          conditions with 1 dependence = |S| effective conditions.
\\        - BUT this is over all v, and we need each to be 1, not just the product.
\\        - dim of C1 = ambient - |S+1| + 1 (Hilbert recip) = 2(|S|+1) - |S| = |S| + 2
\\
\\   C2 = {(d_1, d_2) : (d_1, sf(P*Q))_p = 1 for all p}
\\        - similar dim count: 2(|S|+1) - |S| = |S| + 2 if d_1 ranges freely
\\        - intersecting with C1: typically codim |S| more.
\\
\\ So dim Sel_2 ≈ |S| + 2 - |S| + small correction = 2 + small.
\\
\\ The small correction comes from the interaction of C1 and C2.
\\ Specifically: Sel_2 ⊆ C1 ∩ C2 where each cuts by ~|S| dims.
\\ Naive intersection: dim = 2(|S|+1) - 2|S| = 2.
\\ Plus contributions from "split primes" / cross-pair structure.
\\
\\ Let's verify this on data:

default(parisize, 1500000000);
sf(x) = if(x == 0, 0, my(s = sign(x), a = abs(x), f = factor(a)); s * prod(i=1, matsize(f)[1], f[i,1]^(f[i,2]%2)));

build_E_min(m, n) = {
  my(a = m^2 - n^2, b = 2*m*n, q, E, Em);
  q = a/b;
  E = ellinit([0, 1+q^2, 0, q^2, 0]);
  Em = ellminimalmodel(E);
  Em;
};

\\ Test: dim Sel_2 should match Selmer enumeration in 2D space
\\ Use ellrank2 = (rank+2 = dim Sel_2)

print("===== Hilbert-symbol enumeration of Selmer triples =====");
print("(m, n)  S=BAD union {-1,2}  |S|  dim Sel_2  dim 2|S|+2  redundancy");

{
fibers = [[3,2], [5,2], [4,1], [11,2], [22,17], [99,28], [13,4]];
for(i=1, #fibers,
  mn = fibers[i];
  m = mn[1]; n = mn[2];
  Em = build_E_min(m, n);
  N = ellglobalred(Em)[1];
  Sbad = factor(N)[,1]~;
  S = Set(concat(Sbad, [2]));   \\ include 2 always
  Sw_neg = Set(concat(S, [-1])); \\ with -1
  rk = ellrank(Em, 1);
  s2 = rk[2] + 2;
  ambdim = 2*(#Sw_neg);
  print(mn, "  S+={-1}: ", Vec(Sw_neg), "  |S|=", #Sw_neg, "  dim_Sel2=", s2, "  ambdim=", ambdim, "  red=", ambdim - s2);
);
}

quit;
