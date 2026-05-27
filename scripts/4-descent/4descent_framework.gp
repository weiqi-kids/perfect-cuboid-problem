\\ 4-descent framework: rational-point search on 2-Selmer covers, lift to E(Q), test non-torsion.
\\ This is the production version, to be applied to E_Hm for the (61,38) borderline fiber.

default(parisize, 1500000000);
default(realprecision, 38);

\\ ----- Quadratic-residue sieve helpers -----
\\ For a quartic q(x) = c_4 x^4 + c_3 x^3 + c_2 x^2 + c_1 x + c_0 over Q,
\\ define f(a, b) = b^4 q(a/b) = c_4 a^4 + c_3 a^3 b + c_2 a^2 b^2 + c_1 a b^3 + c_0 b^4.
\\ We want f(a, b) to be a non-negative integer square.

{ get_quartic_int(q) =
  \\ Return [c0, c1, c2, c3, c4] of f(a, b) = b^4 * q(a/b)
  my(d, cs);
  d = poldegree(q);
  \\ Assume degree 4
  if(d != 4, error("not degree 4"));
  cs = vector(5);
  for(i = 0, 4, cs[i+1] = polcoeff(q, i));
  \\ Clear denominators if any
  L = lcm(apply(c->denominator(c), cs));
  cs = apply(c -> c * L, cs);
  [cs, L];
}

\\ Sieve table per prime
{ build_residue_table(coeffs_int, p) =
  my(table, a, b, val);
  table = vector(p*p);
  for(a = 0, p-1,
    for(b = 0, p-1,
      val = (coeffs_int[1]*b^4 + coeffs_int[2]*a*b^3 + coeffs_int[3]*a^2*b^2
            + coeffs_int[4]*a^3*b + coeffs_int[5]*a^4) % p;
      if(val == 0,
        table[a*p + b + 1] = 1
      ,
        if(issquare(Mod(val, p)), table[a*p + b + 1] = 1, table[a*p + b + 1] = 0)
      );
    );
  );
  table;
}

\\ ----- Lifting point on cover y^2 = q(x) to E(Q) -----
\\ Given cover_data = [q, [X_map, Y_map]] (the second is rat funcs in x, y),
\\ and (x_val, y_val) in Q, return the lift on E.

{ lift_cover_to_E(cover_data, x_val, y_val) =
  my(P_map, X_E, Y_E);
  P_map = cover_data[2];
  X_E = subst(subst(P_map[1], 'x, x_val), 'y, y_val);
  Y_E = subst(subst(P_map[2], 'x, x_val), 'y, y_val);
  [X_E, Y_E];
}

\\ ----- Main search routine with sieving + integer-rational search -----
\\ Args: E (ellinit), cover_data, H_int (search bound for integer x), Hrat (for rational a/b)
{ search_cover(E, cover_data, H_int, H_rat, sieve_primes) =
  my(q, coeffs_data, coeffs, L_denom, sieve_tables, j, p, H, a, b,
     val, y_scaled, x_val, y_val, pt, ord, hits, nontorsion,
     t0, t1, total_tested, survived);
  q = cover_data[1];
  coeffs_data = get_quartic_int(q);
  coeffs = coeffs_data[1];  \\ [c0, c1, c2, c3, c4] integer coeffs after clearing denominators
  L_denom = coeffs_data[2]; \\ multiplier
  print("    cleared-denominator quartic coeffs [c0..c4]: ", coeffs, "  (mult L=", L_denom, ")");
  print("    Computing sieve tables for primes ", sieve_primes, " ...");
  sieve_tables = vector(#sieve_primes);
  for(j = 1, #sieve_primes,
    sieve_tables[j] = build_residue_table(coeffs, sieve_primes[j]);
  );

  hits = List();
  nontorsion = List();
  total_tested = 0;
  survived = 0;
  t0 = getwalltime();

  \\ INTEGER x-search: b = 1, |a| <= H_int
  print("    Phase 1: integer-x search |a| <= ", H_int, " (b=1)");
  b = 1;
  for(a = -H_int, H_int,
    total_tested += 1;
    \\ sieve
    is_possible = 1;
    for(j = 1, #sieve_primes,
      p = sieve_primes[j];
      idx = ((a % p + p) % p) * p + ((b % p + p) % p) + 1;
      if(sieve_tables[j][idx] == 0, is_possible = 0; break);
    );
    if(!is_possible, next);
    survived += 1;
    val = coeffs[1]*b^4 + coeffs[2]*a*b^3 + coeffs[3]*a^2*b^2 + coeffs[4]*a^3*b + coeffs[5]*a^4;
    \\ val = L_denom * b^4 * q(a/b)
    \\ y^2 = q(a/b) = val / (L_denom * b^4)
    \\ For y in Q, need val / L_denom to be a square (since b^4 is a sq)
    \\ y * b^2 * sqrt(L_denom) = sqrt(val) -- so need val/L_denom is a square or val * L_denom is a square
    \\ Simplification: y^2 = q(a/b); we want q(a/b) to be a square in Q.
    \\ q(a/b) = val/(L_denom*b^4). For this to be a square in Q:
    \\   val * L_denom must be a square in Z (times b^4 = sq).
    \\ Let test = val * L_denom; check issquare.
    if(val < 0, next);
    \\ Actually q(a/b) >= 0 iff val/(L_denom b^4) >= 0 iff val and L_denom have same sign
    if(val * L_denom < 0, next);
    test_val = val * L_denom;
    if(test_val < 0, next);
    if(issquare(test_val, &y_root),
       \\ y_root = y * b^2 * L_denom. So y = y_root / (b^2 * L_denom).
       x_val = a/b;
       y_val = y_root / (b^2 * L_denom);
       \\ Verify y_val^2 = q(x_val)
       if(y_val^2 != subst(q, 'x, x_val),
         \\ try negation
         y_val = -y_val;
         if(y_val^2 != subst(q, 'x, x_val),
           print("      [WARN] y_val mismatch a=", a, ", b=", b);
           next;
         );
       );
       \\ Lift
       pt_raw = lift_cover_to_E(cover_data, x_val, y_val);
       if(!ellisoncurve(E, pt_raw),
         pt_raw = lift_cover_to_E(cover_data, x_val, -y_val);
         if(!ellisoncurve(E, pt_raw),
           print("      [WARN] lift not on curve, a=", a, " b=", b);
           next;
         );
       );
       \\ Order
       ord = ellorder(E, pt_raw);
       listput(hits, [a, b, pt_raw, ord]);
       if(ord == 0,
         listput(nontorsion, pt_raw);
         print("      !!! NONTORSION lift at a=", a, "/", b, " -> ", pt_raw, " !!!");
       ,
         print("      [torsion ord=", ord, "] a=", a, "/", b, " -> ", pt_raw);
       );
    );
  );
  t1 = getwalltime();
  print("    Phase 1 done: tested=", total_tested, " survived=", survived, " hits=", #hits, " wall=", (t1-t0)/1000.0, "s");

  \\ RATIONAL search: b > 1, gcd(a,b)=1, |a| <= H_rat * b
  if(H_rat > 1,
    print("    Phase 2: rational a/b search, b=2..", H_rat);
    t0 = getwalltime();
    for(b = 2, H_rat,
      for(a = -H_rat*b, H_rat*b,
        if(gcd(abs(a), b) != 1, next);
        total_tested += 1;
        is_possible = 1;
        for(j = 1, #sieve_primes,
          p = sieve_primes[j];
          idx = ((a % p + p) % p) * p + ((b % p + p) % p) + 1;
          if(sieve_tables[j][idx] == 0, is_possible = 0; break);
        );
        if(!is_possible, next);
        survived += 1;
        val = coeffs[1]*b^4 + coeffs[2]*a*b^3 + coeffs[3]*a^2*b^2 + coeffs[4]*a^3*b + coeffs[5]*a^4;
        if(val * L_denom < 0, next);
        test_val = val * L_denom;
        if(issquare(test_val, &y_root),
           x_val = a/b;
           y_val = y_root / (b^2 * L_denom);
           if(y_val^2 != subst(q, 'x, x_val),
             y_val = -y_val;
             if(y_val^2 != subst(q, 'x, x_val), next);
           );
           pt_raw = lift_cover_to_E(cover_data, x_val, y_val);
           if(!ellisoncurve(E, pt_raw),
             pt_raw = lift_cover_to_E(cover_data, x_val, -y_val);
             if(!ellisoncurve(E, pt_raw), next);
           );
           ord = ellorder(E, pt_raw);
           listput(hits, [a, b, pt_raw, ord]);
           if(ord == 0,
             listput(nontorsion, pt_raw);
             print("      !!! NONTORSION lift at a=", a, "/", b, " -> ", pt_raw, " !!!");
           );
        );
      );
    );
    t1 = getwalltime();
    print("    Phase 2 done: total_tested=", total_tested, " survived=", survived, " hits=", #hits, " wall=", (t1-t0)/1000.0, "s");
  );

  [hits, nontorsion];
}

\\ ----- High-level driver: descent on a given E -----
{ four_descent(E, label, H_int, H_rat, sieve_primes) =
  my(Emin, T, r, covers, k, total_nt, result);
  print("======================================================================");
  print("4-descent on ", label);
  print("======================================================================");
  Emin = ellminimalmodel(E);
  print("E [a1..a6] = ", Emin[1..5]);
  T = elltors(Emin);
  print("Torsion: order=", T[1], "  struct=", T[2]);
  r = ellrank(Emin, 4);
  print("ellrank(E, 4) = ", r);
  covers = ell2cover(Emin);
  print("Non-trivial 2-cover count: ", #covers);
  print("=> dim_F2(S^2(E/Q) / E[2](Q)) = ", #covers);
  if(#covers == 0,
    print("No covers — rank from 2-Selmer is 0 (mod E[2]). Done.");
    return([Emin, []]);
  );
  total_nt = List();
  for(k = 1, #covers,
    print();
    print("--- Cover #", k, " of ", #covers, " ---");
    print("    q(x) = ", covers[k][1]);
    result = search_cover(Emin, covers[k], H_int, H_rat, sieve_primes);
    print("    HITS: ", #result[1], "  NONTORSION lifts: ", #result[2]);
    for(j = 1, #result[2], listput(total_nt, result[2][j]));
  );
  print();
  print("======================================================================");
  print("Summary for ", label);
  print("======================================================================");
  print("Total non-torsion points found across all covers: ", #total_nt);
  if(#total_nt == 0,
    print("VERDICT: No generator found at this height. Rank may be 0 OR Sha has hidden generators.");
  ,
    print("VERDICT: Found non-torsion generators!");
    for(j = 1, #total_nt,
      print("  Gen ", j, ": ", total_nt[j]);
    );
  );
  [Emin, total_nt];
}
