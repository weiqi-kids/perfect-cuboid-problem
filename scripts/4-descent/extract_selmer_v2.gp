\\ Phase G prep v2: Extract (d1, d2, d3) Selmer triples for each cover.
\\
\\ Method: for each cover q, find a rational point in Q_p for various p (or Q_R)
\\ and read off (x-e1, x-e2, x-e3) mod Q*^2.
\\
\\ Alternative (more robust): factor lc(q) and the leading coefficient pattern.
\\ For the standard form q(x) = (d2 d3) * x^4 + ... + (d1 d2 d3 e2 e3 ...) ...
\\
\\ ACTUALLY: easiest robust route is to look at q(e_i)/(e_i - e_j)/(e_i - e_k).
\\ Because if P=(x,y) lifts via x-ei = di ui^2 etc., then q at x=ei should be
\\ related to the resultant which factors through d_j*d_k * differences.

default(parisize, 1000000000);
default(realprecision, 38);

read("/root/proof/perfect-cuboid-problem/scripts/4-descent/EHm_short_data.gp");
E_short = ellinit([0, A2_short, 0, A4_short, A6_short]);
e1 = e1_short; e2 = e2_short; e3 = e3_short;
covers = ell2cover(E_short);
print("Number of covers: ", #covers);

BAD = [2, 3, 5, 7, 11, 19, 23, 31, 61, 223, 337, 1033];

\\ Compute n mod squares, restricted to BAD primes (returns vector of (e_p mod 2) for p in BAD, plus sign bit at front)
\\ If n has prime factor outside BAD with odd exponent, returns "BAD_PRIME"
{ encode_bad(n) =
  my(v, k, p, e, nn);
  if(n == 0, return("zero"));
  v = vector(#BAD + 1);
  v[1] = if(n < 0, 1, 0);
  nn = abs(n);
  for(k = 1, #BAD,
    p = BAD[k];
    e = 0;
    while(nn % p == 0, nn = nn / p; e += 1);
    v[k+1] = e % 2;
  );
  \\ Whatever remains in nn should be a square (sf part is 1)
  if(!issquare(nn), return("EXTRA"));
  v;
}

\\ Look at q(e_i)*(e_i - e_j)*(e_i - e_k):
\\ For canonical cover form, q(e_i) should be d_i times product/(squares).
\\ Specifically, if q(x) = c * (x - r1)(x - r2)(x - r3)(x - r4) where r_i lie in
\\ quadratic extensions of Q corresponding to sqrt(d_i), then evaluating at e_j
\\ for j != i gives ...

\\ Actually the clearest invariant: leading coefficient of q
print();
print("===========================================");
print("Cover invariants: leading and constant coefficients (sqf mod BAD):");
print("===========================================");
{
for(k = 1, #covers,
  q = covers[k][1];
  c4 = polcoeff(q, 4);
  c0 = polcoeff(q, 0);
  print("Cover #", k);
  print("  c4 = ", c4, "  = ", factor(c4));
  print("  c0 = ", c0, "  = ", factor(c0));
  enc4 = encode_bad(c4);
  enc0 = encode_bad(c0);
  print("  encode(c4) over [sign,2,3,5,7,11,19,23,31,61,223,337,1033]: ", enc4);
  print("  encode(c0): ", enc0);
  print("  encode(c4*c0): ", if(type(enc4)=="t_VEC" && type(enc0)=="t_VEC", vector(#enc4, i, (enc4[i]+enc0[i])%2), "?"));
  print();
);
}

\\ Try q at e_i, divide out (e_i - e_j)*(e_i - e_k), see if sqf part is in BAD
\\ q has 4 roots r1, r2, r3, r4 in algebraic closure. q(e_i) = c4 prod (e_i - r_l).
\\ For the standard Selmer cover, the 4 roots come in 2 conjugate pairs over sqrt(d_a), sqrt(d_b)
\\ and q(e_i) should naturally factor into (linear-in-d) form.
\\ But this requires knowing the cover convention.
\\
\\ Empirical robust route: parametrize rational point of cover #2 (it has a rational point)
\\ For cover #2, we know x=0 gives a rational point: q(0) = c0 = 3334014193367081497693717504 = (2^5 * 19^4 * 61^4)^2 = 57740923038752^2.
\\ So (0, 57740923038752) is on cover #2. Lifting via cover_map:

print();
print("===========================================");
print("Lifting known rational points to E and reading di triples:");
print("===========================================");
{
print();
print("Cover #2: known point x=0, y = ", sqrtint(polcoeff(covers[2][1], 0)));
y0 = sqrtint(polcoeff(covers[2][1], 0));
P_map = covers[2][2];
\\ Substitute x=0, y=y0 into P_map[1], P_map[2]
X_E = subst(subst(P_map[1], 'x, 0), 'y, y0);
Y_E = subst(subst(P_map[2], 'x, 0), 'y, y0);
print("  Lift to E: (X, Y) = (", X_E, ", ", Y_E, ")");
print("  On curve? ", ellisoncurve(E_short, [X_E, Y_E]));
print("  Order: ", ellorder(E_short, [X_E, Y_E]));
if(ellisoncurve(E_short, [X_E, Y_E]),
  print("  X - e1 = ", X_E - e1, " sqf factor = ", factor(numerator((X_E-e1)*denominator(X_E-e1)^2)));
  print("  X - e2 = ", X_E - e2);
  print("  X - e3 = ", X_E - e3);
);
}

\\ Cover #1: x=0 gives c0 = 74395420577284 — check
{
print();
print("Cover #1: q(0) = ", polcoeff(covers[1][1], 0), "  issquare? ", issquare(polcoeff(covers[1][1], 0)));
}

\\ For Selmer image, use Pari's ell2descent_gen if available, OR
\\ just use the cover quartic c4, c0 as proxies (they ARE in d_j*d_k up to global square).

quit;
