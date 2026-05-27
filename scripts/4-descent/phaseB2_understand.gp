\\ Phase B.2: validate ell2cover output meaning + look at structure

default(parisize, 1500000000);
default(realprecision, 38);

\\ Test on a small curve first
print("=== Test 1: E: y^2 = x(x-1)(x-2), rank 0, torsion Z/2 x Z/2 ===");
E1 = ellinit([0, -3, 0, 2, 0]);  \\ (x)(x-1)(x-2) = x^3 - 3x^2 + 2x
print("E1 [a..]: ", E1[1..5]);
print("Torsion: ", elltors(E1));
r1 = ellrank(E1, 4);
print("ellrank(E1, 4) = ", r1);
c1 = ell2cover(E1);
print("ell2cover(E1) count = ", #c1);
{ for(k=1, #c1, print("  cover ", k, ": ", c1[k][1])); }
print();

print("=== Test 2: E: y^2 = x(x-1)(x+1), rank 0 ===");
E2 = ellinit([0, 0, 0, -1, 0]);  \\ x^3 - x = x(x-1)(x+1)
print("E2 [a..]: ", E2[1..5]);
print("Torsion: ", elltors(E2));
r2 = ellrank(E2, 4);
print("ellrank(E2, 4) = ", r2);
c2 = ell2cover(E2);
print("ell2cover(E2) count = ", #c2);
{ for(k=1, #c2, print("  cover ", k, ": ", c2[k][1])); }
print();

print("=== Test 3: E: y^2 = x(x-4)(x+1), check rank ===");
\\ x(x-4)(x+1) = x(x^2 - 3x - 4) = x^3 - 3x^2 - 4x
E3 = ellinit([0, -3, 0, -4, 0]);
print("E3 [a..]: ", E3[1..5]);
print("Torsion: ", elltors(E3));
r3 = ellrank(E3, 4);
print("ellrank(E3, 4) = ", r3);
c3 = ell2cover(E3);
print("ell2cover(E3) count = ", #c3);
{ for(k=1, #c3, print("  cover ", k, ": ", c3[k][1])); }
print();

\\ Test 4: known rank 1 with full 2-torsion: y^2 = x^3 - 49 x = x(x-7)(x+7)
print("=== Test 4: E: y^2 = x(x-7)(x+7), rank 1, full 2-tors ===");
E4 = ellinit([0, 0, 0, -49, 0]);
print("Torsion: ", elltors(E4));
r4 = ellrank(E4, 4);
print("ellrank(E4, 4) = ", r4);
c4 = ell2cover(E4);
print("ell2cover(E4) count = ", #c4);
{ for(k=1, #c4, print("  cover ", k, ": ", c4[k][1])); }
print();

\\ Question: how do we INTERPRET ell2cover output count?
\\ Reading PARI docs: ell2cover returns "n-covers of E"
\\ Typically returns reps of S^2(E/Q) / E[2](Q) (NON-trivial classes)
\\ So if rk + dim(Sha[2]) = s, then 2^s - 1 covers? Or all (2^s) including trivial?

print("=== Interpretation guide ===");
print("ell2cover docs: returns 2-coverings up to equivalence");
print("For E_Hm: 4 covers means dim S^2(E/Q)/E[2](Q) = log2(?)");

quit;
