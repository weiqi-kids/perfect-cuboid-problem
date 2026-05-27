/* For m = 9 = 3^2, m = 21 = 3*7, m = 33 = 3*11, m = 57 = 3*19, m = 35 = 5*7, etc.
   Check whether nontrivial points (a,b,c) coprime to m with all 4 sums squares mod m exist.
   If NO such (a,b,c) exists, then any PCP must have p | abc for SOME p|m.
   This is just CRT (so no extra info), but it's a check.
*/

isSquareMod(x, m) = {
  my(found, t);
  x = x % m;
  found = 0;
  for(t = 0, m-1, if((t^2 % m) == x, found = 1; break));
  return(found);
}

countMod(m) = {
  my(count, a, b, c);
  count = 0;
  for(a = 1, m-1, if(gcd(a, m) > 1, next);
  for(b = 1, m-1, if(gcd(b, m) > 1, next);
  for(c = 1, m-1, if(gcd(c, m) > 1, next);
    if(isSquareMod(a^2+b^2, m) &&
       isSquareMod(b^2+c^2, m) &&
       isSquareMod(a^2+c^2, m) &&
       isSquareMod(a^2+b^2+c^2, m),
      count = count + 1;
    );
  )));
  return(count);
}

mlist = [9, 25, 49, 121, 361, 15, 21, 33, 57, 35, 55, 95, 77, 133, 209];
for(i = 1, length(mlist), m = mlist[i]; c = countMod(m); print("m=", m, " factor=", factor(m), " nontrivial count = ", c));

quit;
