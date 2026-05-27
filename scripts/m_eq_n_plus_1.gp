\\ m = n+1 sub-family for m <= 60.
\\ Pick 4 noticed (6,5), (9,8), (13,12) etc. - check if m = n+1 always gives rank >= 1.

default(parisize, 2000000000);
default(realprecision, 38);

print("=== m = n+1 sub-family analysis ===");
print("m n a b s N r_an");

{
  for(m = 2, 60,
    n = m - 1;
    if(gcd(m,n) == 1 && (m+n) % 2 == 1,
      a = m^2 - n^2;
      b = 2*m*n;
      s = m^2 + n^2;
      E = ellinit([0, a^2+b^2, 0, a^2*b^2, 0]);
      Emin = ellminimalmodel(E);
      N = ellglobalred(Emin)[1];
      ar = ellanalyticrank(Emin)[1];
      print(m, " ", n, " ", a, " ", b, " ", s, " ", N, " ", ar);
    );
  );
}
quit;
