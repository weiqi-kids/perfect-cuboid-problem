\\ =====================================================================
\\ 05_scaling_check.gp
\\ Pins the exact scalings T, S in the reduction so the chain is rigorous.
\\ Run: gp -q 05_scaling_check.gp
\\ =====================================================================

print("==== Exact scaling C' : T^2 = octic(t) ====");
\\ Body diagonal: a^2+b^2+c^2 = w^2(w^4+16u^2v^2) = g^2  <=>  (g/w)^2 = w^4+16u^2v^2.
\\ With (u,v,w)=(p^2-q^2,2pq,p^2+q^2):
\\   w^4 + 16 u^2 v^2 = q^8 * octic(t),  t = p/q.
\\ Hence (g/w)^2 = q^8 octic(t).  Set T := (g/w)/q^4 = g/(w q^4).  Then T^2 = octic(t).
{
  uu = p^2-q^2; vv=2*p*q; ww=p^2+q^2;
  bracket = ww^4 + 16*uu^2*vv^2;
  octic = t^8+68*t^6-122*t^4+68*t^2+1;
  print("  w^4+16u^2v^2 - q^8*octic(p/q) = ", subst(bracket,p,t*q) - q^8*octic);
  print("  (expect 0) ==> T := g/(w q^4) satisfies  T^2 = octic(t).  This is C'.");
}

print("");
print("==== Exact scaling C'_pal : S^2 = W^4+64W^2-256 ====");
\\ octic(t)/t^4 = W^4+64W^2-256 with W=t+1/t.  C' becomes
\\   T^2 = t^4 (W^4+64W^2-256), so (T/t^2)^2 = W^4+64W^2-256.  Set S := T/t^2.
{
  octic = t^8+68*t^6-122*t^4+68*t^2+1;
  W = t+1/t;
  print("  octic - t^4*(W^4+64W^2-256) = ", octic - t^4*(W^4+64*W^2-256));
  print("  (expect 0) ==> S := T/t^2 satisfies S^2 = W^4+64W^2-256.");
}

print("");
print("==== End-to-end numeric sanity on a genuine Saunderson value ====");
\\ Take (u,v,w)=(3,4,5) [t determined by p,q with p^2-q^2=3,2pq=4 => p=2,q=1, t=2].
\\ Compute the would-be body diagonal squared and walk the chain.
{
  p=2; q=1; t=p/q;
  uu=p^2-q^2; vv=2*p*q; ww=p^2+q^2;
  brick_a = uu*(4*vv^2-ww^2); brick_b = vv*(4*uu^2-ww^2); brick_c = 4*uu*vv*ww;
  body = brick_a^2+brick_b^2+brick_c^2;
  print("  Saunderson(3,4,5) brick = (", brick_a, ",", brick_b, ",", brick_c, ")");
  print("  a^2+b^2+c^2 = ", body, "  is square : ", issquare(body));
  octval = 2^8+68*2^6-122*2^4+68*2^2+1;
  print("  octic(t=2) = ", octval);
  W = t + 1/t;
  print("  W = t+1/t = ", W, ",  W^4+64W^2-256 = ", W^4+64*W^2-256);
  print("  W^2-4 = ", W^2-4, " = (t-1/t)^2 = ", (t-1/t)^2);
  T0 = t - 1/t;
  print("  T0 = t-1/t = ", T0, ",  T0^4+72T0^2+16 = ", T0^4+72*T0^2+16, " is square : ", issquare(T0^4+72*T0^2+16));
  print("  (this is the NON-degenerate brick (44,117,240); body diagonal is NOT a square,");
  print("   consistent with: the corresponding C0-point would need T0 nonzero, impossible.)");
}
print("");
print("==== DONE ====");
