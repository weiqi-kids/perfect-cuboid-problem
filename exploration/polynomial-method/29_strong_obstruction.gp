/* For each prime p, determine whether there exists a "fully nontrivial" point:
   (a,b,c) all nonzero mod p, AND all four sums (a^2+b^2, etc.) nonzero mod p.
   If NO such point exists, then ANY PCP solution must have p | abcdefg.
*/

checkFullyNontrivialFast(p) = {
  my(qr, a, b, c, s1, s2, s3, s4);
  qr = vector(p, i, 0);
  for(x = 0, p-1, qr[(x^2 % p) + 1] = 1);
  for(a = 1, p-1, for(b = 1, p-1, for(c = 1, p-1,
    s1 = (a^2+b^2) % p;
    s2 = (b^2+c^2) % p;
    s3 = (a^2+c^2) % p;
    s4 = (a^2+b^2+c^2) % p;
    if(s1 != 0 && s2 != 0 && s3 != 0 && s4 != 0,
      if(qr[s1+1] && qr[s2+1] && qr[s3+1] && qr[s4+1],
        return(1);
      );
    );
  )));
  return(0);
}

\\ For each prime, check if there's a fully-nontrivial point
print("Primes where NO fully-nontrivial F_p point exists (=> p | abcdefg for ALL PCP):");
forprime(p = 3, 100, if(!checkFullyNontrivialFast(p), print("  p=", p)));

print("");
print("Primes where the obstruction fails (fully-nontrivial point exists):");
forprime(p = 3, 100, if(checkFullyNontrivialFast(p), print("  p=", p)));

quit;
