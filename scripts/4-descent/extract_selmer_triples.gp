\\ Extract Selmer triples (d1, d2, d3) from cover quartics.
\\ For E: y^2 = (x-e1)(x-e2)(x-e3), Selmer class is (d1, d2, d3) in (Q*/Q*^2)^3
\\ with d1 d2 d3 in Q*^2. The cover is y^2 = q(x), and:
\\   q(e1) = d1 * (e1-e2)(e1-e3) * square  (mod squares: d1 with sign correction)
\\ Actually: for the standard cover C_alpha,
\\   q(x) := d1 * d2 * ((x-e1)/d1)^... Let's just compute q(e_i) and factor.

default(parisize, 1000000000);
default(realprecision, 38);

read("/root/proof/perfect-cuboid-problem/scripts/4-descent/EHm_short_data.gp");

E_short = ellinit([0, A2_short, 0, A4_short, A6_short]);
e1 = e1_short;
e2 = e2_short;
e3 = e3_short;

\\ Verify these are the 2-torsion roots
print("Verifying 2-torsion roots:");
print("  (X^3 + X^2 + a4*X + a6) at e1 = ", e1^3 + A2_short*e1^2 + A4_short*e1 + A6_short);
print("  (X^3 + X^2 + a4*X + a6) at e2 = ", e2^3 + A2_short*e2^2 + A4_short*e2 + A6_short);
print("  (X^3 + X^2 + a4*X + a6) at e3 = ", e3^3 + A2_short*e3^2 + A4_short*e3 + A6_short);
print();

print("Differences:");
print("  e2 - e1 = ", e2 - e1, " = ", factor(e2 - e1));
print("  e3 - e1 = ", e3 - e1, " = ", factor(e3 - e1));
print("  e3 - e2 = ", e3 - e2, " = ", factor(e3 - e2));
print();

\\ Get covers
covers = ell2cover(E_short);
print("Number of covers: ", #covers);
print();

\\ For each cover q(x), evaluate q(e_i) and squarefree-ize
\\ The squarefree part of q(e_i) gives d_i' = d_j * d_k = (-d_i) mod squares
\\   (since d1 d2 d3 is square, d_j d_k ≡ d_i^-1 ≡ d_i mod squares)

\\ Squarefree kernel of an integer
{ sqf_kernel(n) =
  my(f, s);
  if(n == 0, return(0));
  s = sign(n);
  f = factor(abs(n));
  for(i = 1, matsize(f)[1],
    if(f[i, 2] % 2 == 0, f[i, 2] = 0, f[i, 2] = 1);
  );
  s * factorback(f);
}

\\ Bad primes
BAD = [2, 3, 5, 7, 11, 19, 23, 31, 61, 223, 337, 1033];

\\ Encode a squarefree integer as a vector over F_2 indexed by BAD plus sign
{ encode_sqf(n, primes) =
  my(v, k, p, e);
  if(n == 0, error("zero"));
  v = vector(#primes + 1);   \\ first entry is sign
  v[1] = if(n < 0, 1, 0);
  n = abs(n);
  for(k = 1, #primes,
    p = primes[k];
    e = 0;
    while(n % p == 0, n = n / p; e += 1);
    v[k+1] = e % 2;
  );
  if(n != 1, error(strprintf("residual prime: %d", n)));
  v;
}

\\ For each cover, compute (q(e1), q(e2), q(e3)) squarefree
print("===========================================");
print("Selmer triples per cover:");
print("===========================================");
{
selmer_triples = vector(#covers);
for(k = 1, #covers,
  q_k = covers[k][1];
  v1 = subst(q_k, 'x, e1);
  v2 = subst(q_k, 'x, e2);
  v3 = subst(q_k, 'x, e3);
  sv1 = sqf_kernel(v1);
  sv2 = sqf_kernel(v2);
  sv3 = sqf_kernel(v3);
  print();
  print("Cover #", k, ":");
  print("  q(e1) = ", v1);
  print("  q(e2) = ", v2);
  print("  q(e3) = ", v3);
  print("  sqf(q(e1)) = ", sv1, "   factored ", if(sv1!=0, factor(abs(sv1)), 0));
  print("  sqf(q(e2)) = ", sv2, "   factored ", if(sv2!=0, factor(abs(sv2)), 0));
  print("  sqf(q(e3)) = ", sv3, "   factored ", if(sv3!=0, factor(abs(sv3)), 0));
  \\ Encode via F_2 vectors
  enc1 = encode_sqf(sv1, BAD);
  enc2 = encode_sqf(sv2, BAD);
  enc3 = encode_sqf(sv3, BAD);
  print("  F_2 encoding of (sqf q(e1)) over [sign,2,3,5,7,11,19,23,31,61,223,337,1033]: ", enc1);
  print("  F_2 encoding of (sqf q(e2)): ", enc2);
  print("  F_2 encoding of (sqf q(e3)): ", enc3);
  selmer_triples[k] = [sv1, sv2, sv3];
);
}

print();
print("===========================================");
print("Summary table of (sqf q(e1), sqf q(e2), sqf q(e3)):");
print("===========================================");
for(k = 1, #covers,
  print("  C", k, ": ", selmer_triples[k]);
);

\\ Save for Phase G
fname = "/root/proof/perfect-cuboid-problem/scripts/4-descent/EHm_selmer_triples.txt";
write(fname, "Selmer triples (sqf q(e1), sqf q(e2), sqf q(e3)) per cover:");
for(k = 1, #covers,
  write(fname, "C", k, ": ", selmer_triples[k]);
);

quit;
