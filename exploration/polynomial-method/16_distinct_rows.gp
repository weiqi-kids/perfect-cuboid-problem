/* Check: are all rows with a != 0 EQUAL for trivial primes? */

investigate(p) = {
  my(qr, T, distinct, rows, equal_count);
  qr = vector(p, i, 0);
  for(x = 0, p-1, qr[(x^2 % p) + 1] = 1);
  T = matrix(p, p^2, a, k, 0);
  for(a = 0, p-1, for(b = 0, p-1, for(c = 0, p-1,
    s1 = (a^2+b^2) % p;
    s2 = (b^2+c^2) % p;
    s3 = (a^2+c^2) % p;
    s4 = (a^2+b^2+c^2) % p;
    if(qr[s1+1] && qr[s2+1] && qr[s3+1] && qr[s4+1], T[a+1, b*p+c+1] = 1);
  )));
  \\ Check whether T[2,..] equals T[3,..], etc., for a in 1..(p-1)
  print("p=", p, ":");
  for(a = 1, (p-1)/2,
    eq = sum(k=1, p^2, abs(T[a+1, k] - T[2, k]));
    print("  row(a=", a, ") - row(a=1): L1 diff = ", eq);
  );
  print("  rank=", matrank(T));
}

investigate(3);
investigate(5);
investigate(7);
investigate(11);
investigate(13);
investigate(17);
investigate(19);
quit;
