/* Step 6: Elliptic Chabauty at rank 1 — the key reduction-mod-p argument.
 *
 * E_Hm has good reduction at p ∈ {11, 13, 17, 23} and |E_Hm(F_p)| = 16 = |T| at all of these.
 * Therefore the rank-1 generator G reduces to torsion mod p.
 * Therefore E_Hm(Q) reduces to a subset of T mod p.
 *
 * For each such p, enumerate E_Hm(F_p) and identify which points have s = -Q/x a non-zero square in F_p
 * (and x ≠ 0, x ≠ infinity).
 *
 * If at SOME such p the only s-square points are the 3 known branch ones (s = X1, X2, X3 in F_p), then
 * any Q ∈ E_Hm(Q) with s(Q) ∈ Q^2 must reduce to one of the 3 branches mod p — and since reduction is INJECTIVE
 * on E_tors at good p, Q itself is one of the 3 branch torsion points.
 */

m = 63; n = 38;
a = m^2 - n^2;   X2 = a^2;
b = 2*m*n;       X3 = b^2;
dab = m^2 + n^2; X1 = dab^2;
S = X1+X2+X3; P = X1*X2 + X1*X3 + X2*X3; Q = X1*X2*X3;
print("Q (= X1 X2 X3) factor: ", factor(Q));

for(pk=1, 4, \
  p = [11, 13, 17, 23][pk]; \
  print(); \
  print("=== Prime p = ", p, " ==="); \
  print("X1 mod p = ", X1 % p, "   (branch 1)"); \
  print("X2 mod p = ", X2 % p, "   (branch 2)"); \
  print("X3 mod p = ", X3 % p, "   (branch 3)"); \
  Ep = ellinit([0, P, 0, Q*S, Q^2] * Mod(1, p)); \
  card = ellcard(Ep); \
  print("|E(F_p)| = ", card); \
  ptsFp = ellgroup(Ep, p, 1); \
  print("group structure = ", ptsFp[1]); \
  \
  \\ Enumerate all 16 points
  allpts = List(); \
  listput(allpts, [0]); \
  for(xv=0, p-1, \
    rhs = xv^3 + P*xv^2 + Q*S*xv + Q^2; \
    r = Mod(rhs, p); \
    if(issquare(r), \
      sq = lift(sqrt(r)); \
      if(sq == 0, listput(allpts, [xv, 0]), \
        listput(allpts, [xv, sq]); \
        listput(allpts, [xv, p - sq])))); \
  print("enumerated total points (with O) = ", length(allpts)); \
  \
  \\ Now for each non-identity, non-x=0 point check if s = -Q/x is a non-zero square mod p
  sqcount = 0; \
  branches_seen = 0; \
  nonbranch_seen = 0; \
  for(i=2, length(allpts), \
    pt = allpts[i]; \
    xx = pt[1]; \
    if(xx % p == 0, next); \
    s_mod = Mod(-Q, p) / Mod(xx, p); \
    if(s_mod == 0, next); \
    if(issquare(s_mod), \
      sqcount += 1; \
      s_val = lift(s_mod); \
      if(s_val == (X1 % p) || s_val == (X2 % p) || s_val == (X3 % p), \
        branches_seen += 1; \
        print("  branch:  x=", xx, "  y=", pt[2], "  s mod p = ", s_val), \
        nonbranch_seen += 1; \
        print("  NON-branch:  x=", xx, "  y=", pt[2], "  s mod p = ", s_val)))); \
  print("Total points with non-zero s-square: ", sqcount, "   branches: ", branches_seen, "   non-branch: ", nonbranch_seen));
