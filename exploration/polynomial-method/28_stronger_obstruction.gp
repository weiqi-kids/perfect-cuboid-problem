/* For each nontrivial prime p, classify nontrivial points by which (if any) of the 4
   sums equals 0 mod p.
   If ALL nontrivial points have, say, sum_4 = 0 (i.e., g^2 = 0 mod p, i.e., g = 0 mod p),
   that gives p | g for every PCP solution. */

classifyp(p) = {
  my(qr, sum_zero, hits);
  qr = vector(p, i, 0);
  for(x = 0, p-1, qr[(x^2 % p) + 1] = 1);
  sum_zero = [0, 0, 0, 0];  \\ count nontrivial hits with sum_i = 0
  no_zero = 0;
  for(a = 1, p-1, for(b = 1, p-1, for(c = 1, p-1,
    s1 = (a^2+b^2) % p;
    s2 = (b^2+c^2) % p;
    s3 = (a^2+c^2) % p;
    s4 = (a^2+b^2+c^2) % p;
    if(qr[s1+1] && qr[s2+1] && qr[s3+1] && qr[s4+1],
      if(s1 == 0, sum_zero[1] = sum_zero[1] + 1);
      if(s2 == 0, sum_zero[2] = sum_zero[2] + 1);
      if(s3 == 0, sum_zero[3] = sum_zero[3] + 1);
      if(s4 == 0, sum_zero[4] = sum_zero[4] + 1);
      if(s1 != 0 && s2 != 0 && s3 != 0 && s4 != 0, no_zero = no_zero + 1);
    );
  )));
  print("p=", p, " sum0 count [a^2+b^2, b^2+c^2, a^2+c^2, a^2+b^2+c^2] = ", sum_zero, " | none_zero = ", no_zero);
  return([sum_zero, no_zero]);
}

for(i = 1, 15, p = [13, 17, 23, 29, 31, 37, 41, 43, 47, 53, 59, 61, 67, 71, 73][i]; classifyp(p));
quit;
