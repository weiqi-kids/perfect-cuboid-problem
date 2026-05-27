\\ Structural data on (578, 319)
default(parisize, 500000000);

m = 578; n = 319;
print("(m, n) = (", m, ", ", n, ")");
print("gcd(m, n) = ", gcd(m, n));
print("(m+n) mod 2 = ", (m+n) % 2);

print();
print("Pythagorean triple:");
a = m^2 - n^2;
b = 2*m*n;
d = m^2 + n^2;
print("  a = m^2-n^2 = ", a, " = ", factor(a));
print("  b = 2mn = ", b, " = ", factor(b));
print("  d = m^2+n^2 = ", d, " = ", factor(d));
print("  Pythagorean check a^2 + b^2 = d^2: ", a^2 + b^2 == d^2);
print("  gcd(a, b) = ", gcd(a, b), ", gcd(a, d) = ", gcd(a, d), ", gcd(b, d) = ", gcd(b, d));

print();
print("omega values:");
print("  omega(m+n) = omega(", m+n, ") = ", omega(m+n));
print("  omega(m-n) = omega(", m-n, ") = ", omega(m-n));
print("  omega(m^2+n^2) = omega(", m^2+n^2, ") = ", omega(m^2+n^2));
print("  omega(m^2-n^2) = omega(", m^2-n^2, ") = ", omega(m^2-n^2));
print("  omega(mn) = omega(", m*n, ") = ", omega(m*n));
print("  omega sum (m+n)+(m-n)+(m^2+n^2)+(m^2-n^2) = ",
      omega(m+n) + omega(m-n) + omega(m^2+n^2) + omega(m^2-n^2));

q = (m^2-n^2)/(2*m*n);
E = ellinit([0, 1+q^2, 0, q^2, 0]);
Emin = ellminimalmodel(E);
print();
print("E_min conductor = ", ellglobalred(Emin)[1]);
print("E_min disc = ", abs(Emin.disc), " omega(N) = ", omega(ellglobalred(Emin)[1]));
gr = ellglobalred(Emin);
print("Tamagawa products: ", gr);
print("ellrootno(Emin) = ", ellrootno(Emin));

quit;
