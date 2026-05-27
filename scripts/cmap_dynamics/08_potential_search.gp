/* Search for a potential function V(q) such that V is monotone along
   c-map orbits, even when h(q) is not.

   Candidates to test on the 40 edges:
   1. V_lN = log_N(E_PCP(q)) — log conductor
   2. V_disc = log|disc(E_min)| — log discriminant
   3. V_h = log_height(q)
   4. V_h_face = log_height of (1+q^2)'s numerator (i.e., the hypotenuse squared)
   5. V_combo = log_N + log_height
   6. V_F3 = numerator(F3) + denominator(F3)
   7. V_disc_qc = log|disc(E_q)| + log|disc(E_c)| (symmetric)
   8. V_m_n = m + n where q = 2mn/(m^2-n^2) (the "level" of the Pyth triple)

   For each candidate V, compute V(c) - V(q) on each edge, and tabulate
   how often V(c) < V(q) (descent), V(c) > V(q) (ascent), or V(c) = V(q) (level).
*/

default(parisize, 1500000000);

canonical_q(qv) = my(n=abs(numerator(qv)), d=abs(denominator(qv))); if (n<=d, n/d, d/n);
log_height(qv) = log(max(abs(numerator(qv)), abs(denominator(qv))));

gens_db = Map();
mapput(gens_db, 20/21, [[-125/4, 395/8]]);
mapput(gens_db, 7/24, [[-317/4, 3887/8]]);
mapput(gens_db, 11/60, [[-185, 9745], [-515, 7270]]);
mapput(gens_db, 48/55, [[-282, 1956]]);
mapput(gens_db, 20/99, [[-965, 44950]]);
mapput(gens_db, 96/247, [[-2260, 581138]]);
mapput(gens_db, 13/84, [[20195/4, 2796619/8]]);
mapput(gens_db, 39/80, [[-900, 9030]]);
mapput(gens_db, 17/144, [[-1920, 142332], [-3348, 48084]]);
mapput(gens_db, 104/153, [[-2894, 44542], [-2998, 7934]]);
mapput(gens_db, 44/117, [[-1965, 38553]]);
mapput(gens_db, 189/340, [[24850, 3252595]]);
mapput(gens_db, 60/91, [[-210, 17805]]);
mapput(gens_db, 225/272, [[-4136, 330088]]);
mapput(gens_db, 132/475, [[-899/144, 5897298719/1728]]);
mapput(gens_db, 252/275, [[-6886, 146663], [-7306, 22553]]);
mapput(gens_db, 140/171, [[-482665/169, 164460005/2197]]);
mapput(gens_db, 85/132, [[-2281, 16313]]);
mapput(gens_db, 108/725, [[360149, 211594238], [39359, 1286048]]);
mapput(gens_db, 57/176, [[-1504, 229442]]);
mapput(gens_db, 135/352, [[-5496, 1741338]]);
mapput(gens_db, 27/364, [[3002, 1265339], [7553, 590681]]);
mapput(gens_db, 25/312, [[-48542/9, 37856650/27]]);
mapput(gens_db, 28/195, [[7394, 493943]]);
mapput(gens_db, 52/165, [[-1346, 190513], [3274, 91183]]);
mapput(gens_db, 160/231, [[-6620, 115510]]);
mapput(gens_db, 95/168, [[3398, 72536]]);
mapput(gens_db, 105/208, [[-13117/4, 2768779/8]]);
mapput(gens_db, 52/675, [[5389, 9242848]]);
mapput(gens_db, 36/323, [[572049/121, 768697884/1331]]);
mapput(gens_db, 195/748, [[151491/4, 15203079/8], [53369, 2563403], [40343619, 256228408278]]);

build_E(q) = ellinit([0, 1+q^2, 0, q^2, 0]);
cond_E(q) = my(E=build_E(q), Em=ellminimalmodel(E)); ellglobalred(Em)[1];
disc_min(q) = my(E=build_E(q), Em=ellminimalmodel(E)); Em.disc;

cmap_c(q, P_emin) =
{
  my(E = build_E(q), v, P_E, c);
  ellminimalmodel(E, &v);
  P_E = ellchangepointinv(P_emin, v);
  if (P_E[1]^2 == q^2, return(0));
  2*q*P_E[2]/(q^2 - P_E[1]^2);
};

/* Reconstruct (m, n) primitive Pyth parameters from q (canonical 0<q<=1).
   For q = a/b in lowest terms, find (m,n) such that 1+q^2 = ((m^2+n^2)/(m^2-n^2))^2
   if q = 2mn/(m^2-n^2), or q = (m^2-n^2)/(2mn).  Express as triples by 1+q^2 = h^2.
*/
mn_level(q) =
{
  my(N = numerator(q), D = denominator(q), Hyp);
  Hyp = sqrtint(N*N + D*D);  /* integer hypotenuse since (a,b,h) Pyth triple */
  /* Now (D, N, Hyp) is a Pythagorean triple (canonical, D >= N).
     Parameter (m, n) with m > n > 0, gcd(m,n)=1, opposite parities:
     a = m^2-n^2, b = 2mn, h = m^2+n^2  OR  a = 2mn, b = m^2-n^2.
     m+n  = sqrt(a+h)  if a = m^2-n^2 (since a+h = 2m^2).
     Try both: */
  my(b_, a_);
  if (D > N, a_ = D; b_ = N, a_ = N; b_ = D);
  /* Try a = m^2-n^2: a+h = 2m^2, h-a = 2n^2 */
  my(m2 = (a_ + Hyp)/2, n2 = (Hyp - a_)/2);
  if (issquare(m2) && issquare(n2),
    my(m = sqrtint(m2), n = sqrtint(n2));
    if (m*m + n*n == Hyp && m*m - n*n == a_ && 2*m*n == b_,
      return([m, n, m+n]);
    );
  );
  /* Try a = 2mn: then b = m^2-n^2 */
  my(m22 = (b_ + Hyp)/2, n22 = (Hyp - b_)/2);
  if (issquare(m22) && issquare(n22),
    my(m = sqrtint(m22), n = sqrtint(n22));
    if (m*m + n*n == Hyp && m*m - n*n == b_ && 2*m*n == a_,
      return([m, n, m+n]);
    );
  );
  return([-1, -1, -1]);  /* failed */
};

print("=== Potential function search ===");
print("");

src_list = [20/21, 7/24, 11/60, 48/55, 20/99, 96/247, 13/84, 39/80, 17/144, 104/153, 44/117, 189/340, 60/91, 225/272, 132/475, 252/275, 140/171, 85/132, 108/725, 57/176, 135/352, 27/364, 25/312, 28/195, 52/165, 160/231, 95/168, 105/208, 52/675, 36/323, 195/748];

edges = List();

{
for (i = 1, length(src_list),
  my(q = src_list[i], gens = mapget(gens_db, q));
  for (k = 1, length(gens),
    my(c, c_can);
    c = cmap_c(q, gens[k]);
    if (c == 0, next);
    c_can = canonical_q(c);
    listput(edges, [q, c_can]);
  );
);
}

print("Total edges: ", #edges);
print("");

/* Now compute potential candidates on each edge */
print("Candidate potentials: 1=lN, 2=ldisc, 3=lh, 4=l(mn), 5=l(m+n), 6=l(N+|disc|/N)");
print("");
print("For each potential V, count: descent (V(c)<V(q)), ascent (V(c)>V(q)), level");
print("");

V_count = vector(8);
V_names = ["lN", "ldisc", "lh", "l(m*n)", "l(m+n)", "lN_p_ldisc", "h_p_lN", "delta_h"];
for (j = 1, 8, V_count[j] = [0, 0, 0]);  /* [descent, ascent, level] */

V_sums_dV = vector(8);
for (j = 1, 8, V_sums_dV[j] = 0.0);

{
for (i = 1, #edges,
  my(q = edges[i][1], c = edges[i][2]);
  my(lNq, lNc, lDq, lDc, lhq, lhc, mn_q, mn_c, mnq_l, mnq_h, mnc_l, mnc_h);
  lNq = log(cond_E(q));
  lNc = log(cond_E(c));
  lDq = log(abs(disc_min(q)));
  lDc = log(abs(disc_min(c)));
  lhq = log_height(q);
  lhc = log_height(c);
  mn_q = mn_level(q);
  mn_c = mn_level(c);
  if (mn_q[1] == -1 || mn_c[1] == -1, next);
  mnq_l = log(mn_q[1] * mn_q[2] * 1.0);
  mnc_l = log(mn_c[1] * mn_c[2] * 1.0);
  mnq_h = log((mn_q[1] + mn_q[2]) * 1.0);
  mnc_h = log((mn_c[1] + mn_c[2]) * 1.0);

  my(V_vals = [
    [lNq, lNc],
    [lDq, lDc],
    [lhq, lhc],
    [mnq_l, mnc_l],
    [mnq_h, mnc_h],
    [lNq + lDq, lNc + lDc],
    [lhq + lNq, lhc + lNc],
    [lhq, lhc]  /* same as #3 but for delta tracking */
  ]);

  for (j = 1, 8,
    my(dV = V_vals[j][2] - V_vals[j][1]);
    V_sums_dV[j] = V_sums_dV[j] + dV;
    if (dV > 0.05, V_count[j][2] = V_count[j][2] + 1);
    if (dV < -0.05, V_count[j][1] = V_count[j][1] + 1);
    if (abs(dV) <= 0.05, V_count[j][3] = V_count[j][3] + 1);
  );
);
}

{
for (j = 1, 8,
  print("Potential ", V_names[j], ":");
  print("  descents: ", V_count[j][1]);
  print("  ascents:  ", V_count[j][2]);
  print("  level:    ", V_count[j][3]);
  print("  mean dV:  ", strprintf("%.4f", V_sums_dV[j] / #edges));
  print("");
);
}

/* Crucial: compute (m+n) of each q in the orbit graph */
print("=== (m,n) level of each fiber ===");
{
my(checked = Set());
for (i = 1, #edges,
  for (e = 1, 2,
    my(q = edges[i][e]);
    if (setsearch(checked, q), next);
    checked = setunion(checked, Set([q]));
    my(mn = mn_level(q));
    print("  q=", q, "  (m,n)=(", mn[1], ",", mn[2], ")  m+n=", mn[1]+mn[2], "  m*n=", mn[1]*mn[2]);
  );
);
}

quit;
