default(parisize, 1500000000);

{
data = [
[20/21, [[-125/4, 395/8]]],
[7/24, [[-317/4, 3887/8]]],
[11/60, [[-185, 9745], [-515, 7270]]],
[48/55, [[-282, 1956]]],
[20/99, [[-965, 44950]]],
[96/247, [[-2260, 581138]]],
[13/84, [[20195/4, 2796619/8]]],
[39/80, [[-900, 9030]]],
[17/144, [[-1920, 142332], [-3348, 48084]]],
[104/153, [[-2894, 44542], [-2998, 7934]]],
[44/117, [[-1965, 38553]]],
[189/340, [[24850, 3252595]]],
[60/91, [[-210, 17805]]],
[225/272, [[-4136, 330088]]],
[132/475, [[-899/144, 5897298719/1728]]],
[252/275, [[-6886, 146663], [-7306, 22553]]],
[140/171, [[-482665/169, 164460005/2197]]],
[85/132, [[-2281, 16313]]],
[108/725, [[360149, 211594238], [39359, 1286048]]],
[57/176, [[-1504, 229442]]],
[135/352, [[-5496, 1741338]]],
[27/364, [[3002, 1265339], [7553, 590681]]],
[25/312, [[-48542/9, 37856650/27]]],
[28/195, [[7394, 493943]]],
[52/165, [[-1346, 190513], [3274, 91183]]],
[160/231, [[-6620, 115510]]],
[95/168, [[3398, 72536]]],
[105/208, [[-13117/4, 2768779/8]]],
[52/675, [[5389, 9242848]]],
[36/323, [[572049/121, 768697884/1331]]]
];
}

canonical_q(qval) = {
  my(num, den);
  num = abs(numerator(qval));
  den = abs(denominator(qval));
  if (num <= den, num/den, den/num);
};

is_pyth(q) = issquare(1 + q^2);

{
print("=== c-map orbit (first 30 nodes from rank_jump_list.txt) ===");
edges = List();
total_genmap = 0;
f3_squares = 0;
for(idx=1, length(data),
  my(q, E, Emin, v, gens_emin);
  q = data[idx][1];
  E = ellinit([0, 1+q^2, 0, q^2, 0]);
  Emin = ellminimalmodel(E, &v);
  gens_emin = data[idx][2];
  print("\nq=", q, " (rank ", length(gens_emin), "):");
  for(i=1, length(gens_emin),
    my(P_emin, P_E, c, cq, F3);
    P_emin = gens_emin[i];
    P_E = ellchangepointinv(P_emin, v);
    if (P_E[1]^2 == q^2,
      print("  G", i, ": pole (skip)");
      next;
    );
    c = 2*q*P_E[2]/(q^2 - P_E[1]^2);
    cq = canonical_q(c);
    F3 = c^2 + 1 + q^2;
    total_genmap = total_genmap + 1;
    if (issquare(F3), f3_squares = f3_squares + 1);
    print("  G", i, " -> c=", c, "  canon=", cq, "  PCP?=", issquare(F3));
    listput(edges, [q, cq]);
  );
);

print("\n=== Edge list (q -> canonical(c)) ===");
for(i=1, length(edges),
  print("  ", edges[i][1], " -> ", edges[i][2]);
);

print("\nTotal generator mappings: ", total_genmap);
print("F3 squares (PCP candidates): ", f3_squares);

print("\n=== Targets that are NEW (not in seed set of 30) ===");
seed_qs = Set(apply(d -> d[1], data));
seen_targets = Set();
for(i=1, length(edges),
  my(t);
  t = edges[i][2];
  if (!setsearch(seed_qs, t) && !setsearch(seen_targets, t),
    seen_targets = setunion(seen_targets, Set([t]));
    print("  ", t);
  );
);
}

quit;
