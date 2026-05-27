/* Verify hand proof for p=7 */

runp7() = {
  my(p, qr, S);
  p = 7;
  qr = vector(p, i, 0);
  for(x = 0, p-1, qr[(x^2 % p) + 1] = 1);
  S = [];
  for(x = 1, p-1, if(qr[x+1], S = concat(S, [x])));
  print("Squares in F_7* = ", S);

  print("All pair sums x+y for x,y in S (allowing x = y):");
  for(i = 1, length(S), for(j = 1, length(S),
    x = S[i]; y = S[j]; sm = (x+y)%p;
    print("  ", x, "+", y, " = ", sm, " is_sq=", qr[sm+1]);
  ));

  print("\nDiagonal cases x=y=z: need 2x and 3x both squares");
  for(i = 1, length(S),
    x = S[i];
    print("  x=", x, ": 2x=", (2*x)%p, " sq=", qr[((2*x)%p)+1], "; 3x=", (3*x)%p, " sq=", qr[((3*x)%p)+1]);
  );
}

runp7();
quit;
