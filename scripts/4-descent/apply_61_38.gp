\\ Apply 4-descent framework to E_Hm for (61, 38) borderline fiber.

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
  print("    cleared-denom coeffs [c0..c4]: ", coeffs);
  print("    L (denom multiplier) = ", L_denom);
  print("    Building sieve tables for primes ", sieve_primes);
  sieve_tables = vector(#sieve_primes);
  for(j = 1, #sieve_primes,
    sieve_tables[j] = build_residue_table(coeffs, sieve_primes[j]);
  );

  hits = List();
  nontorsion = List();
  total_tested = 0;
  survived = 0;

  print("    Phase 1: integer x in [-", H_int, ", ", H_int, "]");
  t0 = getwalltime();
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
         if(!ellisoncurve(E, pt_raw),
           print("      WARN lift not on curve a=", a, " b=", b);
           next;
         );
       );
       ord = ellorder(E, pt_raw);
       listput(hits, [a, b, pt_raw, ord]);
       if(ord == 0,
         listput(nontorsion, pt_raw);
         print("      !!! NONTORSION at a=", a, "/", b, " -> ", pt_raw);
       ,
         print("      [tors ord=", ord, "] a=", a, "/", b);
       );
    );
  );
  t1 = getwalltime();
  print("    Phase 1: tested=", total_tested, " surv=", survived, " hits=", #hits, " wall=", (t1-t0)/1000.0, "s");

  if(H_rat > 1,
    print("    Phase 2: rational a/b, b=2..", H_rat);
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

\\ E_Hm: original
E_Hm = ellinit([1, 0, 0, -4201713691887954766021162410, 103564307677747011646913552825626935447972]);

\\ E_short: integer short Weierstrass with full 2-tors integer
A2 = 4*E_Hm.a2 + E_Hm.a1^2;
A4 = 16*E_Hm.a4;
A6 = 64*E_Hm.a6;
E_short = ellinit([0, A2, 0, A4, A6]);

print("######################################################################");
print("# PHASE E: 4-descent on E_Hm for (61, 38)                            #");
print("######################################################################");
print();
print("E_short [a..]: ", E_short[1..5]);
print("Torsion of E_short: ", elltors(E_short));
print();

\\ Sanity: ellrank on E_short
print("ellrank(E_short, 4):");
t0 = getwalltime();
r = ellrank(E_short, 4);
t1 = getwalltime();
print("  ", r, "  wall=", (t1-t0)/1000.0, "s");
print();

\\ Get covers
print("ell2cover(E_short):");
t0 = getwalltime();
covers = ell2cover(E_short);
t1 = getwalltime();
print("  count = ", #covers, "  wall=", (t1-t0)/1000.0, "s");
print("  dim_F2(S^2(E_short/Q) / E_short[2](Q)) = ", #covers);
print("  => |S^2/E[2]| = ", 2^#covers);
print();

print("Cover quartics:");
{ for(k = 1, #covers,
    print("  Cover #", k, ": q(x) = ", covers[k][1]);
  );
}
print();

\\ Sieve primes: skip 2, 3 (bad), use medium primes
SIEVE = [5, 7, 11, 13, 17, 19, 23, 29, 31, 37, 41];

\\ Search each cover at moderate height
total_nt = List();
{ for(k = 1, #covers,
    print();
    print("==================================================================");
    print("Searching Cover #", k, " of ", #covers);
    print("==================================================================");
    print("  q(x) = ", covers[k][1]);
    \\ For E_Hm with huge coefficients, even moderate x is computationally heavy.
    \\ Use H_int = 200000, H_rat = 200.
    result = search_cover(E_short, covers[k], 200000, 200, SIEVE);
    print("  Cover #", k, ": HITS=", #result[1], "  NONTORSION=", #result[2]);
    for(j = 1, #result[2], listput(total_nt, result[2][j]));
  );
}

print();
print("######################################################################");
print("# PHASE E RESULT");
print("######################################################################");
print("Total non-torsion lifts across all ", #covers, " covers: ", #total_nt);
{ if(#total_nt == 0,
    print();
    print("VERDICT: NO GENERATOR FOUND in this search range.");
    print("  Search bound: integer x up to 200000, rational a/b with |a|, b <= 200");
    print("  This does NOT prove rk(E_Hm) = 0 — a generator may lie higher,");
    print("  or the rank is genuinely 0 with all 4 covers in Sha[2].");
  ,
    print();
    print("VERDICT: GENERATOR(S) FOUND. rk(E_Hm) >= 1, forced to 2 by parity.");
    for(j = 1, #total_nt,
      print("  Generator ", j, ": ", total_nt[j]);
      if(ellisoncurve(E_short, total_nt[j]),
        print("    verified on E_short, order = ", ellorder(E_short, total_nt[j]));
        print("    canonical height = ", ellheight(E_short, total_nt[j]));
      );
    );
  );
}
print();

quit;
