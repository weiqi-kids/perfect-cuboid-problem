\\ Summary computations for the 5 survivor fibers.
default(parisize, 100000000);

sf(n) = if(n == 0, 0, sign(n) * core(abs(n)));

survivors = [[5, 2], [9, 2], [13, 4], [17, 4], [17, 6]];

print("=== DEGENERACY CHECK ===");
{
for(i = 1, #survivors,
  pair = survivors[i];
  m = pair[1]; n = pair[2];
  a = m^2 - n^2;
  b = 2*m*n;
  P = (m+n)^2 - 2*n^2;
  Q = (m-n)^2 - 2*n^2;
  sfP = sf(P); sfQ = sf(Q);
  P_sq = issquare(abs(P));
  Q_sq = issquare(abs(Q));
  P_mod8 = sfP % 8;
  Q_mod8 = sfQ % 8;
  P_prime = if(abs(sfP) > 1, isprime(abs(sfP)), 0);
  Q_prime = if(abs(sfQ) > 1, isprime(abs(sfQ)), 0);
  print();
  print("(", m, ",", n, "): a=", a, " b=", b);
  print("  P=", P, " sf(P)=", sfP, " P square? ", P_sq, " prime? ", P_prime, " mod8=", P_mod8);
  print("  Q=", Q, " sf(Q)=", sfQ, " Q square? ", Q_sq, " prime? ", Q_prime, " mod8=", Q_mod8);
  print("  DEGEN bits: sfP_sq=", (sfP == 1 || sfP == -1),
                "  sfQ_sq=", (sfQ == 1 || sfQ == -1),
                "  sfP prime≡1 mod 8=", (P_prime && (P_mod8 == 1)),
                "  sfQ prime≡1 mod 8=", (Q_prime && (Q_mod8 == 1)));
);
}

quit;
