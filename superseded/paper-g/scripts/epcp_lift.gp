\\ Enumerate multiples n*P0 + eps*T0 on E_PCP=160a2 (rank 1) for |n|<=N,
\\ test the Saunderson lifting condition W^2-4 a nonzero rational square,
\\ where W is the x-coordinate. (Point heights grow like n^2, so N is modest.)
E = ellinit([0,1,0,-1,15]);
P0 = [-1,4];
T0 = [-3,0];
N = 300;
cnt = 0; deg = 0; recs = List();
for(n=-N, N, for(eps=0, 1, \
  if(n==0 && eps==0, next); \
  P = ellmul(E, P0, n); \
  if(eps==1, P = elladd(E, P, T0)); \
  if(P == [0], next); \
  W = P[1]; \
  val = W^2 - 4; \
  if(val == 0, deg++; next); \
  if(issquare(val), cnt++; if(cnt<=10, listput(recs, [n, eps, W])))));
print("E_PCP = ", ellidentify(E)[1][1], ", rank ", ellrank(E)[1], ", torsion ", elltors(E)[2]);
print("generator P0 = ", P0, ", canonical height = ", ellheight(E,P0));
print("|n| <= ", N, " (with eps in {0,1}):");
print("  nondegenerate points with W^2-4 a nonzero rational square: ", cnt);
print("  degenerate points (W^2-4 = 0): ", deg);
print("  sample nondeg records [n,eps,W]: ", recs);
