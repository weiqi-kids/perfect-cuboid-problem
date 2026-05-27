\\ Phase α — Direct Selmer enumeration for E_Hm.
\\
\\ Local image at prime p computed via stratified enumeration:
\\   Stratum 0: X mod p = r ∉ {e_i mod p} — X-e_i all units, easy.
\\   Stratum i (i=1,2,3): X = e_i + p^k * u for k=0..2M+1, u ∈ Z_p^*.
\\     We enumerate u mod p^(2M+2-k) (enough to determine square classes).
\\
\\ For p odd: square class = (val mod 2, kronecker of unit). Need u mod p (or mod p^2 if cross-val).
\\ For p = 2: square class = (val mod 2, unit mod 8). Need u mod 2^3.

default(parisize, 1500000000);

\\ === Squarefree part of nonzero integer (with sign) ===
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

\\ === Is x ∈ Q* a square in Q_p (allowing x to be rational)? ===
is_sq_Qp(x, p) =
{
  my(v, u);
  if(x == 0, return(1));
  v = valuation(x, p);
  if(v % 2 != 0, return(0));
  u = x / p^v;
  if(p == 2,
    ((u % 8) + 8) % 8 == 1
    ,
    kronecker(u, p) == 1
  );
}

\\ === Class encoding ===
\\ For p odd: 2-bit code = (v mod 2)*2 + (1 if unit-mod-p is NR else 0). 4 classes.
\\ For p=2: 3-bit code = (v mod 2)*4 + ((unit mod 8 - 1)/2). 8 classes.
\\ class_Qp(x, p) returns -1 if x = 0.
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

\\ Local image enumeration via stratification.
\\
\\ For each prime p, set M = max{v_p(e_i - e_j) : i!=j}.
\\ Stratum 0 (generic): X = r with r ∈ {0..p-1} \ {e_i mod p}. Add class triple if product is square.
\\ Stratum i (near e_i): X = e_i + p^k u, k = 0..2M+1, u ∈ (Z/p^{2M+2-k})^*.
\\   Enumerate u over those residues.

local_image_p_strat(p, e1l, e2l, e3l) =
{
  my(S, M, Mp, P, X, c1, c2, c3, prod, e_arr, ee, i, k, u, lim_u, mod_u);
  e_arr = [e1l, e2l, e3l];
  M = 0;
  for(i = 1, 3,
    for(j = i+1, 3,
      M = max(M, valuation(abs(e_arr[i] - e_arr[j]), p));
    );
  );
  if(p == 2, M = max(M, 3));  \\ ensure at least mod-8 precision
  S = Set([]);

  \\ Stratum 0: generic X mod p
  for(r = 0, p - 1,
    \\ Check r not equal to any e_i mod p
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

  \\ Strata 1, 2, 3 (near e_i): X = e_i + p^k * u, u ∈ Z_p^*, k = 0..2M+2
  for(i = 1, 3,
    ee = e_arr[i];
    for(k = 0, 2*M + 2,
      \\ Enumerate u with v_p(u) = 0. We need u mod p^(2M+3-k), but capped reasonably.
      \\ For X close to e_i with k = v_p(X-e_i), the classes of X-e_j (j!=i) are
      \\ determined by X mod p^{v_p(e_i-e_j) + 1} if v_p(e_i-e_j) < k, or by more if v_p(e_i-e_j) >= k.
      \\ Use mod_u = 2M+3-k, cap at log_p(10^5).
      mod_u = 2 * M + 3 - k;
      if(mod_u < 1, mod_u = 1);
      \\ Cap p^mod_u at 10^5
      while(p^mod_u > 10^5 && mod_u > 1, mod_u = mod_u - 1);
      lim_u = p^mod_u;
      for(u = 0, lim_u - 1,
        \\ u must be a UNIT mod p (so not divisible by p)
        if(u % p == 0, next);
        X = ee + p^k * u;
        \\ Recompute classes (X may equal an e_j; check)
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

  \\ 2-torsion image (limits)
  S = setunion(S, Set([[class_Qp((e1l-e2l)*(e1l-e3l), p), class_Qp(e1l-e2l, p), class_Qp(e1l-e3l, p)]]));
  S = setunion(S, Set([[class_Qp(e2l-e1l, p), class_Qp((e2l-e1l)*(e2l-e3l), p), class_Qp(e2l-e3l, p)]]));
  S = setunion(S, Set([[class_Qp(e3l-e1l, p), class_Qp(e3l-e2l, p), class_Qp((e3l-e1l)*(e3l-e2l), p)]]));
  \\ Identity
  S = setunion(S, Set([[0, 0, 0]]));
  S;
}

\\ Check infinity (R)
check_inf(d1, d2, d3) =
{
  my(s1 = sign(d1), s2 = sign(d2), s3 = sign(d3));
  if(s1 == 1 && s2 == 1 && s3 == 1, return(1));
  if(s1 == 1 && s2 == -1 && s3 == -1, return(1));
  0;
}

\\ Main: enumerate triples
run_selmer(curve_e1, curve_e2, curve_e3, F, BAD, name) =
{
  my(nF, total, count, results, Lp, d1, d2, d3, NN, c1, c2, c3, ok, p, img);
  print("");
  print("=================================================");
  print("Selmer enumeration for: ", name);
  print("=================================================");
  print("e1=", curve_e1, "  e2=", curve_e2, "  e3=", curve_e3);
  print("Factor base F (size ", #F, "): ", F);
  print("Bad primes BAD: ", BAD);
  nF = #F;
  total = 2^nF;
  print("(d1, d2) candidates: ", total^2);

  print("Computing local images...");
  Lp = vector(#BAD);
  for(j = 1, #BAD,
    p = BAD[j];
    gettime();
    Lp[j] = local_image_p_strat(p, curve_e1, curve_e2, curve_e3);
    my(t = gettime());
    print("  p=", p, "  |L_p|=", #Lp[j], "  time=", t, "ms");
  );

  count = 0;
  results = List();
  gettime();
  for(i1 = 0, total - 1,
    d1 = 1;
    for(k = 1, nF, if(bittest(i1, k-1), d1 *= F[k]));
    for(i2 = 0, total - 1,
      d2 = 1;
      for(k = 1, nF, if(bittest(i2, k-1), d2 *= F[k]));
      d3 = sqf(d1 * d2);
      ok = check_inf(d1, d2, d3);
      if(ok,
        for(j = 1, #BAD,
          p = BAD[j];
          img = Lp[j];
          c1 = class_Qp(d1, p);
          c2 = class_Qp(d2, p);
          c3 = class_Qp(d3, p);
          if(!setsearch(img, [c1, c2, c3]),
            ok = 0; break);
        );
      );
      if(ok,
        count += 1;
        listput(results, [d1, d2, d3]);
      );
    );
  );
  my(t = gettime());
  print("Found |S²| = ", count, "  (enum time = ", t, "ms)");
  results;
}

\\ ============================================
\\ T1 validation: y² = x(x-1)(x-2)
\\ ============================================
print("");
print("==== Validation T1 ====");
results_T1 = run_selmer(0, 1, 2, [-1, 2], [2], "T1: y^2 = x(x-1)(x-2), rk=0");
print("Triples T1:");
for(k = 1, #results_T1, print("  ", results_T1[k]));

\\ ============================================
\\ T4 validation: y² = x(x-7)(x+7)
\\ ============================================
print("");
print("==== Validation T4 ====");
results_T4 = run_selmer(-7, 0, 7, [-1, 2, 7], [2, 7], "T4: y^2 = x(x-7)(x+7), rk=1");
print("Triples T4:");
for(k = 1, #results_T4, print("  ", results_T4[k]));

\\ ============================================
\\ E_Hm: y² = (X-e1)(X-e2)(X-e3) for the (61,38) borderline fiber
\\ ============================================
e1_EHm = -298991117938864;
e2_EHm = 136054851567711;
e3_EHm = 162936266371152;
F_EHm = [-1, 2, 3, 5, 7, 11, 19, 23, 31, 61, 223, 337, 1033];
BAD_EHm = [2, 3, 5, 7, 11, 19, 23, 31, 61, 223, 337, 1033];
print("");
print("==== E_Hm full enumeration ====");
results_EHm = run_selmer(e1_EHm, e2_EHm, e3_EHm, F_EHm, BAD_EHm, "E_Hm (61,38) borderline");
print("");
print("Triples (E_Hm):");
for(k = 1, #results_EHm, print("  ", results_EHm[k]));

\\ Save triples for Phase β
write("/root/proof/perfect-cuboid-problem/scripts/4-descent/EHm_selmer_results.txt",
      "dim_S2 = log2(", #results_EHm, ")");
{
for(k = 1, #results_EHm,
  write("/root/proof/perfect-cuboid-problem/scripts/4-descent/EHm_selmer_results.txt",
        results_EHm[k]);
);
}

quit;
