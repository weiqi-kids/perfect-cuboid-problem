/* Real measure of "distance to square": F3 = N/D in lowest terms.
   F3 is a square iff N*D is a square (since lowest terms forces gcd(N,D)=1).
   So compute s = sqrt(N*D) and measure distance to nearest integer.

   Track: how close does N*D come to a perfect square in the orbit?
   Also: 2-adic valuation pattern, factor structure of N*D.
*/

default(parisize, 1500000000);

canonical_q(qv) = my(n=abs(numerator(qv)), d=abs(denominator(qv))); if (n<=d, n/d, d/n);

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

cmap_c(q, P_emin) =
{
  my(E = build_E(q), v, P_E, c);
  ellminimalmodel(E, &v);
  P_E = ellchangepointinv(P_emin, v);
  if (P_E[1]^2 == q^2, return(0));
  2*q*P_E[2]/(q^2 - P_E[1]^2);
};

/* The "square defect" of a positive rational F3 = N/D (lowest terms):
   F3 is a rational square iff N*D is a perfect integer square (since gcd(N,D)=1
   forces N = a^2, D = b^2 individually).
   Define defect(F3) = sqfree_part(N*D) - 1 (well, 0 iff square).
   Also: log_2(defect_int) = log of square-free part of N*D.
*/
square_defect(F3) =
{
  my(N = numerator(F3), D = denominator(F3), s);
  s = core(N*D);  /* the squarefree core of N*D */
  s;
};

print("=== F3 square-defect analysis ===");
print("");
print("F3 = 1+q^2+c^2 is a rational SQUARE iff core(num*den) = 1.");
print("");
print("q -> c | F3=N/D | core(N*D) [=1 iff PCP] | log2|core| | factor(core)");
print("");

src_list = [20/21, 7/24, 11/60, 48/55, 20/99, 96/247, 13/84, 39/80, 17/144, 104/153, 44/117, 189/340, 60/91, 225/272, 132/475, 252/275, 140/171, 85/132, 108/725, 57/176, 135/352, 27/364, 25/312, 28/195, 52/165, 160/231, 95/168, 105/208, 52/675, 36/323, 195/748];

core_min = 10^30;
core_min_edge = 0;
all_cores = List();

{
for (i = 1, length(src_list),
  my(q = src_list[i], gens);
  gens = mapget(gens_db, q);
  for (k = 1, length(gens),
    my(c = cmap_c(q, gens[k]), c_can, F3, N, D, cor);
    if (c == 0, next);
    c_can = canonical_q(c);
    F3 = 1 + q^2 + c^2;
    N = numerator(F3);
    D = denominator(F3);
    cor = core(N*D);
    listput(all_cores, cor);
    print(q, " -> ", c_can,
          "  F3=", N, "/", D,
          "  core=", cor,
          "  log2(core)=", strprintf("%.2f", log(cor)/log(2)));
    if (cor < core_min, core_min = cor; core_min_edge = [q, c_can, F3]);
  );
);
}

print("");
print("=== Minimum core ===");
print("Min core value: ", core_min);
print("At edge: ", core_min_edge[1], " -> ", core_min_edge[2]);
print("F3 = ", core_min_edge[3]);
print("(Reminder: core=1 means F3 is a perfect rational square = PCP candidate.)");
print("");
print("Factorization of min core: ", factor(core_min));

print("");
print("=== Core values mod small primes (search for obstructions) ===");
print("");
{
my(primes_to_check = [2, 3, 5, 7, 11, 13, 17, 19, 23, 29, 31]);
for (p_idx = 1, length(primes_to_check),
  my(p = primes_to_check[p_idx], divisible = 0, total = 0);
  for (i = 1, #all_cores,
    total = total + 1;
    if (Mod(all_cores[i], p) == 0, divisible = divisible + 1);
  );
  print("  prime ", p, ": ", divisible, "/", total, " cores divisible");
);
}

print("");
print("=== Quadratic residue / non-residue obstruction analysis ===");
print("");
{
my(primes_to_check = [3, 5, 7, 11, 13, 17, 19, 23]);
for (p_idx = 1, length(primes_to_check),
  my(p = primes_to_check[p_idx], nonres = 0, res = 0, zero = 0, total = 0);
  for (i = 1, #all_cores,
    total = total + 1;
    my(k = kronecker(all_cores[i], p));
    if (k == 1, res = res + 1);
    if (k == -1, nonres = nonres + 1);
    if (k == 0, zero = zero + 1);
  );
  print("  kronecker(core, ", p, "): +1=", res, " -1=", nonres, " 0=", zero, " / ", total);
);
}

print("");
print("=== Core distribution by edge ===");
{
my(buckets = Map());
for (i = 1, #all_cores,
  if (mapisdefined(buckets, all_cores[i]),
    mapput(buckets, all_cores[i], mapget(buckets, all_cores[i]) + 1);
  ,
    mapput(buckets, all_cores[i], 1);
  );
);
my(keys = Mat(buckets)[,1], vals = Mat(buckets)[,2]);
for (i = 1, #keys,
  if (vals[i] >= 2,
    print("  core=", keys[i], " : appears ", vals[i], " times");
  );
);
}

quit;
