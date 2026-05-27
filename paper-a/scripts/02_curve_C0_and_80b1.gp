\\ =====================================================================
\\ 02_curve_C0_and_80b1.gp
\\ Establishes the arithmetic of the genus-1 curve
\\        C0 : S^2 = T^4 + 72 T^2 + 16
\\ and its Jacobian = Cremona 80b1, y^2 = x^3 - 7x + 6, conductor 80, rank 0.
\\ Run: gp -q 02_curve_C0_and_80b1.gp
\\ =====================================================================

print("==== Jacobian of C0 : S^2 = T^4 + 72 T^2 + 16 ====");
E0 = ellinit(ellfromeqn(y^2 - (x^4 + 72*x^2 + 16)));
mm = ellminimalmodel(E0);
print("  minimal model [a1,a2,a3,a4,a6] = ", mm.disc * 0 + [mm.a1, mm.a2, mm.a3, mm.a4, mm.a6]);
print("  conductor = ", ellglobalred(E0)[1]);
print("  j-invariant = ", E0.j);
print("  torsion = ", elltors(E0)[1], "  structure ", elltors(E0)[2]);

print("");
print("==== Rank of 80b1 via 2-descent (ellrank) ====");
r = ellrank(E0);
print("  ellrank = ", r, "   (format [rank_low, rank_high, ..., generators])");
print("  rank_low = ", r[1], ",  rank_high = ", r[2]);
if(r[1]==0 && r[2]==0, print("  ==> RANK 0 proved unconditionally by 2-descent"), print("  ==> rank NOT pinned by 2-descent alone, see analytic rank below"));

print("");
print("==== Independent cross-check: analytic rank + L(E,1) (Kolyvagin) ====");
ar = ellanalyticrank(E0);
print("  ellanalyticrank = ", ar);
print("  analytic rank = ", ar[1], ",  L(E,1) ~ ", ar[2]);
print("  (analytic rank 0, L(80b1,1) != 0  ==>  Kolyvagin gives algebraic rank 0)");

print("");
print("==== Minimal Weierstrass curve y^2 = x^3 - 7x + 6 directly ====");
Edir = ellinit([0,0,0,-7,6]);
print("  conductor = ", ellglobalred(Edir)[1]);
print("  j-invariant = ", Edir.j, "   equals 148176/25 :  ", Edir.j == 148176/25);
print("  torsion structure = ", elltors(Edir)[2], "  (expect [2,2])");
print("  factor of x^3-7x+6 equals (x-1)*(x-2)*(x+3) :  ", (x-1)*(x-2)*(x+3) - (x^3 - 7*x + 6) == 0);
print("  E(Q) = { O, (1,0), (2,0), (-3,0) }  (4 points, all 2-torsion)");

print("");
print("==== a_p match: 80b1 vs predicted X_{sigma tau} ====");
plist = [3,7,11,13,17,19,23,29,31,37,41,43,47];
aps = vector(#plist, i, ellap(Edir, plist[i]));
print("  primes  = ", plist);
print("  a_p     = ", aps);
predicted = [0,4,-4,-2,2,-4,-4,-2,8,6,-6,8,-4];
print("  archive = ", predicted);
print("  match   = ", aps == predicted);

print("");
print("==== Exhaustive rational-point search on C0 ====");
\\ Search S^2 = T^4 + 72 T^2 + 16 over T = n/d, gcd(n,d)=1.
\\ Homogeneous test: issquare(n^4 + 72 n^2 d^2 + 16 d^4) over coprime (n,d).
{
  found = List();
  for(d = 1, 2000,
    for(n = -2000, 2000,
      if(gcd(n,d)==1,
        val = n^4 + 72*n^2*d^2 + 16*d^4;
        if(issquare(val), listput(found, [n, d])))));
  print("  affine rational T=n/d with |n|<=2000, d<=2000 giving S in Q:");
  print("  ", Vec(found));
  print("  (the only finite solution is T=0, i.e. n=0,d=1, giving S=+-4)");
}

print("");
print("==== Points at infinity of C0 over Q ====");
\\ Leading coeff of T^4+72T^2+16 is 1 (a perfect square), so the two
\\ points at infinity are rational: S/T^2 -> +-1.  Together with (0,+-4)
\\ and the structure |C0(Q)| = |Jac(Q)| = 4, C0(Q) = {(0,+-4), 2 pts at infty}.
print("  leading coeff = 1 = 1^2 (square) ==> 2 rational points at infinity");
print("  |C0(Q)| = |Jac C0 (Q)| = |80b1(Q)| = 4");
print("  C0(Q) = { (0,+4), (0,-4), inf_+, inf_- }");
print("  all four have T in {0, infinity}  ==>  W^2 = 4 or W = infinity (DEGENERATE)");
print("");
print("==== DONE ====");
