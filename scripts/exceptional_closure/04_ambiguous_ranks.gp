\\ Resolve the [0,2] ambiguous fibers (s=17,33,43) with deeper ellrank + point search.
\\ Also compute analytic rank parity via ellrootno (cheap) to pin parity.
default(parisize,800000000);
default(parisizemax,1200000000);

print("=== Resolving ambiguous [0,2] fibers s=17,33,43 (t=1) ===");
resolve(s) = {
  my(t=1, m=s^2-2*s*t+2*t^2, n=2*s*t, a=m^2-n^2, b=2*m*n, q=a/b);
  my(E=ellinit([0,1+q^2,0,q^2,0]));
  my(Em=ellminimalmodel(E));
  my(w = ellrootno(Em));   \\ global root number: -1 => odd rank, +1 => even
  print("(",s,",1) q=",a,"/",b);
  print("   root number w=",w," => ", if(w==-1,"ODD rank (>=1)","EVEN rank (0 or 2)"));
  \\ deeper ellrank effort
  my(rr);
  iferr(rr=ellrank(Em,4); print("   ellrank(eff=4) -> [",rr[1],",",rr[2],"], gens found: ",#rr[4]), e, print("   ellrank eff=4 SKIP"));
  \\ try to find any non-torsion point by direct search on Em via ellratpoints (height bound)
  iferr(my(pts=ellratpoints(Em,200)); print("   ellratpoints(H=200): ",#pts," affine pts (incl torsion)"), e, print("   ellratpoints SKIP"));
}
resolve(17);
resolve(33);
resolve(43);
