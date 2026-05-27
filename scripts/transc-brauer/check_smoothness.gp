\\ Check smoothness of V' over F_p
\\ V' ⊂ P^5, [a:b:c:d:e:f]
\\ Q1 = a^2 + b^2 - d^2
\\ Q2 = b^2 + c^2 - e^2
\\ Q3 = a^2 + c^2 - f^2
\\ Singular <=> rank of Jacobian < 3 at the point.
\\
\\ Partial derivatives (mod 2 = 0, so this fails over char 2):
\\ dQ1/da = 2a, dQ1/db = 2b, dQ1/dd = -2d, others 0
\\ dQ2/db = 2b, dQ2/dc = 2c, dQ2/de = -2e
\\ dQ3/da = 2a, dQ3/dc = 2c, dQ3/df = -2f
\\
\\ Jacobian (mod p, p odd):
\\   [a  b  0  -d  0  0 ]
\\   [0  b  c   0 -e  0 ]
\\   [a  0  c   0  0 -f ]
\\
\\ Rank < 3 means some 3x3 minor vanishes. Singular locus is union of:
\\ - Various coord. hyperplanes.

singular_pts(p) = {
  my(sing = List());
  for(a = 0, p-1,
    for(b = 0, p-1,
      for(c = 0, p-1,
        for(d = 0, p-1,
          for(e = 0, p-1,
            for(f = 0, p-1,
              if( (a^2+b^2-d^2) % p == 0 &&
                  (b^2+c^2-e^2) % p == 0 &&
                  (a^2+c^2-f^2) % p == 0,
                  \\ on V'
                  if( (a||b||c||d||e||f),
                    my(J = Mod([a, b, 0, -d, 0, 0; 0, b, c, 0, -e, 0; a, 0, c, 0, 0, -f], p));
                    if( matrank(J) < 3,
                        listput(sing, [a,b,c,d,e,f]);
                    );
                  );
              );
            )
          )
        )
      )
    )
  );
  sing;
}

{
  forprime(p = 3, 7,
    my(s = singular_pts(p));
    print("p=", p, ": ", #s, " singular affine pts (incl. cone over P^5 sing)");
    if(#s > 0 && #s < 30,
      for(i=1, #s, print("  ", s[i]));
    );
  );
}
