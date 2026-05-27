/* Direct slice-rank computation for the PCP indicator.
   The tensor T : F_p^3 -> F_p, T(a,b,c) = 1 if (a,b,c) is in A_p, else 0.
   View as 3-tensor with each axis = F_p of size p.
   Slice-rank = min over (i,j,k) partitions ... but for 3-tensor:
     sr(T) = min(rk(M_1), rk(M_2), rk(M_3))?? No:
     sr(T) is min number of terms in T = sum_i u_i o M_i where each term factors with one axis-aligned vector u_i.
   But there's a useful bound: sr(T) <= rk_a (T) where rk_a is rank of the "flattening" along axis a.
   In fact sr(T) = min over axes a of rk_a(T) is FALSE in general; the correct relation is more subtle.
   For our purposes, we can compute the matrix-rank of the flattenings to get upper bounds.

   Flattening along axis 1: matrix M_1 of size p x p^2 where M_1[a][b*p+c] = T(a,b,c).
   Then rk(M_1) = number of linearly independent "a-slices" of T.
   Similar for axes 2 and 3.

   Slice-rank satisfies: sr(T) <= rk(M_a) for ANY axis a.
   And sr(T) >= max(...?) actually sr is more subtle.

   For diagonal tensor T(x,y,z) = 1 if x=y=z in D, 0 else: sr(T) = |D|.
   Each flattening has rank |D|.

   For our T, supported on A_p, the natural diagonal interpretation:
     T(x, x, x) = 1 if x in A_p. Off-diagonal T(x,y,z) = 0?? No: our T is just T(a,b,c) = 1_{(a,b,c) in A_p}.
   This is NOT diagonal in the slice-rank sense; it's a single function on a 3-axis tensor space where each axis is F_p (not F_p^3).
   So we have rank-1 issue: T has rank-1 slices along axis a iff T(a, b, c) = f(a) g(b,c) for some f, g.

   Compute matrix rank of T flattenings:
*/

\\ Build T as p x p x p tensor (a x b x c)
buildTensor(p) = {
  my(T, qr);
  qr = vector(p, i, 0);
  for(x = 0, p-1, qr[(x^2 % p) + 1] = 1);
  T = matrix(p, p^2, a, k, 0);  \\ flattening 1: row indexed by a, col by b*p + c
  for(a = 0, p-1, for(b = 0, p-1, for(c = 0, p-1,
    s1 = (a^2+b^2) % p;
    s2 = (b^2+c^2) % p;
    s3 = (a^2+c^2) % p;
    s4 = (a^2+b^2+c^2) % p;
    if(qr[s1+1] && qr[s2+1] && qr[s3+1] && qr[s4+1], T[a+1, b*p+c+1] = 1);
  )));
  return(T);
}

\\ For each prime p, compute matrix ranks of the three flattenings.
\\ By symmetry of PCP (a <-> c not exact, but b in middle), flattenings 1 and 3 are equal.
\\ Flattening 2 differs.

\\ Note: rank is over what field? Use F_p.
\\ matrank computes over Q; for F_p use Mod.

testflat(p) = {
  my(T, M1, M2, M3);
  T = buildTensor(p);
  \\ M1: row a, col (b,c)
  M1 = T;
  \\ M2: row b, col (a,c)
  M2 = matrix(p, p^2, b, k, 0);
  for(a = 0, p-1, for(b = 0, p-1, for(c = 0, p-1, M2[b+1, a*p+c+1] = T[a+1, b*p+c+1])));
  \\ M3: row c, col (a,b)
  M3 = matrix(p, p^2, c, k, 0);
  for(a = 0, p-1, for(b = 0, p-1, for(c = 0, p-1, M3[c+1, a*p+b+1] = T[a+1, b*p+c+1])));
  \\ Convert to Mod
  M1p = matrix(p, p^2, i, j, Mod(M1[i,j], p));
  M2p = matrix(p, p^2, i, j, Mod(M2[i,j], p));
  M3p = matrix(p, p^2, i, j, Mod(M3[i,j], p));
  r1 = matrank(M1p);
  r2 = matrank(M2p);
  r3 = matrank(M3p);
  \\ Also rank over Q
  r1q = matrank(M1);
  r2q = matrank(M2);
  r3q = matrank(M3);
  print("p=", p, " ranks (over F_p): r_a=", r1, " r_b=", r2, " r_c=", r3, " | (over Q): ", r1q, " ", r2q, " ", r3q);
}

testflat(3);
testflat(5);
testflat(7);
testflat(11);
testflat(13);
testflat(17);
testflat(19);
quit;
