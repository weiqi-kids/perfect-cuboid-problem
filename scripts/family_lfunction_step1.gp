\\ Family L-function exploration for E_PCP(q): Y^2 = X(X+1)(X+q^2)
\\ over Pythagorean q = (m^2 - n^2)/(2mn) with gcd(m,n)=1, m+n odd, m > n > 0.

default(parisize, 800000000);

print("=== Family parameterization of E_PCP(q) ===");
print("(m, n) with gcd=1, m+n odd, m > n > 0:");
print("  q = (m^2 - n^2)/(2mn)");
print("  E_PCP: Y^2 = X(X+1)(X + q^2)");
print();
print("Integer model after X -> X'/(2mn)^2, Y -> Y'/(2mn)^3:");
print("  Y^2 = X (X + u^2)(X + v^2),  u = 2mn, v = m^2 - n^2");
print("       = X^3 + (u^2+v^2) X^2 + u^2 v^2 X");
print();

primes20 = vector(20, k, prime(k));
print("First 20 primes: ", primes20);
print();

print("Computing E_{m,n} for (m,n) in coprime opposite-parity range...");
print();
printf("%5s %4s %12s %14s %s\n", "m", "n", "q", "conductor", "factored");
print("--------------------------------------------------------------");

{
data = List();
for(m = 2, 10,
  for(n = 1, m - 1,
    if(gcd(m, n) == 1 && (m + n) % 2 == 1,
      u = 2*m*n;
      v = m^2 - n^2;
      a2 = u^2 + v^2;
      a4 = u^2 * v^2;
      E = ellinit([0, a2, 0, a4, 0]);
      Emin = ellminimalmodel(E);
      gr = ellglobalred(Emin);
      N = gr[1];
      Nfac = factor(N);
      aps = vector(20, k, ellap(Emin, primes20[k]));
      q = (m^2 - n^2) / (2*m*n);
      listput(data, [m, n, q, N, aps, u, v]);
      printf("%5d %4d %12s %14d  %s\n", m, n, Str(q), N, Str(Nfac));
    );
  );
);
}

print();
print("=== Conductor analysis ===");
print("u = 2mn, v = m^2 - n^2; note u^2 + v^2 = (m^2 + n^2)^2.");
print();

{
for(i = 1, #data,
  d = data[i];
  m = d[1]; n = d[2]; q = d[3]; N = d[4]; u = d[6]; v = d[7];
  printf("(m,n)=(%d,%d): u=%d, v=%d, u^2+v^2=%d, uv=%d, N=%d\n",
    m, n, u, v, u^2+v^2, u*v, N);
);
}

print();
print("=== a_p tables ===");
print();
printf("%-12s ", "(m,n)");
{ for(k = 1, 10, printf("a_%-5d", primes20[k])); }
print();
print("---------------------------------------------------------------------------");
{
for(i = 1, #data,
  d = data[i];
  printf("(%2d,%2d)%-6s ", d[1], d[2], "");
  for(k = 1, 10, printf("%-6d ", d[5][k]));
  print();
);
}

print();
print("=== a_p at p = 11, 13, 17, 19, 23, 29 (next batch) ===");
printf("%-12s ", "(m,n)");
{ for(k = 11, 20, printf("a_%-5d", primes20[k])); }
print();
print("---------------------------------------------------------------------------");
{
for(i = 1, #data,
  d = data[i];
  printf("(%2d,%2d)%-6s ", d[1], d[2], "");
  for(k = 11, 20, printf("%-6d ", d[5][k]));
  print();
);
}

print();
print("=== Save data ===");

\\ Save raw data in human-readable form
{
write("/root/proof/perfect-cuboid-problem/scripts/family_lfunction_data.txt",
  "# (m, n, q, N, [a_2,a_3,a_5,...], u=2mn, v=m^2-n^2)");
for(i = 1, #data,
  write("/root/proof/perfect-cuboid-problem/scripts/family_lfunction_data.txt",
    data[i]);
);
}

print("Done step 1.");
quit;
