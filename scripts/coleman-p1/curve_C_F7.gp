\\ ============================================================
\\ Curve C: {e^2 = 5q^4 - 16q^2 + 20, g^2 = 5q^4 + 20}
\\ Genus 5 curve, fiber product over P^1_q of two genus-1 curves
\\ At p = 7: enumerate F_7 points and find local structure
\\ ============================================================

p = 7;
f1(q) = 5*q^4 - 16*q^2 + 20;  \\ e^2 = f1(q)
f2(q) = 5*q^4 + 20;             \\ g^2 = f2(q)

print("Enumerate C(F_7):");
print();

\\ Squares mod 7
sqs = Set();
for(t = 0, 6, sqs = setunion(sqs, Set([Mod(t,7)^2])));
print("Squares mod 7: ", sqs);
print();

\\ F_7 affine points
{
points = [];
for(q = 0, 6,
  qm = Mod(q, 7);
  v1 = lift(5*qm^4 - 16*qm^2 + 20);
  v2 = lift(5*qm^4 + 20);
  v1 = v1 % 7; v2 = v2 % 7;
  e_vals = [];
  g_vals = [];
  for(e = 0, 6, if(Mod(e^2, 7) == v1, e_vals = concat(e_vals, [e])));
  for(g = 0, 6, if(Mod(g^2, 7) == v2, g_vals = concat(g_vals, [g])));
  if(#e_vals > 0 && #g_vals > 0,
    for(i = 1, #e_vals,
      for(j = 1, #g_vals,
        points = concat(points, [[q, e_vals[i], g_vals[j]]]);
        print("  (q,e,g) = (", q, ",", e_vals[i], ",", g_vals[j], "), f1=", v1, ", f2=", v2);
      );
    );
  );
);
print();
print("Total affine F_7 points: ", #points);
}

print();
print("============================================================");
print("Known rational points of C(Q) (from proof.md):");
print("  (±1, ±3, ±5), (±2, ±6, ±10)");
print("============================================================");
{
known = [[1,3,5],[1,3,-5],[1,-3,5],[1,-3,-5],[-1,3,5],[-1,3,-5],[-1,-3,5],[-1,-3,-5],
         [2,6,10],[2,6,-10],[2,-6,10],[2,-6,-10],[-2,6,10],[-2,6,-10],[-2,-6,10],[-2,-6,-10]];
print("All 16 known Q-points reduce mod 7:");
for(i = 1, #known,
  pt = known[i];
  red = [pt[1] % 7, pt[2] % 7, pt[3] % 7];
  print("  (", pt[1], ",", pt[2], ",", pt[3], ") → mod 7 → (", red[1], ",", red[2], ",", red[3], ")");
);
}
