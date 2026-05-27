/* Structural analysis: why do certain primes p have V(F_p) entirely trivial?
   For each "trivial prime" p, examine why no (a,b,c) all nonzero with all 4 sums square exists. */

\\ Approach: explicitly print pattern of squares mod p

analyze(p) = {
  my(squares, nonsq, qr);
  qr = vector(p, i, 0);
  squares = [];
  nonsq = [];
  for(x = 0, p-1,
    qr[(x^2 % p) + 1] = 1;
  );
  for(x = 1, p-1, if(qr[x+1], squares = concat(squares, [x]), nonsq = concat(nonsq, [x])));
  print("p=", p, ": squares (nonzero) = ", squares);
  print("        nonsquares = ", nonsq);
  print("        chi(-1) = ", kronecker(-1, p), "  (== 1 iff p == 1 mod 4)");
  print("        chi(2) = ", kronecker(2, p));
  print("        chi(5) = ", kronecker(5, p));
}

for(i = 1, 6, analyze([3,5,7,11,13,17,19][i]));
quit;
