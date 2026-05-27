\\ Rank survey, m <= 60. Uses ellanalyticrank with reduced precision.
default(parisize, 2000000000);
default(realprecision, 19);

{
  for(m = 2, 60,
    for(n = 1, m-1,
      if(gcd(m,n) == 1 && (m+n) % 2 == 1,
        a = m^2 - n^2;
        b = 2*m*n;
        E = ellinit([0, a^2 + b^2, 0, a^2*b^2, 0]);
        Emin = ellminimalmodel(E);
        N = ellglobalred(Emin)[1];
        \\ analytic rank with lower precision target
        ar = ellanalyticrank(Emin, 0.1)[1];
        print(m, " ", n, " ", m+n, " ", N, " ", ar, " ",
              isprime(m+n), " ", isprime(m^2+n^2));
      );
    );
  );
}
quit;
