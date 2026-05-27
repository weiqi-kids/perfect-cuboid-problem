\\ Check: for the rank-3 generators, does c lift to a perfect cuboid?
\\ A perfect cuboid (a,b,c) has all 7 of:
\\   sqrt(a^2+b^2), sqrt(a^2+c^2), sqrt(b^2+c^2), sqrt(a^2+b^2+c^2) all rational.
\\ Recall q = a/b. So we have a, b, q rational, and need c so that:
\\   a^2 + c^2 = square,  b^2 + c^2 = square,  a^2 + b^2 + c^2 = square.
\\ Since (a,b) is Pythagorean we have a^2 + b^2 = (m^2+n^2)^2 (already a square).
\\ Then 4 conditions to check given c.

is_square(x) = my(s); if(x < 0, return(0)); s = sqrtint(numerator(x)*denominator(x)); s^2 == numerator(x)*denominator(x);

check_cuboid(a, b, c) = {
  my(d_ab = a^2 + b^2, d_ac = a^2 + c^2, d_bc = b^2 + c^2, d_abc = a^2 + b^2 + c^2);
  print("    a^2+b^2 = ", d_ab, " sq? ", is_square(d_ab));
  print("    a^2+c^2 = ", d_ac, " sq? ", is_square(d_ac));
  print("    b^2+c^2 = ", d_bc, " sq? ", is_square(d_bc));
  print("    a^2+b^2+c^2 = ", d_abc, " sq? ", is_square(d_abc));
};

{
\\ q = 195/748 case
m = 22; n = 17;
A = m^2 - n^2;  \\ 195
B = 2*m*n;       \\ 748
print("=== Pyth triple (a, b) = (", A, ", ", B, ") for q = a/b = ", A/B, " ===");
print();

c_vals = [52/165, -135/352, -144/17];
for(j = 1, #c_vals,
  c = c_vals[j];
  print("c = ", c, " (gen ", j, "):");
  check_cuboid(A, B, c);
  print();
);

\\ Also note: the PCP formulation might use a different scaling: (a,b,c) with q = a/b vs q = a^2/b^2 etc.
\\ Let's also try with c interpreted as c/b (so absolute c = c_val * b) and as c (absolute).
\\ Standard formulation: q = a/b, "c" coordinate on phi is in same scale; so try absolute c directly.
}

quit;
