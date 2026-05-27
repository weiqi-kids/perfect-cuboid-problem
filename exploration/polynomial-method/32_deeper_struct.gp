/* For each strong-obstruction prime p, identify WHICH constraint forces obstruction:
   - face-graph has no triangle? (p in P_face)
   - face-graph has triangles but space-diagonal fails? (p in P_space)
   - both happen?
*/

analyzePrime(p) = {
  my(qr, S, edges, triangles, face_only_ok, full_ok);
  qr = vector(p, i, 0);
  for(x = 0, p-1, qr[(x^2 % p) + 1] = 1);
  S = [];
  for(x = 1, p-1, if(qr[x+1], S = concat(S, [x])));

  \\ Build pair-graph
  edges = [];
  for(i = 1, length(S), for(j = i+1, length(S),
    x = S[i]; y = S[j];
    if(qr[((x+y)%p)+1], edges = concat(edges, [[x,y]]));
  ));

  \\ Count triangles (including x=y degenerate via "self-edge" 2x square)
  triangles = 0;
  face_only_ok = 0;
  full_ok = 0;
  for(i = 1, length(S), for(j = i, length(S), for(k = j, length(S),
    x = S[i]; y = S[j]; z = S[k];
    \\ Triangle: all 3 face conditions
    if(qr[((x+y)%p)+1] && qr[((y+z)%p)+1] && qr[((x+z)%p)+1],
      triangles = triangles + 1;
      face_only_ok = face_only_ok + 1;
      \\ Now check space-diagonal: also x+y+z is a square
      if(qr[((x+y+z)%p)+1], full_ok = full_ok + 1);
    );
  )));

  print("p=", p, " squares*=", length(S), " edges=", length(edges), " triangles=", triangles, " full_ok=", full_ok,
        if(full_ok == 0, "  (PCP-OBSTRUCTED)", "  (allows PCP residues)"));
}

\\ Run on first 20 primes
forprime(p = 3, 100, analyzePrime(p));
quit;
