\\ Detailed analysis of "perfect" cuboids mod p
\\ All of a,b,c,d,e,f,g nonzero -- these are the actual PCP candidates mod p

countV_nontrivial_v2(p) = {
  my(total, chi);
  chi = vector(p);
  chi[1] = 1;
  for(y=1, p-1,
    chi[(y*y)%p + 1] = chi[(y*y)%p + 1] + 1;
  );
  total = 0;
  for(a=1, p-1,
    for(b=1, p-1,
      for(c=1, p-1,
        my(N1 = (a*a + b*b) % p);
        my(N2 = (b*b + c*c) % p);
        my(N3 = (a*a + c*c) % p);
        my(N4 = (a*a + b*b + c*c) % p);
        my(c1 = chi[N1+1] - if(N1==0, 1, 0));
        my(c2 = chi[N2+1] - if(N2==0, 1, 0));
        my(c3 = chi[N3+1] - if(N3==0, 1, 0));
        my(c4 = chi[N4+1] - if(N4==0, 1, 0));
        total = total + c1 * c2 * c3 * c4;
      );
    );
  );
  return(total);
}

print("Nontrivial counts (all 7 coords nonzero), extended");
{
forprime(p = 3, 47,
  my(nt = countV_nontrivial_v2(p));
  print("p=", p, "  count=", nt);
);
}

\\ Display specific nontrivial points for p=23 and small p where they exist
print("\nSample nontrivial points mod p=23:");
{
my(p = 23, found = 0);
for(a=1, p-1,
  if(found >= 6, break());
  for(b=1, p-1,
    if(found >= 6, break());
    for(c=1, p-1,
      if(found >= 6, break());
      my(N1 = (a*a + b*b) % p);
      my(N2 = (b*b + c*c) % p);
      my(N3 = (a*a + c*c) % p);
      my(N4 = (a*a + b*b + c*c) % p);
      if(N1==0 || N2==0 || N3==0 || N4==0, next());
      \\ Look for square roots
      my(d, e, f, g);
      d = 0; for(y=1, p-1, if((y*y)%p == N1, d = y; break()));
      if(d == 0, next());
      e = 0; for(y=1, p-1, if((y*y)%p == N2, e = y; break()));
      if(e == 0, next());
      f = 0; for(y=1, p-1, if((y*y)%p == N3, f = y; break()));
      if(f == 0, next());
      g = 0; for(y=1, p-1, if((y*y)%p == N4, g = y; break()));
      if(g == 0, next());
      print("  (a,b,c)=(", a, ",", b, ",", c, ") (d,e,f,g)=(", d, ",", e, ",", f, ",", g, ")");
      found = found + 1;
    );
  );
);
}

quit;
