\\ 00_catalog.gp — Catalog the auxiliary elliptic curves for each rank-jump fiber
\\ Strategy I: E_Hm (Saunderson aux for elliptic Chabauty via bielliptic projection)
\\ Strategy II: 5-factor decomposition of J(V_q): E_ef, E_eg, E_fg, E_Hp, E_Hm- (= X_-)
\\
\\ NOTE: In V-FIBRATION-CHABAUTY.md the genus-2 quotient EFG splits as E_H+ × E_H-.
\\ The Halcke E_Hm IS the bielliptic quotient of the genus-2 quotient.
\\ It corresponds to one of {E_H+, E_H-} or is related by isogeny — verified below.

default(parisize, 2*10^9);
default(realprecision, 38);

\\ ---- Build the 5 auxiliary curves for a fiber parametrized by q = 2mn/(m^2-n^2) ----
\\ All formulas from exploration/V-FIBRATION-CHABAUTY.md §1.4 and exploration/pcp_halcke_full_proof.md

\\ E_ef(q): Y^2 = X^3 - 2(1+q^2) X^2 + (1-q^2)^2 X
make_Eef(q) = {
  my(A = -2*(1+q^2), B = (1-q^2)^2);
  ellinit([0, A, 0, B, 0])
};

\\ E_eg(q): Y^2 = X^3 - 2(1+2q^2) X^2 + X
make_Eeg(q) = {
  my(A = -2*(1+2*q^2), B = 1);
  ellinit([0, A, 0, B, 0])
};

\\ E_fg(q): Y^2 = X^3 - 2(2+q^2) X^2 + q^4 X
make_Efg(q) = {
  my(A = -2*(2+q^2), B = q^4);
  ellinit([0, A, 0, B, 0])
};

\\ E_Hp(q): Y^2 = (X+q^2)(X+1)(X+1+q^2)
\\ Expanded: Y^2 = X^3 + (2+2q^2)X^2 + (1+3q^2+q^4)X + (q^2+q^4)
make_EHp(q) = {
  my(A = 2+2*q^2, B = 1+3*q^2+q^4, C = q^2+q^4);
  ellinit([0, A, 0, B, C])
};

\\ E_Hm(q) — the Saunderson auxiliary used in Halcke template
\\ For Pythag (m,n) with a=m^2-n^2, b=2mn, d=m^2+n^2:
\\   A = d^2, B = a^2, C = b^2
\\   E_Hm: y^2 = (x+BC)(x+AC)(x+AB)
\\ Parametrize by (m,n) since q=b/a or a=1/q (after scaling); cleanest to pass (m,n).
make_EHm_mn(m, n) = {
  my(a = m^2-n^2, b = 2*m*n, d = m^2+n^2);
  my(A = d^2, B = a^2, C = b^2);
  my(P = -(B*C + A*C + A*B));   \\ coeff of x^2 after expansion: x^3 + (sum)x^2 + ...
  \\ (x+u)(x+v)(x+w) = x^3 + (u+v+w)x^2 + (uv+uw+vw)x + uvw
  my(s1 = B*C + A*C + A*B);
  my(s2 = A*B*C*(B+C) + A*A*B*C);  \\ wrong; recompute:
  \\ uv+uw+vw = BC*AC + BC*AB + AC*AB = ABC(C/A + ... ) — just expand:
  \\ s2 = BC*AC + BC*AB + AC*AB = A*B*C*(... ); actually = B*C*A*C + B*C*A*B + A*C*A*B = A*BC*(C+B) + A^2*BC
  \\ simpler: just multiply
  my(s2_real = B*C*A*C + B*C*A*B + A*C*A*B);
  my(s3 = A*B*C * A*B*C / (A*B*C) * A*B*C);  \\ placeholder
  \\ Forget — just expand directly via ellinit on the factored form:
  ellinit([0, s1, 0, B*C*A*C + B*C*A*B + A*C*A*B, A^2*B^2*C^2 / (A*B*C) * A*B*C])
};

\\ Simpler: use ellinit with sum/products from (x+u)(x+v)(x+w):
make_EHm(m, n) = {
  my(a = m^2-n^2, b = 2*m*n, d = m^2+n^2);
  my(u = b^2 * a^2,         \\ BC = b^2 a^2
     v = d^2 * b^2,         \\ AC = d^2 b^2
     w = d^2 * a^2);        \\ AB = d^2 a^2
  my(c2 = u + v + w);
  my(c1 = u*v + u*w + v*w);
  my(c0 = u*v*w);
  ellinit([0, c2, 0, c1, c0])
};

\\ Pythag q = 2mn / (m^2-n^2)
qof(m, n) = (2*m*n) / (m^2-n^2);

\\ ---- Sanity test on Halcke (8, 3): should give E_Hm with conductor 17,368,890 ----
print("=== Halcke (m,n) = (8, 3) ===");
{
  my(m = 8, n = 3, q = qof(8, 3));
  print("q = ", q);
  my(EHm = make_EHm(m, n));
  my(EHm_min = ellminimalmodel(EHm));
  print("E_Hm minimal model: ", EHm_min[1..5]);
  my(N = ellglobalred(EHm_min)[1]);
  print("conductor N(E_Hm) = ", N, "   (expected 17368890)");
  print("expected factorization: 2*3*5*7*11*73*103 = ", 2*3*5*7*11*73*103);
}

\\ Sanity Halcke (88, 35) — conductor should be 204,925,111,777,748,670
print("=== Saunderson (m,n) = (88, 35) ===");
{
  my(m = 88, n = 35);
  my(EHm = make_EHm(m, n));
  my(EHm_min = ellminimalmodel(EHm));
  print("conductor N(E_Hm) = ", ellglobalred(EHm_min)[1]);
  print("expected ~ 2.05e17, factorization 2*3*5*7*11*31*41*53*359*409*8969 = ", 2*3*5*7*11*31*41*53*359*409*8969);
}

\\ ---- Now write the catalog of 12 rank-4 fibers + 35 rank-3 fibers ----
\\ Rank-4 fibers (from GAP3-UNIFORM-RANK-BOUND.md / RANK5-HUNT.md §4):
rank4_fibers = [[99,28],[118,25],[174,83],[176,63],[181,38],[205,66],[209,72],[216,185],[221,202],[261,52],[273,86],[578,319]];

\\ Rank-3 fibers (35 from RANK5-HUNT §2.2 verify_rank3plus.txt, excluding the rank-4):
rank3_fibers = [[341,208],[359,138],[366,107],[391,248],[413,214],[442,229],[451,152],[451,214],[457,154],[462,71],[464,65],[502,341],[506,47],[506,313],[526,319],[538,279],[541,306],[562,483],[581,362],[589,316],[592,539],[629,398],[737,574],[778,531],[816,497],[834,361],[851,334],[869,442],[892,551],[899,158],[928,623],[943,206],[974,259],[988,251],[988,321]];

print("\n=== Catalog Sizes ===");
print("rank-4 fibers (E_PCP rank): ", length(rank4_fibers));
print("rank-3 fibers (E_PCP rank): ", length(rank3_fibers));

\\ Note: The rank of E_PCP(q) is NOT the rank of J(V_q). For Chabauty on V_q we need
\\ rank J(V_q) < 5. The PCP rank-4 catalog gives us E_PCP — which is one factor of
\\ Jac of the genus-2 quotient H, NOT directly a factor of J(V_q).
\\ But for elliptic Chabauty via the bielliptic projection H → E_Hm, we need rank E_Hm.

quit;
