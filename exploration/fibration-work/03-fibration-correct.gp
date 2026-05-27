\\ CORRECT INTERPRETATION of the fibration question
\\
\\ V is a surface (dim 2). It admits projections to P^1, each with curve fibers (dim 1).
\\
\\ The "Saunderson parametrization" maps:
\\   Saunderson:  Pythag triple (p, q, r) with p^2 + q^2 = r^2  →  candidate PCP
\\
\\ Specifically: a = p^2 - q^2, b = 2pq, c = ... etc., with constraints.
\\ This parametrizes a 1-dim family of "potential PCPs" (with one space-diag-like constraint).
\\
\\ Within this family, requiring the remaining conditions becomes a curve in (p, q) ~ (1, q).
\\
\\ The "Case B genus-5 curve C" is THE LOCUS in V of one branch of this Saunderson family.
\\ I.e., C ⊂ V is a curve (not a fiber).
\\
\\ The "fibration C → P^1_q" is then the structure on C itself (not on V).
\\
\\ So when the problem says "for each rational q_0, fiber C_{q_0}", it really means:
\\   For each q_0 in Q, look at all (e, g) with e^2 = 5q_0^4 - 16q_0^2 + 20 AND g^2 = 5q_0^4 + 20.
\\   If both quartics are squares in Q, get up to 4 points (signs of e, g).
\\
\\ This is a 0-dim fiber. The whole curve C(Q) is finite because the rank-3 < genus-5 Chabauty applies.
\\
\\ The PROPOSED PLAN in the question is misleading: summing over fibers doesn't directly bound V(Q).
\\ Instead, V(Q) decomposes into sub-curves; each sub-curve like C (genus-5, rank-3) gives finite contribution.
\\
\\ So the REAL question is: WHICH SUB-CURVES of V do we get, and is each one Chabauty-amenable?
\\
\\ Saunderson's reduction:
\\
\\ Start: PCP (a, b, c, d, e, f, g). The "Saunderson move" is:
\\   Set a = p^2 - q^2, b = 2pq for Pythag base (p, q). Then a^2 + b^2 = (p^2+q^2)^2 = d^2.
\\   ⇒ d = p^2 + q^2 automatically.
\\   Remaining conditions: b^2 + c^2 = e^2 → 4p^2q^2 + c^2 = e^2
\\                         a^2 + c^2 = f^2 → (p^2-q^2)^2 + c^2 = f^2
\\                         a^2 + b^2 + c^2 = g^2 → (p^2+q^2)^2 + c^2 = g^2 (i.e., d^2 + c^2 = g^2)
\\
\\ So we parametrize by (p, q, c) (3-dim) and need 3 squares to exist:
\\   4p^2q^2 + c^2 = □
\\   (p^2-q^2)^2 + c^2 = □
\\   (p^2+q^2)^2 + c^2 = □
\\
\\ That's 3 conditions in 3-dim → 0-dim variety (curve, after projectivizing → 1-dim).
\\
\\ Set p = 1 (homogenize, projection P^2 → P^1: (p:q:c) → (q:c) sort of) — but we just FIX p = 1:
\\   4q^2 + c^2 = □  (E_1)
\\   (1 - q^2)^2 + c^2 = □  (E_2)
\\   (1 + q^2)^2 + c^2 = □  (E_3)
\\
\\ These give 3 conics-in-c for each q, so 3 quadrics in (q, c) plane.
\\
\\ For all 3 to be squares simultaneously: that's a curve in (q, c) plane.
\\
\\ "Case B" is specifically when c is parametrized to kill one of these. Specifically, set
\\   c = 2q (so that (q^2-1)^2 + c^2 = (q^2-1)^2 + 4q^2 = q^4 - 2q^2 + 1 + 4q^2 = (q^2+1)^2 = d^2)
\\ Hmm but that just makes one of them automatic.
\\
\\ Let me trace through. After Saunderson with (p, q, c), one of the 3 conditions becomes free.
\\ The remaining 2 conditions on (q, c) give a curve in (q, c). Quotient by (q ↔ -q) and (c ↔ -c) symmetries...

print("Trying to derive Case B as a sub-curve of V");
print("");
print("Saunderson params: p=1, q variable, c variable");
print("a = 1-q^2, b = 2q, d = 1+q^2");
print("Need: b^2 + c^2 = e^2: 4q^2 + c^2 = e^2");
print("     a^2 + c^2 = f^2: (1-q^2)^2 + c^2 = f^2");
print("     g^2 = d^2 + c^2 = (1+q^2)^2 + c^2");
print("");
print("3 conditions on (q, c) — gives 1-dim curve in (q,c).");

\\ At this point we have a CURVE in (q, c) — dim 2 → 3 conditions → -1?
\\ Wait: 3 conditions e^2 = ..., f^2 = ..., g^2 = ... each ADD a variable (e, f, g respectively).
\\ So total: (q, c, e, f, g) 5-dim, 3 equations → 2-dim. That's a surface.
\\ But Saunderson already used 1 condition (Pythag (a,b,d)), so we're at the same V (dim 2).

\\ Now we project further. "Case B" specializes c = 2q · (linear in q^2) or similar.
\\ Actually Case B in the literature: c = q^2 - 1, e = q^2 + 1 + ... ?

\\ Let me just check: with c = q^2 - 1, what happens?
\\   c^2 = (q^2-1)^2 = q^4 - 2q^2 + 1
\\   b^2 + c^2 = 4q^2 + q^4 - 2q^2 + 1 = q^4 + 2q^2 + 1 = (q^2+1)^2 = e^2. ✓ (e = q^2+1)
\\   a^2 + c^2 = (1-q^2)^2 + (q^2-1)^2 = 2(q^2-1)^2 = f^2 → f^2 = 2(q^2-1)^2 → f = (q^2-1)√2. Not rational!
\\   ✗ unless q^2 = 1.

\\ Try c = 2q^2 - 1 type formulas... actually the Saunderson formula is more subtle.

\\ The case B curve C : e^2 = 5q^4 - 16q^2 + 20, g^2 = 5q^4 + 20 comes from a SPECIFIC
\\ Saunderson-like parametrization where some conditions are auto-satisfied.

\\ Looking at e^2 = 5q^4 - 16q^2 + 20: this factors as (5q^2 - ?) hmm.
\\ Compute: 5q^4 - 16q^2 + 20 has disc = 256 - 400 = -144 in q^2, so factors over Q[i].
\\ Over R: roots of 5x^2 - 16x + 20 = 0 have x = (16 ± 12i)/10 (complex). So 5q^4 - 16q^2 + 20 > 0 for all real q.

\\ Similarly g^2 = 5q^4 + 20 > 0.

\\ Let's just accept C : (e, g, q) curve, genus 5, rank 3 — this IS the curve cut out in V by
\\ some specific Saunderson parametrization.

\\ The FIBRATION V → P^1_q (using q as a coord on V):
\\
\\ The Saunderson curve C ⊂ V has its OWN map C → P^1_q (degree 4 from analysis above).
\\ But the AMBIENT V → P^1_q would have higher-dim fibers.
\\
\\ Wait — V is 2-dim, so V → P^1 has 1-dim fibers (curves). What ARE those fibers?

\\ V_{q_0} = {(a, b, c, d, e, f, g) ∈ V : "q = q_0"} where q is some coord function on V.
\\
\\ If q = b/a (Saunderson param), then V_{q_0} = V ∩ {b = q_0 a}. With a normalized to 1,
\\ this is V ∩ {b = q_0} (fixing a = 1, b = q_0).
\\
\\ Recall V_{a=1, b=q_0} is a curve in (c, d, e, f, g)-space, dim 1.
\\
\\ Let's compute its genus. Substitute a = 1, b = q_0:
\\   1 + q_0^2 = d^2  (face I — q_0^2 + 1 must be a SQUARE)
\\   q_0^2 + c^2 = e^2
\\   1 + c^2 = f^2  (so 1 + c^2 must be a square)
\\   1 + q_0^2 + c^2 = g^2
\\
\\ Now 1 + q_0^2 = d^2 forces q_0 to be such that 1 + q_0^2 is a Q-square.
\\ Rational solutions: q_0 = (m^2 - n^2)/(2mn) for any (m, n) — yes parametrize over P^1.
\\
\\ For EACH q_0 with 1 + q_0^2 = □ (a 1-parameter family of rational q_0), we have d fixed (up to sign).
\\ Then V_{q_0} is the curve:
\\   c^2 + 1 = f^2 (forces c rational such that c^2 + 1 = □, parametrized by P^1)
\\   c^2 + q_0^2 = e^2 (another P^1 parametrization of c)
\\   c^2 + 1 + q_0^2 = g^2 (third condition)
\\
\\ For all 3 to be squares for the same c: a 2-codim condition in 1-dim — generically NO solution.
\\ But certain c (degenerate) work.
\\
\\ Genus of V_{q_0}: it's a (Z/2)^3 cover of A^1_c branched along (c^2 + 1), (c^2 + q_0^2), (c^2 + 1 + q_0^2)
\\ Each branched at 2 complex points (zeros of c^2 + k). Total branch locus: 6 points (over P^1_c).
\\ Cover degree 8 → 2g - 2 = 8 (0 - 2) + sum_branches.

\\ At each of the 6 branch points (zeros of one of (c^2 + k_i)), 4 of the 8 sheets ramify (e = 2)
\\ So ramification per branch point = 4 × (2-1) = 4.
\\ Total ram = 6 × 4 = 24.
\\ 2g - 2 = -16 + 24 = 8 → g(V_{q_0}) = 5.

\\ ⟨!⟩ Fiber of V → P^1_q has generic genus 5! (Same as the Saunderson curve C!)

print("");
print("=========================================");
print("KEY DISCOVERY:");
print("=========================================");
print("V → P^1_q (via q = b/a) has generic fiber genus 5.");
print("This is THE SAME genus as the Case B curve C.");
print("");
print("Each fiber V_{q_0} = {a=1, b=q_0} ∩ V is a genus-5 curve,");
print("equipped with 3 quadratic conditions:");
print("  1 + c^2 = f^2");
print("  q_0^2 + c^2 = e^2");
print("  1 + q_0^2 + c^2 = g^2");
print("(For this to be nonempty, also need 1 + q_0^2 = d^2 — q_0 is a Pythag-like parameter.)");
print("");
print("So V(Q) = ∪_{q_0 ∈ Q, 1+q_0^2 = □} V_{q_0}(Q)");
print("Each V_{q_0} is a genus-5 curve.");

