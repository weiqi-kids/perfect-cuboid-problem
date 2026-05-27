/* Sanity check: print first 5 fully-nontrivial F_p points for p = 23, 31, 41, 43.
   These are candidates that satisfy ALL constraints but with all coords nonzero. */

findfully(p) = {
  my(qr, hits, count);
  qr = vector(p, i, 0);
  for(x = 0, p-1, qr[(x^2 % p) + 1] = 1);
  count = 0;
  print("p=", p, " first fully-nontrivial points (a, b, c with all 4 sums nonzero squares):");
  for(a = 1, p-1, for(b = 1, p-1, for(c = 1, p-1,
    s1 = (a^2+b^2) % p;
    s2 = (b^2+c^2) % p;
    s3 = (a^2+c^2) % p;
    s4 = (a^2+b^2+c^2) % p;
    if(s1 != 0 && s2 != 0 && s3 != 0 && s4 != 0 && qr[s1+1] && qr[s2+1] && qr[s3+1] && qr[s4+1],
      count = count + 1;
      if(count <= 5, print("  (", a, ",", b, ",", c, ") sums=(", s1, ",", s2, ",", s3, ",", s4, ")"));
    );
  )));
  print("  total fully-nontrivial: ", count);
}

findfully(23);
findfully(31);
findfully(41);
findfully(43);
quit;
