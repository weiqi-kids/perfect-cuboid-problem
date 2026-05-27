\\ 03_halcke_closure.gp — Apply Halcke elliptic-Chabauty template per fiber.
\\
\\ For each fiber (m, n) with proven rank(E_Hm) = 0:
\\   1. Build E_Hm un-substituted: y^2 = (x + b^2 a^2)(x + d^2 b^2)(x + d^2 a^2)
\\      where a = m^2-n^2, b = 2mn, d = m^2+n^2.
\\   2. elltors → 16-point torsion subgroup (Z/8 ⊕ Z/2 typically).
\\   3. For each torsion T = (x_un, y_un) (not identity):
\\        compute s = -ABC / x_un, where ABC = a^2 b^2 d^2.
\\        compute t = y_un * ABC / x_un^2.
\\        If s is a perfect rational square, Y = ±sqrt(s) gives rational H-point.
\\   4. For each rational Y: c^2 = Y^2 - d^2.
\\        If c^2 == 0:    DEGENERATE (Y = ±d, c = 0)
\\        If c^2 < 0:     IMPOSSIBLE (degenerate by negativity)
\\        If c^2 > 0 and c^2 is square:  c is rational, push to Face-3: F3 = c^2+1+q^2.
\\          (But c^2 from non-degenerate Y on H requires c^2 + d^2 = Y^2, which means
\\          c^2 ∈ {Y^2 - d^2 | Y rational ≠ ±d}.)
\\   5. Confirm all rational H-points are degenerate. No PCP candidate.

default(parisize, 2*10^9);
default(realprecision, 38);
read("lib.gp");

\\ Enumerate the full torsion subgroup of an elliptic curve E given elltors output.
\\ Returns list of points (each [x, y] or [0] for identity).
full_torsion(E) = my(t, struct, gens, all); \
  t = elltors(E); struct = t[2]; gens = t[3]; \
  if(length(struct) == 0, [[0]], \
  if(length(struct) == 1, vector(struct[1], i, ellmul(E, gens[1], i-1)), \
  if(length(struct) == 2, concat(vector(struct[1], i, vector(struct[2], j, elladd(E, ellmul(E, gens[1], i-1), ellmul(E, gens[2], j-1))))), \
  [])));

\\ Halcke closure for a single fiber (m,n)
halcke_close(m, n) = my(a, b, d, ABC, E, tors, all, results, P, x_un, y_un, s, t_val, is_sq, Y_num, Y_den, csq); \
  a = m^2 - n^2; b = 2*m*n; d = m^2 + n^2; ABC = a^2 * b^2 * d^2; \
  print("=== Halcke closure (m,n)=(", m, ",", n, ")  a=", a, " b=", b, " d=", d, " ==="); \
  E = ellinit([0, b^2*a^2 + d^2*b^2 + d^2*a^2, 0, \
              b^2*a^2*d^2*b^2 + b^2*a^2*d^2*a^2 + d^2*b^2*d^2*a^2, \
              b^2*a^2 * d^2*b^2 * d^2*a^2]); \
  tors = elltors(E); \
  print("torsion: ", tors[2], " gens=", tors[3]); \
  all = full_torsion(E); \
  print("|torsion| = ", length(all)); \
  results = []; \
  for(k = 1, length(all), \
    P = all[k]; \
    if(length(P) == 1, \
      results = concat(results, [[0, "identity", "H ∞_+", "degen"]]), \
      x_un = P[1]; y_un = P[2]; \
      if(x_un == 0, \
        results = concat(results, [[0, [0, y_un], "H ∞", "degen"]]), \
        s = -ABC / x_un; \
        t_val = y_un * ABC / x_un^2; \
        is_sq = issquare(s); \
        if(!is_sq, \
          results = concat(results, [[k, P, ["s=", s], "irrational Y — discard"]]), \
          Y_num = if(s>=0, sqrtint(numerator(s)), 0); \
          Y_den = if(s>=0 && denominator(s)>0, sqrtint(denominator(s)), 1); \
          Y_pos = Y_num / Y_den; \
          csq = Y_pos^2 - d^2; \
          verdict = if(csq == 0, "DEGENERATE (Y=±d, c=0)", \
                    if(csq < 0, "IMPOSSIBLE (c^2<0)", \
                       if(issquare(csq), \
                         my(c = sqrtint(numerator(csq))/sqrtint(denominator(csq))); \
                         my(q = b/a); my(F3 = c^2 + 1 + q^2); \
                         if(issquare(F3), Str("!!! PCP CANDIDATE c=", c), Str("c=",c," but F3 not square")), \
                         "c not rational"))); \
          results = concat(results, [[k, P, [Str("Y=±", Y_pos)], verdict]]); \
        ); \
      ); \
    ); \
  ); \
  print("\nresults:"); \
  for(k = 1, length(results), print("  T", results[k][1], ": ", results[k][2], " → ", results[k][3], " | ", results[k][4])); \
  print(""); \
  results;

\\ Test on Halcke (8, 3) first (known result: all 8 H-points degenerate)
print("\n*** Sanity test: Halcke (8, 3) ***");
halcke_close(8, 3);

\\ Then on (88, 35) — should also yield only degenerate.
print("\n*** Saunderson (88, 35) ***");
halcke_close(88, 35);

quit;
