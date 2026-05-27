\\ Verify the hit g=86173, a=30940, b=79920, d=85700
g = 86173;
a = 30940;
b = 79920;
d = 85700;
print("a^2 + b^2 = ", a^2 + b^2);
print("d^2       = ", d^2);
print("Equal? ", a^2 + b^2 == d^2);
print("");
print("g = ", g, " = ", factor(g));
print("a = ", a, " = ", factor(a));
print("b = ", b, " = ", factor(b));
print("d = ", d, " = ", factor(d));
print("");
\\ Check: a^2 + e^2 = g^2 ?
e2 = g^2 - a^2;
print("g^2 - a^2 = ", e2, " is square? ", issquare(e2));
if(issquare(e2), e = sqrtint(e2); print("e = ", e, " = ", factor(e)));
print("");
f2 = g^2 - b^2;
print("g^2 - b^2 = ", f2, " is square? ", issquare(f2));
if(issquare(f2), f = sqrtint(f2); print("f = ", f, " = ", factor(f)));
print("");
\\ d^2 + c^2 = g^2 ?
c2 = g^2 - d^2;
print("g^2 - d^2 = ", c2, " is square? ", issquare(c2));
if(issquare(c2), c = sqrtint(c2); print("c = ", c, " = ", factor(c)));
print("");
\\ Now PCP check
if(issquare(g^2 - a^2) && issquare(g^2 - b^2) && issquare(g^2 - d^2),
  e = sqrtint(g^2 - a^2);
  f = sqrtint(g^2 - b^2);
  c = sqrtint(g^2 - d^2);
  print("a, b, c, d, e, f, g = ", a, ", ", b, ", ", c, ", ", d, ", ", e, ", ", f, ", ", g);
  print("a^2+b^2 = ", a^2+b^2, "  d^2 = ", d^2, "  eq? ", a^2+b^2==d^2);
  print("b^2+c^2 = ", b^2+c^2, "  e^2 = ", e^2, "  eq? ", b^2+c^2==e^2);
  print("a^2+c^2 = ", a^2+c^2, "  f^2 = ", f^2, "  eq? ", a^2+c^2==f^2);
  print("a^2+b^2+c^2 = ", a^2+b^2+c^2, "  g^2 = ", g^2, "  eq? ", a^2+b^2+c^2==g^2);
);

quit;
