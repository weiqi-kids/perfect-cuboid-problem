/* Character-sum analysis of |A_p|.
   For odd prime p, let chi be the Legendre symbol. Then:
     1_{x is square} = (1 + chi(x))/2 for x != 0, and 1 for x = 0.

   So #{ (a,b,c) : all four sums are squares }
     = sum_{a,b,c} prod_{i=1..4} ((1 + chi(Q_i))/2 + correction at Q_i = 0)
   To leading order:
     |A_p| ~ p^3 / 16  * (16 + correction)
     so 16 * |A_p| / p^3 ~ 16 + lower order
   Hmm let's just compute the character sum carefully and look at corrections.

   Actually the simpler view: |A_p| should be approximately 16 * p^3 / 2^4 = p^3
   if we counted with sign multiplicity 2^4 (each of 4 sums having a sqrt and -sqrt).
   We saw Nproper / p^3 -> 1, which matches.

   Let me compute the character sum for # of points on V directly, separating cases.
*/

\\ Legendre symbol implemented via kronecker
leg(x, p) = if(x % p == 0, 0, kronecker(x, p));

\\ For each prime p, compute character sum:
\\   S_p = sum_{a,b,c in F_p} (1+chi(a^2+b^2))(1+chi(b^2+c^2))(1+chi(a^2+c^2))(1+chi(a^2+b^2+c^2)) / 16
\\ This equals Nproper minus the "boundary" cases where some Q_i = 0.
\\ For Q_i nonzero, (1+chi(Q_i))/2 in {0,1} = 1_{Q_i is square}.
\\ For Q_i = 0, (1+chi(0))/2 = 1/2, which mishandles. But Q_i=0 means d_i = 0, which gives 1 choice instead of 2.

\\ Define the "smooth" count S_p which is exactly Nproper (counting +-sqrt as 2 choices, including 0=>1 by convention if Q_i = 0).
\\ Actually Nproper = 2^{#nonzero Q_i among the 4 sums} per valid (a,b,c).

\\ Compute Nproper via product expansion and see structure.

chiL(x, p) = if(x % p == 0, 0, kronecker(x, p));

countViaChi(p) =
{
  my(S, a, b, c, q1, q2, q3, q4, prod, f);
  S = 0;
  for(a = 0, p-1,
    for(b = 0, p-1,
      for(c = 0, p-1,
        q1 = (a^2+b^2) % p;
        q2 = (b^2+c^2) % p;
        q3 = (a^2+c^2) % p;
        q4 = (a^2+b^2+c^2) % p;
        \\ Number of (d,e,f,g) with d^2=q1, e^2=q2, f^2=q3, g^2=q4 in F_p:
        \\ For each q_i: 0 if q_i is nonsquare, 1 if q_i = 0, 2 if q_i nonzero square
        prod = 1;
        f = 1;
        if(chiL(q1, p) == -1, f = 0);
        if(chiL(q2, p) == -1, f = 0);
        if(chiL(q3, p) == -1, f = 0);
        if(chiL(q4, p) == -1, f = 0);
        if(f == 1,
          if(q1 != 0, prod = prod * 2);
          if(q2 != 0, prod = prod * 2);
          if(q3 != 0, prod = prod * 2);
          if(q4 != 0, prod = prod * 2);
          S = S + prod;
        );
      );
    );
  );
  return(S);
}

\\ For each prime, count |V(F_p)|, compare with p^3, give error
print("\nReconciling counts (should match Nproper from before):");
plist = [3,5,7,11,13,17,19];
for(i = 1, length(plist), p = plist[i]; r = countViaChi(p); print("p=", p, " |V(F_p)|=", r, " p^3=", p^3, " error=", r - p^3, " err/sqrt(p)*p^2=", (r-p^3)*1.0/(p^2*sqrt(p))));
quit;
