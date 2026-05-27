/* Check A + B on ALL V(Q_2) points (mod 2^K), without restriction. */

default(parisize, "500M");
inv2(x,y) = if(hilbert(x,y,2)==1, 0, 1);
K = 5;  M = 2^K;
sqrt_all_mod(n, M) = { my(L = List()); for(t=0, M-1, if((t*t - n)%M == 0, listput(L, t))); Vec(L); }

print("=== A + B = (d,d-a)(d-a,d-b)(f,f-a)(f-a,f-c) ===");
print("Enumerate all (a,b,c) mod 2^",K," with all 4 face/space equations soluble.");
print("Iterate over all sqrt choices for d, e, f, g.");
print();

\\ Need to also normalize: primitive cuboids have gcd(a,b,c)=1, but more generally
\\ V(Q_2) doesn't have this constraint. Just enumerate (a,b,c) mod M projectively.
\\ However, since we're in projective space we can scale. Let's just do affine and dedupe.

values = List();
{
for(a=0, M-1, for(b=0, M-1, for(c=0, M-1,
  if(a!=0 || b!=0 || c!=0,  \\ not all zero
    my(d2 = (a^2+b^2)%M, e2 = (b^2+c^2)%M, f2 = (a^2+c^2)%M, g2 = (a^2+b^2+c^2)%M);
    if(issquare(Mod(d2, M)) && issquare(Mod(e2, M)) && issquare(Mod(f2, M)) && issquare(Mod(g2, M)),
      my(dsqs = sqrt_all_mod(d2, M), fsqs = sqrt_all_mod(f2, M));
      for(id=1, #dsqs, for(if_=1, #fsqs,
        my(d = dsqs[id], f = fsqs[if_]);
        \\ Only compute when (d-a), (d-b), (f-a), (f-c) are non-zero mod M
        \\ (we just need them non-zero in Q_2 — but if mod M they're zero, the symbol may be ambiguous)
        if((d-a)%M != 0 && (d-b)%M != 0 && (f-a)%M != 0 && (f-c)%M != 0,
          my(vA = inv2(d, d-a) + inv2(d-a, d-b));
          my(vB = inv2(f, f-a) + inv2(f-a, f-c));
          listput(values, (vA + vB) % 2)
        )
      ))
    )
  )
)));
}
print("Number of valid samples: ", #values);
print("Set of values: ", Set(values));
