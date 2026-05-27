\\ Compute QC ingredients for one fiber (m, n) of E_PCP / V_q
\\ Usage: MVAL=m NVAL=n gp -q compute_fiber_ingredients.gp

default(parisize, 4000000000);
default(realprecision, 38);

mm = eval(getenv("MVAL"));
nn = eval(getenv("NVAL"));

q0_num = 2 * mm * nn;
q0_den = mm^2 - nn^2;
g0 = gcd(q0_num, q0_den);
q0_num /= g0;
q0_den /= g0;
q0 = q0_num / q0_den;

print("FIBER (m,n) = (", mm, ",", nn, ")");
print("  q0 = ", q0_num, "/", q0_den);
print("  1+q0^2 = ", 1 + q0^2);

E_ef_coef = [0, -2*(1+q0^2), 0, (1-q0^2)^2, 0];
E_eg_coef = [0, -2*(1+2*q0^2), 0, 1, 0];
E_fg_coef = [0, -2*(2+q0^2), 0, q0^4, 0];
E_Hp_coef = [0, 2 + 2*q0^2, 0, 1 + 3*q0^2 + q0^4, q0^2 + q0^4];
E_Hm_coef = ellfromeqn('y^2 - 'x * ('x + q0^2) * ('x + 1) * ('x + 1 + q0^2));

E_ef = ellminimalmodel(ellinit(E_ef_coef));
E_eg = ellminimalmodel(ellinit(E_eg_coef));
E_fg = ellminimalmodel(ellinit(E_fg_coef));
E_Hp = ellminimalmodel(ellinit(E_Hp_coef));
E_Hm = ellminimalmodel(ellinit(E_Hm_coef));

factors = [E_ef, E_eg, E_fg, E_Hp, E_Hm];
names   = ["E_ef","E_eg","E_fg","E_Hp","E_Hm"];

conds = vector(5);
badprimes_all = [];
print("");
print("FACTORS:");
for(i=1,5, Nfac = ellglobalred(factors[i])[1]; conds[i] = Nfac; bp = factor(Nfac)[,1]~; badprimes_all = setunion(Set(badprimes_all), Set(bp)); print("  ", names[i], ": [a1..a6]=", factors[i][1..5], "  N=", Nfac));
print("BADPRIMES: ", badprimes_all);

print("");
print("RANKS (effort=1):");
ranks_lo = vector(5);
ranks_hi = vector(5);
ngens    = vector(5);
gens_per = vector(5, j, []);
total_lo = 0; total_hi = 0;
for(i=1,5, r = ellrank(factors[i], 1); ranks_lo[i] = r[1]; ranks_hi[i] = r[2]; ngens[i] = #r[4]; gens_per[i] = r[4]; total_lo += r[1]; total_hi += r[2]; print("  ", names[i], ": rk in [", r[1], ",", r[2], "]  #gens=", #r[4], "  gens=", r[4]));
print("TOTAL_RANK_LO_HI: [", total_lo, ",", total_hi, "]");

deny = denominator(q0); denyfact = if(deny == 1, [], factor(deny)[,1]~);
forbidden = setunion(Set(badprimes_all), Set(denyfact));
forbidden = setunion(forbidden, Set([2]));

print("");
print("FORBIDDEN PRIMES: ", forbidden);

candidate_primes = [11, 13, 17, 19, 23, 29, 31, 37, 41, 43, 47, 53, 59, 61, 67, 71, 73, 79, 83, 89, 97, 101, 103, 107, 109, 113];
good_primes = [];
for(k=1, #candidate_primes, pp = candidate_primes[k]; if(setsearch(forbidden, pp) == 0, good_primes = concat(good_primes, [pp])));
print("CANDIDATE_GOOD_PRIMES: ", good_primes);

print("");
print("ORDINARITY / a_p at candidate primes:");
chosen_p = -1;
for(k=1,#good_primes, pp = good_primes[k]; aps = vector(5, i, ellap(factors[i], pp)); ordinary = 1; for(i=1,5, if(aps[i] % pp == 0, ordinary = 0)); print("  p=", pp, "  a_p=", aps, "  ordinary=", ordinary); if(ordinary && chosen_p < 0, chosen_p = pp));
print("RECOMMENDED_PRIME: ", chosen_p);

print("");
print("PAIRWISE a_p check (non-isogeny):");
test_primes = vecextract(good_primes, [1..min(8, #good_primes)]);
ap_table = matrix(5, #test_primes, i, k, ellap(factors[i], test_primes[k]));
non_isog = 1;
for(i=1,5, for(j=i+1,5, diff = 0; for(k=1, #test_primes, if(ap_table[i,k] != ap_table[j,k], diff = 1; break)); if(!diff, print("  WARNING: ", names[i], " ~ ", names[j], " a_p match at all test primes"); non_isog = 0)));
print("NON_ISOGENOUS_5_FACTORS: ", non_isog);

print("");
print("CM check (a_p=0 over 25 primes):");
many_primes = [];
pp = 7;
while(#many_primes < 25, pp = nextprime(pp+1); if(setsearch(forbidden, pp) == 0, many_primes = concat(many_primes, [pp])));
for(i=1,5, zcount = 0; for(k=1,#many_primes, if(ellap(factors[i], many_primes[k]) == 0, zcount++)); print("  ", names[i], ": a_p=0 = ", zcount, "/", #many_primes));

print("");
print("=== MACHINE_SUMMARY ===");
print("MN=", mm, ",", nn);
print("Q0=", q0_num, "/", q0_den);
print("CONDS=", conds);
print("RANKS_LO=", ranks_lo);
print("RANKS_HI=", ranks_hi);
print("TOTAL_RANK=", total_lo, "..", total_hi);
print("CHOSEN_PRIME=", chosen_p);
print("MIN_COEF_ef=", E_ef[1..5]);
print("MIN_COEF_eg=", E_eg[1..5]);
print("MIN_COEF_fg=", E_fg[1..5]);
print("MIN_COEF_Hp=", E_Hp[1..5]);
print("MIN_COEF_Hm=", E_Hm[1..5]);
print("GENS_ef=", gens_per[1]);
print("GENS_eg=", gens_per[2]);
print("GENS_fg=", gens_per[3]);
print("GENS_Hp=", gens_per[4]);
print("GENS_Hm=", gens_per[5]);
print("=== END_SUMMARY ===");

quit;
