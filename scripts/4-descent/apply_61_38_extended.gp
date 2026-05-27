\\ Extended apply to E_Hm: higher search bounds + verify local solubility + try high effort.

default(parisize, 2000000000);
default(realprecision, 50);

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

{ search_cover_ext(E, cover_data, H_int, H_rat, sieve_primes, label) =
  my(q, coeffs_data, coeffs, L_denom, sieve_tables, j, p, a, b,
     val, y_root, x_val, y_val, pt_raw, ord, hits, nontorsion,
     t0, t1, total_tested, survived, is_possible, idx, test_val);
  q = cover_data[1];
  coeffs_data = get_quartic_int(q);
  coeffs = coeffs_data[1];
  L_denom = coeffs_data[2];
  print("  [", label, "] building sieve...");
  sieve_tables = vector(#sieve_primes);
  for(j = 1, #sieve_primes,
    sieve_tables[j] = build_residue_table(coeffs, sieve_primes[j]);
  );

  hits = List();
  nontorsion = List();
  total_tested = 0;
  survived = 0;

  print("  [", label, "] Phase 1: int x in [-", H_int, ", ", H_int, "]");
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
         if(!ellisoncurve(E, pt_raw), next);
       );
       ord = ellorder(E, pt_raw);
       listput(hits, [a, b, pt_raw, ord]);
       if(ord == 0,
         listput(nontorsion, pt_raw);
         print("  [", label, "] !!! NONTORSION at x=", a, "/", b, " => ", pt_raw);
       ,
         print("  [", label, "] [tors ord=", ord, "] x=", a, "/", b);
       );
    );
  );
  t1 = getwalltime();
  print("  [", label, "] Phase 1: tested=", total_tested, " surv=", survived, " hits=", #hits, " wall=", (t1-t0)/1000.0, "s");

  if(H_rat > 1,
    print("  [", label, "] Phase 2: a/b, b=2..", H_rat);
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
             print("  [", label, "] !!! NONTORSION at x=", a, "/", b);
           );
        );
      );
    );
    t1 = getwalltime();
    print("  [", label, "] Phase 2: total_tested=", total_tested, " surv=", survived, " hits=", #hits, " wall=", (t1-t0)/1000.0, "s");
  );

  [hits, nontorsion];
}

\\ E_Hm
E_Hm = ellinit([1, 0, 0, -4201713691887954766021162410, 103564307677747011646913552825626935447972]);
A2 = 4*E_Hm.a2 + E_Hm.a1^2;
A4 = 16*E_Hm.a4;
A6 = 64*E_Hm.a6;
E_short = ellinit([0, A2, 0, A4, A6]);

print("######################################################################");
print("# PHASE E EXT: Higher-bound search on E_Hm 2-covers                 #");
print("######################################################################");

\\ Higher-effort ellrank
print();
print("Trying ellrank(E_short, 5) ...");
t0 = getwalltime();
r5 = ellrank(E_short, 5);
t1 = getwalltime();
print("  ellrank(E_short, 5) = ", r5);
print("  wall = ", (t1-t0)/1000.0, "s");
print();

\\ Get covers
covers = ell2cover(E_short);
print("Number of 2-covers (S^2/E[2] basis): ", #covers);
print();

\\ Sieve primes including 2, 3 reduction (modulo bad primes)
SIEVE = [5, 7, 11, 13, 17, 29, 37, 41, 43, 47, 53, 59, 67, 71];

\\ Total nontorsion
total_nt = List();
{
for(k = 1, #covers,
    print();
    print("========================================================");
    print("Cover #", k, " of ", #covers);
    print("========================================================");
    q_k = covers[k][1];
    print("  q(x) = ", q_k);
    print("  c0 = ", polcoeff(q_k, 0), ", c4 = ", polcoeff(q_k, 4));
    print("  disc(q) = ", poldisc(q_k));
    print("  factored disc = ", factor(abs(poldisc(q_k))));
    \\ Try a higher search
    result = search_cover_ext(E_short, covers[k], 2000000, 500, SIEVE, concat("C", Str(k)));
    print("  TOTAL HITS: ", #result[1], "  NONTORSION: ", #result[2]);
    for(jj = 1, #result[2], listput(total_nt, result[2][jj]));
);
}

print();
print("######################################################################");
print("Final summary: nontorsion = ", #total_nt);
print("######################################################################");

quit;
