/* For nontrivial primes p = 13, 17, 23, 29, ..., examine the structure
   of the nontrivial F_p solutions: are they orbits under some symmetry?
*/

runp(p) = {
  my(qr, hits, hits_by_orbit);
  qr = vector(p, i, 0);
  for(x = 0, p-1, qr[(x^2 % p) + 1] = 1);
  hits = [];
  for(a = 1, p-1, for(b = 1, p-1, for(c = 1, p-1,
    s1 = (a^2+b^2) % p;
    s2 = (b^2+c^2) % p;
    s3 = (a^2+c^2) % p;
    s4 = (a^2+b^2+c^2) % p;
    if(qr[s1+1] && qr[s2+1] && qr[s3+1] && qr[s4+1],
      hits = concat(hits, [[a, b, c]]);
    );
  )));
  print("p=", p, " total nontrivial = ", length(hits));
  print("  first 10 hits: ");
  for(i = 1, min(10, length(hits)), print("    ", hits[i], " sums=(", (hits[i][1]^2+hits[i][2]^2)%p, ",", (hits[i][2]^2+hits[i][3]^2)%p, ",", (hits[i][1]^2+hits[i][3]^2)%p, ",", (hits[i][1]^2+hits[i][2]^2+hits[i][3]^2)%p, ")"));

  \\ Symmetries: (a,b,c) -> (a*k, b*k, c*k) for k in F_p* (scaling)
  \\ Since k^2 multiplies all sums, k^2 must preserve "is-square" property
  \\ which it does (k^2 is a square). So orbit size in scaling is at least p-1 (or 1 if all zero).
  \\
  \\ Symmetries: (a,b,c) -> (-a, b, c) etc.: gives 2^3 = 8.
  \\ Together: (p-1)*8 / [stabilizer] generic orbit size.
  \\ For "generic" point: stabilizer trivial, orbit size 8*(p-1)/|inner action|.

  \\ Group of total signed permutations: 8 * (p-1) / (gcd stab) is order.
  \\
  \\ Other obvious symmetry: (a,b,c) -> (c,b,a) (swap a,c, preserves all four equations)
  \\ This gives orbit size doubled.
  \\
  \\ So expected orbit size: 8 * 2 * (p-1) / |stab|.

  \\ For p=13, expected single orbit size: 16*(p-1) = 16*12 = 192. We have 768/192 = 4 orbits.
  \\ For p=17, 16*16 = 256, total 2304/256 = 9 orbits.
}

runp(13);
runp(17);
runp(23);
quit;
