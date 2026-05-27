\\ Quick scaling test
pyth_reps(g) = {
  my(sols = List(), g2 = g^2, lim);
  lim = sqrtint(g2 \ 2);
  for(x = 1, lim,
    my(y2 = g2 - x^2);
    if(issquare(y2), my(y = sqrtint(y2)); if(x < y, listput(sols, [x, y])));
  );
  Vec(sols);
}

\\ Faster: enumerate Pythagorean reps of g^2 directly via Gaussian factorization
\\ For g squarefree with k primes ≡ 1 mod 4, count = (3^k - 1)/2
\\ But we need explicit pairs. Brute force is O(g/sqrt(2)) per g, OK up to ~50000.

\\ Try a few sample g's
print("g=1105 reps: ");
P = pyth_reps(1105);
print("  n=", #P);
for(i=1,#P, print("  ", P[i]));

print("\ng=5525=5^2*13*17 reps: ");
P = pyth_reps(5525);
print("  n=", #P);

print("\ng=1885=5*13*29 reps: ");
P = pyth_reps(1885);
print("  n=", #P);

print("\ng=2210=2*5*13*17 reps: ");
P = pyth_reps(2210);
print("  n=", #P);

print("\ng=32045=5*13*17*29 reps: ");
P = pyth_reps(32045);
print("  n=", #P);

quit;
