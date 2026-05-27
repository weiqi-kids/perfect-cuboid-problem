\\ Sanity check at p=5, k=1: enumerate ALL of F_5^6 to count V' points.
\\ 5^6 = 15625 — feasible.

p = 5;
{
  my(N = 0);
  for(a = 0, p-1,
    for(b = 0, p-1,
      for(c = 0, p-1,
        for(d = 0, p-1,
          for(e = 0, p-1,
            for(f = 0, p-1,
              if( (a^2+b^2-d^2) % p == 0 &&
                  (b^2+c^2-e^2) % p == 0 &&
                  (a^2+c^2-f^2) % p == 0,
                  N++);
            )
          )
        )
      )
    )
  );
  print("Naive F_5^6 count: ", N);
}

\\ p=7, F_7^6 = 117649 also feasible.
p = 7;
{
  my(N = 0);
  for(a = 0, p-1,
    for(b = 0, p-1,
      for(c = 0, p-1,
        for(d = 0, p-1,
          for(e = 0, p-1,
            for(f = 0, p-1,
              if( (a^2+b^2-d^2) % p == 0 &&
                  (b^2+c^2-e^2) % p == 0 &&
                  (a^2+c^2-f^2) % p == 0,
                  N++);
            )
          )
        )
      )
    )
  );
  print("Naive F_7^6 count: ", N);
}
