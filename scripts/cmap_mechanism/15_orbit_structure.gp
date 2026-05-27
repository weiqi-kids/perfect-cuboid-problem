/* Examine the orbit structure: connected components, in-degrees, branching.
   Build the full graph from the 30 seeds + computed extensions.
   For each node, list out-edges, in-edges, cycle structure.
*/
default(parisize, 1500000000);

canonical_q(qv) = my(n=abs(numerator(qv)), d=abs(denominator(qv))); if (n<=d, n/d, d/n);

gens_db = Map();

addg(q, gv) = mapput(gens_db, q, gv);

addg(20/21, [[-125/4, 395/8]]);
addg(7/24, [[-317/4, 3887/8]]);
addg(11/60, [[-185, 9745], [-515, 7270]]);
addg(48/55, [[-282, 1956]]);
addg(20/99, [[-965, 44950]]);
addg(96/247, [[-2260, 581138]]);
addg(13/84, [[20195/4, 2796619/8]]);
addg(39/80, [[-900, 9030]]);
addg(17/144, [[-1920, 142332], [-3348, 48084]]);
addg(104/153, [[-2894, 44542], [-2998, 7934]]);
addg(44/117, [[-1965, 38553]]);
addg(189/340, [[24850, 3252595]]);
addg(60/91, [[-210, 17805]]);
addg(225/272, [[-4136, 330088]]);
addg(132/475, [[-899/144, 5897298719/1728]]);
addg(252/275, [[-6886, 146663], [-7306, 22553]]);
addg(140/171, [[-482665/169, 164460005/2197]]);
addg(85/132, [[-2281, 16313]]);
addg(108/725, [[360149, 211594238], [39359, 1286048]]);
addg(57/176, [[-1504, 229442]]);
addg(135/352, [[-5496, 1741338]]);
addg(27/364, [[3002, 1265339], [7553, 590681]]);
addg(25/312, [[-48542/9, 37856650/27]]);
addg(28/195, [[7394, 493943]]);
addg(52/165, [[-1346, 190513], [3274, 91183]]);
addg(160/231, [[-6620, 115510]]);
addg(95/168, [[3398, 72536]]);
addg(105/208, [[-13117/4, 2768779/8]]);
addg(52/675, [[5389, 9242848]]);
addg(36/323, [[572049/121, 768697884/1331]]);
addg(195/748, [[151491/4, 15203079/8], [53369, 2563403], [40343619, 256228408278]]);

cmap_data(q) = my(E, Emin, v, gens, results = List(), P_emin, P_E, c); if (!issquare(1 + q^2), return([])); E = ellinit([0, 1+q^2, 0, q^2, 0]); Emin = ellminimalmodel(E, &v); if (!mapisdefined(gens_db, q), return([])); gens = mapget(gens_db, q); for(i=1, length(gens), P_emin = gens[i]; P_E = ellchangepointinv(P_emin, v); if (P_E[1]^2 == q^2, next); c = 2*q*P_E[2]/(q^2 - P_E[1]^2); listput(results, canonical_q(c))); Vec(results);

\\ For nodes in DB, list edges.
{
all_nodes = Vec(Mat(gens_db)[,1]);
print("=== Edge list (q -> c) from 31 in-DB nodes ===");
print("");
edges = List();
for(i=1, length(all_nodes),
  my(q = all_nodes[i], targets = cmap_data(q));
  for(j=1, length(targets),
    my(t = targets[j]);
    listput(edges, [q, t]);
  );
);
print("Total edges: ", length(edges));
for(i=1, length(edges), print("  ", edges[i][1], " -> ", edges[i][2]));

\\ Compute in-degrees, out-degrees per node.
print("");
print("=== Node in/out degrees ===");
nodes_set = Set();
for(i=1, length(edges),
  nodes_set = setunion(nodes_set, Set([edges[i][1], edges[i][2]]));
);

indeg = Map();
outdeg = Map();
for(i=1, #nodes_set,
  mapput(indeg, nodes_set[i], 0);
  mapput(outdeg, nodes_set[i], 0);
);
for(i=1, length(edges),
  my(s = edges[i][1], t = edges[i][2]);
  mapput(outdeg, s, mapget(outdeg, s) + 1);
  mapput(indeg, t, mapget(indeg, t) + 1);
);

print("Total nodes: ", #nodes_set);
print("");
print("Node  | in-deg | out-deg");
for(i=1, #nodes_set,
  my(q = nodes_set[i]);
  print("  q=", q, "  in=", mapget(indeg, q), "  out=", mapget(outdeg, q));
);

\\ Hub analysis
print("");
print("=== Hubs (in-degree >= 2) ===");
for(i=1, #nodes_set,
  my(q = nodes_set[i], ind = mapget(indeg, q));
  if (ind >= 2,
    \\ Find all sources
    sources = List();
    for(e=1, length(edges),
      if (edges[e][2] == q, listput(sources, edges[e][1]));
    );
    print("  q=", q, "  in-deg=", ind, "  sources=", Vec(sources));
  );
);

\\ Cycles (q -> q)
print("");
print("=== Self-loops and 2-cycles ===");
for(e=1, length(edges),
  my(s = edges[e][1], t = edges[e][2]);
  if (s == t, print("  self-loop: ", s, " -> ", t));
);
for(e1=1, length(edges),
  for(e2 = e1+1, length(edges),
    if (edges[e1][1] == edges[e2][2] && edges[e1][2] == edges[e2][1],
      print("  2-cycle: ", edges[e1][1], " <-> ", edges[e1][2]));
  );
);
}

quit;
