\\ Verify F_{p^2} counting for p=3
\\ Should agree with direct enumeration using polynomials.

p = 3;
q = 9;

\\ Build F_9 explicitly
T = ffinit(p, 2);
x = ffgen(T, 'x);

\\ Element list
elems = vector(q);
elems[1] = x*0;
for(i = 1, q-1, elems[i+1] = x^(i-1));

\\ All elements
print("Elements of F_9: ", elems);
print("");

\\ Verify squareness check
sq_count = 0;
for(i = 1, q,
  if(elems[i] != 0,
    if(elems[i]^((q-1)/2) == 1, sq_count++);
  )
);
print("Nonzero squares in F_9: ", sq_count, " (should be (q-1)/2 = 4)");

\\ Now count V'(F_9):
\\ For each (a,b,c) in F_9^3, count #{(d,e,f) : eqns hold}.
N = 0;
for(ia = 1, q,
  A = elems[ia];
  for(ib = 1, q,
    B = elems[ib];
    for(ic = 1, q,
      C = elems[ic];
      s1 = A^2 + B^2;
      s2 = B^2 + C^2;
      s3 = A^2 + C^2;
      nd = if(s1 == 0, 1, if(s1^((q-1)/2) == 1, 2, 0));
      ne = if(s2 == 0, 1, if(s2^((q-1)/2) == 1, 2, 0));
      nf = if(s3 == 0, 1, if(s3^((q-1)/2) == 1, 2, 0));
      N += nd * ne * nf;
    )
  )
);
print("Affine count V'_sing(F_9): ", N);
print("Projective: ", (N - 1)/(q - 1));
print("With resolution: ", (N-1)/(q-1) + 12*q);
