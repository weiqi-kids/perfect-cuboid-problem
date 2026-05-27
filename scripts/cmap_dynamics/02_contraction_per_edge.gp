/* Per-edge dynamics analysis: from the 40 c-map edges, compute
   d_h = h(c) - h(q)              (height change)
   d_N = log(N(E_c)) - log(N(E_q)) (conductor change)
   d_d = log|disc(E_c)| - log|disc(E_q)| (disc change)
   ratio = F3 / (1+q^2)(1+c^2)    (the PCP-defect normalised)

   Classify into:
   - "contracting" edges (d_h < 0)
   - "expanding" edges  (d_h > 0)
   - "neutral"          (|d_h| < 0.1)
   And look at 2-cycle structure (does the height oscillate or contract?).
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
disc_E(q) = my(E=build_E(q), Em=ellminimalmodel(E)); Em.disc;

cmap_c(q, P_emin) =
{
  my(E = build_E(q), v, P_E, c);
  ellminimalmodel(E, &v);
  P_E = ellchangepointinv(P_emin, v);
  if (P_E[1]^2 == q^2, return(0));
  2*q*P_E[2]/(q^2 - P_E[1]^2);
};

/* Sources in DB */
src_list = [20/21, 7/24, 11/60, 48/55, 20/99, 96/247, 13/84, 39/80, 17/144, 104/153, 44/117, 189/340, 60/91, 225/272, 132/475, 252/275, 140/171, 85/132, 108/725, 57/176, 135/352, 27/364, 25/312, 28/195, 52/165, 160/231, 95/168, 105/208, 52/675, 36/323, 195/748];

print("=== Per-edge contraction analysis ===");
print("");
print("source -> target | h(q) | h(c) | dh | log_N_q | log_N_c | dN | sqrtF3");
print("");

contracts = 0;
expands = 0;
neutral = 0;
total = 0;
dh_sum = 0.0;
dh_min = 1e30;
dh_max = -1e30;
dh_list = List();

{
for (i = 1, length(src_list),
  my(q = src_list[i], gens, hq, lNq);
  hq = log_height(q);
  lNq = log(cond_E(q));
  gens = mapget(gens_db, q);
  for (k = 1, length(gens),
    my(c, c_can, hc, lNc, dh, dN, F3, sF3);
    c = cmap_c(q, gens[k]);
    if (c == 0, next);
    c_can = canonical_q(c);
    hc = log_height(c_can);
    lNc = log(cond_E(c_can));
    dh = hc - hq;
    dN = lNc - lNq;
    F3 = 1 + q^2 + c^2;
    sF3 = sqrt(F3 * 1.0);
    print(q, " -> ", c_can,
          " | h(q)=", strprintf("%.3f", hq),
          " h(c)=", strprintf("%.3f", hc),
          " dh=", strprintf("%+.3f", dh),
          " | lNq=", strprintf("%.2f", lNq),
          " lNc=", strprintf("%.2f", lNc),
          " dN=", strprintf("%+.2f", dN),
          " | sqrtF3=", strprintf("%.5f", sF3));
    total = total + 1;
    listput(dh_list, dh);
    dh_sum = dh_sum + dh;
    if (dh < dh_min, dh_min = dh);
    if (dh > dh_max, dh_max = dh);
    if (dh < -0.1, contracts = contracts + 1, if (dh > 0.1, expands = expands + 1, neutral = neutral + 1));
  );
);
}

print("");
print("=== Edge classification ===");
print("Total edges: ", total);
print("Contracting (dh < -0.1): ", contracts);
print("Expanding   (dh > +0.1): ", expands);
print("Neutral     (|dh|<=0.1): ", neutral);
print("Mean dh: ", strprintf("%.4f", dh_sum / total));
print("Min dh:  ", strprintf("%.4f", dh_min));
print("Max dh:  ", strprintf("%.4f", dh_max));

print("");
print("=== 2-cycle detection ===");
print("Pairs where q -> c is in DB and c -> q' returns to q:");
{
two_cycles = List();
for (i = 1, length(src_list),
  my(q = src_list[i], gens, c, c_can);
  gens = mapget(gens_db, q);
  for (k = 1, length(gens),
    c = cmap_c(q, gens[k]);
    if (c == 0, next);
    c_can = canonical_q(c);
    /* Check if c_can is also in DB and if any of its generators map back to q */
    if (mapisdefined(gens_db, c_can),
      my(gens2 = mapget(gens_db, c_can));
      for (l = 1, length(gens2),
        my(c2 = cmap_c(c_can, gens2[l]));
        if (c2 == 0, next);
        if (canonical_q(c2) == q,
          listput(two_cycles, [q, c_can]);
          print("  2-cycle: ", q, " <-> ", c_can,
                "  (h:", strprintf("%.3f", log_height(q)), ",", strprintf("%.3f", log_height(c_can)), ")");
          break;
        );
      );
    );
  );
);
print("");
print("Total 2-cycles found: ", length(two_cycles));
}

quit;
