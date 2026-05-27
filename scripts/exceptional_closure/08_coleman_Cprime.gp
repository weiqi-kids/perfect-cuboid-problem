default(parisize,800000000);
default(parisizemax,1200000000);

\\ Coleman-Chabauty feasibility on genus-3 C': T^2 = f(t), f=t^8+68t^6-122t^4+68t^2+1.
\\ rank J(C') = 2 < 3 = genus  (verified in 07: E_PCP rk1 twice + X_st=80a rk0).
\\ Coleman bound at a prime p of good reduction:
\\   |C'(Q)| <= #C'(F_p) + 2*genus - 2  (Coleman 1985, for p > 2g, rank < g),
\\ more precisely with the Chabauty-Coleman refinement |C(Q)| <= #C(F_p) + (2g-2) when p>2g.
\\ We compute #C'(F_p) for several good p and report the bound + the known rational points.

fpval(t,p) = {
  my(v = (t^8+68*t^6-122*t^4+68*t^2+1) % p);
  ((v % p) + p) % p;
}
countCp(p) = {
  my(cnt=0);
  for(tt=0,p-1, cnt += 1 + kronecker(fpval(tt,p),p));
  cnt + 2;   \\ + 2 points at infinity (leading coeff 1 = square)
}

print("=== Coleman-Chabauty on genus-3 Saunderson C' (rank J = 2 < 3) ===");
print("Known rational points on C' (Saunderson doc): (t,T) in {(0,+-1),(+-1,+-4)} -> all degenerate.");
print();
print("p (good, p>6) | #C'(F_p) | Coleman bound #C(F_p)+2g-2 = +4");
{
my(g=3);
foreach([7,11,13,17,19,23], p,
  if(p % 2 == 0 || p == 5, next);
  my(N = countCp(p));
  print("p=",p," | #C'(F_p)=",N," | Coleman bound <= ", N + 2*g - 2);
);
}
print();
print("Min over p gives the sharpest finite Coleman bound on |C'(Q)|.");
print("This bound is SIGMA-FREE (depends only on rank J(C')=2<3, not on Szpiro).");
