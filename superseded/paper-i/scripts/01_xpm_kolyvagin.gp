\\ P14: X_pm rank 0 via Kolyvagin (analytic rank 0, L(1)>0 => algebraic rank 0).
\\ Two equivalent integral models appear in the corpus; we verify BOTH are the
\\ same pair of curves (conductors 120 and 80) and both rank 0.
print("=== Model set A (COLEMAN-P1-RIGOROUS.md §2.2) ===");
XpA = ellinit([0,1,0,-20,0]);
XmA = ellinit([0,0,0,-7,6]);
printf("X+  [0,1,0,-20,0]   cond=%d  ar=%s  tors=%s  ellrank=%s  L(1)=%.6f\n", \
   ellglobalred(XpA)[1], ellanalyticrank(XpA)[1], elltors(XpA)[2], ellrank(XpA), lfun(XpA,1));
printf("X-  [0,0,0,-7,6]    cond=%d  ar=%s  tors=%s  ellrank=%s  L(1)=%.6f\n", \
   ellglobalred(XmA)[1], ellanalyticrank(XmA)[1], elltors(XmA)[2], ellrank(XmA), lfun(XmA,1));
print("ellidentify X+ : ", ellidentify(XpA)[1][1]);
print("ellidentify X- : ", ellidentify(XmA)[1][1]);

print("\n=== Model set B (PCP-COMPLETE-PROOF-v2.md §6.5) ===");
XpB = ellinit([0,4,0,-320,0]);
XmB = ellinit([0,-36,0,320,0]);
printf("X+  x^3+4x^2-320x   cond=%d  ar=%s  tors=%s  ellrank=%s  L(1)=%.6f\n", \
   ellglobalred(XpB)[1], ellanalyticrank(XpB)[1], elltors(XpB)[2], ellrank(XpB), lfun(XpB,1));
printf("X-  x^3-36x^2+320x  cond=%d  ar=%s  tors=%s  ellrank=%s  L(1)=%.6f\n", \
   ellglobalred(XmB)[1], ellanalyticrank(XmB)[1], elltors(XmB)[2], ellrank(XmB), lfun(XmB,1));
print("ellidentify X+ : ", ellidentify(XpB)[1][1]);
print("ellidentify X- : ", ellidentify(XmB)[1][1]);

print("\n=== Are A and B isomorphic over Q? (same curve, different model) ===");
printf("X+: j(A)=%s  j(B)=%s  equal=%d\n", XpA.j, XpB.j, XpA.j==XpB.j);
printf("X-: j(A)=%s  j(B)=%s  equal=%d\n", XmA.j, XmB.j, XmA.j==XmB.j);
