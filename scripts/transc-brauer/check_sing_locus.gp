\\ Check the dim of singular locus of V' over Q (and F_p^2).
\\ Jacobian:
\\   [a  b  0  -d   0   0]
\\   [0  b  c   0  -e   0]
\\   [a  0  c   0   0  -f]
\\ Singular locus: rank < 3 AND on V'.
\\
\\ Look at conditions:
\\ Take 3x3 minors of the Jacobian. There are C(6,3)=20 minors.
\\
\\ Let's compute minors symbolically.

J = [a, b, 0, -d, 0, 0;
     0, b, c, 0, -e, 0;
     a, 0, c, 0, 0, -f];

\\ All 3x3 minors of J:
{
  print("Computing 3x3 minors of Jacobian:");
  for(i1 = 1, 4,
    for(i2 = i1+1, 5,
      for(i3 = i2+1, 6,
        my(M = matrix(3, 3, r, c, J[r, [i1,i2,i3][c]]));
        my(d = matdet(M));
        if(d != 0,
          print("cols ", [i1,i2,i3], ": det = ", d);
        );
      )
    )
  );
}

\\ Singular locus is the common zero of all 20 minors.
\\ Looking at det(cols (1,2,3)) = det[a,b,0; 0,b,c; a,0,c] = abc + a*b*c (?)
\\ Computing: a*(b*c - 0) - b*(0 - a*c) + 0 = abc + abc = 2abc.
\\
\\ So one minor is 2abc; for the singular locus to contain a point, need abc=0.
\\ The other minors involve d, e, f. So singular locus is:
\\   abc = 0 AND (other minor conditions involving signs of d,e,f).
\\
\\ Plus the equations Q1=Q2=Q3=0.

\\ Suppose a = 0. Then Q3: c^2 = f^2 => f = ±c. Q1: b^2 = d^2 => d = ±b.
\\ Q2: b^2+c^2 = e^2.
\\ So the locus on V' with a=0 is parametrized by (b, c) with b^2+c^2 = e^2,
\\ d = ±b, f = ±c.
\\ This is 1-dimensional! Not just isolated points.
\\
\\ So V' along {a=0} has a 1-dim Pythagorean curve, but is it singular?
\\
\\ Compute Jacobian at a=0, d=b, e=sqrt(b^2+c^2), f=c:
\\ Row 1: [0, b, 0, -b, 0, 0]
\\ Row 2: [0, b, c, 0, -e, 0]
\\ Row 3: [0, 0, c, 0, 0, -c]
\\ Rank: row 1 is [0,b,0,-b,0,0]. Row 3: [0,0,c,0,0,-c].
\\ Row 2 minus row 1: [0, 0, c, b, -e, 0].
\\ Now rows: [0,b,0,-b,0,0], [0,0,c,b,-e,0], [0,0,c,0,0,-c].
\\ Row 3 - row 2 part: [0,0,0,-b,e,-c]. So rank generically 3.
\\
\\ So actually a curve in V' is "generically smooth" but the Jacobian could
\\ degenerate at special points along the curve.
\\
\\ Hmm, so V' might have MORE singularities — entire curves of singularities,
\\ not just isolated nodes. Let me recount.

print("");
print("Brute force: count singular points over F_3, F_5 — including curves");
{
  forprime(p = 3, 7,
    my(count = 0, ex_list = List());
    for(a = 0, p-1,
      for(b = 0, p-1,
        for(c = 0, p-1,
          for(d = 0, p-1,
            for(e = 0, p-1,
              for(f = 0, p-1,
                if( (a^2+b^2-d^2) % p == 0 &&
                    (b^2+c^2-e^2) % p == 0 &&
                    (a^2+c^2-f^2) % p == 0,
                    if(a||b||c||d||e||f,
                      my(J = Mod([a, b, 0, -d, 0, 0; 0, b, c, 0, -e, 0; a, 0, c, 0, 0, -f], p));
                      if( matrank(J) < 3, count++);
                    );
                );
              )
            )
          )
        )
      )
    );
    print("p=", p, ": ", count, " singular affine pts; projective sing: ", count / (p-1));
  );
}
