m = 63; n = 38;
a = m^2 - n^2;   X2 = a^2;
b = 2*m*n;       X3 = b^2;
dab = m^2 + n^2; X1 = dab^2;
S = X1+X2+X3; P = X1*X2 + X1*X3 + X2*X3; QQ = X1*X2*X3;
E = ellinit([0, P, 0, QQ*S, QQ^2]);
BR1 = -X1*X2; BR2 = -X1*X3; BR3 = -X2*X3;
print("Branch x: ", BR1, ", ", BR2, ", ", BR3);

\\ Build enumerated F_p points as list of [x, y].
enum_pts(p) = my(L=List(), rhs, r, sq); listput(L, [-1, -1]); for(xv = 0, p-1, rhs = (xv^3 + P*xv^2 + QQ*S*xv + QQ^2) % p; r = Mod(rhs, p); if(issquare(r), sq = lift(sqrt(r)); if(sq == 0, listput(L, [xv, 0]), listput(L, [xv, sq]); listput(L, [xv, p-sq])))); L;

\\ Process one pt: returns 0 = ignored, 1 = branch with -x QR, 2 = non-branch with -x QR
classify_pt(pt, p, brmod) = my(xx, negx); xx = pt[1]; if(xx == 0, return(0)); negx = Mod(-xx, p); if(negx == 0, return(0)); if(!issquare(negx), return(0)); if(xx == brmod[1] || xx == brmod[2] || xx == brmod[3], return(1), return(2));

run(p) = my(brmod, L, totalQR, branchcnt, nonbrcnt, c); brmod = [(BR1 % p), (BR2 % p), (BR3 % p)]; print(); print("=== p = ", p, " ===  branch x mod p = ", brmod); L = enum_pts(p); print("|E(F_p)| = ", length(L)); totalQR = 0; branchcnt = 0; nonbrcnt = 0; for(i = 2, length(L), c = classify_pt(L[i], p, brmod); if(c == 1, branchcnt += 1; totalQR += 1; print("  branch: x=", L[i][1], "  y=", L[i][2])); if(c == 2, nonbrcnt += 1; totalQR += 1; print("  NON-branch -x QR: x=", L[i][1], "  y=", L[i][2]))); print("==> total -x QR: ", totalQR, "   branches: ", branchcnt, "   non-branch: ", nonbrcnt);

run(11);
run(13);
run(17);
run(23);
run(29);
run(37);
run(41);
run(43);
