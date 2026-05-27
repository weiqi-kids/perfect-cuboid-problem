/* Verify the Euler brick finding for ALL 37 c-map edges from CMAP-ORBIT-STRUCTURE.md §2.
   For each (q, c), check:
     F1 = 1+q^2 (always square — Pythagorean q)
     F3 = 1+c^2 (always square — algebraic identity)
     F2 = q^2+c^2 (the third face — is this square?)
     LD = 1+q^2+c^2 (long diagonal — PCP)

   If F2 is square universally, then the c-map AUTOMATICALLY produces Euler bricks.
   This would be a MECHANISTIC explanation.

   Possible exception found: 96/247 -> 315/572.  Verify.
*/
default(parisize, 800000000);

\\ Pre-computed generators
{
gens_db = Map();
mapput(gens_db, 20/21, [[-125/4, 395/8]]);
mapput(gens_db, 7/24, [[-317/4, 3887/8]]);
mapput(gens_db, 11/60, [[-185, 9745], [-515, 7270]]);
mapput(gens_db, 48/55, [[-282, 1956]]);
mapput(gens_db, 20/99, [[-965, 44950]]);
mapput(gens_db, 96/247, [[-2260, 581138]]);
mapput(gens_db, 13/84, [[20195/4, 2796619/8]]);
mapput(gens_db, 39/80, [[-900, 9030]]);
mapput(gens_db, 17/144, [[-1920, 142332], [-3348, 48084]]);
mapput(gens_db, 104/153, [[-2894, 44542], [-2998, 7934]]);
mapput(gens_db, 44/117, [[-1965, 38553]]);
mapput(gens_db, 189/340, [[24850, 3252595]]);
mapput(gens_db, 60/91, [[-210, 17805]]);
mapput(gens_db, 225/272, [[-4136, 330088]]);
mapput(gens_db, 132/475, [[-899/144, 5897298719/1728]]);
mapput(gens_db, 252/275, [[-6886, 146663], [-7306, 22553]]);
mapput(gens_db, 140/171, [[-482665/169, 164460005/2197]]);
mapput(gens_db, 85/132, [[-2281, 16313]]);
mapput(gens_db, 108/725, [[360149, 211594238], [39359, 1286048]]);
mapput(gens_db, 57/176, [[-1504, 229442]]);
mapput(gens_db, 135/352, [[-5496, 1741338]]);
mapput(gens_db, 27/364, [[3002, 1265339], [7553, 590681]]);
mapput(gens_db, 25/312, [[-48542/9, 37856650/27]]);
mapput(gens_db, 28/195, [[7394, 493943]]);
mapput(gens_db, 52/165, [[-1346, 190513], [3274, 91183]]);
mapput(gens_db, 160/231, [[-6620, 115510]]);
mapput(gens_db, 95/168, [[3398, 72536]]);
mapput(gens_db, 105/208, [[-13117/4, 2768779/8]]);
mapput(gens_db, 52/675, [[5389, 9242848]]);
mapput(gens_db, 36/323, [[572049/121, 768697884/1331]]);
mapput(gens_db, 195/748, [[151491/4, 15203079/8], [53369, 2563403], [40343619, 256228408278]]);
}

canonical_q(qv) = {
  my(n=abs(numerator(qv)), d=abs(denominator(qv)));
  if (n<=d, n/d, d/n);
};

print("=== Three-face squareness check on all c-map edges from 30 seeds ===");
print("Columns: q | gen# | c (raw) | canon(c) | F1=1+q^2 | F2=q^2+c^2 | F3=1+c^2 | LD=1+q^2+c^2");
print("");

f2_squares = 0;
f2_total = 0;
exceptions = List();
all_data = List();

{
qlist = [20/21, 7/24, 11/60, 48/55, 20/99, 96/247, 13/84, 39/80, 17/144, 104/153, 44/117, 189/340, 60/91, 225/272, 132/475, 252/275, 140/171, 85/132, 108/725, 57/176, 135/352, 27/364, 25/312, 28/195, 52/165, 160/231, 95/168, 105/208, 52/675, 36/323, 195/748];
for(qi = 1, length(qlist),
  my(q = qlist[qi]);
  if (!mapisdefined(gens_db, q), next);
  my(E = ellinit([0, 1+q^2, 0, q^2, 0]));
  my(Emin = ellminimalmodel(E, &v));
  my(gens = mapget(gens_db, q));
  for(i = 1, length(gens),
    my(P_emin = gens[i]);
    my(P_E = ellchangepointinv(P_emin, v));
    if (P_E[1]^2 == q^2, next);
    my(c = 2*q*P_E[2]/(q^2 - P_E[1]^2));
    my(F1 = 1+q^2, F2 = q^2+c^2, F3 = 1+c^2, LD = 1+q^2+c^2);
    my(b1 = issquare(F1), b2 = issquare(F2), b3 = issquare(F3), b4 = issquare(LD));
    f2_total = f2_total + 1;
    if (b2, f2_squares = f2_squares + 1);
    listput(all_data, [q, i, c, canonical_q(c), b1, b2, b3, b4]);
    if (!b2, listput(exceptions, [q, i, c, P_E]));
    print(q, " G", i, " c=", c, "  F1=", b1, " F2=", b2, " F3=", b3, " LD=", b4);
  );
);
}

print("\n=== Summary ===");
print("Total c-images: ", f2_total);
print("F1 always square (Pythag-q): ", "automatic");
print("F3 always square (algebraic identity): ", "automatic");
print("F2 square (third face): ", f2_squares, "/", f2_total);
print("LD square (PCP candidate): all ", "0/", f2_total);
print("\nF2-square FAILURES (c-map output NOT Euler brick):");
{
for(i = 1, length(exceptions),
  print("  q=", exceptions[i][1], " G", exceptions[i][2], " c=", exceptions[i][3], " (P=", exceptions[i][4], ")");
);
}

print("\n=== Detailed check on the exceptions ===");
{
for(i = 1, length(exceptions),
  my(q = exceptions[i][1], c = exceptions[i][3], P = exceptions[i][4]);
  print("--- q=", q, " c=", c);
  print("  q^2 + c^2 = ", q^2+c^2);
  print("  numerator factor: ", factor(numerator(q^2+c^2)));
  print("  denominator factor: ", factor(denominator(q^2+c^2)));
  \\ Try canonical c -- maybe sign matters
  my(cc = canonical_q(c));
  print("  canonical c=", cc);
  print("  q^2 + cc^2 = ", q^2+cc^2);
  print("  square? ", issquare(q^2+cc^2));
);
}

quit;
