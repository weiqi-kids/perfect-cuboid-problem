/* Identify the "trivial" locus on V: points where some coordinate is 0.
   These are the easy points; PCP wants points with all positive coordinates. */

\\ Enumerate trivial points over F_p (a, b, or c equal to 0)
\\ - a=0: then b^2 = d^2 (so d = +-b), c^2 = e^2 (so e = +-c), c^2 = f^2 (so f = +-c), b^2+c^2 = g^2.
\\   So {(0, b, c, +-b, +-c, +-c, +-g) : b^2+c^2 = g^2}.
\\   Number of (b,c,g) with b^2+c^2 = g^2 (i.e., a Pythagorean triple over F_p, possibly with 0).
\\
\\ Let's count |Pyth(F_p)| = #{(x,y,z) in F_p^3 : x^2 + y^2 = z^2}
\\ = sum_{z in F_p} #{(x,y) : x^2+y^2 = z^2}.

countPyth(p) =
{
  my(N, qr, x, y, z);
  qr = vector(p, i, 0);
  for(x = 0, p-1, qr[(x^2 % p) + 1] = 1);
  N = 0;
  for(x = 0, p-1, for(y = 0, p-1, if(qr[((x^2+y^2) % p)+1], N=N+1)));
  \\ N counts pairs (x,y) with x^2+y^2 square. Need to upgrade by signs of z.
  Ntrip = 0;
  for(x = 0, p-1, for(y = 0, p-1, t = (x^2+y^2)%p; if(qr[t+1], if(t==0, Ntrip=Ntrip+1, Ntrip=Ntrip+2))));
  return([N, Ntrip]);
}

\\ Now: # trivial points with a=0:
\\   For each (b,c,g) on Pyth curve: 1 choice of a, 2 choices for d (=+-b, if b!=0, else 1), 2 for e (=+-c, if c!=0, else 1), 2 for f (=+-c, if c!=0, else 1).
\\   Plus 2 for g if g != 0, else 1.
\\ This counts (a,b,c,d,e,f,g) tuples with a=0 satisfying all 4 PCP equations.

\\ Similarly for b=0 or c=0. By symmetry these are the same.
\\ For b=0: a^2 = d^2, c^2 = e^2, a^2+c^2 = f^2, a^2+c^2 = g^2. So f = +-g.
\\ For c=0: a^2+b^2 = d^2, b^2 = e^2, a^2 = f^2, a^2+b^2 = g^2. So d = +-g.

\\ Inclusion-exclusion needed for points where multiple coords are zero.

trivialCount(p) =
{
  my(Na, Nb, Nc, Nab, Nbc, Nac, Nabc, total);
  \\ a=0: for each (b,c) with b^2+c^2 square, count multiplicities.
  Na = 0; Nb = 0; Nc = 0;
  qr = vector(p, i, 0);
  for(x = 0, p-1, qr[(x^2 % p) + 1] = 1);
  for(b = 0, p-1, for(c = 0, p-1,
    t = (b^2+c^2)%p;
    if(qr[t+1],
      \\ multiplicities: d (+- b: 2 if b!=0 else 1), e (+- c: 2 if c!=0 else 1), f (+- c: 2 if c!=0 else 1), g (+-sqrt(t): 2 if t!=0 else 1)
      m = 1;
      if(b!=0, m=m*2);
      if(c!=0, m=m*2*2, m=m*1*1);
      \\ above: e and f both depend on c. e:+-c, f:+-c. So if c!=0: 2*2; if c=0: 1*1.
      if(t!=0, m=m*2);
      Na = Na + m;
    );
  ));
  \\ b=0: a^2 = d^2 => d=+-a (2 if a!=0); b^2+c^2 = c^2 => e=+-c (2 if c!=0); a^2+c^2 = f^2 (must be square); g^2 = a^2+c^2 = f^2, g=+-f or g=+-(-f), so g has 2 values if f!=0.
  for(a = 0, p-1, for(c = 0, p-1,
    t = (a^2+c^2)%p;
    if(qr[t+1],
      m = 1;
      if(a!=0, m=m*2);
      if(c!=0, m=m*2);
      if(t!=0, m=m*2*2, m=m*1*1);  \\ f and g both: +-sqrt(t)
      Nb = Nb + m;
    );
  ));
  \\ c=0: a^2+b^2=d^2 (must be sqr); b^2=e^2 => e=+-b; a^2=f^2 => f=+-a; a^2+b^2 = g^2 => g=+-d.
  for(a = 0, p-1, for(b = 0, p-1,
    t = (a^2+b^2)%p;
    if(qr[t+1],
      m = 1;
      if(b!=0, m=m*2);
      if(a!=0, m=m*2);
      if(t!=0, m=m*2*2, m=m*1*1);  \\ d and g both
      Nc = Nc + m;
    );
  ));
  \\ a=b=0: then d=0, c^2=e^2, c^2=f^2, c^2=g^2. So e,f,g in {+-c}.
  \\ For c=0: (0,0,0,0,0,0,0). 1 tuple.
  \\ For c!=0: e in {c,-c}, similarly f,g. So 2*2*2 = 8 tuples per c.
  Nab = 1 + 8*(p-1);
  \\ b=c=0: similarly. a^2=d^2, 0=e^2, a^2=f^2, a^2=g^2.
  Nbc = 1 + 8*(p-1);
  \\ a=c=0: d^2=b^2, e^2=b^2, f^2=0, g^2=b^2.
  Nac = 1 + 8*(p-1);
  \\ a=b=c=0: (0,0,0,0,0,0,0). 1 tuple.
  Nabc = 1;
  total = Na + Nb + Nc - Nab - Nbc - Nac + Nabc;
  return([Na, Nb, Nc, Nab, Nbc, Nac, Nabc, total]);
}

\\ Apply to small primes
plist = [3,5,7,11,13,17,19,23];
for(i = 1, length(plist), p = plist[i]; tt = trivialCount(p); print("p=", p, " Na=", tt[1], " Nb=", tt[2], " Nc=", tt[3], " trivial_total=", tt[8]));
quit;
