\\ Compute V' over F_9 directly by enumerating ALL 6-tuples in F_9^6 = 531441 tuples
\\ This is at the edge of feasibility but OK.
\\ Compare to the "smart" count.

p = 3; q = 9;
T = ffinit(p, 2);
x = ffgen(T, 'x);
elems = vector(q);
elems[1] = x*0;
for(i = 1, q-1, elems[i+1] = x^(i-1));

\\ Naive enumeration: ALL 6-tuples
naive_count() = {
  my(N = 0);
  for(ia = 1, q,
    my(A = elems[ia]);
    for(ib = 1, q,
      my(B = elems[ib]);
      for(ic = 1, q,
        my(C = elems[ic]);
        for(id = 1, q,
          my(D = elems[id]);
          for(ie = 1, q,
            my(E = elems[ie]);
            for(iff = 1, q,
              my(F = elems[iff]);
              if( A^2+B^2-D^2 == 0 &&
                  B^2+C^2-E^2 == 0 &&
                  A^2+C^2-F^2 == 0,
                  N++);
            )
          )
        )
      )
    )
  );
  N;
};

\\ Smart count
smart_count() = {
  my(N = 0);
  for(ia = 1, q,
    my(A = elems[ia]);
    for(ib = 1, q,
      my(B = elems[ib]);
      for(ic = 1, q,
        my(C = elems[ic]);
        my(s1 = A^2 + B^2);
        my(s2 = B^2 + C^2);
        my(s3 = A^2 + C^2);
        my(nd, ne, nf);
        nd = if(s1 == 0, 1, if(s1^((q-1)/2) == 1, 2, 0));
        ne = if(s2 == 0, 1, if(s2^((q-1)/2) == 1, 2, 0));
        nf = if(s3 == 0, 1, if(s3^((q-1)/2) == 1, 2, 0));
        N += nd * ne * nf;
      )
    )
  );
  N;
};

print("naive F_9 count: ", naive_count());
print("smart F_9 count: ", smart_count());
