\\ Estimate generic rank of E_H+(q) over Q(q) via specialization analysis
\\
\\ Silverman's specialization theorem: there is a cofinite set of q_0 ∈ Q where
\\ rank(E_H+_{q_0}) = generic rank.
\\
\\ For q_0 special: rank can JUMP up. So the rank we observed (3, 3, 4, ...) gives an UPPER bound
\\ on the generic rank from low-rank specializations.
\\
\\ Min observed rank in our survey (Pythag fibers):
\\   q_0 = 4/3: rank E_H+ = 3
\\   q_0 = 3/4: rank E_H+ = 3
\\   q_0 = 5/12: rank E_H+ = 3
\\   q_0 = 15/8: rank E_H+ = 3
\\
\\ So generic rank ≤ 3. With (Z/2)^2 torsion, the full Mordell-Weil structure is at most (Z/2)^2 + Z^3.
\\
\\ For non-Pythag fibers:
\\   q_0 = 2: rank E_H+ = 2
\\   q_0 = 5: rank E_H+ = 2
\\   q_0 = 1/2: rank E_H+ = 2
\\   q_0 = 11: rank E_H+ = 2
\\
\\ So generic rank ≤ 2! The Pythag q_0 see an extra rank jump.

\\ Why: for Pythag q_0, the section (X = 0, Y = q*sqrt(1+q^2)) becomes rational.
\\ Adding this section bumps rank by 1.
\\
\\ Hence:
\\   GENERIC rank over Q(q): 2
\\   Pythag-q rank: 3 (with one extra section)
\\   Special-q rank: can be higher

\\ Let's test more non-Pythag q_0 to confirm:

compute_E_Hplus(q0) = { my(c2, c1, c0); c2 = 3 + 2*q0^2; c1 = 1 + 3*q0^2 + q0^4; c0 = q0^2 + q0^4; return(ellminimalmodel(ellinit([0, c2, 0, c1, c0]))); }

print("Non-Pythag q_0 only (testing generic rank):");
print("q_0\trk(E_H+)");
nonpyth = [2, 3, 5, 6, 7, 10, 11, 13, 14, 1/2, 1/3, 2/5, 3/7, 4/5, 6/7, 9/10, 11/13];
for(i = 1, #nonpyth, q0 = nonpyth[i]; E = compute_E_Hplus(q0); r = ellrank(E); print(q0, "\t", r[1], if(r[1] != r[2], concat("..", r[2]), "")))

print("\nObservations: most q_0 have rank E_H+ ≥ 2. Need to check if rank can drop to 1 or 0.");
