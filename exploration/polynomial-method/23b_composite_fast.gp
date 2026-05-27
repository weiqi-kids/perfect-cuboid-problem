/* Faster composite check using precomputed squares table */

countModFast(m) = {
  my(qrt, count, a, b, c, qr_list);
  \\ Precompute: for each residue x mod m, is x a square?
  qr_list = vector(m, i, 0);
  for(t = 0, m-1, qr_list[(t^2 % m) + 1] = 1);
  count = 0;
  for(a = 1, m-1, if(gcd(a, m) > 1, next);
  for(b = 1, m-1, if(gcd(b, m) > 1, next);
  for(c = 1, m-1, if(gcd(c, m) > 1, next);
    if(qr_list[((a^2+b^2) % m) + 1] &&
       qr_list[((b^2+c^2) % m) + 1] &&
       qr_list[((a^2+c^2) % m) + 1] &&
       qr_list[((a^2+b^2+c^2) % m) + 1],
      count = count + 1;
    );
  )));
  return(count);
}

mlist = [9, 25, 49, 121, 361, 15, 21, 33, 57, 35, 55, 95, 77, 133, 209];
for(i = 1, length(mlist), m = mlist[i]; c = countModFast(m); print("m=", m, " factor=", factor(m), " nontrivial count = ", c));
quit;
