\\ Step 3: Investigate the structure of a_p values.
\\ At each prime p, a_p(E_{m,n}) takes only 2-3 distinct values.
\\ Hypothesis: a_p depends only on a quadratic character / mod-p data of (m,n).

default(parisize, 800000000);

print("=================================================================");
print("Step 3: Character / mod-p structure of a_p");
print("=================================================================");
print();

\\ Re-collect data with explicit (m, n, u, v) info
{
data = List();
for(m = 2, 14,
  for(n = 1, m - 1,
    if(gcd(m, n) == 1 && (m + n) % 2 == 1,
      u = 2*m*n;
      v = m^2 - n^2;
      E = ellinit([0, u^2+v^2, 0, u^2*v^2, 0]);
      Emin = ellminimalmodel(E);
      N = ellglobalred(Emin)[1];
      aps = vector(15, k, ellap(Emin, prime(k)));
      listput(data, [m, n, u, v, N, aps]);
    );
  );
);
}

print("Collected ", #data, " curves (m,n) with m up to 14.");
print();

\\ Test 1: Is a_p a function of (m mod p, n mod p)?
print("--- Test 1: Is a_p a function of (m mod p, n mod p)? ---");
print();
{
for(k = 1, 10,
  p = prime(k);
  buckets = Map();
  inconsistent = 0;
  for(i = 1, #data,
    d = data[i];
    \\ key = (m mod p, n mod p)
    mp = d[1] % p; np = d[2] % p;
    key = [mp, np];
    if(mapisdefined(buckets, key, &prev),
      if(prev != d[6][k], inconsistent = inconsistent + 1),
      mapput(buckets, key, d[6][k])
    );
  );
  print("p = ", p, ": ", #buckets, " distinct (m mod p, n mod p) keys, ",
        inconsistent, " inconsistencies among ", #data, " curves");
);
}

print();
\\ Test 2: Is a_p a function of (mn mod p, m^2-n^2 mod p), i.e. of (u,v) mod p?
print("--- Test 2: Is a_p a function of (u mod p, v mod p)? ---");
print();
{
for(k = 1, 10,
  p = prime(k);
  buckets = Map();
  inconsistent = 0;
  for(i = 1, #data,
    d = data[i];
    up = d[3] % p; vp = d[4] % p;
    key = [up, vp];
    if(mapisdefined(buckets, key, &prev),
      if(prev != d[6][k], inconsistent = inconsistent + 1),
      mapput(buckets, key, d[6][k])
    );
  );
  print("p = ", p, ": ", #buckets, " distinct keys, ", inconsistent, " inconsistencies");
);
}

print();
\\ Test 3: Is a_p determined by the curve E_{m,n} mod p (i.e. j-invariant mod p)?
\\ For Y^2 = X(X+u^2)(X+v^2), discriminant = 16 u^4 v^4 (u^2-v^2)^2
\\   = 16 u^4 v^4 (u-v)^2 (u+v)^2
\\ and a_p depends on the reduction E mod p. If p does not divide N, then
\\ a_p = p + 1 - #E(F_p). Let's verify by direct point count.
print("--- Test 3: Point counts on Y^2 = X(X+u^2)(X+v^2) mod p ---");
print();
{
for(k = 1, 10,
  p = prime(k);
  print("p = ", p, ":");
  for(i = 1, min(#data, 8),
    d = data[i];
    m = d[1]; n = d[2]; u = d[3]; v = d[4];
    \\ Count points mod p directly on minimal-equation reduction:
    \\ This may differ from ellap(Emin) at bad primes — skip those.
    if(d[5] % p != 0,
      \\ count Y^2 = X(X+u^2)(X+v^2) mod p
      cnt = 1; \\ point at infinity
      for(x = 0, p - 1,
        rhs = (x * (x + u^2) * (x + v^2)) % p;
        if(rhs == 0, cnt = cnt + 1,
          if(kronecker(rhs, p) == 1, cnt = cnt + 2);
        );
      );
      ap_direct = p + 1 - cnt;
      ap_table = d[6][k];
      match = if(ap_direct == ap_table, "OK", "MISMATCH");
      printf("  (m,n)=(%d,%d), direct a_p=%d, table a_p=%d  %s\n",
        m, n, ap_direct, ap_table, match);
    );
  );
);
}

print();
\\ Test 4: Quadratic twists?
\\ E_{m,n}: Y^2 = X(X+u^2)(X+v^2). Substitute X -> v^2 X':
\\   Y^2 = v^2 X (v^2 X + u^2)(v^2 X + v^2) = v^6 X (X + (u/v)^2)(X + 1)
\\ Let Y -> v^3 Y: Y^2 = X (X+1)(X + (u/v)^2)
\\ Hmm — this just recovers E_PCP(u/v).
\\ Or: substitute X = u v X': harder. Try: relate E_{m,n} to a standard curve via twist.
\\
\\ E_{m,n} is Y^2 = X^3 + (u^2+v^2) X^2 + u^2 v^2 X.
\\ Let s = u^2 + v^2 = (m^2+n^2)^2, p = u*v = 2mn(m^2-n^2).
\\ Then E: Y^2 = X^3 + s X^2 + p^2 X.
\\ This has discriminant = 16 p^4 (s^2 - 4 p^2) = 16 p^4 (s-2p)(s+2p).
\\ s - 2p = u^2 + v^2 - 2uv = (u-v)^2
\\ s + 2p = u^2 + v^2 + 2uv = (u+v)^2
\\ So disc(E) = 16 (uv)^4 (u-v)^2 (u+v)^2 = 16 (uv (u-v)(u+v))^2 * (uv)^2
\\           = 16 (uv)^2 ((u-v)(u+v) uv)^2 ... let me redo:
\\ disc = 16 (uv)^4 (u-v)^2 (u+v)^2
\\ j-invariant: j = 256 (s^2 - 3 p^2)^3 / ((uv)^4 (u^2-v^2)^2)
\\
\\ Recall u = 2mn, v = m^2 - n^2, so u^2 - v^2 = 4 m^2 n^2 - (m^2-n^2)^2
\\                                              = -(m^2 - n^2 - 2mn)(m^2 - n^2 + 2mn)
\\                                              = -(m-n)^2(m+n)^2 ... wait
\\ (m^2 - n^2)^2 - 4 m^2 n^2 = (m^2 - n^2 - 2mn)(m^2 - n^2 + 2mn) = ((m-n)^2 - 2n^2)((m+n)^2 - 2n^2)?
\\ Hmm let me just compute symbolically.
print("--- Test 5: j-invariant formula ---");
print();
print("E_{m,n}: Y^2 = X^3 + (u^2+v^2) X^2 + (uv)^2 X");
print("c4 = 16 ((u^2+v^2)^2 - 3 (uv)^2) = 16 (u^4 - u^2 v^2 + v^4)");
print("c6 = -64 (u^2+v^2)((u^2+v^2)^2 - 9/2 (uv)^2) hmm");
print();
{
for(i = 1, min(#data, 12),
  d = data[i];
  m = d[1]; n = d[2]; u = d[3]; v = d[4];
  E = ellinit([0, u^2+v^2, 0, u^2*v^2, 0]);
  jE = ellj(E);
  c4 = E.c4; c6 = E.c6; disc = E.disc;
  printf("(m,n)=(%d,%d): j = %s,  c4 = %d, disc = %d\n",
    m, n, Str(jE), c4, disc);
);
}

print();
print("--- Test 6: Are E_{m,n} all 2-isogenous to a fixed curve? ---");
print();
{
\\ For each E_{m,n}, compute its 2-isogeny class and check overlap
for(i = 1, min(#data, 8),
  d = data[i];
  m = d[1]; n = d[2]; u = d[3]; v = d[4];
  E = ellinit([0, u^2+v^2, 0, u^2*v^2, 0]);
  Emin = ellminimalmodel(E);
  isos = ellisomat(Emin, 0, 1); \\ flag=1: only return matrix of isogeny degrees
  printf("(m,n)=(%d,%d): isogeny matrix shape (size = %d):\n", m, n, #isos);
  print("  matrix = ", isos);
);
}

quit;
