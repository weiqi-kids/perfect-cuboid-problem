/* Why is the flattening rank exactly (p+1)/2?

   Observation: T(a, b, c) only depends on (a^2, b^2, c^2) (everything is quadratic).
   So if we define s(a) = a^2 (the squaring map), T factors as:
     T(a, b, c) = T'(a^2, b^2, c^2)
   where T' is defined on Squares(F_p)^3.

   Number of squares in F_p: (p+1)/2 (including 0).

   So the slice-rank of T = slice-rank of T' (each axis of T'-rank is the # distinct values of a^2 over F_p, multiplied appropriately).

   The matrix flattening of T along axis 1 has columns indexed by (b,c), and rows by a.
   But row a depends only on a^2; rows for +a and -a are equal.
   So distinct rows = (p+1)/2 (a=0 gives 1 row, +-a give same row for a in 1..(p-1)/2).
   Hence rank <= (p+1)/2.

   AND we observe rank IS exactly (p+1)/2, meaning the (p+1)/2 distinct rows are linearly independent.
*/

\\ Verify: print the distinct rows of T (modulo +-a)
investigate(p) = {
  my(qr, T, distinct_rows);
  qr = vector(p, i, 0);
  for(x = 0, p-1, qr[(x^2 % p) + 1] = 1);
  T = matrix(p, p^2, a, k, 0);
  for(a = 0, p-1, for(b = 0, p-1, for(c = 0, p-1,
    s1 = (a^2+b^2) % p;
    s2 = (b^2+c^2) % p;
    s3 = (a^2+c^2) % p;
    s4 = (a^2+b^2+c^2) % p;
    if(qr[s1+1] && qr[s2+1] && qr[s3+1] && qr[s4+1], T[a+1, b*p+c+1] = 1);
  )));
  \\ Print row for a = 0 and a = 1, .., (p-1)/2, and a = p-1, ...
  print("p=", p, ": rows of T as multisets");
  for(a = 0, (p-1)/2, sum_a = sum(k=1, p^2, T[a+1, k]); print("  a=", a, " row_sum=", sum_a));
  \\ Test linear independence of distinct rows
  rows = vector((p+1)/2, k, vecextract(T, "..", concat(",", concat(k-1, ".."))));
  \\ Just verify rank again
  print("  rank confirmed: ", matrank(T));
}

investigate(7);
investigate(11);
investigate(19);

\\ Now compute: is there a 4-tensor T_4 : F_p^4 -> F_p that's more interesting?
\\ Consider: T_4(a, b, c, x) = 1 iff (a^2+b^2 = x^2 \and b^2+c^2 = ? \and ...)
\\ Probably too unnatural. Stick with 3-tensor for now.

quit;
