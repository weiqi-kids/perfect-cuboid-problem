\\ Family L-function — Step 2: Look for family identities
\\
\\ Striking observations from step 1:
\\   - a_3 = 1 for ALL (m,n) tested
\\   - a_p takes few distinct values (suggests E_{m,n} has CM or congruences)
\\
\\ Test: does E_{m,n} have CM? If so, by which order?
\\ Test: do the curves split as a Q-isogeny class by (m,n) mod p?

default(parisize, 800000000);

print("=================================================================");
print("Step 2: Search for family identities (CM, isogenies, congruences)");
print("=================================================================");
print();

\\ === Recompute curves and check CM, j-invariant ===
print("--- j-invariants and CM check ---");
print();
printf("%-10s %-15s %-30s %s\n", "(m,n)", "j(E)", "j factored", "CM?");
print("---------------------------------------------------------------------------");

{
data2 = List();
for(m = 2, 10,
  for(n = 1, m - 1,
    if(gcd(m, n) == 1 && (m + n) % 2 == 1,
      u = 2*m*n;
      v = m^2 - n^2;
      E = ellinit([0, u^2+v^2, 0, u^2*v^2, 0]);
      Emin = ellminimalmodel(E);
      jE = ellj(Emin);
      \\ Discriminant
      disc = Emin.disc;
      \\ CM-detection via class number 1 j-invariants:
      cmJ = [0, 1728, -3375, 8000, -32768, 54000,
             287496, -12288000, 16581375, -884736,
             -884736000, -147197952000, -262537412640768000];
      isCM = if(setsearch(Set(cmJ), jE) > 0, "CM", "no-CM(class>1?)");
      printf("(%2d,%2d)    %-15d %-30s %s\n", m, n, jE, Str(factor(numerator(jE))), isCM);
      listput(data2, [m, n, jE, disc, Emin]);
    );
  );
);
}

print();
print("--- 2-isogeny structure ---");
print("E_{m,n}: Y^2 = X(X+u^2)(X+v^2) has full rational 2-torsion (3 roots).");
print("Hence E_{m,n}[2] = (Z/2)^2 rational. There are 3 non-trivial 2-isogenies.");
print();

\\ Compute the 3 isogenous curves and their j-invariants
print("--- 2-isogeny graph ---");
{
for(i = 1, min(#data2, 8),
  d = data2[i];
  m = d[1]; n = d[2]; E = d[5];
  isos = ellisomat(E);
  printf("(%2d,%2d): j=%d, isogeny class size = %d\n", m, n, ellj(E), #isos[1]);
);
}

print();
print("--- Same-conductor pairs / isogenous (m,n) ? ---");
print("Check if different (m,n) give isogenous curves (= same L-function).");
print();

\\ For each pair, check if curves are isogenous (over Q)
\\ Two curves are Q-isogenous iff they have same conductor AND same L-function (a_p sequence).
\\ Reload data:
data = readvec("/root/proof/perfect-cuboid-problem/scripts/family_lfunction_data.txt");

\\ Actually data is saved differently — re-collect:
{
collected = List();
for(m = 2, 10,
  for(n = 1, m - 1,
    if(gcd(m, n) == 1 && (m + n) % 2 == 1,
      u = 2*m*n;
      v = m^2 - n^2;
      E = ellinit([0, u^2+v^2, 0, u^2*v^2, 0]);
      Emin = ellminimalmodel(E);
      N = ellglobalred(Emin)[1];
      aps = vector(20, k, ellap(Emin, prime(k)));
      listput(collected, [m, n, N, aps]);
    );
  );
);
}

\\ Check pairs with equal a_p sequence
print("Pairs (i, j) with identical first 20 a_p (Q-isogenous, same L):");
{
nfound = 0;
for(i = 1, #collected,
  for(j = i+1, #collected,
    if(collected[i][4] == collected[j][4],
      nfound = nfound + 1;
      printf("  (%d,%d) ~ (%d,%d): N1=%d, N2=%d\n",
        collected[i][1], collected[i][2],
        collected[j][1], collected[j][2],
        collected[i][3], collected[j][3]);
    );
  );
);
if(nfound == 0, print("  None."));
}

print();
print("--- Common a_p patterns ---");
print();
print("For each prime p, the multiset of {a_p(E_{m,n})} across the family:");
{
for(k = 1, 10,
  p = prime(k);
  vals = vector(#collected, i, collected[i][4][k]);
  vals_sorted = vecsort(vals);
  print("p = ", p, ": values = ", vals_sorted);
  print("    distinct values: ", Set(vals));
);
}

print();
print("=== Save updated data ===");
{
write("/root/proof/perfect-cuboid-problem/scripts/family_lfunction_data2.txt",
  "# Refined data: (m, n, N, [a_p for p in first 20 primes])");
for(i = 1, #collected,
  write("/root/proof/perfect-cuboid-problem/scripts/family_lfunction_data2.txt",
    collected[i]);
);
}

print();
print("Done step 2.");
quit;
