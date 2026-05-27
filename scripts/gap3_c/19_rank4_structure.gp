\\ Analyze structure of the 2 rank-4 fibers: (99,28) and (118,25).
default(parisize, 500000000);
print("=== Structural analysis of rank-4 fibers ===");

\\ For each, compute:
\\ - the four prime factors a, b, m^2+2mn-n^2, m^2-2mn-n^2 = u, v
\\ - conductor's prime factorization
\\ - Tamagawa numbers
\\ - 2-isogeny class graph

fibers = [[99, 28], [118, 25]];

for(i=1, length(fibers), my(pair=fibers[i], m=pair[1], n=pair[2], a, b, u, v, q, E, Em, N, fctN, tama_data); m = pair[1]; n = pair[2]; a = m^2 - n^2; b = 2*m*n; u = m^2 - 2*m*n - n^2; v = m^2 + 2*m*n - n^2; q = a/b; print("\n=== (m,n) = (", m, ",", n, ") ==="); print("a = m^2-n^2 = ", a, " = ", factor(a)); print("b = 2mn = ", b, " = ", factor(b)); print("u = m^2-2mn-n^2 = ", u, " = ", factor(u)); print("v = m^2+2mn-n^2 = ", v, " = ", factor(v)); print("q = ", q); print("1+q^2 = ", 1+q^2, " = (m^2+n^2)^2/(2mn)^2 = ", (m^2+n^2)^2/(2*m*n)^2); E = ellinit([0, 1+q^2, 0, q^2, 0]); Em = ellminimalmodel(E); N = ellglobalred(Em)[1]; fctN = factor(N); print("Conductor N = ", N); print("Factorization: ", fctN); print("omega(N) = ", omega(N)); print("Tamagawa numbers (from elllocalred per prime):"); for(j=1, matsize(fctN)[1], my(p=fctN[j,1], lr); lr = elllocalred(Em, p); print("  p=", p, ":  Kodaira=", lr[2], " c_p=", lr[4])); print("c(p) product = ", ellglobalred(Em)[3]));
quit;
