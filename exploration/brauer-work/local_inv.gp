/* ==========================================================================
   Local invariant calculator for quaternion algebras (P,Q)_p over Q_p
   restricted to V(Q_p) for the cuboid variety V.

   Strategy: parametrize V(Q_p) by triples of Pythagorean triples + space
   diagonal. Use 2-adic structure constraints.

   The 'Hilbert symbol' hilbert(a,b,p) returns +1 if (a,b)_p splits, -1 else.
   We map: +1 -> 0 (in Q/Z), -1 -> 1/2.

   Convention: a candidate Brauer class is given as a "symbol"
     A(a,b,c,d,e,f,g) = (P, Q) where P,Q are functions in 7 variables.
   ========================================================================== */

\\ Inv at p of (a,b) = 0 if hilbert(a,b,p)=1 else 1/2
inv_p(a,b,p) = if(hilbert(a,b,p)==1, 0, 1/2);

\\ Test that local invariants behave sensibly
print("Inv test: (2,5) at p=2 = ", inv_p(2,5,2));     \\ should be 1/2 (5 not norm from Q_2(sqrt 2))
print("Inv test: (3,5) at p=2 = ", inv_p(3,5,2));     \\ should be 0 (both odd, residue class)
print("Inv test: (2,3) at p=2 = ", inv_p(2,3,2));     \\ should be 1/2
print("Inv test: (1,*) at p=2 = ", inv_p(1,7,2));     \\ should be 0 (trivial)

\\ Sum-vanishing reciprocity test: For any rational a,b: sum of inv_p over all p = 0.
test_reciprocity(a,b) = {
  my(s = 0, plist);
  plist = concat([2], factor(abs(a*b))[,1]~);
  plist = vecsort(Set(plist));
  for(i=1, #plist, s += inv_p(a,b,plist[i]));
  \\ Plus infinity place if needed
  if(a<0 && b<0, s += 1/2);
  \\ Reduce mod 1
  s = s - floor(s);
  s;
}

print();
print("Reciprocity test (should be 0): ", test_reciprocity(2,5));
print("Reciprocity test (should be 0): ", test_reciprocity(3,5));
print("Reciprocity test (should be 0): ", test_reciprocity(7,13));
print("Reciprocity test (should be 0): ", test_reciprocity(-1,2));

\\ Symbol manipulator: a quaternion algebra (P,Q) restricted to a point P0=(a0,...g0)
\\ gives a value over Q_p. Compute the local invariant.

\\ Test on a known Euler brick (44, 117, 240): is this in V(Q_p) for all p, with sup
\\ space diag? Compute g = sqrt(a^2+b^2+c^2)
verify_eulerbrick(a,b,c) = {
  my(d2,e2,f2,g2,d,e,f);
  d2 = a^2+b^2; e2 = b^2+c^2; f2 = a^2+c^2; g2 = a^2+b^2+c^2;
  print("(",a,",",b,",",c,"): d2=",d2," issqr=",issquare(d2),
        ", e2=",e2," issqr=",issquare(e2),
        ", f2=",f2," issqr=",issquare(f2),
        ", g2=",g2," issqr=",issquare(g2));
}
verify_eulerbrick(44,117,240);
verify_eulerbrick(240,252,275);

\\ For an Euler brick with non-square g^2, we have a Q-point of V_part
\\ (the face system), and a Q_p-point of V (full) when g^2 happens to be a
\\ square in Q_p.

\\ For the brick (44, 117, 240): g^2 = 44^2+117^2+240^2 = 73225 = 5^2 * 29 * 101
\\ So g = sqrt(73225) = 5 sqrt(2929)
print();
print("44^2+117^2+240^2 = ", 44^2+117^2+240^2, " = ", factor(73225));
print("240^2+252^2+275^2 = ", 240^2+252^2+275^2, " = ", factor(240^2+252^2+275^2));
