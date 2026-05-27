\\ Test the formula: q(e_i) ≡ d_i * (e_i - e_j)(e_i - e_k) mod Q*^2
\\ for ell2cover output.

default(parisize, 1000000000);
default(realprecision, 38);

read("/root/proof/perfect-cuboid-problem/scripts/4-descent/EHm_short_data.gp");
E_short = ellinit([0, A2_short, 0, A4_short, A6_short]);
e1 = e1_short; e2 = e2_short; e3 = e3_short;
covers = ell2cover(E_short);

BAD = [2, 3, 5, 7, 11, 19, 23, 31, 61, 223, 337, 1033];

\\ Squarefree mod BAD plus extra: returns [sign, e_2, e_3, ..., e_1033, EXTRA_bit]
\\ Accepts rationals: multiplies by square of denominator first.
{ sqf_bad(n) =
  my(v, k, p, e, nn, num, den);
  if(n == 0, return("zero"));
  num = numerator(n);
  den = denominator(n);
  \\ Rational n ≡ num*den mod squares (multiply by den^2/den = den)
  n = num * den;
  v = vector(#BAD + 2);
  v[1] = if(n < 0, 1, 0);
  nn = abs(n);
  for(k = 1, #BAD,
    p = BAD[k];
    e = 0;
    while(nn % p == 0, nn = nn / p; e += 1);
    v[k+1] = e % 2;
  );
  v[#BAD+2] = if(issquare(nn), 0, 1);
  v;
}

\\ Convert a squarefree integer to its representative in BAD (with sign)
{ canon_sqf(n) =
  my(v, k, p, e, nn, result, sign_part);
  if(n == 0, return(0));
  sign_part = sign(n);
  nn = abs(n);
  result = 1;
  for(k = 1, #BAD,
    p = BAD[k];
    e = 0;
    while(nn % p == 0, nn = nn / p; e += 1);
    if(e % 2 == 1, result *= p);
  );
  \\ Check residual is a square
  if(!issquare(nn), error(strprintf("non-bad prime in residual: %d", nn)));
  sign_part * result;
}

\\ For each cover, evaluate q(e_i) and divide by (e_i - e_j)(e_i - e_k):
print("===========================================");
print("Testing q(e_i) / [(e_i - e_j)(e_i - e_k)] mod Q*^2:");
print("===========================================");
{
results = vector(#covers);
for(k = 1, #covers,
  q = covers[k][1];
  d1_raw = subst(q, 'x, e1) / ((e1 - e2) * (e1 - e3));
  d2_raw = subst(q, 'x, e2) / ((e2 - e1) * (e2 - e3));
  d3_raw = subst(q, 'x, e3) / ((e3 - e1) * (e3 - e2));
  \\ These are integers (multiply through). Compute squarefree mod bad.
  print();
  print("Cover #", k);
  print("  d1_raw = q(e1)/(e1-e2)(e1-e3) = ", d1_raw);
  print("  d2_raw = q(e2)/(e2-e1)(e2-e3) = ", d2_raw);
  print("  d3_raw = q(e3)/(e3-e1)(e3-e2) = ", d3_raw);
  print("  sqf(d1) = ", sqf_bad(d1_raw));
  print("  sqf(d2) = ", sqf_bad(d2_raw));
  print("  sqf(d3) = ", sqf_bad(d3_raw));
  print("  product = ", sqf_bad(d1_raw * d2_raw * d3_raw), " (should be square -> all zeros)");
);
}

quit;
