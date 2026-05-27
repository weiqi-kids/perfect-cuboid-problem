default(parisize,800000000);
default(parisizemax,1200000000);

cntFp(p) = {
  my(c=0, v);
  for(tt=0, p-1,
    v = (tt^8 + 68*tt^6 - 122*tt^4 + 68*tt^2 + 1) % p;
    c = c + 1 + kronecker(v, p);
  );
  c + 2;
}

{
  my(g=3, r=2, myps, best=10^9, bestp=0, p, N, cb, ok2g, sb);
  print("=== Coleman-Chabauty bound on |C'(Q)|, genus g=3, rank r=2 ===");
  print("Bad primes of C': {2,5}. Good primes p>=3, p!=5.");
  print("Coleman 1985 (p>2g=6): |C(Q)| <= #C(F_p)+2g-2 = #C(F_p)+4.");
  print("");
  print("p | #C'(F_p) | Coleman #C+2g-2 | p>2g? | (#C+2r form)");
  myps = [3,7,11,13,17,19,23,29,31,37,41,43];
  for(i=1, length(myps),
    p = myps[i];
    if(p==5, next);
    N = cntFp(p);
    cb = N + 2*g - 2;
    ok2g = (p > 2*g);
    sb = N + 2*r;
    print(p, " | ", N, " | ", cb, " | ", ok2g, " | ", sb);
    if(ok2g && cb < best, best = cb; bestp = p);
  );
  print("");
  print("Sharpest rigorous Coleman bound (p>6, #C+2g-2): |C'(Q)| <= ", best, " at p=", bestp);
  print("Known C'(Q) points = 8 (6 affine + 2 infinity).");
}
