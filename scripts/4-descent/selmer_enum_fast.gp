\\ Phase α — Fast Selmer enumeration via precomputed class arrays.
\\
\\ For each prime p ∈ BAD, precompute:
\\   cF[p, k] = class_Qp(F[k], p), an integer in {0..3} (odd p) or {0..7} (p=2)
\\ Then for any d = ∏ F[k]^{i_k} (squarefree), class_Qp(d, p) = XOR_{i_k=1} cF[p, k].
\\
\\ Local image L_p stored as bitmap (for p odd: 64 bits; for p=2: 512 bits).
\\ Lookup: O(1) bit test.

default(parisize, 1500000000);

sqf(n) =
{
  my(s, a, f, r);
  if(n == 0, error("sqf(0)"));
  s = sign(n); a = abs(n);
  f = factor(a);
  r = 1;
  for(i = 1, matsize(f)[1], if(f[i,2] % 2 == 1, r *= f[i,1]));
  s * r;
}

is_sq_Qp(x, p) =
{
  my(v, u);
  if(x == 0, return(1));
  v = valuation(x, p);
  if(v % 2 != 0, return(0));
  u = x / p^v;
  if(p == 2, ((u % 8) + 8) % 8 == 1, kronecker(u, p) == 1);
}

class_Qp(x, p) =
{
  my(v, u, b0);
  if(x == 0, return(-1));
  v = valuation(x, p);
  u = x / p^v;
  if(p == 2,
    b0 = ((u % 8) + 8) % 8;
    b0 = (b0 - 1) / 2;
    return((v % 2) * 4 + b0);
    ,
    b0 = if(kronecker(u, p) == 1, 0, 1);
    return((v % 2) * 2 + b0);
  );
}

local_image_p_strat(p, e1l, e2l, e3l) =
{
  my(S, M, X, c1, c2, c3, prod, e_arr, ee, i, k, u, lim_u, mod_u);
  e_arr = [e1l, e2l, e3l];
  M = 0;
  for(i = 1, 3,
    for(j = i+1, 3,
      M = max(M, valuation(abs(e_arr[i] - e_arr[j]), p));
    );
  );
  if(p == 2, M = max(M, 3));
  S = Set([]);

  \\ Stratum 0
  for(r = 0, p - 1,
    my(skip = 0);
    for(i = 1, 3, if((e_arr[i] - r) % p == 0, skip = 1));
    if(!skip,
      X = r;
      prod = (X - e1l) * (X - e2l) * (X - e3l);
      if(is_sq_Qp(prod, p),
        c1 = class_Qp(X - e1l, p);
        c2 = class_Qp(X - e2l, p);
        c3 = class_Qp(X - e3l, p);
        S = setunion(S, Set([[c1, c2, c3]]));
      );
    );
  );

  \\ Strata i = 1, 2, 3
  for(i = 1, 3,
    ee = e_arr[i];
    for(k = 0, 2*M + 2,
      mod_u = 2 * M + 3 - k;
      if(mod_u < 1, mod_u = 1);
      while(p^mod_u > 10^5 && mod_u > 1, mod_u = mod_u - 1);
      lim_u = p^mod_u;
      for(u = 0, lim_u - 1,
        if(u % p == 0, next);
        X = ee + p^k * u;
        my(skip2 = 0);
        for(jj = 1, 3, if(X == e_arr[jj], skip2 = 1));
        if(!skip2,
          prod = (X - e1l) * (X - e2l) * (X - e3l);
          if(is_sq_Qp(prod, p),
            c1 = class_Qp(X - e1l, p);
            c2 = class_Qp(X - e2l, p);
            c3 = class_Qp(X - e3l, p);
            S = setunion(S, Set([[c1, c2, c3]]));
          );
        );
      );
    );
  );

  S = setunion(S, Set([[class_Qp((e1l-e2l)*(e1l-e3l), p), class_Qp(e1l-e2l, p), class_Qp(e1l-e3l, p)]]));
  S = setunion(S, Set([[class_Qp(e2l-e1l, p), class_Qp((e2l-e1l)*(e2l-e3l), p), class_Qp(e2l-e3l, p)]]));
  S = setunion(S, Set([[class_Qp(e3l-e1l, p), class_Qp(e3l-e2l, p), class_Qp((e3l-e1l)*(e3l-e2l), p)]]));
  S = setunion(S, Set([[0, 0, 0]]));
  S;
}

check_inf(d1, d2, d3) =
{
  my(s1 = sign(d1), s2 = sign(d2), s3 = sign(d3));
  if(s1 == 1 && s2 == 1 && s3 == 1, return(1));
  if(s1 == 1 && s2 == -1 && s3 == -1, return(1));
  0;
}

\\ Encode (c1, c2, c3) as integer for bitmap lookup
\\ For p odd: each c ∈ {0..3}, total 6 bits. encode = c1 | c2<<2 | c3<<4.
\\ For p=2: each c ∈ {0..7}, total 9 bits. encode = c1 | c2<<3 | c3<<6.
encode_classes(c1, c2, c3, p) =
{
  if(p == 2, c1 + 8 * c2 + 64 * c3, c1 + 4 * c2 + 16 * c3);
}

run_selmer_fast(curve_e1, curve_e2, curve_e3, F, BAD, name) =
{
  my(nF, total, count, results, Lp_set, Lp_bitmap, d1, d2, d3, c1, c2, c3, ok, p, cF, enc, cd1, cd2_arr, cd3_arr);
  print("");
  print("=================================================");
  print("Fast Selmer enumeration: ", name);
  print("=================================================");
  print("e1=", curve_e1, " e2=", curve_e2, " e3=", curve_e3);
  print("F (", #F, "): ", F);
  print("BAD: ", BAD);
  nF = #F;
  total = 2^nF;
  print("(d1, d2) candidates: ", total^2);

  \\ Precompute local images
  Lp_set = vector(#BAD);
  Lp_bitmap = vector(#BAD);
  for(j = 1, #BAD,
    p = BAD[j];
    gettime();
    Lp_set[j] = local_image_p_strat(p, curve_e1, curve_e2, curve_e3);
    \\ Build bitmap
    my(bm = 0);
    for(k = 1, #Lp_set[j],
      my(tup = Lp_set[j][k]);
      bm = bitor(bm, 2^encode_classes(tup[1], tup[2], tup[3], p));
    );
    Lp_bitmap[j] = bm;
    print("  p=", p, " |L_p|=", #Lp_set[j], " time=", gettime(), "ms");
  );

  \\ Precompute cF[j][k] = class_Qp(F[k], BAD[j])
  cF = matrix(#BAD, nF);
  for(j = 1, #BAD,
    p = BAD[j];
    for(k = 1, nF,
      cF[j, k] = class_Qp(F[k], p);
    );
  );
  print("  cF precomputed.");

  \\ For both p=2 and odd p, class multiplication corresponds to bitxor of encoded class.

  count = 0;
  results = List();
  cd1 = vector(#BAD);
  cd2_arr = vector(#BAD);
  cd3_arr = vector(#BAD);
  gettime();
  for(i1 = 0, total - 1,
    d1 = 1;
    for(k = 1, nF, if(bittest(i1, k-1), d1 *= F[k]));
    \\ classes of d1
    for(j = 1, #BAD,
      cd1[j] = 0;
      for(k = 1, nF, if(bittest(i1, k-1), cd1[j] = bitxor(cd1[j], cF[j, k])));
    );
    if(i1 % 1024 == 0, print("  i1=", i1, "/", total, "  count_so_far=", count, "  time=", gettime(), "ms"));
    for(i2 = 0, total - 1,
      d2 = 1;
      for(k = 1, nF, if(bittest(i2, k-1), d2 *= F[k]));
      d3 = sqf(d1 * d2);
      ok = check_inf(d1, d2, d3);
      if(ok,
        for(j = 1, #BAD,
          p = BAD[j];
          cd2_arr[j] = 0;
          for(k = 1, nF, if(bittest(i2, k-1), cd2_arr[j] = bitxor(cd2_arr[j], cF[j, k])));
          cd3_arr[j] = bitxor(cd1[j], cd2_arr[j]);
          enc = encode_classes(cd1[j], cd2_arr[j], cd3_arr[j], p);
          if(!bittest(Lp_bitmap[j], enc),
            ok = 0; break);
        );
      );
      if(ok,
        count += 1;
        listput(results, [d1, d2, d3]);
      );
    );
  );
  print("Found |S²| = ", count, "  enum time = ", gettime(), "ms");
  results;
}

\\ T1 validation
print("");
print("==== Validation T1 ====");
results_T1 = run_selmer_fast(0, 1, 2, [-1, 2], [2], "T1 rk=0");
print("Triples T1:");
for(k = 1, #results_T1, print("  ", results_T1[k]));

\\ T4 validation
print("");
print("==== Validation T4 ====");
results_T4 = run_selmer_fast(-7, 0, 7, [-1, 2, 7], [2, 7], "T4 rk=1");
print("Triples T4:");
for(k = 1, #results_T4, print("  ", results_T4[k]));

\\ E_Hm
e1_EHm = -298991117938864;
e2_EHm = 136054851567711;
e3_EHm = 162936266371152;
F_EHm = [-1, 2, 3, 5, 7, 11, 19, 23, 31, 61, 223, 337, 1033];
BAD_EHm = [2, 3, 5, 7, 11, 19, 23, 31, 61, 223, 337, 1033];
print("");
print("==== E_Hm full enumeration ====");
results_EHm = run_selmer_fast(e1_EHm, e2_EHm, e3_EHm, F_EHm, BAD_EHm, "E_Hm (61,38)");
print("");
print("Triples (E_Hm):");
for(k = 1, #results_EHm, print("  ", results_EHm[k]));

\\ Save to file (for Phase β to consume)
{
write("/root/proof/perfect-cuboid-problem/scripts/4-descent/EHm_selmer_results.txt", "");
for(k = 1, #results_EHm,
  write("/root/proof/perfect-cuboid-problem/scripts/4-descent/EHm_selmer_results.txt", results_EHm[k]);
);
}

quit;
