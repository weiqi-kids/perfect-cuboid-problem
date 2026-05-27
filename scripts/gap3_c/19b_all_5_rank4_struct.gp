\\ Structure of all 5 rank-4 fibers
default(parisize, 500000000);
print("=== Structure of 5 rank-4 fibers ===");

fibers = [[99, 28], [118, 25], [174, 83], [176, 63], [181, 38]];
for(i=1, length(fibers), my(pair=fibers[i], m=pair[1], n=pair[2], a, b, u, v, q, E, Em, N, om); m = pair[1]; n = pair[2]; a = m^2-n^2; b = 2*m*n; u = m^2-2*m*n-n^2; v = m^2+2*m*n-n^2; q = a/b; E = ellinit([0, 1+q^2, 0, q^2, 0]); Em = ellminimalmodel(E); N = ellglobalred(Em)[1]; om = omega(N); print("\n(", m, ",", n, "): q=", q, " N=", N); print("  ω(N) = ", om); print("  a=", a, " factors: ", factor(a)); print("  b=", b, " factors: ", factor(b)); print("  u=", u, " factors: ", factor(u)); print("  v=", v, " factors: ", factor(v)); print("  Tamagawa product: ", ellglobalred(Em)[3]));
quit;
