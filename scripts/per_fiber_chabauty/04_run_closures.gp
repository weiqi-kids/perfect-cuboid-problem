\\ 04_run_closures.gp — Run Halcke elliptic-Chabauty closure on all 10 rank-0 fibers
\\ plus the 2 reference fibers (8,3) and (88,35).

default(parisize, 2*10^9);
default(realprecision, 38);
read("lib.gp");

\\ ---- Same helpers as 03 ----
full_torsion(E) = my(t, struct, gens); \
  t = elltors(E); struct = t[2]; gens = t[3]; \
  if(length(struct) == 0, [[0]], \
  if(length(struct) == 1, vector(struct[1], i, ellmul(E, gens[1], i-1)), \
  if(length(struct) == 2, concat(vector(struct[1], i, vector(struct[2], j, elladd(E, ellmul(E, gens[1], i-1), ellmul(E, gens[2], j-1))))), \
  [])));

\\ Returns: [num_rational_Y, num_degenerate, num_impossible, num_PCP_candidate, verdict_string]
halcke_close_summary(m, n) = my(a, b, d, ABC, E, all, n_rat, n_deg, n_imp, n_pcp, P, x_un, y_un, s, Y, csq, q, F3); \
  a = m^2 - n^2; b = 2*m*n; d = m^2 + n^2; ABC = a^2 * b^2 * d^2; q = b/a; \
  E = ellinit([0, b^2*a^2 + d^2*b^2 + d^2*a^2, 0, \
              b^2*a^2*d^2*b^2 + b^2*a^2*d^2*a^2 + d^2*b^2*d^2*a^2, \
              b^2*a^2 * d^2*b^2 * d^2*a^2]); \
  all = full_torsion(E); \
  n_rat = 0; n_deg = 0; n_imp = 0; n_pcp = 0; \
  pcp_details = []; \
  rational_Ys = []; \
  for(k = 1, length(all), \
    P = all[k]; \
    if(length(P) == 1, \
      n_deg = n_deg + 1; \
      next; \
    ); \
    x_un = P[1]; y_un = P[2]; \
    if(x_un == 0, n_deg = n_deg + 1; next); \
    s = -ABC / x_un; \
    if(!issquare(s), next); \
    n_rat = n_rat + 1; \
    Y = sqrtint(numerator(s)) / sqrtint(denominator(s)); \
    rational_Ys = concat(rational_Ys, [Y, -Y]); \
    csq = Y^2 - d^2; \
    if(csq == 0, n_deg = n_deg + 2; next); \
    if(csq < 0, n_imp = n_imp + 2; next); \
    if(issquare(csq), \
      my(c = sqrtint(numerator(csq))/sqrtint(denominator(csq))); \
      F3 = c^2 + 1 + q^2; \
      if(issquare(F3), n_pcp = n_pcp + 2; pcp_details = concat(pcp_details, [[c, F3]]); print("!!! PCP CANDIDATE c=", c, " (m,n)=(", m,",",n,")")) \
    ); \
  ); \
  rational_Ys = vecsort(Set(rational_Ys)); \
  [n_rat, n_deg, n_imp, n_pcp, length(all), rational_Ys, pcp_details, q];

print("=== HALCKE CLOSURE ON ALL PROVEN-RANK-0 FIBERS ===");
print();
print("Each row: (m,n) q a b d  |torsion|  rational_Y_count  Y_list  c_status  verdict");
print();

\\ All Halcke-closable: the 10 proven-rank-0 from survey + the 2 reference fibers
\\ Also include (88,35) reference
proven_zero = [[8,3], [88,35], [205,66], [341,208], [451,152], [506,47], [538,279], [592,539], [737,574], [834,361], [943,206], [988,321]];

write("closure_results.txt", "# m n a b d |T| nrat_Y nDeg nImp nPCP Y_list q verdict");

{
  for(k = 1, length(proven_zero),
    mn = proven_zero[k];
    m = mn[1]; n = mn[2];
    a = m^2-n^2; b = 2*m*n; d = m^2+n^2; q = b/a;
    print1("(", m, ",", n, ") q=", numerator(q), "/", denominator(q), " a=", a, " b=", b, " d=", d, "  ");
    res = halcke_close_summary(m, n);
    nrat = res[1]; ndeg = res[2]; nimp = res[3]; npcp = res[4]; tsize = res[5]; ys = res[6]; pcpd = res[7];
    verdict = if(npcp == 0, "CLOSED-no-PCP", Str("!!! PCP-candidates: ", pcpd));
    print("|T|=", tsize, " #rat_Y=", nrat, "  Ys=", ys, "  #Deg=", ndeg, " #Imp=", nimp, " #PCP=", npcp, "  | ", verdict);
    write("closure_results.txt", m, " ", n, " ", a, " ", b, " ", d, " ", tsize, " ", nrat, " ", ndeg, " ", nimp, " ", npcp, " \"", ys, "\" ", numerator(q), "/", denominator(q), " ", verdict)
  );
}

print();
print("DONE. closure_results.txt written.");
quit;
