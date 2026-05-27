/* Verify for p = 19 */

runp19() = {
  my(p, qr, S, edges, x, y, z, i, j, k, triangles, ssum, is_pcp);
  p = 19;
  qr = vector(p, i, 0);
  for(x = 0, p-1, qr[(x^2 % p) + 1] = 1);

  S = [];
  for(x = 1, p-1, if(qr[x+1], S = concat(S, [x])));
  print("Squares in F_19* = ", S);

  edges = [];
  for(i = 1, length(S), for(j = i+1, length(S), x = S[i]; y = S[j]; sm = (x+y)%p; if(qr[sm+1], edges = concat(edges, [[x,y]]))));
  print("Edges in pair-graph: ", edges);
  print("Number of edges: ", length(edges));

  print("\nTriangles (x, y, z) with all pair sums squares (or 0):");
  triangles = 0;
  for(i = 1, length(S), for(j = i+1, length(S), for(k = j+1, length(S),
    x = S[i]; y = S[j]; z = S[k];
    if(qr[((x+y)%p)+1] && qr[((y+z)%p)+1] && qr[((x+z)%p)+1],
      triangles = triangles + 1;
      ssum = (x+y+z) % p;
      is_pcp = qr[ssum+1];
      print("  Triangle (", x, ",", y, ",", z, ") face_sums=(", (x+y)%p, ",", (y+z)%p, ",", (x+z)%p, ") space_sum=", ssum, " is_pcp=", is_pcp);
    );
  )));
  print("Total triangles with distinct x<y<z: ", triangles);

  print("\nDiagonal cases (a^2 = b^2 = c^2): need 2x and 3x squares.");
  for(i = 1, length(S), x = S[i]; if(qr[((2*x)%p)+1] && qr[((3*x)%p)+1], print("  x=", x, " is PCP candidate")));

  print("\nDouble cases (x, x, z), x != z, x in S, z in S:");
  for(i = 1, length(S), for(k = 1, length(S),
    if(i == k, next);
    x = S[i]; z = S[k];
    if(qr[((2*x)%p)+1] && qr[((x+z)%p)+1] && qr[((2*x+z)%p)+1],
      print("  (x,x,z)=(", x, ",", x, ",", z, ") face_sums=(", (2*x)%p, ",", (x+z)%p, ",", (x+z)%p, ") space_sum=", (2*x+z)%p, " is_pcp=", qr[((2*x+z)%p)+1]);
    );
  ));
}

runp19();
quit;
