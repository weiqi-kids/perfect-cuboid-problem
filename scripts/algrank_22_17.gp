\\ Try ellrank for (22, 17) at various effort levels.
default(parisize, 4000000000);
default(realprecision, 25);

m=22; n=17;
a = m^2 - n^2; b = 2*m*n;
print("(22,17): a=", a, " b=", b);
E = ellinit([0, a^2+b^2, 0, a^2*b^2, 0]);
Emin = ellminimalmodel(E);
print("Emin coeffs: ", Emin[1..5]);
print("conductor: ", ellglobalred(Emin)[1]);

\\ The 2-Selmer rank bound is what's tractable for high conductors
print();
print("--- Try ellrank effort 0 ---");
r = ellrank(Emin, 0);
print("ellrank(0): ", r);
print();
print("--- Try ellrank effort 1 ---");
r = ellrank(Emin, 1);
print("ellrank(1): ", r);
quit;
