\\ PICK-16: |V_q(F_p)| counts at rank-3 fibers, for Stoll-Chabauty bound
\\
\\ V_q (affine):  c^2 + q^2 = e^2,  c^2 + 1 = f^2,  c^2 + 1 + q^2 = g^2
\\ Count smooth F_p points; report Stoll bound |V_q(Q)| <= |V_q(F_p)| + 2r
\\ where r = rank(J(V_q)).
\\
\\ Note: this counts affine A^4 points (c,e,f,g) with all three eqs holding.
\\ A point is "smooth" if e, f, g are all nonzero mod p (the 3 face conditions are
\\ smooth quadrics in (c, *) iff their constant terms are nonzero).

default(parisize, 4*10^9);

\\ Count affine (c, e, f, g) in F_p^4 satisfying the 3 squareness conditions for q0.
\\ For each c in F_p, if c^2+q^2, c^2+1, c^2+1+q^2 are all squares in F_p (including 0),
\\ multiply choice counts (2 sign choices each if nonzero, 1 if zero).
\\ Project: returns the affine point count.

countVqFp(q0, p) = {
  my(qm, cnt, c, e2, f2, g2, ne, nf, ng);
  qm = Mod(q0, p);
  cnt = 0;
  for(c = 0, p-1, my(cm = Mod(c, p));
    e2 = cm^2 + qm^2;
    f2 = cm^2 + 1;
    g2 = cm^2 + 1 + qm^2;
    if(issquare(e2) && issquare(f2) && issquare(g2),
      ne = if(e2 == 0, 1, 2);
      nf = if(f2 == 0, 1, 2);
      ng = if(g2 == 0, 1, 2);
      cnt += ne * nf * ng;
    );
  );
  cnt;
};

\\ Check bad-reduction: q0 reduces well iff denom(q0) coprime to p AND
\\ q0^2, 1, q0^2+1 all distinct mod p (so the 3 quadrics are distinct), AND p != 2.
goodReduction(q0, p) = {
  if(p == 2, return(0));
  if(denominator(q0) % p == 0, return(0));
  my(qm = Mod(q0, p));
  if(qm == 0 || qm^2 == 0, return(0));
  if(qm^2 == 1, return(0)); \\ q^2 = 1 collapses faces I/II
  if(qm^2 == -1, return(0));
  1;
};

rank3_fibers = [[22,17,195/748],[35,22,741/1540],[37,26,693/1924],[40,29,759/2320],[40,33,511/2640]];
primes_to_try = [5, 7, 11, 13, 17, 19, 23, 29, 31, 37, 41, 43, 47];

print("=== |V_q(F_p)| for rank-3 fibers ===");
print();

for(i = 1, #rank3_fibers, my(m = rank3_fibers[i][1], n = rank3_fibers[i][2], q0 = rank3_fibers[i][3]); \
  print("--- (m,n) = (", m, ",", n, ")  q = ", q0, " ---"); \
  for(j = 1, #primes_to_try, my(p = primes_to_try[j]); \
    if(goodReduction(q0, p), \
      my(cnt = countVqFp(q0, p)); \
      print("  p = ", p, "    |V_q(F_p)|_aff = ", cnt) \
    , \
      print("  p = ", p, "    bad reduction (skip)") \
    ) \
  ); \
  print(); \
);

quit;
