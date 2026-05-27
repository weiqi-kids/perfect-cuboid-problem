\\ Phase F: Extreme integer-x search (B = 10^8) on the 4 covers of E_Hm.
\\ Pass 1 only (integer x, b=1), 2*10^8 candidates per cover.
\\ Uses the QR sieve from apply_61_38_extended.gp.

default(parisize, 1000000000);
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

\\ Pass-1-only integer-x search with 9-prime sieve and progress reports.
{ search_cover_int_only(E, cover_data, H_int, sieve_primes, label) =
  my(q, coeffs_data, coeffs, L_denom, sieve_tables, j, p, a,
     val, y_root, x_val, y_val, pt_raw, ord, hits, nontorsion,
     t0, t1, total_tested, survived, is_possible, idx, test_val,
     b, sv_arr, batch, next_report);
  q = cover_data[1];
  coeffs_data = get_quartic_int(q);
  coeffs = coeffs_data[1];
  L_denom = coeffs_data[2];
  print("  [", label, "] building sieve over primes ", sieve_primes, "...");
  sieve_tables = vector(#sieve_primes);
  for(j = 1, #sieve_primes,
    sieve_tables[j] = build_residue_table(coeffs, sieve_primes[j]);
  );

  hits = List();
  nontorsion = List();
  total_tested = 0;
  survived = 0;

  print("  [", label, "] Pass 1: int x in [-", H_int, ", ", H_int, "]");
  t0 = getwalltime();
  b = 1;
  batch = max(1, H_int \ 20);   \\ report every 5% of range
  next_report = -H_int + batch;
  for(a = -H_int, H_int,
    total_tested += 1;
    if(a >= next_report,
      t1 = getwalltime();
      print("    [", label, "] progress: a=", a, "  surv=", survived, "  hits=", #hits,
            "  wall=", (t1-t0)/1000.0, "s");
      next_report = a + batch;
    );
    is_possible = 1;
    for(j = 1, #sieve_primes,
      p = sieve_primes[j];
      idx = ((a % p + p) % p) * p + 1 + 1;   \\ b=1 mod p
      if(sieve_tables[j][idx] == 0, is_possible = 0; break);
    );
    if(!is_possible, next);
    survived += 1;
    val = coeffs[1] + coeffs[2]*a + coeffs[3]*a^2 + coeffs[4]*a^3 + coeffs[5]*a^4;
    test_val = val * L_denom;
    if(test_val < 0, next);
    if(issquare(test_val, &y_root),
       x_val = a;
       y_val = y_root / L_denom;
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
         print("  [", label, "] !!! NONTORSION at x=", a, " => ", pt_raw);
       ,
         print("  [", label, "] [tors ord=", ord, "] x=", a);
       );
    );
  );
  t1 = getwalltime();
  print("  [", label, "] Pass 1 done: tested=", total_tested, " surv=", survived,
        " hits=", #hits, " nontorsion=", #nontorsion, " wall=", (t1-t0)/1000.0, "s");

  [hits, nontorsion];
}

\\ E_Hm
E_Hm = ellinit([1, 0, 0, -4201713691887954766021162410, 103564307677747011646913552825626935447972]);
A2 = 4*E_Hm.a2 + E_Hm.a1^2;
A4 = 16*E_Hm.a4;
A6 = 64*E_Hm.a6;
E_short = ellinit([0, A2, 0, A4, A6]);

print("######################################################################");
print("# PHASE F: EXTREME integer-x search (B = 10^8) on E_Hm 2-covers     #");
print("######################################################################");

covers = ell2cover(E_short);
print("Number of 2-covers (S^2/E[2] basis): ", #covers);

\\ 9-prime sieve (same as extended but trimmed; we keep larger ones for filter)
SIEVE = [5, 7, 11, 13, 17, 29, 37, 41, 43];

B_INT = 100000000;

total_nt = List();
t_global = getwalltime();
{
for(k = 1, #covers,
    print();
    print("========================================================");
    print("Cover #", k, " of ", #covers);
    print("========================================================");
    q_k = covers[k][1];
    print("  q(x) = ", q_k);
    result = search_cover_int_only(E_short, covers[k], B_INT, SIEVE, concat("C", Str(k)));
    print("  TOTAL HITS: ", #result[1], "  NONTORSION: ", #result[2]);
    for(jj = 1, #result[2], listput(total_nt, result[2][jj]));
);
}
t_global_end = getwalltime();

print();
print("######################################################################");
print("Phase F complete:");
print("  total wall time = ", (t_global_end - t_global)/1000.0, "s");
print("  total nontorsion lifts = ", #total_nt);
print("######################################################################");

quit;
