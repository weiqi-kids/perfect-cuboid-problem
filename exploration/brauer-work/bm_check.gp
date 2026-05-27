/* ==========================================================================
   BM check: enumerate 2-adic V-points (mod 2^K, with cuboid parity),
   for each compute candidate Brauer class local invariants at p=2.
   Goal: find a class A with inv_2(A) constant nonzero on V(Q_2).
   ========================================================================== */

\\ inv_2((a,b)) using PARI hilbert function returning -1/1, mapped to 1/2 / 0
inv2(a,b) = if(hilbert(a,b,2)==1, 0, 1/2);

\\ For each 2-adic V-point, compute a vector of Hilbert symbols at p=2.
\\ A "2-adic V-point" representative: pick (a,b,c) representing classes;
\\ derive d,e,f,g from sqrt of corresponding sums (need to make a choice).

\\ Square class of x in Q_2: returns elt of {1,3,5,7,2,6,10,14} = representative mod 8 * 2^(v2(x) mod 2)
sqclass2(x) = {
  my(v = valuation(x,2), u = x / 2^v);
  my(uc = u % 8); if(uc < 0, uc += 8);
  if(v % 2 == 0, uc, 2 * uc % 16);
}

\\ Strategy: For each (a,b,c) mod 64 with parity constraint, pick "canonical" (d,e,f,g)
\\ as smallest non-negative sqrt. Then compute Hilbert symbols.

\\ Find smallest sqrt of n mod M, returning -1 if none
sqrt_mod(n, M) = {
  my(r=-1, t);
  for(t=0, M-1, if((t*t - n)%M == 0, r = t; break));
  r;
}

K = 6;  M = 2^K;

\\ Try just a few representative 2-adic points
print("=== Computing inv_2 for various Brauer candidates ===");
print();
print("Candidates considered:");
print("  A1 = (a, b)");
print("  A2 = (b, c)");
print("  A3 = (a, c)");
print("  A4 = (a, -1)");
print("  A5 = (b, -1)");
print("  A6 = (c, -1)");
print("  A7 = (a, b) + (b, c) + (a, c)  [sum]");
print("  A8 = (-1, a) + (-1, b) + (-1, c)");
print("  A9 = (a, c) + (b, c)");
print("  A10 = (d, e), where d = sqrt(a^2+b^2), etc.");
print();

print("Tabulate inv_2 values on diverse 2-adic V-points:");
print("(a, b, c, d, e, f, g)  | inv_2(A1..A10)");
{
my(seen = List(), count = 0, vals_seen);
for(a=1, M-1, if(a%2==1,
  for(b=4, M-1, if(b%4==0,
    if(issquare(Mod(a^2+b^2, M)),
      my(d = sqrt_mod((a^2+b^2)%M, M));
      for(c=4, M-1, if(c%4==0,
        if(issquare(Mod(b^2+c^2, M)) && issquare(Mod(a^2+c^2, M)) && issquare(Mod(a^2+b^2+c^2, M)),
          my(e = sqrt_mod((b^2+c^2)%M, M),
             f = sqrt_mod((a^2+c^2)%M, M),
             g = sqrt_mod((a^2+b^2+c^2)%M, M));
          if(d!=0 && e!=0 && f!=0 && g!=0,
            my(A1 = inv2(a, b), A2 = inv2(b, c), A3 = inv2(a, c),
               A4 = inv2(a, -1), A5 = inv2(b, -1), A6 = inv2(c, -1),
               A7 = (A1+A2+A3) - floor(A1+A2+A3),
               A8 = (A4+A5+A6) - floor(A4+A5+A6),
               A9 = (A3+A2) - floor(A3+A2),
               A10 = inv2(d,e));
            my(key = [A1,A2,A3,A4,A5,A6,A7,A8,A9,A10]);
            if(!setsearch(Set(seen), key),
              listput(seen, key);
              count = count + 1;
              if(count <= 30,
                print("(",a,",",b,",",c,",",d,",",e,",",f,",",g,")  | ",[A1,A2,A3,A4,A5,A6,A7,A8,A9,A10])
              )
            );
          )
        )
      ))
    )
  ))
));
print();
print("Number of distinct invariant patterns: ", count);
print();
print("Set of pattern tuples:");
vals_seen = vecsort(Vec(seen));
for(i=1, min(30, #vals_seen), print(vals_seen[i]))
}
