\\ =====================================================================
\\ 03_EPCP_and_hyperell.gp
\\ (a) E_PCP : Jacobian of S^2 = W^4 + 64 W^2 - 256, conductor 160, rank 1.
\\ (b) hyperellratpoints independent confirmation of C0(Q).
\\ (c) Saunderson-membership of small primitive Euler bricks.
\\ Run: gp -q 03_EPCP_and_hyperell.gp
\\ =====================================================================

print("==== E_PCP : Jacobian of S^2 = W^4 + 64 W^2 - 256 ====");
EP = ellinit(ellfromeqn(y^2 - (x^4 + 64*x^2 - 256)));
mmP = ellminimalmodel(EP);
print("  minimal model = ", [mmP.a1, mmP.a2, mmP.a3, mmP.a4, mmP.a6]);
print("  conductor = ", ellglobalred(EP)[1]);
print("  j-invariant = ", EP.j, "   equals -64/25 :  ", EP.j == -64/25);
print("  torsion structure = ", elltors(EP)[2]);
arP = ellanalyticrank(EP);
print("  analytic rank = ", arP[1], ",  L'(E,1) ~ ", arP[2]);
rP = ellrank(EP);
print("  ellrank = ", rP, "   (rank_low=", rP[1], ", rank_high=", rP[2], ")");
print("  (analytic rank 1 ==> Kolyvagin gives algebraic rank exactly 1)");

print("");
print("==== Independent confirmation of C0(Q) via hyperellratpoints ====");
\\ hyperellratpoints expects the quartic; search bound 10^4.
pts = hyperellratpoints(x^4 + 72*x^2 + 16, 10^4);
print("  hyperellratpoints(T^4+72T^2+16, 10^4) = ", pts);
print("  (affine rational points; [0,4] and [0,-4] are the only finite ones)");

print("");
print("==== Saunderson-membership test for small primitive Euler bricks ====");
\\ A brick (a,b,c) is 'Saunderson form' if there is a primitive Pythagorean
\\ (u,v,w), u^2+v^2=w^2, with {a,b,c} = {u(4v^2-w^2), v(4u^2-w^2), 4uvw}
\\ up to permutation and sign/scaling.  We test the canonical small bricks.
issaund(brick, BND) = {my(a, b, c, g1, prim, w, cand, g2, candprim); a=brick[1]; b=brick[2]; c=brick[3]; g1=gcd(gcd(a,b),c); prim=Set([a/g1,b/g1,c/g1]); for(u=1, BND, for(v=u+1, BND, if(gcd(u,v)==1 && issquare(u^2+v^2), w=sqrtint(u^2+v^2); cand=[abs(u*(4*v^2-w^2)), abs(v*(4*u^2-w^2)), abs(4*u*v*w)]; g2=gcd(gcd(cand[1],cand[2]),cand[3]); candprim=Set([cand[1]/g2, cand[2]/g2, cand[3]/g2]); if(prim==candprim, return([u,v,w]))))); return(0);}
bricks = [[44,117,240], [85,132,720], [140,480,693], [160,231,792], [240,252,275]];
names  = ["(44,117,240)         ","(85,132,720)         ","(140,480,693)        ","(160,231,792)        ","(240,252,275) Halcke "];
for(i=1, #bricks, my(res = issaund(bricks[i], 60)); if(res==0, print("  ", names[i], " : NOT Saunderson form (search u,v up to 60)"), print("  ", names[i], " : Saunderson(u,v,w)=", res)));
print("");
print("  ==> only (44,117,240)=Saunderson(3,4,5); the rest (incl. Halcke) are non-Saunderson");
print("  ==> Saunderson family is a strict, small subfamily of all Euler bricks");
print("");
print("==== DONE ====");
