/* Verify p = 11 has NO face-triangles */

runp11() = {
  my(p, qr, S, edges, x, y, z, i, j, k, triangles);
  p = 11;
  qr = vector(p, i, 0);
  for(x = 0, p-1, qr[(x^2 % p) + 1] = 1);

  S = [];
  for(x = 1, p-1, if(qr[x+1], S = concat(S, [x])));
  print("Squares in F_11* = ", S);

  edges = [];
  for(i = 1, length(S), for(j = i+1, length(S), x = S[i]; y = S[j]; sm = (x+y)%p; if(qr[sm+1], edges = concat(edges, [[x,y]]))));
  print("Edges in pair-graph (sum of two distinct squares is square): ", edges);
  print("Number of edges: ", length(edges));

  triangles = 0;
  for(i = 1, length(S), for(j = i+1, length(S), for(k = j+1, length(S),
    x = S[i]; y = S[j]; z = S[k];
    if(qr[((x+y)%p)+1] && qr[((y+z)%p)+1] && qr[((x+z)%p)+1],
      triangles = triangles + 1;
      print("  Triangle (", x, ",", y, ",", z, ")");
    );
  )));
  print("Total distinct triangles: ", triangles);

  \\ Also check x=y triangles (a^2=b^2)
  print("\nDiagonal cases (x=y=z): need 2x and 3x square");
  for(i = 1, length(S), x = S[i]; if(qr[((2*x)%p)+1] && qr[((3*x)%p)+1], print("  x=", x, " is PCP candidate")));

  print("\nDouble cases (x, x, z), x != z:");
  for(i = 1, length(S), for(k = 1, length(S),
    if(i == k, next);
    x = S[i]; z = S[k];
    if(qr[((2*x)%p)+1] && qr[((x+z)%p)+1] && qr[((2*x+z)%p)+1],
      print("  (", x, ",", x, ",", z, ") is_pcp=", qr[((2*x+z)%p)+1]);
    );
  ));
}

runp11();
quit;
