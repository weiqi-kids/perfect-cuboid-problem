\\ =====================================================================
\\ 04_degeneracy_bookkeeping.gp
\\ Confirms that every rational point of C0 (all with T0 in {0, infinity})
\\ pulls back to a DEGENERATE Saunderson brick (some edge = 0).
\\ Run: gp -q 04_degeneracy_bookkeeping.gp
\\ =====================================================================

print("==== Degeneracy of the C0 rational points ====");
print("");
print("C0(Q) = { (T0,S) = (0,+4), (0,-4), inf_+, inf_- }.");
print("");
print("Case T0 = 0:");
print("  T0 = t - 1/t = 0  ==>  t^2 = 1  ==>  t = +-1  ==>  p = +-q.");
print("  Then u = p^2 - q^2 = 0, so a = u(4v^2 - w^2) = 0.  (edge a vanishes)");
\\ numeric check at p=q=1 (t=1):
{
  p=1; q=1;
  u=p^2-q^2; v=2*p*q; w=p^2+q^2;
  a=u*(4*v^2-w^2); b=v*(4*u^2-w^2); c=4*u*v*w;
  print("  numeric p=q=1: (u,v,w)=(",u,",",v,",",w,"), brick (a,b,c)=(",a,",",b,",",c,") -> a=0, degenerate");
}
print("");
print("Case T0 = infinity:");
print("  T0 = t - 1/t = infinity  ==>  t in {0, infinity}  ==>  p = 0 or q = 0.");
print("  If q = 0: v = 2pq = 0, so c = 4uvw = 0 and b = v(...) = 0. (edges vanish)");
print("  If p = 0: u = -q^2, v = 0 again c = 0, b = 0. (edges vanish)");
{
  p=1; q=0;
  u=p^2-q^2; v=2*p*q; w=p^2+q^2;
  a=u*(4*v^2-w^2); b=v*(4*u^2-w^2); c=4*u*v*w;
  print("  numeric p=1,q=0: (u,v,w)=(",u,",",v,",",w,"), brick (a,b,c)=(",a,",",b,",",c,") -> b=c=0, degenerate");
}
print("");
print("Conversely a NON-degenerate Saunderson cuboid needs a,b,c all nonzero,");
print("hence u,v,w all nonzero and u != +-v, i.e. t != 0, +-1, infinity,");
print("equivalently T0 = t - 1/t notin {0, infinity}.  No such point lies on C0(Q).");
print("");
print("==== Sanity: the lifting recovers t from a non-degenerate (W,T0) ====");
\\ Given rational W, T0 with W^2-4 = T0^2, t solves t + 1/t = W and t - 1/t = T0,
\\ so t = (W + T0)/2 is rational.  Check the identity t + 1/t = W algebraically.
{
  \\ symbolic: let t be free, W = t+1/t, T0 = t-1/t; then (W+T0)/2 = t.
  W = t + 1/t; T0c = t - 1/t;
  print("  (W + T0)/2 - t = ", (W + T0c)/2 - t, "   (expect 0: t is recovered rationally)");
}
print("");
print("==== DONE ====");
