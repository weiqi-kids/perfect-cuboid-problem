\\ Sanity check: count #(x in F_9 : x is a square).
\\ Should be (q-1)/2 = 4 nonzero squares + 0 itself = 5 squares.

p = 3; q = 9;
T = ffinit(p, 2);
x = ffgen(T, 'x);
elems = vector(q);
elems[1] = x*0;
for(i = 1, q-1, elems[i+1] = x^(i-1));

print("Elements of F_9: ");
for(i = 1, q, print("  ", i, ": ", elems[i]));

\\ Squares
sq_test() = {
  my(c0 = 0, c2 = 0, c_other = 0);
  for(i = 1, q,
    if(elems[i] == 0, c0++,
      if(elems[i]^((q-1)/2) == 1, c2++, c_other++);
    );
  );
  [c0, c2, c_other]
};

print("Square count [zero, nonzero square, non-square]: ", sq_test());

\\ Now: count y^2 = s for fixed s = 1
\\ s = 1 nonzero square -> 2 solutions for y.
\\ s = x (a non-square, since x is generator of F_9^*)? x^4 = 1, so x^4 = 1, x^((q-1)/2)=x^4=1. So x IS a square.
\\ Actually F_9^* is cyclic of order 8. Squares = {1, x^2, x^4, x^6}.

\\ For each s in F_9, count #{y : y^2 = s} directly
for(i = 1, q,
  my(s = elems[i], cnt = 0);
  for(j = 1, q, if(elems[j]^2 == s, cnt++));
  print("s = ", s, " -> # square roots: ", cnt);
);
