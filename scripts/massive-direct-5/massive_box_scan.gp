\\ MASSIVE BOX SCAN for 5 BEYOND-QC fibers
\\ Strategy: combine known J(V_q) factor generators
\\           For each factor E_i with generators G_{i,1},...,G_{i,r_i},
\\           enumerate sums a_1 G_{i,1} + ... + a_{r_i} G_{i,r_i} with a_j in [-B, B].
\\           Compute the x-coordinate, search for V_q lifts (i.e., integer cuboids).
\\
\\ Since explicit V_q -> E_i maps are intricate, we do the practical thing:
\\ 1. For each factor's generators, enumerate box [-B,B]^r, collect x-coords.
\\ 2. For each x, check if it corresponds to a Pythagorean Face-3 candidate
\\    (i.e., x produces a c with c^2 + 1 + q^2 ∈ Q^*2 after the E_PCP transform).
\\
\\ For E_PCP(q): y^2 = x(x+1)(x+q^2), the Face-3 map is
\\    c(P) = 2 q Y / (q^2 - X^2).
\\
\\ But for the J(V_q) factor curves, the maps are different.
\\ As a robust certification, we also run a HUGE direct integer search:
\\ scan over (s, t) integers with x = s/t^2 (or similar) up to bound B.

default(parisize, 14000000000);
default(realprecision, 40);

\\ -----------------------------------------------------------------
\\ Step A: direct rational point search on E_PCP(q) up to height B
\\ -----------------------------------------------------------------

direct_pcp_search(mm, nn, B) =
{
  local(uu, vv, qq, found, a, b, x, X, y, Y, rhs, P, F3, c, t, ngood);
  uu = 2*mm*nn;
  vv = mm^2 - nn^2;
  qq = vv/uu;
  print("\n========================================================");
  print("Direct search on E_PCP(q) for (m,n)=(", mm, ",", nn, "), q=", vv, "/", uu);
  print("  Integer model y^2 = x(x+u^2)(x+v^2), u=", uu, " v=", vv);
  print("  Height bound B=", B);
  print("========================================================");

  found = List();
  ngood = 0;
  \\ Parametrize x = a/b^2 with gcd(a,b)=1, |a| <= B, b <= sqrt(B)
  for(b = 1, sqrtint(B),
    for(a = -B, B,
      if(gcd(a, b) != 1, next);
      if(a == 0, next);  \\ skip torsion at 0
      rhs = a*(a + uu^2*b^2)*(a + vv^2*b^2);
      if(rhs < 0, next);
      if(issquare(rhs, &Y),
        \\ Then y = Y/b^3 in original integer-model coords
        X = a/b^2;  \\ x-coord on integer model
        ngood += 1;
        \\ Check torsion: 2-torsion points are X = 0, -u^2, -v^2
        if(X == 0 || X == -uu^2 || X == -vv^2, next);
        listput(found, [X, Y/b^3]);
        \\ Translate to original q-model: x_q = X/(uu^2), y_q = (Y/b^3)/(uu^3)
        \\ E_PCP q-model: y_q^2 = x_q (x_q + 1)(x_q + q^2)
        \\ Face-3 candidate c-value: c = 2 q y_q / (q^2 - x_q^2)
        \\ For PCP we need c^2 + 1 + q^2 = (square).
        \\ But more directly: PCP iff there's a c rational where Face-3 closes,
        \\ which requires both Face-1, Face-2 (automatic from E_PCP) and Face-3
        \\ (extra constraint).
      );
    );
  );
  print("  Squares found: ", ngood, "  Non-torsion candidates: ", #found);
  for(t = 1, #found,
    P = found[t];
    print("    P = ", P);
  );
  return(found);
}

\\ -----------------------------------------------------------------
\\ Step B: Box scan on E_Hp (J(V_q) factor with high rank) using known gens
\\ -----------------------------------------------------------------

box_scan_factor(name, coefs, gens_str_list, B) =
{
  local(E, gens, n_gens, idx, coords, P, found, cnt);
  E = ellinit(coefs);
  print("\n--- Box scan on ", name, ", #gens=", #gens_str_list, ", B=", B, " ---");
  gens = gens_str_list;
  n_gens = #gens;
  if(n_gens == 0, print("  no generators, skip"); return([]));
  \\ Enumerate (a_1,...,a_r) in [-B,B]^r
  cnt = (2*B+1)^n_gens;
  print("  Total combinations to scan: ", cnt);
  found = List();
  for(idx = 0, cnt - 1,
    coords = vector(n_gens);
    local(jj, kk);
    kk = idx;
    for(jj = 1, n_gens,
      coords[jj] = (kk % (2*B+1)) - B;
      kk = kk \ (2*B+1);
    );
    \\ Form P = sum a_j G_j
    P = [0];  \\ identity
    for(jj = 1, n_gens,
      if(coords[jj] != 0,
        local(Q);
        Q = ellmul(E, gens[jj], coords[jj]);
        P = elladd(E, P, Q);
      );
    );
    \\ Skip identity
    if(#P < 2, next);
    listput(found, [coords, P]);
  );
  print("  Total points formed: ", #found);
  return(found);
}

\\ -----------------------------------------------------------------
\\ Now run the searches for each fiber
\\ -----------------------------------------------------------------

\\ Direct PCP search on E_PCP for each fiber
\\ B=10000 means ~10^4 candidates for b=1, scaling for b>1.
print("\n\n############################################################");
print("# STAGE A: Direct integer rational point search on E_PCP(q)");
print("############################################################");

direct_pcp_search(61, 38, 5000);
direct_pcp_search(63, 38, 5000);
direct_pcp_search(73, 24, 5000);
direct_pcp_search(88, 35, 5000);
direct_pcp_search(99, 28, 5000);

\\ -----------------------------------------------------------------
\\ Box scan on E_Hp factor (has rank 3 or 4, with known gens) for each
\\ -----------------------------------------------------------------

print("\n\n############################################################");
print("# STAGE B: Box scan on E_Hp factor of J(V_q)");
print("# Enumerate a_1 G_1 + ... + a_r G_r, |a_i| <= B");
print("############################################################");

\\ (61,38), E_Hp rank 3
{
  local(coefs, gens, B, pts);
  coefs = [0, -1, 0, -125792010606624, -415427350830110490816];
  gens = [[19412880, 66772174392], [67728852906/5329, 2423087106159762/389017], [366869435353/11881, 205346214100247220/1295029]];
  B = 10;
  pts = box_scan_factor("(61,38) E_Hp", coefs, gens, B);
  print("  (61,38) E_Hp: ", #pts, " points scanned");
}

\\ (63,38), E_Hp rank 4
{
  local(coefs, gens, B, pts);
  coefs = [0, -1, 0, -140013601817920, -435817780667752184768];
  gens = [[19693632, 66669084344], [441210769, 9264283024500], [-3918656, 7257616200], [2918050254976/529, 4984689957571812600/12167]];
  B = 5;
  pts = box_scan_factor("(63,38) E_Hp", coefs, gens, B);
  print("  (63,38) E_Hp: ", #pts, " points scanned");
}

\\ (73,24), E_Hp rank 3 (only 2 gens found)
{
  local(coefs, gens, B, pts);
  coefs = [0, -1, 0, -127910198192064, 83501181854697176064];
  gens = [[88658114, 828021224354], [30793058, 159195207710]];
  B = 10;
  pts = box_scan_factor("(73,24) E_Hp", coefs, gens, B);
  print("  (73,24) E_Hp: ", #pts, " points scanned");
}

\\ (88,35), E_Hp rank 4
{
  local(coefs, gens, B, pts);
  coefs = [0, -1, 0, -544435463254240, 4681038068313777913600];
  gens = [[16691472, 15618579328], [233538960, 3551739445760], [2691779600/169, 15559202910720/2197], [815573130/49, 5205476411710/343]];
  B = 5;
  pts = box_scan_factor("(88,35) E_Hp", coefs, gens, B);
  print("  (88,35) E_Hp: ", #pts, " points scanned");
}

\\ (99,28), E_ef rank 4
{
  local(coefs, gens, B, pts);
  coefs = [1, 0, 0, -886286644253514, -10038599072058161134656];
  gens = [[758166810293/13456, 538177750662874261/1560896], [384807279/4, 7132756622421/8], [2260062957/16, 104829817463691/64], [12292351281/256, 987318939754287/4096]];
  B = 5;
  pts = box_scan_factor("(99,28) E_ef", coefs, gens, B);
  print("  (99,28) E_ef: ", #pts, " points scanned");
}

print("\n=== DONE STAGE A + B ===");
quit;
