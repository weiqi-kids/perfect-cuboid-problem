/* Refined analysis: count triples (x, y, z) in S^3 where:
   (1) all three pair sums x+y, y+z, x+z are in S \cup {0}, AND
   (2) sum x+y+z is in S \cup {0}, AND
   (3) all FOUR sums are NONZERO (i.e., not in {0}).
   This corresponds to "fully nontrivial" points in (a^2, b^2, c^2) coordinates.
*/

analyzePrimeV2(p) = {
  my(qr, S, full_ok_nonzero, x, y, z, i, j, k);
  qr = vector(p, i, 0);
  for(x = 0, p-1, qr[(x^2 % p) + 1] = 1);
  S = [];
  for(x = 1, p-1, if(qr[x+1], S = concat(S, [x])));
  full_ok_nonzero = 0;
  for(i = 1, length(S), for(j = i, length(S), for(k = j, length(S),
    x = S[i]; y = S[j]; z = S[k];
    s_xy = (x+y)%p;
    s_yz = (y+z)%p;
    s_xz = (x+z)%p;
    s_xyz = (x+y+z)%p;
    if(s_xy != 0 && s_yz != 0 && s_xz != 0 && s_xyz != 0 &&
       qr[s_xy+1] && qr[s_yz+1] && qr[s_xz+1] && qr[s_xyz+1],
      full_ok_nonzero = full_ok_nonzero + 1;
    );
  )));
  print("p=", p, " squares*=", length(S), " unordered (x,y,z) all conditions all-nonzero squares: ", full_ok_nonzero);
}

forprime(p = 3, 100, analyzePrimeV2(p));
quit;
