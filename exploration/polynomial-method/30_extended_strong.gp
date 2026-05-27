/* Find ALL strong-obstruction primes up to 500.
   p is "strong-obstruction" if NO (a,b,c) in (F_p^*)^3 with all 4 sums in (F_p^*)^2 exists.
*/

isStrong(p) = {
  my(qr, a, b, c, s1, s2, s3, s4);
  qr = vector(p, i, 0);
  for(x = 0, p-1, qr[(x^2 % p) + 1] = 1);
  for(a = 1, p-1, for(b = 1, p-1, for(c = 1, p-1,
    s1 = (a^2+b^2) % p;
    s2 = (b^2+c^2) % p;
    s3 = (a^2+c^2) % p;
    s4 = (a^2+b^2+c^2) % p;
    if(s1 != 0 && s2 != 0 && s3 != 0 && s4 != 0 && qr[s1+1] && qr[s2+1] && qr[s3+1] && qr[s4+1],
      return(0);
    );
  )));
  return(1);
}

\\ Pre-screening optimization: skip large primes quickly.
\\ But for completeness, run on all primes up to 500.
runtri() = {
  print("Strong-obstruction primes (p | abcdefg in every PCP):");
  forprime(p = 3, 500, if(isStrong(p), print("  p=", p)));
}

runtri();
quit;
