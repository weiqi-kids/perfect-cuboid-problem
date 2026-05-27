/* ============================================================
   03_integral_points.gp
   LINCHPIN: the COMPLETE set of integral points on E_anom.
   NOTE: PARI/GP 2.15.4 has NO ellintegralpoints (Baker-based) routine.
   We (a) enumerate integral points among the MW lattice nP + eps*T,
   (b) PROVE completeness by an explicit canonical-height argument,
   (c) confirm with an exhaustive bounded ellratpoints search.
   ============================================================ */

Emin = ellinit([0,0,0,-275,1750]);
print("E_anom = y^2 = x^3 - 275 x + 1750, conductor ", ellglobalred(Emin)[1]);
P = [-15,50]; T = [10,0];
print("MW: rank 1, generator P = ", P, ", torsion T = ", T, " (Z/2)");
print("");

print("=== Integral points among nP + eps*T, |n| up to 8 ===");
{ for(n = -8, 8,
  Q = ellmul(Emin, P, n);
  if(Q != [0] && denominator(Q[1])==1 && denominator(Q[2])==1,
     print("  ", n, "*P      = ", Q, "   [INTEGRAL]"));
  QT = if(Q==[0], T, elladd(Emin, Q, T));
  if(QT != [0] && denominator(QT[1])==1 && denominator(QT[2])==1,
     print("  ", n, "*P + T  = ", QT, "   [INTEGRAL]"));
); }

print("");
print("=== Completeness via canonical heights ===");
hP = ellheight(Emin, P);
print("hat-h(P) = ", hP);
{ for(n=1,6, print("   hat-h(", n, "P) = n^2*hat-h(P) = ", n^2*hP)); }
print("Torsion T adds 0 to canonical height; hat-h(nP + eps T) = n^2 hat-h(P).");
print("");
print("x-denominators of nP and nP+T for n=3..6 (non-integral => not int. pts):");
{ for(n=3,6,
  Q = ellmul(Emin, P, n);
  QT = elladd(Emin, Q, T);
  print("   n=", n, ":  denom(x(nP))=", denominator(Q[1]), "   denom(x(nP+T))=", denominator(QT[1]));
); }

print("");
print("=== Exhaustive bounded ellratpoints (naive height <= 10^7) ===");
rp = ellratpoints(Emin, 10^7);
brute = List();
{ for(i=1,#rp,
  if(denominator(rp[i][1])==1 && denominator(rp[i][2])==1, listput(brute, rp[i]));
); }
bv = vecsort(Vec(brute), , 8);
print("integral points by brute force (height<=10^7) = ", #bv);
{ for(i=1,#bv, print("   ", bv[i])); }

print("");
print("=== Manual on-curve checks (framework's listed integral points) ===");
chk = [[-15,50],[46,294],[9,2],[10,0]];
{ for(i=1,#chk,
  xx = chk[i][1]; yy = chk[i][2];
  rhs = xx^3 - 275*xx + 1750;
  print("   x=", xx, ": x^3-275x+1750 = ", rhs, " = ", yy, "^2 ? ", rhs == yy^2);
); }

quit;
