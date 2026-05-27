\\ Verify how to get F_q^* generator.

p = 5; q = 25;
T = ffinit(p, 2);
print("T = ", T);
x = ffgen(T, 'x);
print("x = ", x);
print("x^12 = ", x^12);
print("x^24 = ", x^24);
print("x^(24/2) = ", x^12);

\\ Use ffprimroot to find a primitive root of F_q
g = ffprimroot(x);
print("ffprimroot(x) = ", g);
print("g^12 = ", g^12);
print("g^24 = ", g^24);
