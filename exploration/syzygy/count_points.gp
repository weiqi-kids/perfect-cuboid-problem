\\ Count V(F_p) for small primes, V ⊂ P^6 defined by:
\\ Q1: a^2 + b^2 - d^2 = 0
\\ Q2: b^2 + c^2 - e^2 = 0
\\ Q3: a^2 + c^2 - f^2 = 0
\\ Q4: a^2 + b^2 + c^2 - g^2 = 0

countV_affine(p) = {
  my(total, chi, N1, N2, N3, N4);
  if(p == 2,
    total = 0;
    for(a=0,1, for(b=0,1, for(c=0,1, for(d=0,1, for(e=0,1, for(f=0,1, for(g=0,1,
      if( ((a*a+b*b-d*d) % 2 == 0) &&
          ((b*b+c*c-e*e) % 2 == 0) &&
          ((a*a+c*c-f*f) % 2 == 0) &&
          ((a*a+b*b+c*c-g*g) % 2 == 0),
        total = total + 1;
      );
    )))))));
    return(total);
  );
  chi = vector(p);
  chi[1] = 1;
  for(y=1, p-1,
    chi[(y*y)%p + 1] = chi[(y*y)%p + 1] + 1;
  );
  total = 0;
  for(a=0, p-1,
    for(b=0, p-1,
      for(c=0, p-1,
        N1 = (a*a + b*b) % p;
        N2 = (b*b + c*c) % p;
        N3 = (a*a + c*c) % p;
        N4 = (a*a + b*b + c*c) % p;
        total = total + chi[N1+1] * chi[N2+1] * chi[N3+1] * chi[N4+1];
      );
    );
  );
  return(total);
}

print("p  |V_aff|  |V_proj|  p^2+p+1  delta");
{
forprime(p = 2, 23,
  my(aff, proj, main);
  aff = countV_affine(p);
  proj = (aff - 1)/(p - 1);
  main = p^2 + p + 1;
  print("p=", p, "  aff=", aff, "  proj=", proj, "  p^2+p+1=", main, "  delta=", proj - main);
);
}

quit;
