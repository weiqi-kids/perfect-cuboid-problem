\\ Verify the new algebraic identity (I_2) from Track C:
\\ q² + c² = (q(x²+2x+q²)/(q²-x²))² on E_PCP(q): y² = x(x+1)(x+q²)
\\ Equivalent to: (q²-x²)² + 4y² = (x²+2x+q²)² when restricted to the curve
\\ (since c = 2qy/(q²-x²) gives c² = 4q²y²/(q²-x²)², so q²+c² = q²[(q²-x²)²+4y²]/(q²-x²)²)

print("=== Verify (I_2): (q²-x²)² + 4y² = (x²+2x+q²)² on E_PCP(q) ===");
{
  lhs = (q^2 - x^2)^2 + 4*(x^3 + (1+q^2)*x^2 + q^2*x);
  rhs = (x^2 + 2*x + q^2)^2;
  diff = lhs - rhs;
  print("LHS expanded: ", lhs);
  print("RHS expanded: ", rhs);
  print("Diff (after substituting y² = x³+(1+q²)x²+q²x): ", diff);
  print("Identity holds: ", diff == 0);
}

print();
print("=== Numerical verification on q=20/21, G1=(-45/49, 10/343) ===");
{
  qv = 20/21;
  xv = -45/49;
  yv = 10/343;
  E = ellinit([0, 1+qv^2, 0, qv^2, 0]);
  print("On curve? ", ellisoncurve(E, [xv, yv]));
  cv = 2*qv*yv/(qv^2 - xv^2);
  print("c = ", cv);
  print("q² + c² = ", qv^2 + cv^2);
  rhs_val = (qv*(xv^2 + 2*xv + qv^2)/(qv^2 - xv^2))^2;
  print("RHS (q·A)² = ", rhs_val);
  print("Match: ", qv^2 + cv^2 == rhs_val);
  print();
  \\ Now compute 1 + q² + c² (Face-3)
  F3 = 1 + qv^2 + cv^2;
  print("F3 = 1 + q² + c² = ", F3);
  print("issquare(F3) = ", issquare(F3));
}

print();
print("=== Verify (I_1) + (I_2) joint: (1, q, c) is an Euler brick ===");
\\ Euler brick (a, b, c) needs: a²+b², a²+c², b²+c² all squares.
\\ With (a, b, c) = (1, q, c), this means: 1+q², 1+c², q²+c² all squares.
\\ (I_1) says 1 + c² = (B)² for B = (x²+2q²x+q²)/(q²-x²).
\\ (I_2) says q² + c² = (qA)² for A = (x²+2x+q²)/(q²-x²).
\\ Pythagorean q ⟹ 1 + q² = u² for some u.
\\ Hence (1, q, c) is automatically an Euler brick on E_PCP(q) for Pythagorean q!
\\ The PCP condition is ALSO 1 + q² + c² ∈ Q*² (the space diagonal).

{
  qv = 20/21;
  xv = -45/49;
  yv = 10/343;
  cv = 2*qv*yv/(qv^2 - xv^2);
  d2 = 1 + qv^2;
  e2 = qv^2 + cv^2;
  f2 = 1 + cv^2;
  g2 = 1 + qv^2 + cv^2;
  print("(a, b, c) = (1, q, c) = (1, ", qv, ", ", cv, ")");
  print("a²+b² = 1+q² = ", d2, "  square? ", issquare(d2));
  print("b²+c² = q²+c² = ", e2, "  square? ", issquare(e2));
  print("a²+c² = 1+c² = ", f2, "  square? ", issquare(f2));
  print("a²+b²+c² = ", g2, "  square (= PCP)? ", issquare(g2));
}

quit;
