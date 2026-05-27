\\ Compute root number / sign of functional equation for (217, 24)
\\ If sign = -1 (odd analytic rank), then under BSD analytic rank is odd
\\ -> rank is odd -> can't be 4 -> must be 3 or 5.
\\ If sign = +1, rank is even -> must be 4 (since lo>=3 and up<=5).

default(parisize, 1000000000);
print("=== Root number / parity of (217, 24) ===");
m = 217; n = 24;
q = (m^2-n^2)/(2*m*n);
E = ellinit([0, 1+q^2, 0, q^2, 0]);
Em = ellminimalmodel(E);
\\ ellrootno gives the global root number
rn = ellrootno(Em);
print("Root number w(E) = ", rn);
print("Parity: ", if(rn == 1, "+1 (analytic rank EVEN)", "-1 (analytic rank ODD)"));
\\ Under BSD, the parity of rank equals parity of analytic rank.
if(rn == 1, print("\nIf BSD parity holds: rank is even, so rank ∈ {0, 2, 4, ...}."); print("Given lower=3, upper=5, this means rank = 4."); print("dim Sel_2 = 6 (with Sha[2] = 0)."), print("\nIf BSD parity holds: rank is odd, so rank ∈ {1, 3, 5, ...}."); print("Given lower=3, upper=5, this means rank = 3 or 5."); print("If rank = 5: VIOLATES r ≤ 4 conjecture."); print("If rank = 3: dim Sha[2] = 2 (Sel_2 = 7)."));

\\ Also compute the analytic rank parity from the L-function root number more directly:
\\ For non-CM curves the parity is given by the global root number computed via
\\ epsilon factor analysis.
\\ Already covered by ellrootno.

\\ For our family with full 2-torsion, the parity of rank is also encoded
\\ in the 2-Selmer parity if Sha[2] is invariant under self-duality.
\\ Specifically: dim_F2 Sel_2 mod 2 = rank mod 2 + 2 mod 2 + dim Sha[2] mod 2.
\\ Since +2 even, dim Sel_2 parity = rank parity + dim Sha[2] parity.
\\ For our E with full 2-torsion: there's a particular formula.

print("\nIn our family E_PCP(q) with full 2-torsion:");
print("  Cassels-Tate self-duality gives dim Sha[2] even.");
print("  Hence dim Sel_2 ≡ rank + 0 (mod 2).");
print("  Observed dim Sel_2 = 5 -> rank odd -> rank ∈ {3, 5}.");
print("  Observed dim Sel_2 = 6 -> rank even -> rank ∈ {0, 2, 4}.");
print("  Observed dim Sel_2 = 7 -> rank odd -> rank ∈ {3, 5}.");
print("\nFor (217,24): up(rk) = 5, dim Sel_2 = 7 -> rank odd, in {3, 5}.");

quit;
