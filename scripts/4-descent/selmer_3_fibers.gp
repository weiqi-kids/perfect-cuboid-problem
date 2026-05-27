\\ 2-Selmer enumeration for E_Hm of three remaining BEYOND-QC fibers:
\\ (63, 38), (73, 24), (88, 35).
\\ Uses the bit-packed local-class enumeration from selmer_enum_fast.gp.

default(parisize, 1500000000);

\\ ---------- helpers ----------

\\ Transform [a1, a2, a3, a4, a6] (with a1=1, a2=a3=0) to short Weierstrass
\\ Y^2 = X^3 + X^2 + 16*a4 * X + 64*a6
{
to_short_int(a4, a6) = [1, 16*a4, 64*a6];  \\ [coef of X^2, coef of X, constant]
}

\\ Find rational roots of X^3 + b*X^2 + c*X + d  via PARI factor
{
short_roots(b, c, d) = my(P, F, roots);
  P = x^3 + b*x^2 + c*x + d;
  F = factor(P);
  roots = List();
  for(i = 1, #F~,
    if(poldegree(F[i, 1]) == 1,
      \\ root: -coeff of x^0 in monic linear factor
      r = -polcoef(F[i, 1], 0);
      for(k = 1, F[i, 2], listput(roots, r));
    )
  );
  return(Vec(roots));
}

\\ Sqfp of integer over a factor base F (signs + each prime)
\\ Returns vector of 0/1 indicating each F[i] divides squarefree part.
\\ F = [-1, p_1, p_2, ..., p_n]
{
sqfp_vector(n, F) = my(v, ff, p, e, i, idx);
  v = vector(#F);
  if(n == 0, return(v));
  if(n < 0, v[1] = 1; n = -n);
  ff = factor(n);
  for(i = 1, #ff~,
    p = ff[i, 1];
    e = ff[i, 2];
    if(e % 2 == 1,
      idx = -1;
      for(j = 2, #F, if(F[j] == p, idx = j; break));
      if(idx == -1, return(-1));  \\ prime outside factor base
      v[idx] = 1;
    )
  );
  return(v);
}

\\ ---------- Selmer enumeration ----------

{
selmer_enum(fname, a4, a6) =
  my(E, b, c, d, roots, e1, e2, e3, disc, primes_bad, F, dim_F,
     d1, d2, d3, prod_v, idx, ok_count, basis_count,
     trial_count, p, X, P, v);
  print("==============================================");
  print("Fiber ", fname, ":  short Weierstrass Y^2 = X^3 + X^2 + ", 16*a4, "*X + ", 64*a6);

  b = 1; c = 16*a4; d_const = 64*a6;
  E = ellinit([0, b, 0, c, d_const]);  \\ y^2 = x^3 + x^2 + cx + d
  disc = abs(E.disc);
  print("  disc = ", disc);
  print("  disc factored = ", factor(disc));

  roots = short_roots(b, c, d_const);
  if(#roots < 3,
    print("  *** Not all rational 2-torsion: roots = ", roots);
    print("  *** Skipping this fiber");
    return([fname, 0, 0, 0]);
  );
  e1 = roots[1]; e2 = roots[2]; e3 = roots[3];
  \\ Sort
  if(e1 > e2, t = e1; e1 = e2; e2 = t);
  if(e2 > e3, t = e2; e2 = e3; e3 = t);
  if(e1 > e2, t = e1; e1 = e2; e2 = t);
  print("  e1 = ", e1);
  print("  e2 = ", e2);
  print("  e3 = ", e3);
  print("  e2-e1 = ", factor(e2 - e1));
  print("  e3-e1 = ", factor(e3 - e1));
  print("  e3-e2 = ", factor(e3 - e2));

  \\ Bad primes = primes dividing disc
  primes_bad = factor(disc)[, 1]~;
  F = concat([-1], Vec(primes_bad));
  dim_F = #F;
  print("  factor base F (size ", dim_F, "): ", F);

  \\ Enumerate d1, d2 over F (subsets of bad primes + sign),
  \\ d3 = d1 * d2 (in F_2^dim_F).
  \\ For each (d1, d2, d3), check local solvability at each prime in factor base + infty.
  \\ d1 squarefree integer representable as product of F[i]^v_i; similarly d2, d3.
  \\ Local condition at v: exists X in Q_v such that X - e_i is square in Q_v * d_i.
  \\ Equivalent: certain Hilbert symbol relations hold.
  \\
  \\ Efficient implementation: enumerate d1, d2 candidates; for each, locally check.

  ok_count = 0;
  trial_count = 0;
  selmer_list = List();
  num_d_choices = 2^dim_F;

  \\ Precompute e_i for use
  \\ Note: we work with E_Hm in short Weierstrass form Y^2 = (X-e1)(X-e2)(X-e3).

  print("  enumerating 2^(2*", dim_F, ") = ", 2^(2*dim_F), " (d1,d2) pairs ...");
  t0 = getwalltime();
  for(idx1 = 0, num_d_choices - 1,
    \\ Build d1 from bitmask idx1 over factor base F
    d1_val = 1;
    for(j = 1, dim_F, if(bittest(idx1, j-1), d1_val *= F[j]));
    if(d1_val == 0, next);

    for(idx2 = 0, num_d_choices - 1,
      d2_val = 1;
      for(j = 1, dim_F, if(bittest(idx2, j-1), d2_val *= F[j]));
      if(d2_val == 0, next);

      \\ d3 = d1 * d2 (in Q*/Q*^2, so squarefree part)
      d3_temp = d1_val * d2_val;
      \\ squarefree-ify
      d3_sf = core(d3_temp);
      if(d3_sf == 0, next);

      trial_count += 1;

      \\ Check local solvability at each place:
      \\   (X - e_i) / d_i ∈ Q_v^2 for some X
      \\ Sufficient: at infty, find X with sign((X-e_i)/d_i) > 0 for all i
      \\ At each p ∈ bad primes: enumerate X mod p^k for small k, check.

      \\ Infinity:
      \\ For X in (e1, e2): signs (X-e_i) = (+, -, -)
      \\ For X in (e2, e3): signs = (+, +, -)
      \\ For X > e3: signs = (+, +, +)
      \\ For X < e1: signs = (-, -, -)
      \\ Need (X-e_i)/d_i > 0 for all i: depends on sign of d_i.
      \\ Determine which sign-pattern of (X-e1, X-e2, X-e3) is compatible with d:
      d = [d1_val, d2_val, d3_sf];
      sgn_d = [sign(d[1]), sign(d[2]), sign(d[3])];
      \\ Required: (X-e_i)/d_i > 0, so sign(X-e_i) = sgn_d[i].
      \\ Possible patterns: for X<e1: (-,-,-); X∈(e1,e2): (+,-,-); X∈(e2,e3): (+,+,-); X>e3: (+,+,+).
      pattern_ok = 0;
      if(sgn_d == [-1, -1, -1], pattern_ok = 1);
      if(sgn_d == [ 1, -1, -1], pattern_ok = 1);
      if(sgn_d == [ 1,  1, -1], pattern_ok = 1);
      if(sgn_d == [ 1,  1,  1], pattern_ok = 1);
      if(!pattern_ok, next);

      \\ Bad primes: for each p, search for X mod p^3 (mod 2^7 for p=2)
      pass_local = 1;
      for(pj = 2, dim_F,
        p = F[pj];
        kmax = if(p == 2, 6, 3);
        M = p^kmax;
        found_p = 0;
        for(X = 0, M - 1,
          all_ok2 = 1;
          for(i = 1, 3,
            r = (X - [e1,e2,e3][i]);
            \\ Reduce r modulo M
            r = r % M;
            \\ Check r / d[i] is square in Q_p
            \\ For p odd: v_p(r/d_i) must be even AND unit-part is QR mod p.
            \\ For p=2: v_2(r/d_i) must be even AND unit-part ≡ 1 mod 8.
            \\ Implementation:
            \\   If r = 0 mod M, treat as boundary, OK.
            if(r == 0, ; ,
              vp_r = valuation(r, p);
              if(vp_r >= kmax, ; ,
                vp_d = valuation(d[i], p);
                v_total = vp_r - vp_d;
                if(v_total % 2 != 0, all_ok2 = 0; break);
                unit_r = r / p^vp_r;
                unit_d = d[i] / p^vp_d;
                if(p == 2,
                  if(Mod(unit_r * unit_d, 8) != Mod(1, 8), all_ok2 = 0; break),
                  if(kronecker(unit_r * unit_d, p) != 1, all_ok2 = 0; break)
                );
              );
            );
          );
          if(all_ok2, found_p = 1; break);
        );
        if(!found_p, pass_local = 0; break);
      );
      if(pass_local,
        ok_count += 1;
        listput(selmer_list, [d1_val, d2_val, d3_sf]);
      );
    );
  );
  t1 = getwalltime();
  print("  ", trial_count, " trials, ", ok_count, " locally-solvable triples found");
  print("  enumeration wall: ", (t1 - t0)/1000.0, " s");

  if(ok_count > 0 && ok_count <= 100,
    print("  Selmer triples (full list):");
    for(k = 1, #selmer_list, print("    ", selmer_list[k]));
  );

  if(ok_count > 0,
    \\ Determine dim_F2 of S² (= log_2 of count)
    dim_S2 = round(log(ok_count) / log(2));
    print("  log_2(|S²|) approx = ", dim_S2);
    print("  ==> dim_F2 S²(E_Hm/Q) = ", dim_S2);
    print("  ==> dim_F2 S²/E[2] = ", dim_S2 - 2, " (since dim E[2](Q) = 2)");
  );

  print();
  return([fname, dim_F, ok_count, t1 - t0]);
}

\\ ---------- Apply to 3 fibers ----------

\\ (63,38) E_Hm = [1, 0, 0, -5343652737951011423545792190, 147088469266310969311366478538247305164100]
print("################################################################");
print("# 2-Selmer enumeration on E_Hm for 3 remaining BEYOND-QC fibers");
print("################################################################\n");

r1 = selmer_enum("(63,38)", -5343652737951011423545792190, 147088469266310969311366478538247305164100);

\\ (73,24) E_Hm = [1, 0, 0, -4296889542830417930548255320, 69513195990628448299367172717433334517312]
r2 = selmer_enum("(73,24)", -4296889542830417930548255320, 69513195990628448299367172717433334517312);

\\ (88,35) E_Hm = [1, 0, 0, -56968972021100673322719633980, -4381013374830911732760444269999712553455600]
r3 = selmer_enum("(88,35)", -56968972021100673322719633980, -4381013374830911732760444269999712553455600);

print("\n################################################################");
print("# Summary table");
print("################################################################");
print("Fiber        |F| (bad primes + sign) | |S²|  | dim S²  | dim S²/E[2] | wall");
print("-----        ------------------------ ------ -------- ------------- ------");
for(r = 1, 3,
  res = [r1, r2, r3][r];
  d_S2 = round(log(max(1, res[3])) / log(2));
  print(res[1], "    F = ", res[2], "       |S²|=", res[3], "  dim S²=", d_S2, "  dim S²/E[2]=", d_S2 - 2, "  ", res[4]/1000.0, "s");
);

quit;
