\\ Leg I - Precompute Mordell-Weil sieve residues for ε class [1, 219, 219].
\\ For each small good prime ℓ ∈ {11, 13, 17, 19, 29, 31}:
\\   For each q mod ℓ (q ≠ 0 since gcd(p,q)=1), find all p mod ℓ such that
\\     val2 = d2 * (d1 p^2 - C21 q^2) is a square mod ℓ
\\     val3 = d3 * (d1 p^2 - C31 q^2) is a square mod ℓ
\\
\\ Output:  bitmaps (one per prime, one per q-residue class).
\\ These are used in legI_main.gp to skip ~70-90% of (p,q) candidates.

default(parisize, 200000000);
default(parisizemax, 400000000);

e1 = -289985899459969;
e2 =  69618111281856;
e3 =  220367788178112;
C21 = e2 - e1;
C31 = e3 - e1;

d1 = 1; d2 = 219; d3 = 219;

\\ Excluded bad primes: {2, 3, 5, 7, 23, 73, 97, 359, 1181, 1249}
\\ Also 219 = 3*73 — so val_i are 0 mod 3 and mod 73 always. Skip those.
\\ Good small primes: 11, 13, 17, 19, 29, 31

is_square_mod_p(a, p) = {
  a = a % p;
  if(a == 0, return(1));
  return(Mod(a, p)^((p-1)/2) == 1);
};

print("=== Sieve density per (q mod p) for ε class [1,219,219] ===");
print();

PRIMES = [11, 13, 17, 19, 29, 31];
total_density = 1.0;

{
for(ip = 1, #PRIMES,
  ell = PRIMES[ip];
  C21m = C21 % ell;
  C31m = C31 % ell;
  d1m = d1 % ell;
  d2m = d2 % ell;
  d3m = d3 % ell;
  \\ For q ≢ 0 mod ell, set Q = q^2 mod ell (a quadratic residue).
  \\ Need: d2*(d1 p^2 - C21 Q) and d3*(d1 p^2 - C31 Q) both squares mod ell.
  \\ Same density for any nonzero q since p shifts uniformly.
  \\ Just pick q = 1 mod ell:
  q = 1;
  allowed = 0;
  for(p = 0, ell - 1,
    if(gcd(p, q) != 1 && (p != 0 || ell == 1), \\ noop
      0;
    );
    v2 = (d2m * (d1m * p^2 - C21m * q^2)) % ell;
    v3 = (d3m * (d1m * p^2 - C31m * q^2)) % ell;
    if(is_square_mod_p(v2, ell) && is_square_mod_p(v3, ell),
      allowed = allowed + 1;
    );
  );
  density = allowed / ell * 1.0;
  total_density = total_density * density;
  print("  ell = ", ell, "  allowed p (out of ", ell, ") = ", allowed, "  density = ", density);
);
}
print();
print("Combined density (product) = ", total_density);
print("=> sieving cuts work by factor ~", 1.0/total_density);

\\ Now dump bitmaps for q = 1 case (others computed inline in main script)
print();
print("Bitmaps for q=1 mod ell:");
{
for(ip = 1, #PRIMES,
  ell = PRIMES[ip];
  C21m = C21 % ell; C31m = C31 % ell;
  d1m = d1 % ell; d2m = d2 % ell; d3m = d3 % ell;
  q = 1;
  bits = vector(ell);
  for(p = 0, ell - 1,
    v2 = (d2m * (d1m * p^2 - C21m * q^2)) % ell;
    v3 = (d3m * (d1m * p^2 - C31m * q^2)) % ell;
    if(is_square_mod_p(v2, ell) && is_square_mod_p(v3, ell), bits[p+1] = 1);
  );
  print("  ell=", ell, " bits=", bits);
);
}

quit;
