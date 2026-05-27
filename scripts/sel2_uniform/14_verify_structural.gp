\\ =====================================================================
\\ 14_verify_structural.gp -- Verify the structural conditions C1, C2
\\ produce the correct dim Sel_2.
\\
\\ For (m, n) ∈ {(3, 2), (5, 2), (4, 1), (22, 17), (99, 28)}:
\\   Enumerate (d_1, d_2) over Q(S, 2)^2 where S = bad primes ∪ {2}
\\   Check (C1): (d_1, d_2)_v = 1 for all v
\\   Check (C2): (d_1, -R)_v * (d_2, R)_v = 1 for all v
\\   Count #{(d_1, d_2)} satisfying both → 2^(dim Sel_2)
\\
\\ where R = sf((m+n)^2 - 2n^2) * sf((m-n)^2 - 2n^2) = sf(P*Q).
\\ =====================================================================

default(parisize, 1500000000);

sf(x) = if(x == 0, 0, my(s = sign(x), a = abs(x), f = factor(a)); s * prod(i=1, matsize(f)[1], f[i,1]^(f[i,2]%2)));

build_E_min(m, n) = {
  my(a = m^2 - n^2, b = 2*m*n, q, E, Em);
  q = a/b;
  E = ellinit([0, 1+q^2, 0, q^2, 0]);
  Em = ellminimalmodel(E);
  Em;
};

selmer_count_structural(m, n) = {
  my(P, Q, R, Em, N, S, k, Sext, count, d1, d2);
  P = (m+n)^2 - 2*n^2;
  Q = (m-n)^2 - 2*n^2;
  R = sf(P * Q);
  Em = build_E_min(m, n);
  N = ellglobalred(Em)[1];
  S = vecsort(Set(concat(factor(N)[,1]~, [2])));
  k = #S;
  count = 0;
  \\ Enumerate d_1, d_2 in 2^(k+1) each (the +1 is the sign bit)
  for(d1_mask = 0, 2^(k+1) - 1,
    d1 = 1;
    if(bittest(d1_mask, 0), d1 = -1);
    for(j=1, k, if(bittest(d1_mask, j), d1 *= S[j]));
    for(d2_mask = 0, 2^(k+1) - 1,
      d2 = 1;
      if(bittest(d2_mask, 0), d2 = -1);
      for(j=1, k, if(bittest(d2_mask, j), d2 *= S[j]));
      \\ C1: (d_1, d_2)_v = 1 for all v
      ok = 1;
      for(j=1, k, if(hilbert(d1, d2, S[j]) != 1, ok = 0; break));
      if(ok && hilbert(d1, d2, 0) != 1, ok = 0);
      if(ok,
        \\ C2: (d_1, -R)_v * (d_2, R)_v = 1 for all v
        for(j=1, k, if(hilbert(d1, -R, S[j]) * hilbert(d2, R, S[j]) != 1, ok = 0; break));
        if(ok && hilbert(d1, -R, 0) * hilbert(d2, R, 0) != 1, ok = 0);
      );
      if(ok, count++);
    );
  );
  [count, round(log(count)/log(2)), k+1];  \\ |Sel|, dim, |S|+1
};

print("===== Verify structural Selmer conditions =====");
print("(m,n)  |S|+1  ambdim  |Sel_structural|  dim_via_C1_C2  dim_via_ellrank");

{
\\ Small fibers only — exponential cost
fibers = [[3,2], [5,2], [4,1], [5,4], [7,2], [8,3], [9,4], [11,2]];
for(i=1, #fibers,
  mn = fibers[i];
  m = mn[1]; n = mn[2];
  r = selmer_count_structural(m, n);
  Em = build_E_min(m, n);
  ek = ellrank(Em, 1);
  s2_pari = ek[2] + 2;
  print(mn, "  ", r[3], "  ", 2*r[3], "  ", r[1], "  ", r[2], "  ", s2_pari);
);
}

quit;
