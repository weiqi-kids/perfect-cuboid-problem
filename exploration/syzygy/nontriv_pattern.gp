\\ Look for arithmetic pattern in nontriv counts

countV_nontrivial(p) = {
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

print("p  p%8  p%12  p%24  nontriv_count");
{
forprime(p = 3, 71,
  my(nt = countV_nontrivial(p));
  print("p=", p, "  p%8=", p%8, "  p%12=", p%12, "  p%24=", p%24, "  count=", nt);
);
}

quit;
