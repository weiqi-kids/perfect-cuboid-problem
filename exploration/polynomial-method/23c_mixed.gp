/* m = p*q where p in trivial set, q in nontrivial set */

countModFast(m) = {
  my(qr_list, count, a, b, c);
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

mlist = [39, 51, 65, 85, 91, 143];  \\ 39=3*13, 51=3*17, 65=5*13, 85=5*17, 91=7*13, 143=11*13
for(i = 1, length(mlist), m = mlist[i]; c = countModFast(m); print("m=", m, " factor=", factor(m), " nontrivial count = ", c));
quit;
