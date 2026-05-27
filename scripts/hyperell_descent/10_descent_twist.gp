/* 10_descent_twist.gp
 *
 * Compute ranks of E_PCP(q)^(-1) for many Pythagorean q,
 * comparing with the known ranks of E_PCP(q).
 *
 * Key question: does E_PCP(q)^(-1) tend to have low rank?
 * If E_PCP(q)^(-1)(Q) = torsion (and torsion gives only degenerate),
 * then there are NO Pythagorean perfect cuboids with that hypotenuse.
 */
default(parisize, 1000000000);

/* Known rank-jump fibers from the catalog, including some rank-4 examples */
test_qs = [\
  [3,4,"generic"], [5,12,"generic"], [8,15,"generic"], [7,24,"r1"],\
  [20,21,"r1"], [9,40,"generic"], [11,60,"r2"], [12,35,"generic"],\
  [13,84,"r1"], [27,364,"r1"], [25,312,"r1"], [48,55,"r1"], [39,80,"r1"],\
  [17,144,"r2"], [195,748,"r3"], [225,272,"r1"], [104,153,"r2"],\
  [832,855,"r1"], [55,1512,"r2"], [44,117,"?"], [52,165,"r2"],\
  [99,28,"r4"], [118,25,"r4"], [174,83,"r4"], [176,63,"r4"], [181,38,"r4"],\
  [88,105,"?"], [33,56,"?"], [16,63,"?"], [65,72,"?"]\
];

print("=== Rank comparison: E_PCP(q) vs E_PCP(q)^(-1) ===");
print();
print("Pythagorean (n,m): q = n/m, h^2 = m^2+n^2");
print();
print("| n | m | h^2 | tag | rank E_PCP | rank E_twist | tors E_twist |");
print("|---|---|-----|-----|-----------|--------------|---------------|");

{
for(i=1, #test_qs,
  n = test_qs[i][1];
  m = test_qs[i][2];
  tag = test_qs[i][3];

  /* Check Pythagorean: m^2+n^2 must be a square */
  hsq = m^2 + n^2;
  if(issquare(hsq),

    /* E_PCP minimal */
    Epcp = ellminimalmodel(ellinit([0, m^2+n^2, 0, m^2*n^2, 0]));
    /* Twist by -1 */
    Etw = ellminimalmodel(ellinit([0, -(m^2+n^2), 0, m^2*n^2, 0]));

    /* Ranks */
    er = ellrank(Epcp);
    tr = ellrank(Etw);
    tors_tw = elltors(Etw);

    print("| ", n, " | ", m, " | ", hsq, " | ", tag, \
      " | [", er[1], ",", er[2], "] | [", tr[1], ",", tr[2], "] | ", tors_tw[1], " ", tors_tw[2], " |");
  ,
    print("| ", n, " | ", m, " | NOT PYTHAGOREAN |");
  );
);
}

print();
print("=== Summary ===");
print();
print("If ALL E_PCP(q)^(-1) have rank 0, then PCP closure follows automatically");
print("(modulo identifying all torsion points as degenerate).");
quit;
