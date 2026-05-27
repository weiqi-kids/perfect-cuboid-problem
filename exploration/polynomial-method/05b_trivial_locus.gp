/* Corrected trivial locus count */

chiL(x, p) = if(x % p == 0, 0, kronecker(x, p));

trivialCount(p) =
{
  my(Na, Nb, Nc, qr, b, c, a, t, m, total);
  qr = vector(p, i, 0);
  for(x = 0, p-1, qr[(x^2 % p) + 1] = 1);

  \\ a=0: d=+-b, e=+-sqrt(b^2+c^2), f=+-c, g=+-sqrt(b^2+c^2)
  Na = 0;
  for(b = 0, p-1, for(c = 0, p-1,
    t = (b^2+c^2)%p;
    if(qr[t+1],
      m = 1;
      if(b!=0, m=m*2);
      if(c!=0, m=m*2);
      if(t!=0, m=m*4, m=m*1); \\ e and g each contribute 2 if t!=0
      Na = Na + m;
    );
  ));

  \\ b=0: d=+-a, e=+-c, f=+-sqrt(a^2+c^2), g=+-sqrt(a^2+c^2)
  Nb = 0;
  for(a = 0, p-1, for(c = 0, p-1,
    t = (a^2+c^2)%p;
    if(qr[t+1],
      m = 1;
      if(a!=0, m=m*2);
      if(c!=0, m=m*2);
      if(t!=0, m=m*4, m=m*1);
      Nb = Nb + m;
    );
  ));

  \\ c=0: d=+-sqrt(a^2+b^2), e=+-b, f=+-a, g=+-sqrt(a^2+b^2)
  Nc = 0;
  for(a = 0, p-1, for(b = 0, p-1,
    t = (a^2+b^2)%p;
    if(qr[t+1],
      m = 1;
      if(a!=0, m=m*2);
      if(b!=0, m=m*2);
      if(t!=0, m=m*4, m=m*1);
      Nc = Nc + m;
    );
  ));

  \\ a=b=0: d=0, e=+-c, f=+-c, g=+-c.
  \\ For c=0: (0,0,0,0,0,0,0): m=1.
  \\ For c!=0: 8 tuples.
  Nab = 1 + 8*(p-1);
  \\ b=c=0: d=+-a, e=0, f=+-a, g=+-a.
  Nbc = 1 + 8*(p-1);
  \\ a=c=0: d=+-b, e=+-b, f=0, g=+-b.
  Nac = 1 + 8*(p-1);
  \\ a=b=c=0: (0,...,0), m=1.
  Nabc = 1;

  total = Na + Nb + Nc - Nab - Nbc - Nac + Nabc;
  return([Na, Nb, Nc, Nab, Nbc, Nac, Nabc, total]);
}

plist = [3,5,7,11,13,17,19,23,29,31,37,41,43,47];
print("trivial locus counts (points on V with a*b*c = 0):");
for(i = 1, length(plist), p = plist[i]; tt = trivialCount(p); print("p=", p, " Na=", tt[1], " Nb=", tt[2], " Nc=", tt[3], " trivial_total=", tt[8]));
quit;
