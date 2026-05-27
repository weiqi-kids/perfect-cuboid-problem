\\ Fast 2-Selmer enumeration on E_Hm for the 3 remaining BEYOND-QC fibers.
\\ Reuses the bit-packed local-image precomputation from selmer_enum_fast.gp.

default(parisize, 1500000000);

\\ ============== Helpers (copied from selmer_enum_fast.gp) ==============

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
  if(s1 == -1 && s2 == 1 && s3 == -1, return(1));
  if(s1 == -1 && s2 == -1 && s3 == 1, return(1));
  0;
}

encode_classes(c1, c2, c3, p) =
{
  if(p == 2, c1 + 8 * c2 + 64 * c3, c1 + 4 * c2 + 16 * c3);
}

run_selmer_fast(e1_, e2_, e3_, F, BAD, name) =
{
  my(nF, total, count, results, Lp_set, Lp_bitmap, d1, d2, d3, ok, p, cF, enc, cd1, cd2_arr, cd3_arr);
  print("");
  print("=================================================");
  print("Fast Selmer enumeration: ", name);
  print("=================================================");
  print("e1=", e1_, "  e2=", e2_, "  e3=", e3_);
  print("F (size ", #F, "): ", F);
  print("BAD (size ", #BAD, "): ", BAD);
  nF = #F;
  total = 2^nF;
  print("(d1, d2) candidates: ", total^2);
  Lp_set = vector(#BAD);
  Lp_bitmap = vector(#BAD);
  for(j = 1, #BAD,
    p = BAD[j];
    gettime();
    Lp_set[j] = local_image_p_strat(p, e1_, e2_, e3_);
    my(bm = 0);
    for(k = 1, #Lp_set[j],
      my(tup = Lp_set[j][k]);
      bm = bitor(bm, 2^encode_classes(tup[1], tup[2], tup[3], p));
    );
    Lp_bitmap[j] = bm;
    print("  p=", p, "  |L_p|=", #Lp_set[j], "  time=", gettime(), "ms");
  );
  cF = matrix(#BAD, nF);
  for(j = 1, #BAD,
    p = BAD[j];
    for(k = 1, nF, cF[j, k] = class_Qp(F[k], p));
  );
  print("  cF precomputed.");
  count = 0;
  results = List();
  cd1 = vector(#BAD);
  cd2_arr = vector(#BAD);
  cd3_arr = vector(#BAD);
  gettime();
  for(i1 = 0, total - 1,
    d1 = 1;
    for(k = 1, nF, if(bittest(i1, k-1), d1 *= F[k]));
    for(j = 1, #BAD,
      cd1[j] = 0;
      for(k = 1, nF, if(bittest(i1, k-1), cd1[j] = bitxor(cd1[j], cF[j, k])));
    );
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
          if(!bittest(Lp_bitmap[j], enc), ok = 0; break);
        );
      );
      if(ok,
        count += 1;
        listput(results, [d1, d2, d3]);
      );
    );
  );
  print("  |S²| = ", count, "  enum time = ", gettime(), "ms");
  results;
}

\\ ============== Compute e1,e2,e3 and BAD for each fiber's E_Hm ==============

\\ E_Hm minimal form is [1, 0, 0, A4, A6]. Short Weierstrass is
\\ Y^2 = X^3 + X^2 + (16*A4) X + (64*A6).

setup_short(A4, A6) =
{
  my(b, c, d, P, F, roots);
  b = 1; c = 16 * A4; d = 64 * A6;
  P = x^3 + b*x^2 + c*x + d;
  F = factor(P);
  roots = List();
  for(i = 1, #F~,
    if(poldegree(F[i, 1]) == 1,
      for(k = 1, F[i, 2], listput(roots, -polcoef(F[i, 1], 0)))
    );
  );
  if(#roots < 3, error("Not all 2-torsion rational for short Weierstrass"));
  roots = Vec(roots);
  \\ Sort
  vecsort(roots);
}

\\ Determine bad primes for each fiber (primes dividing disc).
\\ For E_Hm in short Weierstrass, disc = ... use ellinit and look at disc.
get_bad_primes(A4, A6) =
{
  my(E, d, f);
  E = ellinit([0, 1, 0, 16*A4, 64*A6]);
  d = abs(E.disc);
  f = factor(d);
  Vec(f[, 1]~);
}

\\ ============== Apply to 3 fibers ==============

print("################################################################");
print("# 2-Selmer enumeration on E_Hm for 3 remaining BEYOND-QC fibers");
print("################################################################");

\\ Fiber (63,38): A4 = -5343652737951011423545792190, A6 = 147088469266310969311366478538247305164100
A4_63 = -5343652737951011423545792190;
A6_63 = 147088469266310969311366478538247305164100;
roots_63 = setup_short(A4_63, A6_63);
BAD_63 = get_bad_primes(A4_63, A6_63);
F_63 = concat([-1], BAD_63);
print();
print("Fiber (63,38):");
print("  short Weierstrass roots: ", roots_63);
print("  BAD primes: ", BAD_63);
print("  |BAD| = ", #BAD_63, ",  |F| = ", #F_63);
results_63 = run_selmer_fast(roots_63[1], roots_63[2], roots_63[3], F_63, BAD_63, "E_Hm (63,38)");

\\ Fiber (73,24): A4 = -4296889542830417930548255320, A6 = 69513195990628448299367172717433334517312
A4_73 = -4296889542830417930548255320;
A6_73 = 69513195990628448299367172717433334517312;
roots_73 = setup_short(A4_73, A6_73);
BAD_73 = get_bad_primes(A4_73, A6_73);
F_73 = concat([-1], BAD_73);
print();
print("Fiber (73,24):");
print("  short Weierstrass roots: ", roots_73);
print("  BAD primes: ", BAD_73);
print("  |BAD| = ", #BAD_73, ",  |F| = ", #F_73);
results_73 = run_selmer_fast(roots_73[1], roots_73[2], roots_73[3], F_73, BAD_73, "E_Hm (73,24)");

\\ Fiber (88,35): A4 = -56968972021100673322719633980, A6 = -4381013374830911732760444269999712553455600
A4_88 = -56968972021100673322719633980;
A6_88 = -4381013374830911732760444269999712553455600;
roots_88 = setup_short(A4_88, A6_88);
BAD_88 = get_bad_primes(A4_88, A6_88);
F_88 = concat([-1], BAD_88);
print();
print("Fiber (88,35):");
print("  short Weierstrass roots: ", roots_88);
print("  BAD primes: ", BAD_88);
print("  |BAD| = ", #BAD_88, ",  |F| = ", #F_88);
results_88 = run_selmer_fast(roots_88[1], roots_88[2], roots_88[3], F_88, BAD_88, "E_Hm (88,35)");

\\ ============== Summary ==============

print();
print("################################################################");
print("# SUMMARY TABLE");
print("################################################################");
print();
print("| Fiber   | |F| | |S²|        | dim S² | dim S²/E[2] |");
print("|---------|-----|-------------|--------|-------------|");

d63 = round(log(max(1, #results_63))/log(2));
d73 = round(log(max(1, #results_73))/log(2));
d88 = round(log(max(1, #results_88))/log(2));
print("| (63,38) | ", #F_63, "  | ", #results_63, "  | ", d63, "      | ", d63 - 2, "          |");
print("| (73,24) | ", #F_73, "  | ", #results_73, "  | ", d73, "      | ", d73 - 2, "          |");
print("| (88,35) | ", #F_88, "  | ", #results_88, "  | ", d88, "      | ", d88 - 2, "          |");

\\ Save triples to files
write("/root/proof/perfect-cuboid-problem/scripts/4-descent/selmer_63_38.txt", "");
for(k = 1, #results_63, write("/root/proof/perfect-cuboid-problem/scripts/4-descent/selmer_63_38.txt", results_63[k]));
write("/root/proof/perfect-cuboid-problem/scripts/4-descent/selmer_73_24.txt", "");
for(k = 1, #results_73, write("/root/proof/perfect-cuboid-problem/scripts/4-descent/selmer_73_24.txt", results_73[k]));
write("/root/proof/perfect-cuboid-problem/scripts/4-descent/selmer_88_35.txt", "");
for(k = 1, #results_88, write("/root/proof/perfect-cuboid-problem/scripts/4-descent/selmer_88_35.txt", results_88[k]));

quit;
