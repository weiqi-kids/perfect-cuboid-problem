/* Local obstruction analysis at higher prime powers and p=2.
   For p=2: check (a,b,c) mod 2, 4, 8.
   For p in trivial set, check mod p^2.
*/

\\ Check (a,b,c) mod 2: total of 2^3 = 8 cases, find those with all 4 sums being squares mod 2,4,...

check_mod_m(m) = {
  my(qr, hits);
  qr = vector(m, i, 0);
  for(x = 0, m-1, qr[(x^2 % m)+1] = 1);
  hits = 0;
  for(a = 0, m-1, for(b = 0, m-1, for(c = 0, m-1,
    s1 = (a^2+b^2) % m;
    s2 = (b^2+c^2) % m;
    s3 = (a^2+c^2) % m;
    s4 = (a^2+b^2+c^2) % m;
    if(qr[s1+1] && qr[s2+1] && qr[s3+1] && qr[s4+1],
      \\ Print first few
      if(hits < 20, print("  m=", m, " (a,b,c)=(", a, ",", b, ",", c, ")"));
      hits = hits + 1;
    );
  )));
  print("m=", m, " : total = ", hits);
}

print("Mod 2:"); check_mod_m(2);
print("Mod 4:"); check_mod_m(4);
print("Mod 8:"); check_mod_m(8);
print("Mod 16:"); check_mod_m(16);
quit;
