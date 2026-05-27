/* Search for trivial primes up to 1000 */

isTrivial(p) = {
  my(qr, s1, s2, s3, s4, a, b, c);
  qr = vector(p, i, 0);
  for(x = 0, p-1, qr[(x^2 % p) + 1] = 1);
  for(a = 1, p-1, for(b = 1, p-1, for(c = 1, p-1,
    s1 = (a^2+b^2) % p;
    s2 = (b^2+c^2) % p;
    s3 = (a^2+c^2) % p;
    s4 = (a^2+b^2+c^2) % p;
    if(qr[s1+1] && qr[s2+1] && qr[s3+1] && qr[s4+1], return(0));
  )));
  return(1);
}

runtri() = {
  print("Trivial primes up to 1000:");
  forprime(p = 3, 1000, if(isTrivial(p), print("  p=", p)));
  print("Done.");
}

runtri();
quit;
