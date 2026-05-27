/* For each trivial prime p, check whether the obstruction lifts to p^2, p^3, ...
   This would give STRONGER divisibility: e.g., if p^2 | abc instead of just p.
   Also check at primes p NOT in {3,5,7,11,19}: do they give partial obstructions
   for special (a,b,c) modulo p^k?
*/

\\ For each prime p, count (a,b,c) in (Z/p^k Z)^3 with abc nonzero mod p, all 4 sums squares mod p^k.
\\ "Square mod p^k" : usually means a^2 = x mod p^k for some a in Z/p^k.

\\ For p odd: x is a square mod p^k iff x is a square mod p (when p doesn't divide x).
\\ If p divides x, then it's a square iff vp(x) is even and (x/p^{vp(x)}) is a square mod p.

\\ Let's count: for (a,b,c) in (Z/p^k)^3 with gcd(abc, p) = 1, is the system solvable?

isSquareModpk(x, p, k) = {
  my(pk, vp, q);
  pk = p^k;
  x = x % pk;
  if(x == 0, return(1));
  vp = 0;
  q = x;
  while(q % p == 0, vp = vp + 1; q = q/p);
  \\ vp = v_p(x), q = x / p^{vp}
  if(vp >= k, return(1));  \\ x = 0 mod p^k essentially (but we said x !=0; means x = c*p^k)
  if(vp % 2 != 0, return(0));  \\ odd valuation
  if(kronecker(q, p) != 1, return(0));
  return(1);
}

\\ For (a,b,c) coprime to p, check all 4 sums.
checkmod(p, k) = {
  my(pk, count);
  pk = p^k;
  count = 0;
  for(a = 1, pk-1, if(gcd(a, p) > 1, next);
  for(b = 1, pk-1, if(gcd(b, p) > 1, next);
  for(c = 1, pk-1, if(gcd(c, p) > 1, next);
    if(isSquareModpk(a^2+b^2, p, k) &&
       isSquareModpk(b^2+c^2, p, k) &&
       isSquareModpk(a^2+c^2, p, k) &&
       isSquareModpk(a^2+b^2+c^2, p, k),
      count = count + 1;
    );
  )));
  return(count);
}

\\ For p=3, k=1: expect 0.
\\ For p=3, k=2: expect 0 (Hensel lifts of trivial preserve triviality).
\\ But for "non-trivial" primes p=13, k=2 might give more constraints.

print("Higher-order obstructions:");
for(i = 1, 5, p = [3,5,7,11,19][i]; for(k = 1, 2, print("  p=", p, " k=", k, ": ", checkmod(p, k))));

print("\nNon-trivial primes at higher order:");
for(p_idx = 1, 4, p = [13, 17, 23, 29][p_idx]; for(k = 1, 1, print("  p=", p, " k=", k, ": ", checkmod(p, k))));
quit;
