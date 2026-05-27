\\ ============================================================
\\ Verify all 16 Q-points of C correspond to degenerate cuboids
\\ Avoid using 'e' as variable (PARI built-in)
\\ ============================================================

print("=== PCP correspondence: degeneracy check ===");
print();

kk = [[1,3,5], [1,3,-5], [1,-3,5], [1,-3,-5], [-1,3,5], [-1,3,-5], [-1,-3,5], [-1,-3,-5], [2,6,10], [2,6,-10], [2,-6,10], [2,-6,-10], [-2,6,10], [-2,6,-10], [-2,-6,10], [-2,-6,-10]];

print("Total known Q-points: ", #kk);
print();

{
for(i = 1, #kk,
  P = kk[i];
  qa = P[1]; ea = P[2]; ga = P[3];
  b_val = qa^2 - 4;
  msg = if(b_val < 0, "DEGENERATE (b<0)", if(b_val == 0, "DEGENERATE (b=0)", "WARN"));
  print("P_", i, " = (q=", qa, ", e=", ea, ", g=", ga, "): b = q^2-4 = ", b_val, " - ", msg);
);
}

print();
print("Analysis:");
print("  q = +-1: b = -3 < 0  =>  degenerate");
print("  q = +-2: b =  0      =>  degenerate");
print();
print("All 16 Q-points yield degenerate cuboids.");
print();

print("=== Sanity: verify (q, e, g) actually lie on C ===");
{
for(i = 1, #kk,
  P = kk[i];
  qa = P[1]; ea = P[2]; ga = P[3];
  lhs1 = ea^2;
  rhs1 = 5*qa^4 - 16*qa^2 + 20;
  lhs2 = ga^2;
  rhs2 = 5*qa^4 + 20;
  status = if(lhs1 == rhs1 && lhs2 == rhs2, "ON C", "FAIL");
  print("P_", i, " = (", qa, ",", ea, ",", ga, "): e^2=", lhs1, ", f1(q)=", rhs1, "; g^2=", lhs2, ", f2(q)=", rhs2, " - ", status);
);
}
