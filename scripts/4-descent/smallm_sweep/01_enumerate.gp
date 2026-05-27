\\ Enumerate primitive Saunderson fibers (m,n) with 1<=n<m<=20, gcd(m,n)=1, m+n odd.
\\ For each fiber:
\\  - compute a = m^2 - n^2, b = 2mn
\\  - bad primes of E_PCP : y^2 = x(x+a^2)(x+b^2)
\\  - the 3-face Hilbert filter status (P,Q)_v, (P,-Q)_v, (-P,Q)_v
\\
\\ Bad primes: E_PCP has 2-torsion (0, -a^2, -b^2). Its discriminant is
\\    16 * (a*b)^2 * (a^2 - b^2)^2 = 16 a^2 b^2 (PQ)^2 (since a^2-b^2 = PQ).
\\ Bad primes thus divide 2 * a * b * |PQ| = 2 * a * b * P * Q.

default(parisize, 800000000);

\\ ---- Hilbert symbol (P,Q) over Q at all bad places.
\\ Returns 1 if locally solvable everywhere, 0 otherwise.
\\ Also returns list of failing places (-1 = infinite).
hilbert_global(P, Q) =
{
  my(badset, ok, fails);
  if(P == 0 || Q == 0, return([0, "zero coefficient"]));
  \\ At infinity: (P,Q)_oo = -1 iff both P<0 and Q<0
  badset = Set();
  if(hilbert(P, Q, 0) < 0, badset = setunion(badset, [-1]));
  \\ Finite primes dividing 2PQ
  my(fac = factor(2 * abs(P) * abs(Q))[,1]);
  for(i = 1, #fac, my(p = fac[i]); if(hilbert(P, Q, p) < 0, badset = setunion(badset, [p])));
  return([#badset == 0, Vec(badset)]);
}

\\ Bad-prime list of E_PCP.
bad_primes_EPCP(a, b) =
{
  my(N = 2 * abs(a) * abs(b) * abs(a^2 - b^2));
  factor(N)[,1];
}

print("=== Primitive Saunderson fibers (1<=n<m<=20, gcd=1, m+n odd) ===");
print();
print("m n | a b | bad_primes | sf(P) sf(Q) | ab bc ac | All3");

count_total = 0;
count_pass = 0;
all_fibers = [];

{
for(m = 2, 20,
  for(n = 1, m - 1,
    if(gcd(m, n) != 1, next);
    if((m + n) % 2 == 0, next);
    count_total = count_total + 1;
    a = m^2 - n^2;
    b = 2 * m * n;
    P = (m+n)^2 - 2*n^2;
    Q = (m-n)^2 - 2*n^2;
    sfP = core(abs(P)) * sign(P);
    sfQ = core(abs(Q)) * sign(Q);
    bad = bad_primes_EPCP(a, b);
    r_ab = hilbert_global(P, Q);
    r_bc = hilbert_global(P, -Q);
    r_ac = hilbert_global(-P, Q);
    pass_ab = r_ab[1]; pass_bc = r_bc[1]; pass_ac = r_ac[1];
    all3 = (pass_ab && pass_bc && pass_ac);
    if(all3, count_pass = count_pass + 1);
    print(m, " ", n, " | ", a, " ", b, " | ", bad, " | ", sfP, " ", sfQ,
          " | ", if(pass_ab,"P","F"), if(pass_bc,"P","F"), if(pass_ac,"P","F"),
          " | ", if(all3,"YES","no"));
    if(all3,
      all_fibers = concat(all_fibers, [[m, n, a, b, P, Q, sfP, sfQ, bad]]);
    );
  );
);
}

print();
print("Total primitive fibers checked: ", count_total);
print("Passed all 3 Hilbert filters: ", count_pass);
print();
print("Survivors:");

{
for(i = 1, #all_fibers, f = all_fibers[i]; print(f));
}

quit;
