\\ =====================================================================
\\ 10_explicit_selmer.gp
\\
\\ Direct Schaefer-style enumeration of Sel_2(E_PCP(q)/Q) using
\\ Hilbert symbol local conditions.
\\
\\ For E: y^2 = (x-e_1)(x-e_2)(x-e_3) with all e_i in Q,
\\ Selmer pair (d_1, d_2) (with d_3 = d_1*d_2*(square) chosen to make
\\ product be a square) is in Sel_2 iff
\\   for all places v in S = {bad primes, 2, ∞}:
\\     The system  d_1 z_1^2 - d_2 z_2^2 = e_2 - e_1
\\                 d_1 z_1^2 - d_1 d_2 z_3^2 = e_3 - e_1
\\     has Q_v-rational point.
\\
\\ For E_PCP we have e_2 - e_1 = q^2 - 1 (≡ sf(P)*sf(Q) mod sq)
\\                    e_3 - e_1 = q^2          (≡ 1 mod sq)
\\                    e_3 - e_2 = 1            (≡ 1 mod sq)
\\
\\ The 2nd ternary, since RHS is a square, can be rewritten as
\\   d_1 z_1^2 - d_1 d_2 z_3^2 = q^2
\\ which has Q_v-solution at v iff (d_1, d_1 d_2)_v = (d_1, q^2)_v = 1
\\   (Hilbert symbol of (-d_1*(-d_1 d_2), -d_1*q^2) = (d_1^2 d_2, -d_1*q^2)
\\   = (d_2, -d_1*q^2) ... taking sq out: = (d_2, -d_1)_v)
\\ Wait this needs care. Standard fact: for ax^2 + by^2 + cz^2 = 0,
\\ isotropic over Q_v iff hilbert(-ab, -ac, v) = 1.
\\
\\ Ternary d_1 z_1^2 - d_1 d_2 z_3^2 - q^2 c^2 = 0:
\\   a = d_1, b = -d_1 d_2, c = -q^2
\\   hilbert(-d_1 * (-d_1 d_2), -d_1 * (-q^2), v) = hilbert(d_1^2 d_2, d_1 q^2, v)
\\   = hilbert(d_2, d_1, v) (since d_1^2 and q^2 are squares)
\\   So criterion: (d_1, d_2)_v = 1 for all v. ☆☆☆ THIS IS THE KEY CONDITION
\\
\\ Similarly the 3rd ternary (using d_2 z_2^2 - d_1 d_2 z_3^2 = 1):
\\   a = d_2, b = -d_1 d_2, c = -1
\\   hilbert(-d_2 * (-d_1 d_2), -d_2 * (-1), v) = hilbert(d_1 d_2^2, d_2, v)
\\   = hilbert(d_1, d_2, v) = (d_1, d_2)_v
\\   So criterion: (d_1, d_2)_v = 1 for all v. (Same condition!)
\\
\\ And the 1st ternary (d_1 z_1^2 - d_2 z_2^2 = (q^2 - 1)):
\\   ternary d_1 z_1^2 - d_2 z_2^2 - (q^2 - 1) c^2 = 0:
\\   a = d_1, b = -d_2, c' = -(q^2 - 1)
\\   hilbert(-d_1 * (-d_2), -d_1 * (-(q^2-1)), v) = hilbert(d_1 d_2, d_1 (q^2-1), v)
\\
\\ For the conditions to all hold, we need:
\\   (a) (d_1, d_2)_v = 1 for all v
\\   (b) (d_1 d_2, d_1 (q^2-1))_v = 1 for all v
\\
\\ Using bilinearity of Hilbert symbol:
\\   (b) = (d_1, d_1)_v * (d_1, q^2 - 1)_v * (d_2, d_1)_v * (d_2, q^2 - 1)_v
\\       = (d_1, -1)_v * (d_1, q^2 - 1)_v * (d_2, d_1)_v * (d_2, q^2 - 1)_v
\\         (using (a, a)_v = (a, -a)_v = (a, -1)_v)
\\   Combining with (a) i.e. (d_1, d_2)_v = (d_2, d_1)_v = 1:
\\   (b) becomes: (d_1, -1)_v * (d_1, q^2 - 1)_v * (d_2, q^2 - 1)_v = 1
\\              = (d_1 d_2, q^2 - 1)_v * (d_1, -1)_v
\\
\\ Letting R = sf(q^2 - 1) ≡ sf(P*Q) (mod squares), we need:
\\   (a) (d_1, d_2)_v = 1 for all v
\\   (b') (d_1 d_2, R)_v * (d_1, -1)_v = 1 for all v
\\
\\ Equivalent form:
\\   (a) (d_1, d_2)_v = 1
\\   (b'') (d_1, -R)_v * (d_2, R)_v = 1
\\         (Both giving same R-norm relation.)
\\
\\ Looking at THIS form: the Selmer condition is exactly
\\   ((d_1, d_2), (d_1 d_2, R), (d_1, -1)) consistent across all v
\\
\\ ===== HILBERT RECIPROCITY ANALYSIS =====
\\
\\ Each condition (a, b)_v = 1 for all v has a Hilbert reciprocity relation:
\\   prod_v (a, b)_v = 1.
\\ So at most |S| - 1 of the v-conditions are independent... but we need
\\ ALL of them to equal 1, which is a stronger condition.
\\
\\ Actually: the local conditions cut a SUBGROUP of the ambient. Each
\\ "condition (a, b)_v = 1 for given (a, b)" is 1 bit at each place where
\\ it's non-trivial. Across all v, Hilbert recip gives ONE F_2-relation,
\\ so the number of effective bits = (#places where it's non-trivial) - 1.
\\
\\ Hmm this is getting complex. Let me COMPUTE for specific fibers.

default(parisize, 1500000000);

sf(x) = if(x == 0, 0, my(s = sign(x), a = abs(x), f = factor(a)); s * prod(i=1, matsize(f)[1], f[i,1]^(f[i,2]%2)));

build_E_min(m, n) = {
  my(a = m^2 - n^2, b = 2*m*n, q, E, Em);
  q = a/b;
  E = ellinit([0, 1+q^2, 0, q^2, 0]);
  Em = ellminimalmodel(E);
  Em;
};

\\ ===== Direct Hilbert-symbol enumeration =====
\\
\\ For each fiber, build the support set S = {-1, 2, p_1, ..., p_k}
\\ for primes p in conductor of E_min.
\\ Enumerate all (d_1, d_2) in {±1, ±2, ±p_1, ..., ±products} mod squares.
\\ That is, (d_1, d_2) in (Q(S, 2))^2 of dim 2(|S|+1).
\\
\\ Check local conditions:
\\   (a) (d_1, d_2)_v = 1 for all v in S ∪ {∞}
\\   (b) (d_1, -1)_v * (d_1 d_2, R)_v = 1 for all v
\\
\\ where R = sf((m^2-n^2)^2 - (2mn)^2) / (2mn)^2 ≡ sf(P*Q) (mod squares).
\\
\\ Then count survivors -> dim Sel_2.

selmer_enum(m, n) = {
  my(P, Q, R, Em, N, Sprimes, Sext, d1ranges, d2ranges, count, dim_amb);
  P = (m+n)^2 - 2*n^2;
  Q = (m-n)^2 - 2*n^2;
  R = sf(P * Q);   \\ squarefree part of q^2 - 1 (up to squares of 2mn)
  Em = build_E_min(m, n);
  N = ellglobalred(Em)[1];
  Sprimes = factor(N)[,1]~;
  \\ S = primes in support of (d_1, d_2): conductor primes ∪ {2}
  S = Vec(Set(concat(Sprimes, [2])));
  k = #S;
  dim_amb = 2 * (k + 1);  \\ each of d_1, d_2 has (k+1) bits
  \\ Generate all 2^(k+1) values for d_1 and d_2 each
  \\ d_1 = prod of subset of {-1, S[1], ..., S[k]}
  count = 0;
  d1d2_survivors = List();
  for(d1_mask = 0, 2^(k+1) - 1,
    d1 = 1;
    if(bittest(d1_mask, 0), d1 = -d1);
    for(j=1, k, if(bittest(d1_mask, j), d1 *= S[j]));
    for(d2_mask = 0, 2^(k+1) - 1,
      d2 = 1;
      if(bittest(d2_mask, 0), d2 = -d2);
      for(j=1, k, if(bittest(d2_mask, j), d2 *= S[j]));
      \\ Check local conditions at each place v in S ∪ {-1 (i.e. ∞)}
      ok = 1;
      \\ (a) (d_1, d_2)_v = 1 for all v
      for(idx=1, k,
        p = S[idx];
        if(hilbert(d1, d2, p) != 1, ok = 0; break);
      );
      if(ok && hilbert(d1, d2, 0) != 1, ok = 0);  \\ infinity = 0 in PARI
      if(ok,
        \\ (b) (d_1, -1)_v * (d_1 d_2, R)_v = 1 for all v
        d1d2 = d1*d2;
        for(idx=1, k,
          p = S[idx];
          if(hilbert(d1, -1, p) * hilbert(d1d2, R, p) != 1, ok = 0; break);
        );
        if(ok && hilbert(d1, -1, 0) * hilbert(d1d2, R, 0) != 1, ok = 0);
      );
      if(ok, count++; listput(d1d2_survivors, [d1, d2]));
    );
  );
  [count, dim_amb, d1d2_survivors];
};

print("===== Direct Hilbert-symbol Selmer enumeration =====");
print("(m,n)   |S|+1   ambdim   |Sel_2|   log2|Sel|   dim_via_ellrank");

\\ NOTE: This will be expensive for large |S|. Limit to small fibers.
{
fibers = [[3,2], [5,2], [4,1], [11,2], [8,3]];
for(i=1, #fibers,
  mn = fibers[i];
  m = mn[1]; n = mn[2];
  r = selmer_enum(m, n);
  cnt = r[1]; ambdim = r[2];
  d = round(log(cnt)/log(2));
  Em = build_E_min(m, n);
  ek = ellrank(Em, 1);
  s2_pari = ek[2] + 2;
  print(mn, "   ", ambdim/2, "   ", ambdim, "    ", cnt, "       ", d, "        ", s2_pari);
);
}

quit;
