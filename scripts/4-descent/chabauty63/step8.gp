m = 63; n = 38;
a = m^2 - n^2;   X2 = a^2;
b = 2*m*n;       X3 = b^2;
dab = m^2 + n^2; X1 = dab^2;
S = X1+X2+X3; P = X1*X2 + X1*X3 + X2*X3; QQ = X1*X2*X3;
E = ellinit([0, P, 0, QQ*S, QQ^2]);
print("disc primes = ", factor(abs(E.disc))[,1]);

\\ Try point search at progressively higher heights.
print("ellratpoints H = 10^7:");
pts = ellratpoints(E, 10^7);
print("found ", length(pts), " pts");
for(k=1, length(pts), print(pts[k]));

print();
print("ellratpoints H = 10^8:");
pts = ellratpoints(E, 10^8);
print("found ", length(pts), " pts");
for(k=1, length(pts), print(pts[k]));
