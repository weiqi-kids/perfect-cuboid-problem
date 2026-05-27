\\ Test the framework against PARI's ellrank on small curves.
\\ Functions defined inline.

default(parisize, 1500000000);
default(realprecision, 38);

{ get_quartic_int(q) =
  my(d, cs, L);
  d = poldegree(q);
  if(d != 4, error("not degree 4"));
  cs = vector(5);
  for(i = 0, 4, cs[i+1] = polcoeff(q, i));
  L = lcm(apply(c->denominator(c), cs));
  cs = apply(c -> c * L, cs);
  [cs, L];
}

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

{ lift_cover_to_E(cover_data, x_val, y_val) =
  my(P_map, X_E, Y_E);
  P_map = cover_data[2];
  X_E = subst(subst(P_map[1], 'x, x_val), 'y, y_val);
  Y_E = subst(subst(P_map[2], 'x, x_val), 'y, y_val);
  [X_E, Y_E];
}

{ search_cover(E, cover_data, H_int, H_rat, sieve_primes) =
  my(q, coeffs_data, coeffs, L_denom, sieve_tables, j, p, a, b,
     val, y_root, x_val, y_val, pt_raw, ord, hits, nontorsion,
     t0, t1, total_tested, survived, is_possible, idx, test_val);
  q = cover_data[1];
  coeffs_data = get_quartic_int(q);
  coeffs = coeffs_data[1];
  L_denom = coeffs_data[2];
  print("    cleared-denom coeffs [c0..c4]: ", coeffs, "  L=", L_denom);
  print("    Building sieve tables for primes ", sieve_primes);
  sieve_tables = vector(#sieve_primes);
  for(j = 1, #sieve_primes,
    sieve_tables[j] = build_residue_table(coeffs, sieve_primes[j]);
  );

  hits = List();
  nontorsion = List();
  total_tested = 0;
  survived = 0;
  t0 = getwalltime();

  \\ Phase 1: integer
  b = 1;
  for(a = -H_int, H_int,
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
    test_val = val * L_denom;
    if(test_val < 0, next);
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
         print("      !!! NONTORSION at a=", a, "/", b, " -> ", pt_raw);
       );
    );
  );
  t1 = getwalltime();
  print("    Phase 1: tested=", total_tested, " surv=", survived, " hits=", #hits, " wall=", (t1-t0)/1000.0, "s");

  if(H_rat > 1,
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
        test_val = val * L_denom;
        if(test_val < 0, next);
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
             print("      !!! NONTORSION at a=", a, "/", b, " -> ", pt_raw);
           );
        );
      );
    );
    t1 = getwalltime();
    print("    Phase 2: total_tested=", total_tested, " surv=", survived, " hits=", #hits, " wall=", (t1-t0)/1000.0, "s");
  );

  [hits, nontorsion];
}

{ four_descent(E, label, H_int, H_rat, sieve_primes) =
  my(Emin, T, r, covers, k, j, total_nt, result);
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
  print("Non-trivial 2-cover count (dim_F2 S^2/E[2]): ", #covers);
  if(#covers == 0,
    print("No covers. rank from 2-Selmer = 0.");
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
  print("=====================================================================");
  print("Summary for ", label);
  print("=====================================================================");
  print("Total non-torsion lifts: ", #total_nt);
  if(#total_nt == 0,
    print("VERDICT (at this height): NO GENERATOR FOUND.");
    print("rk may be 0 OR generator hides above search bound OR in Sha[2].");
  ,
    print("VERDICT: GENERATOR(S) FOUND. rk >= 1.");
    for(j = 1, #total_nt, print("  Gen ", j, ": ", total_nt[j]));
  );
  [Emin, total_nt];
}

print();
print("##############################################");
print("# PHASE D: Test framework on small curves    #");
print("##############################################");

four_descent(ellinit([0,-3,0,2,0]), "Test 1: y^2 = x(x-1)(x-2), expected rk=0", 200, 20, [3,5,7,11,13]);
four_descent(ellinit([0,0,0,-1,0]), "Test 2: y^2 = x(x-1)(x+1), expected rk=0", 200, 20, [3,5,7,11,13]);
four_descent(ellinit([0,-3,0,-4,0]), "Test 3: y^2 = x(x-4)(x+1)", 200, 20, [3,5,7,11,13]);
four_descent(ellinit([0,0,0,-49,0]), "Test 4: y^2 = x(x-7)(x+7), expected rk=1", 200, 20, [3,5,7,11,13]);
four_descent(ellinit([0,-26,0,25,0]), "Test 5: y^2 = x(x-1)(x-25)", 200, 20, [3,5,7,11,13]);

print();
print("##############################################");
print("# Phase D done.                              #");
print("##############################################");
quit;
