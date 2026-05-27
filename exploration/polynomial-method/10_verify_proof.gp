/* Independent verification via brute force search:
   For each p in {3,5,7,11,19}, explicitly check all (a,b,c) in (F_p^*)^3
   (i.e., abc != 0) for whether all 4 sums are squares mod p.
   Print first 5 hits if any (should be none). */

verify(p) = {
  my(qr, hits, s1, s2, s3, s4);
  qr = vector(p, i, 0);
  for(x = 0, p-1, qr[(x^2 % p) + 1] = 1);
  hits = 0;
  for(a = 1, p-1,
    for(b = 1, p-1,
      for(c = 1, p-1,
        s1 = (a^2+b^2) % p;
        s2 = (b^2+c^2) % p;
        s3 = (a^2+c^2) % p;
        s4 = (a^2+b^2+c^2) % p;
        if(qr[s1+1] && qr[s2+1] && qr[s3+1] && qr[s4+1],
          hits = hits + 1;
          if(hits <= 3, print("  HIT at p=", p, ": (a,b,c)=(", a, ",", b, ",", c, ") sums=", [s1, s2, s3, s4]));
        );
      );
    );
  );
  print("p=", p, ": total nontrivial hits = ", hits);
  return(hits);
}

print("Verification of trivial primes for PCP:");
for(i = 1, 5, verify([3,5,7,11,19][i]));
print("");
print("Verification of non-trivial primes (sanity check):");
verify(13);
verify(17);
quit;
