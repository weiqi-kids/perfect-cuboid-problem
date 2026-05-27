\\ =====================================================================
\\ 04_local_conditions.gp -- Count local conditions explicitly.
\\
\\ For E_PCP(q): y^2 = x(x+1)(x+q^2), e_1 = -q^2, e_2 = -1, e_3 = 0.
\\ Differences:
\\   e_2 - e_1 = -1 + q^2 = q^2 - 1   = (q-1)(q+1)
\\   e_3 - e_1 = q^2                  = q^2
\\   e_3 - e_2 = 1                    = 1
\\
\\ For q = (m^2-n^2)/(2mn):
\\   q^2 - 1 = (m^2-n^2)^2/(2mn)^2 - 1 = ((m^2-n^2)^2 - (2mn)^2) / (2mn)^2
\\           = P * Q / (2mn)^2   where P = (m+n)^2 - 2n^2, Q = (m-n)^2 - 2n^2
\\           (the Heron identity!)
\\   q^2 = (m^2-n^2)^2 / (2mn)^2
\\   e_3 - e_2 = 1 (trivial squarefree part)
\\
\\ So mod squares:
\\   sf(e_2 - e_1) = sf(P) * sf(Q)
\\   sf(e_3 - e_1) = sf((m^2-n^2)^2) = 1
\\   sf(e_3 - e_2) = 1
\\
\\ This is the STRUCTURE THEOREM: two of the three root differences are
\\ perfect squares! The only non-trivial squarefree part is on e_2 - e_1
\\ (this is "Theorem 2.0" of HERON-FACE-SELMER and FINAL-SYNTHESIS).
\\
\\ Consequence: The Selmer descent's local conditions are HIGHLY DEGENERATE.
\\ For ternary forms d_1 y_1^2 - d_2 y_2^2 = e_2 - e_1, only this one
\\ involves a non-square coefficient.
\\
\\ KEY: For binary forms d_a y_a^2 - d_b y_b^2 = c with c a perfect square,
\\   the form represents c iff d_a, d_b have the same square class as c,
\\   modulo trivial cases. This is a TRIVIAL local condition (always solvable
\\   when d_a in same class as d_b times sf(c)).
\\
\\ The non-trivial constraint comes from the e_2 - e_1 equation, where
\\ sf(e_2 - e_1) = sf(P) * sf(Q) is a product of two Heron-form quadratics.
\\
\\ This explains structurally why dim Sel_2 << 2|H|.

default(parisize, 1500000000);

sf(x) = if(x == 0, 0, my(s = sign(x), a = abs(x), f = factor(a)); s * prod(i=1, matsize(f)[1], f[i,1]^(f[i,2]%2)));

\\ For each fiber, compute the squarefree parts of e_2 - e_1, e_3 - e_1, e_3 - e_2
\\ on the minimal Weierstrass model.
\\ For E_PCP, the affine model gives e = [0, -1, -q^2] (after sorting).

analyze_fiber(m, n) = {
  my(a, b, q, q2, e1, e2, e3, diffs, sfs);
  a = m^2 - n^2;
  b = 2*m*n;
  q = a/b;
  q2 = q^2;
  \\ Roots of x*(x+1)*(x+q^2): {0, -1, -q^2}
  \\ Sort: if q^2 > 1 (i.e. m > n*sqrt(2)+...): -q^2 < -1 < 0
  \\        else: -1 < -q^2 < 0
  e1 = if(q2 > 1, -q2, -1);
  e2 = if(q2 > 1, -1, -q2);
  e3 = 0;
  diffs = [e2-e1, e3-e1, e3-e2];
  sfs = [sf(numerator(diffs[i]) * denominator(diffs[i])) | i <- [1, 2, 3]];
  [q, e1, e2, e3, diffs, sfs];
};

print("===== Root-difference squarefree parts (mod squares) =====");
print("(m, n)   q        sf(e_2-e_1)  sf(e_3-e_1)  sf(e_3-e_2)");

{
fibers = [[3,2], [5,2], [4,1], [22,17], [37,26], [40,33], [99,28], [118,25], [578,319]];
for(i=1, #fibers,
  mn = fibers[i];
  m = mn[1]; n = mn[2];
  if(gcd(m,n) != 1 || (m+n) % 2 == 0, next);
  r = analyze_fiber(m, n);
  print(mn, "  ", r[1], "  ", r[6][1], "  ", r[6][2], "  ", r[6][3]);
);
}

print();
print("===== Critical structural fact: sf(e_3-e_1), sf(e_3-e_2) are NOT always 1 =====");
print("Indeed: e_3 - e_1 = 0 - (-q^2) = q^2 in Q, sf = 1 (trivially squarefree as a square).");
print("        e_3 - e_2 = 0 - (-1) = 1, sf = 1.");
print("So sf(e_3-e_1) = sf(e_3-e_2) = 1 always.");
print("The ONLY non-trivial root difference is sf(e_2 - e_1) = sf(q^2 - 1) = sf(P*Q)/(2mn squared) = sf(P)*sf(Q).");
print();

\\ Now compute dim of the "naive" Selmer space supported only by sf(P), sf(Q), and sign:
print("===== Predicted Selmer dimension: 2 + ω(sf(P)) + ω(sf(Q)) (modulo correlations) =====");
print("Heuristic: each prime p | sf(P*Q) gives at most 1 F_2 generator");
print("(plus 2 torsion dimensions for E[2](Q) = (Z/2)^2)");
print();
print("(m,n)  sf(P)  sf(Q)  ω(sf(P))  ω(sf(Q))  predicted_dim_Sel2  observed");

{
small_fibers = [[3,2], [5,2], [4,1], [5,4], [7,2], [8,3], [9,4], [11,2], [22,17], [35,22]];
for(i=1, #small_fibers,
  mn = small_fibers[i];
  m = mn[1]; n = mn[2];
  if(gcd(m,n) != 1 || (m+n) % 2 == 0, next);
  P = (m+n)^2 - 2*n^2;
  Q = (m-n)^2 - 2*n^2;
  sP = sf(P); sQ = sf(Q);
  omP = if(sP > 0, omega(sP), omega(-sP) + 1);
  omQ = if(sQ > 0, omega(sQ), omega(-sQ) + 1);
  E = ellinit([0, 1 + ((m^2-n^2)/(2*m*n))^2, 0, ((m^2-n^2)/(2*m*n))^2, 0]);
  Em = ellminimalmodel(E);
  rk = ellrank(Em, 1);
  s2 = rk[2] + 2;
  predict = 2 + omP + omQ;
  print(mn, "  ", sP, "  ", sQ, "  ", omP, "  ", omQ, "  ", predict, "  ", s2);
);
}

quit;
