\\ =====================================================================
\\ 15_hilbert_217_24.gp -- Compute Hilbert symbols for (217, 24)
\\ Verify our structural conditions C1, C2 produce the right count
\\ =====================================================================

default(parisize, 1500000000);

sf(x) = if(x == 0, 0, my(s = sign(x), a = abs(x), f = factor(a)); s * prod(i=1, matsize(f)[1], f[i,1]^(f[i,2]%2)));

m = 217; n = 24;
print("(m, n) = (", m, ", ", n, ")");
print("q = ", (m^2 - n^2)/(2*m*n));
P = (m+n)^2 - 2*n^2;
Q = (m-n)^2 - 2*n^2;
R = sf(P * Q);
print("P = ", P, " = ", factor(P));
print("Q = ", Q, " = ", factor(Q));
print("R = sf(P*Q) = ", R, " = ", factor(R));
print("ω(R) = ", omega(abs(R)));
print();
print("Heron set H(m,n) (primes):");
{
H = List();
for(k=1, 8,
  v = [m, n, m+n, abs(m-n), m^2+n^2, m^2-n^2, P, Q][k];
  if(abs(v) > 1, listput(H, factor(abs(v))[,1]~));
);
H = vecsort(Set(concat(Vec(H))));
print("  H = ", H, "  |H| = ", #H);
}

print();
print("Conductor primes of E_PCP(", m, ",", n, "):");
{
q = (m^2 - n^2)/(2*m*n);
E = ellinit([0, 1+q^2, 0, q^2, 0]);
Em = ellminimalmodel(E);
N = ellglobalred(Em)[1];
SN = factor(N)[,1]~;
print("  N(E_min) = ", N);
print("  ω(N) = ", #SN, " primes = ", SN);
print();
\\ Sample Hilbert symbol calculation: (-R, R)_p
print("Hilbert symbols at conductor primes (sanity):");
print("  p     (-R, R)_p    (-1, R)_p");
for(i=1, #SN,
  p = SN[i];
  print("  ", p, "    ", hilbert(-R, R, p), "         ", hilbert(-1, R, p));
);
print("  ∞     ", hilbert(-R, R, 0), "         ", hilbert(-1, R, 0));
}

quit;
