/* ==========================================================================
   Enumerate non-degenerate 2-adic V-points (a,b,c,d,e,f,g) mod 2^K
   with all coords units up to specified 2-valuations.
   For each, compute candidate Hilbert symbols.
   ========================================================================== */

K = 6;
M = 2^K;

\\ Find a mod 2^K representation of sqrt(s) for s a square mod 2^K
sqrt_mod2K(s, K) = {
  my(M = 2^K, t);
  for(t=1, M-1, if((t^2 - s)%M == 0, return(t)));
  -1;
}

\\ Enumerate (a,b,c) with parity (odd, 4|b not 8|b, 4|c) say -- this gives v2(b)=2, v2(c)>=2.
\\ Actually need: a odd, b=4b' (b' arbitrary), c=4c' (c' arbitrary), and one of b,c has v2=2.
\\ Let's fix v2(b)=2, v2(c)>=4 (so c=16*c' essentially) for clarity.
\\ Actually we just want valuations exactly 2 and some other.

\\ Iterate solutions, filter, compute symbols.
print("=== Solutions with v2(b)=2, v2(c)>=4, all face equations valid mod ",M," ===");
count = 0;
{
for(a=1, M-1, if(a%2==1,
  for(bp=1, M/4 - 1, if(bp%2==1,
    my(b = 4*bp);
    if(b < M,
      my(d2 = (a^2+b^2)%M);
      if(issquare(Mod(d2,M)),
        for(cp=0, M/16 - 1,
          my(c = 16*cp);
          if(c<M && c!=0,
            my(e2=(b^2+c^2)%M, f2=(a^2+c^2)%M, g2=(a^2+b^2+c^2)%M);
            if(issquare(Mod(e2,M)) && issquare(Mod(f2,M)) && issquare(Mod(g2,M)),
              count = count + 1;
              if(count <= 20,
                my(d = sqrt_mod2K(d2, K), e = sqrt_mod2K(e2, K), f = sqrt_mod2K(f2, K), g = sqrt_mod2K(g2, K));
                print("a=",a," b=",b," c=",c," d=",d," e=",e," f=",f," g=",g,
                  "  (mod 8: a=",a%8," d=",d%8," e=",e%8," f=",f%8," g=",g%8,")")
              )
            )
          )
        )
      )
    )
  ))
))
}
print("\nTotal: ", count);
