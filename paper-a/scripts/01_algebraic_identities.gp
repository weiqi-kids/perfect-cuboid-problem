\\ =====================================================================
\\ 01_algebraic_identities.gp
\\ Verifies the algebraic reduction steps 1-3 of the Saunderson chain
\\ symbolically as polynomial identities over Q.
\\ Run: gp -q 01_algebraic_identities.gp
\\ =====================================================================

print("==== STEP 1: Saunderson body-diagonal identity ====");
\\ Saunderson brick: a = u(4v^2 - w^2), b = v(4u^2 - w^2), c = 4 u v w,
\\ where (u,v,w) is a Pythagorean triple: u^2 + v^2 = w^2.
\\ Claim:  a^2 + b^2 + c^2 = w^2 (w^4 + 16 u^2 v^2)   modulo  w^2 - u^2 - v^2.
{
  a = u*(4*v^2 - w^2);
  b = v*(4*u^2 - w^2);
  c = 4*u*v*w;
  lhs = a^2 + b^2 + c^2;
  rhs = w^2*(w^4 + 16*u^2*v^2);
  \\ reduce modulo the Pythagorean relation w^2 = u^2 + v^2
  diff = lhs - rhs;
  \\ substitute w^2 -> u^2 + v^2 everywhere by working in Q[u,v] with w^2=u^2+v^2.
  \\ Replace w^2 by (u^2+v^2): do it as a polynomial reduction.
  red = subst(diff, w, sqrt(u^2+v^2));  \\ symbolic; we will square-check instead
}
\\ Robust check: substitute a genuine parametric Pythagorean triple
\\ (u,v,w) = (p^2-q^2, 2pq, p^2+q^2) and verify the identity as a
\\ polynomial identity in Q[p,q].
{
  uu = p^2 - q^2; vv = 2*p*q; ww = p^2 + q^2;
  A = uu*(4*vv^2 - ww^2);
  B = vv*(4*uu^2 - ww^2);
  C = 4*uu*vv*ww;
  LHS = A^2 + B^2 + C^2;
  RHS = ww^2*(ww^4 + 16*uu^2*vv^2);
  print("  a^2+b^2+c^2 - w^2(w^4+16u^2v^2)  (in Q[p,q]) = ", LHS - RHS);
  print("  (expect 0)");
}

print("");
print("==== STEP 2: reduction to the genus-3 octic ====");
\\ With (u,v,w)=(p^2-q^2, 2pq, p^2+q^2):
\\   a^2+b^2+c^2 = w^2 (w^4 + 16 u^2 v^2).
\\ PCP body-diagonal condition a^2+b^2+c^2 = g^2 becomes
\\   (g/w)^2 = w^4 + 16 u^2 v^2.
\\ Compute w^4 + 16 u^2 v^2 as a polynomial in p,q and factor out q^8;
\\ set t = p/q. Claim: w^4 + 16 u^2 v^2 = q^8 (t^8+68 t^6-122 t^4+68 t^2+1).
{
  uu = p^2 - q^2; vv = 2*p*q; ww = p^2 + q^2;
  bracket = ww^4 + 16*uu^2*vv^2;
  \\ divide by q^8 and substitute p = t*q
  scaled = subst(bracket, p, t*q) / q^8;
  octic = t^8 + 68*t^6 - 122*t^4 + 68*t^2 + 1;
  print("  (w^4+16u^2v^2)/q^8 |_{p=tq} - octic = ", scaled - octic);
  print("  (expect 0)  ==>  T^2 = t^8+68t^6-122t^4+68t^2+1,  T = g/(w q^4)?? check scaling");
  \\ note: g/w = sqrt(bracket); with bracket = q^8 * octic, set T = g/(w q^4)
  \\ then T^2 = octic.  This is curve C'.
}

print("");
print("==== STEP 3: palindromic substitution W = t + 1/t ====");
\\ Claim: (t^8+68t^6-122t^4+68t^2+1)/t^4 = W^4 + 64 W^2 - 256, W = t+1/t.
{
  octic = t^8 + 68*t^6 - 122*t^4 + 68*t^2 + 1;
  reduced = octic / t^4;             \\ Laurent polynomial in t
  W = t + 1/t;
  target = W^4 + 64*W^2 - 256;
  print("  octic/t^4 - (W^4+64W^2-256) = ", reduced - target);
  print("  (expect 0)  ==>  S^2 = W^4+64W^2-256,  S = T/t^2");
}

print("");
print("==== STEP 3b: lifting identity  W^2 - 4 = (t - 1/t)^2 ====");
{
  W = t + 1/t;
  print("  (W^2 - 4) - (t - 1/t)^2 = ", (W^2 - 4) - (t - 1/t)^2);
  print("  (expect 0)  ==>  W^2-4 is a rational square whenever t is rational");
}

print("");
print("==== STEP 4: substitution W^2 = T0^2 + 4 into S^2=W^4+64W^2-256 ====");
\\ Lifting condition: W^2 - 4 = T0^2  (T0 = t - 1/t).  So W^2 = T0^2 + 4.
\\ Substitute into S^2 = W^4 + 64 W^2 - 256 = (W^2)^2 + 64 W^2 - 256.
{
  Wsq = T0^2 + 4;
  result = Wsq^2 + 64*Wsq - 256;
  target = T0^4 + 72*T0^2 + 16;
  print("  (W^2)^2+64W^2-256 |_{W^2=T0^2+4} - (T0^4+72T0^2+16) = ", result - target);
  print("  (expect 0)  ==>  C0 : S^2 = T0^4 + 72 T0^2 + 16");
}

print("");
print("==== Discriminant cross-check (PICK-19 quadruple route) ====");
\\ Independent route: s^2 - 16 r(r^2-1) s - (r^2+1)^4 = 0 has discriminant
\\   D(r) = 256 r^2 (r^2-1)^2 + 4 (r^2+1)^4 = 4 (r^8+68r^6-122r^4+68r^2+1).
{
  D = 256*r^2*(r^2-1)^2 + 4*(r^2+1)^4;
  octr = 4*(r^8 + 68*r^6 - 122*r^4 + 68*r^2 + 1);
  print("  D(r) - 4*octic(r) = ", D - octr);
  print("  (expect 0)  -- confirms the two derivation routes meet at the same octic");
}
print("");
print("==== ALL ALGEBRAIC IDENTITIES VERIFIED (each diff above must be 0) ====");
