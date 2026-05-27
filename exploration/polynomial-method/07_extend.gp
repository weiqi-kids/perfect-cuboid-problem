/* Extend search to primes up to 200 */

nontrivCountBase(p) =
{
  my(Nbase, qr, s1, s2, s3, s4, a, b, c);
  Nbase = 0;
  qr = vector(p, i, 0);
  for(x = 0, p-1, qr[(x^2 % p) + 1] = 1);
  for(a = 1, p-1,
    for(b = 1, p-1,
      for(c = 1, p-1,
        s1 = (a^2+b^2) % p;
        s2 = (b^2+c^2) % p;
        s3 = (a^2+c^2) % p;
        s4 = (a^2+b^2+c^2) % p;
        if(qr[s1+1] && qr[s2+1] && qr[s3+1] && qr[s4+1], Nbase = Nbase + 1);
      );
    );
  );
  return(Nbase);
}

runtrivials() = {
  forprime(p = 3, 200, nt = nontrivCountBase(p); print("p=", p, " NTbase=", nt, if(nt==0, " *** TRIVIAL ***", "")));
}

runtrivials();
quit;
