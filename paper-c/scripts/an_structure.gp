\\ ============================================================
\\ Paper P3: Structure of the Face-3 quantity a_n = c_n^2+1+q^2.
\\ This examines WHETHER the published EDS primitive-divisor
\\ theorems apply directly to a_n. They concern the EDS
\\ denominator B_n of nP; a_n is a different rational function.
\\ Author: CL / Lightman Chang
\\ ============================================================
default(parisize, 3000000000);
default(realprecision, 40);

{
qq = 20/21;
E = ellinit([0, 1+qq^2, 0, qq^2, 0]);
P = [-45/49, 10/343];
print("=== Structure of Face-3 numerator a_n, q=20/21 ===");
print("Compare: EDS denominator B_n (nP = A_n/B_n^2, C_n/B_n^3)");
print("    vs.  Face-3 num(a_n) where a_n = c_n^2 + 1 + q^2.");
print();
for(kk = 1, 6,
  pt = ellmul(E, P, kk);
  xx = pt[1]; yy = pt[2];
  Bn = sqrtint(denominator(xx));   \\ B_n^2 = den(x); B_n = sqrt
  cc = 2*yy*qq/(qq^2 - xx^2);
  aa = cc^2 + 1 + qq^2;
  nm = numerator(aa);
  dn = denominator(aa);
  print("n=", kk, ":");
  print("   EDS B_n (den(x_n)=B_n^2)  = ", Bn);
  print("   a_n = ", aa);
  print("   issquare(a_n)            = ", issquare(aa));
  print("   issquare(num a_n)        = ", issquare(nm));
  print("   issquare(den a_n)        = ", issquare(dn));
  if(kk <= 5,
    print("   num(a_n) factored        = ", factor(nm)~);
  );
);
print();
print("Observation: den(a_n) is a perfect square in every row,");
print("so a_n square <=> num(a_n) square. The non-squareness of");
print("num(a_n) is what must be forced for all n.");
quit;
}
