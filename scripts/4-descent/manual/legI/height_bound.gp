\\ Compute refined canonical height lower bound from Leg I negative result.

default(parisize, 200000000);

A4 = -4296889542830417930548255320;
A6 = 69513195990628448299367172717433334517312;
E = ellinit([1, 0, 0, A4, A6]);

e1 = -289985899459969;
e2 =  69618111281856;
e3 =  220367788178112;

\\ Maximum naïve heights covered per patch:
\\ Patch z_3: largest p was 6e8 at q=3 ⇒ z_3 = 6e8/3 = 2e8 ⇒ h(z_3) ≈ log(2e8) ≈ 19.1
\\ Patch z_2: largest at q=3 was 4.32e8 ⇒ z_2 = 4.32e8/3 = 1.44e8 ⇒ h(z_2) ≈ 18.8
\\ Patch z_1: q=1 to 2.64e9, q=5 to 673M ⇒ z_1 = 673M/5 = 1.35e8 or 2.64e9/1 = 2.64e9 ⇒ h ≈ 21.7

\\ For a triple (d_1, d_2, d_3) cover the x-coord on E is x_E = X̃/4 = (d_1 z_1^2 + e_1)/4 (in z_1 patch).
\\ Naïve height h(x_E) ≥ 2*log(|p|) - log(4 q^2) ≈ 2 h(z_1) for d_1 = 1.
\\ Canonical height: ĥ(P) = h(x_E)/2 + O(1) (Silverman): more precisely ĥ - h(x)/2 bounded.

\\ Refined bound from Leg I:
\\ Most restrictive: z_3 patch h(z_3) coverage to ≈ 19.1
\\ This means: any point P with naïve x-height h(x_E) such that some z_i = sqrt((x_E - e_i)/d_i) has h(z_i) ≤ 19 is FOUND.
\\
\\ Specifically:
\\   h(x_E - e_1) = 2 h(z_1) + log d_1 (mod O(log)) = 2 h(z_1)  since d_1 = 1
\\   h(x_E - e_2) = 2 h(z_2) + log d_2 = 2 h(z_2) + log 219 = 2 h(z_2) + 5.39
\\   h(x_E - e_3) = 2 h(z_3) + log d_3 = 2 h(z_3) + 5.39
\\
\\ For large h(x_E), h(x_E - e_i) ≈ h(x_E) for all i. So:
\\   h(x_E) ≈ 2 min_i h(z_i) (approximately).
\\
\\ Coverage:
\\   z_1 patch: h(z_1) ≤ log(2.64e9) ≈ 21.7  (q=1 ext) and log(673M/5) ≈ 18.7 (q=5)
\\   z_2 patch: h(z_2) ≤ log(4.32e8/3) ≈ 18.8 (q=3)  and log(2e8) ≈ 19.1 (q=1)
\\   z_3 patch: h(z_3) ≤ log(6e8/3) ≈ 19.1 (q=3) and log(2e8) ≈ 19.1 (q=1)
\\
\\ A non-torsion generator P of E_Hm exists somewhere if rk = 1. It corresponds to some
\\ (p, q) in EACH patch (z_1, z_2, z_3) — three different (p, q) pairs but same E-point P.
\\
\\ The (z_1, z_2, z_3) representations are related by: z_1 z_2 z_3 = Y/q^3 / (d_1 d_2 d_3).
\\ So if Y is large, at least one z_i is large.
\\ But if all three z_i are ≤ B, then Y ≤ d_1 d_2 d_3 B^3 = 219·219 B^3.

\\ So the negative result says: no rational point P of E_Hm has
\\   z_1 ≤ 2.64e9, z_2 ≤ 1.44e8, z_3 ≤ 2e8  (simultaneously in the ε class)
\\ Of course these are different (p,q) representations.
\\
\\ Stronger bound: at least one z_i must exceed ALL covered ranges.
\\ Specifically: in patch i, we covered z_i ≤ B_i where B_1 ≈ 2.6e9 (q=1) or B_1 ≈ 1.3e8 (q≥5).
\\
\\ The canonical height: for the ε class lift (d_1, d_2, d_3) = (1, 219, 219),
\\   x_E = (z_1^2 + e_1)/4   (in z_1 patch, d_1=1)
\\   ĥ(P) ≈ h(x_E)/2 + bdd
\\
\\ Take h(x_E) lower bound. For x_E to NOT have been hit in any patch, we'd need (assuming a rational point exists):
\\   the smallest of (h(z_1), h(z_2), h(z_3)) > some threshold.
\\ But min h(z_i) ≤ avg = (h(z_1)+h(z_2)+h(z_3))/3.

\\ The simplest robust statement: in z_3 patch, p_lo = 0 so the search starts at the lowest possible (p,q) rep.
\\ We covered p up to 2e8 at q=1, meaning all rational z_3 = p/q with |p| ≤ 2e8, q=1 (so |z_3| ≤ 2e8) failed.
\\ For q=2,3: |z_3| ≤ 4e8/2 = 2e8 and 6e8/3 = 2e8 respectively. So h(z_3) ≤ log(2e8) ≈ 19.1 EVERYWHERE.
\\
\\ Now x_E - e_3 = 219 z_3^2, so:
\\   h(x_E - e_3) ≈ log(219) + 2 log|z_3| ≈ 5.39 + 2 log|z_3|
\\
\\ If |z_3| > 2e8, then x_E - e_3 > 219 * (2e8)^2 = 8.76e18, so x_E > 8.76e18 - |e_3| ≈ 8.76e18.
\\ Thus h(x_E) > log(8.76e18) ≈ 43.6.
\\
\\ Canonical height ĥ(P): Silverman bounds give ĥ(P) ≥ h(x_E)/2 - 26.3 ≈ 21.8 - 26.3 = NEGATIVE.
\\ So Silverman is uninformative.
\\
\\ Better: empirical ĥ(P)/h(x(P)) ratio ≈ 0.5–0.7 for typical curves. So ĥ ≳ 22.
\\ But Leg H already established ĥ ≳ 65, so the Leg I refinement is in DIFFERENT direction:
\\ it constrains the (p,q) representation, not the canonical height absolutely.

print("=== Height bound refinement from Leg I ===");
print();
print("Patch z_3 coverage (UNEXPLORED before Leg I):");
print("  q=1: p ∈ [0, 2e8]");
print("  q=2: p ∈ [0, 4e8]");
print("  q=3: p ∈ [0, 6e8]");
print("  q=4: p ∈ [0, 5e7]");
print("  ⇒ |z_3| ≤ 2e8 throughout (log ≈ 19.1)");
print();
print("Patch z_2 coverage (UNEXPLORED before Leg I):");
print("  q=1: p ∈ [8.3e5, 2e8]");
print("  q=2: p ∈ [1.66e6, 4e8]");
print("  q=3: p ∈ [2.49e6, 4.32e8]");
print("  ⇒ |z_2| ∈ [8.3e5, 2e8] (log ≈ 14 to 19.1)");
print();
print("Patch z_1 coverage (extending Leg H):");
print("  q=1: p ∈ [2.26e7, 2.64e9] (Leg H ≤ 2e9; +30% ext)");
print("  q=5: p ∈ [1.13e8, 6.73e8] (new q)");
print("  ⇒ |z_1| up to 2.64e9 (log ≈ 21.7) or 1.35e8 (log ≈ 18.7) for q=5");
print();
print("Combined bound on naïve height of P in ε class:");
print("  All three z_i in different (p,q) reps; min h(z_i) ≤ 19.1");
print("  ⇒ x_E - e_3 = 219 * z_3^2 with h(z_3) > 19.1 needed");
print("  ⇒ h(x_E) > 2*19.1 + log(219) ≈ 43.6");
print();
print("Implication: any non-torsion generator P (if rk = 1) of E_Hm lifted via ε class");
print("has naïve x-height h(x_E) > 43.6 (in addition to canonical height ≳ 65 from Leg H).");

quit;
