\\ Task 2c: q = 60/11 (rank 2) — iterate both generators and combinations
default(parisize, 2000000000);

{
q = 60/11;
a2 = 1 + q^2; a4 = q^2;
E = ellinit([0, a2, 0, a4, 0]);
Emin = ellminimalmodel(E, &v);
print("v = ", v);

\\ Generators on Emin (from earlier ellrank)
G1_min = [-185, 9745];
G2_min = [-515, 7270];

\\ Verify on Emin
print("G1 on Emin? ", ellisoncurve(Emin, G1_min));
print("G2 on Emin? ", ellisoncurve(Emin, G2_min));

\\ Map back to original E
G1 = ellchangepointinv(G1_min, v);
G2 = ellchangepointinv(G2_min, v);
print("G1 on E: ", G1, " — onE? ", ellisoncurve(E, G1));
print("G2 on E: ", G2, " — onE? ", ellisoncurve(E, G2));

print("h(G1) on E: ", ellheight(E, G1));
print("h(G2) on E: ", ellheight(E, G2));

print();
print("=== Iterate (a, b) generator combinations, |a|, |b| <= 4 ===");
print();

\\ For a rank-2 curve, we want to scan combinations aG1 + bG2 for small a, b
\\ Total: ~9x9 = 81 combos (minus identity and double-counted)

for(a = -4, 4,
  for(b = -4, 4,
    if(a == 0 && b == 0, next);
    \\ Compute aG1 + bG2 on E
    P = ellmul(E, G1, a);
    Q = ellmul(E, G2, b);
    R = elladd(E, P, Q);
    if(R == [0],
      print("(a=", a, ", b=", b, "): R = O");
      next;
    );
    Tn = R[1]; Yn = R[2];
    denom = q^2 - Tn^2;
    if(denom == 0,
      print("(a=", a, ", b=", b, "): pole");
      next;
    );
    cn = 2 * Yn * q / denom;
    an = cn^2 + 1 + q^2;
    valnum = numerator(an);
    valden = denominator(an);
    is_sq = issquare(valnum) && issquare(valden);
    print("(a=", a, ", b=", b, "): is_sq=", is_sq, ", digits(num)=", #Str(valnum));
    if(is_sq,
      print("  !!! a_n IS a rational square !!!");
      print("  a_n = ", an);
      print("  c_n = ", cn);
      print("  R = ", R);
    );
  );
);

print();
print("===== End rank-2 fiber (q = 60/11) =====");
}
