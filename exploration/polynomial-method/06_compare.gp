/* Compare Nproper vs trivial; isolate nontrivial points */

chiL(x, p) = if(x % p == 0, 0, kronecker(x, p));

\\ Compute nontrivial points (a*b*c != 0 in F_p) on V:
nontrivCount(p) =
{
  my(Nproper, Nbase, qr, s1, s2, s3, s4, m, a, b, c);
  Nproper = 0; Nbase = 0;
  qr = vector(p, i, 0);
  for(x = 0, p-1, qr[(x^2 % p) + 1] = 1);
  for(a = 1, p-1,
    for(b = 1, p-1,
      for(c = 1, p-1,
        s1 = (a^2+b^2) % p;
        s2 = (b^2+c^2) % p;
        s3 = (a^2+c^2) % p;
        s4 = (a^2+b^2+c^2) % p;
        if(qr[s1+1] && qr[s2+1] && qr[s3+1] && qr[s4+1],
          Nbase = Nbase + 1;
          m = 1;
          if(s1 != 0, m=m*2);
          if(s2 != 0, m=m*2);
          if(s3 != 0, m=m*2);
          if(s4 != 0, m=m*2);
          Nproper = Nproper + m;
        );
      );
    );
  );
  return([Nbase, Nproper]);
}

plist = [3,5,7,11,13,17,19,23,29,31,37,41,43,47,53,59,61,67,71,73,79,83,89,97,101,103,107,109];
print("Nontrivial (abc != 0) points on V(F_p):");
print("p | NTbase | NTproper | NTbase/p^3");
for(i = 1, length(plist), p = plist[i]; r = nontrivCount(p); print(p, " | ", r[1], " | ", r[2], " | ", r[1]*1.0/p^3));
quit;
