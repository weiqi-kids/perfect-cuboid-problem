\\ Extended Mordell-Weil sieve at 30+ primes on the J(V_q) elliptic factors
\\ for each BEYOND-QC fiber. For each factor with explicit generators we
\\ compute the orders of the generators in E(F_p), take the lcm = lambda(p),
\\ and the local-image density  lambda(p)^r / #E(F_p)^r. The aggregate
\\ density across the 30 primes gives the MW-sieve probability bound on
\\ a rational point landing in the Face-3 locus.

default(parisize, 8000000000);
default(realprecision, 40);

\\ Sieve primes (30 primes, all odd, avoiding 2, 3, 5, 7, 11 which often
\\ have bad reduction for E_PCP).
{sieve_primes_30 = [13, 17, 19, 23, 29, 31, 37, 41, 43, 47, 53, 59, 61, 67, 71, 73, 79, 83, 89, 97, 101, 103, 107, 109, 113, 127, 131, 137, 139, 149];}

\\ Output: per (fiber, factor) a list of triples (p, #E(F_p), lcm) and the
\\ aggregate density product = prod_p (lambda(p)/#E(F_p))^r.

sieve_factor_30(fname, coefs, gens, primes) = {
  my(r, E, disc, results, p, EFp, sz, j, k, total, has_bad, g, dx, dy, ord, density_log);
  r = #gens;
  E = ellinit(coefs);
  disc = E.disc;
  density_log = 0.0;
  if(r == 0,
    print("  E_", fname, " r=0: no generators -- skipped");
    return(0)
  );
  print("\n  --- E_", fname, " (rank ", r, ") ---");
  for(j = 1, #primes,
    p = primes[j];
    if(disc % p == 0,
      print("    p=", p, " BAD reduction, skip"); next
    );
    iferr(
      EFp = ellinit(coefs, p);
      sz = ellcard(EFp);
      total = 1;
      has_bad = 0;
      for(k = 1, r,
        g = gens[k];
        dx = denominator(g[1]);
        dy = denominator(g[2]);
        if(dx % p == 0 || dy % p == 0,
          has_bad = 1;
          next
        );
        ord = ellorder(EFp, [g[1], g[2]]);
        if(ord == 0, ord = 1);
        total = lcm(total, ord);
      );
      \\ Local density estimate: lcm^r / #E^r  (geometric-mean type bound).
      \\ This treats each generator as independent within the subgroup of
      \\ exponent lcm.
      \\ For a tighter estimate, we'd compute the actual image subgroup index.
      my(density);
      density = total^r / sz^r;
      density_log = density_log + log(1.0 * density);
      print("    p=", p, " #E=", sz, " lcm=", total, " r=", r,
            " density=", density, if(has_bad, " [has bad gens]", "")),
      E1,
      print("    p=", p, " ellinit/order failed")
    );
  );
  print("  log(prod density) over all primes = ", density_log,
        "  prod density = ", exp(density_log));
  return(density_log);
};

\\ Fiber data (copied from mw_sieve.gp)
{fd_61_38 = [
  ["ef", [1, 0, 0, -42684740442159, -101889258036034244616],
    [[58987827/4, 397992407343/8], [592500852, 14421088318314], [44640322184/625, 9390298181935952/15625]]],
  ["fg", [0, 1, 0, -55728214538800, -146186146319718549100],
    [[298156741903850/1713481, 5143525299205695602880/2242946629], [116218354628075/201601, 1252781991116084208780/90518849]]],
  ["Hp", [0, -1, 0, -125792010606624, -415427350830110490816],
    [[19412880, 66772174392], [67728852906/5329, 2423087106159762/389017], [366869435353/11881, 205346214100247220/1295029]]]
];}

{fd_63_38 = [
  ["ef", [1, 0, 0, -54426114516745, -149326661877655991488],
    [[-3801744259/784, 16617386054471/21952], [896449604/25, 26219493853582/125], [-9954307819/2704, 150630549616919/140608]]],
  ["eg", [1, 0, 0, -224751480208975, -1296824565825870679168],
    [[4149945852764/841, 8453928052111134922/24389]]],
  ["Hp", [0, -1, 0, -140013601817920, -435817780667752184768],
    [[19693632, 66669084344], [441210769, 9264283024500], [-3918656, 7257616200], [2918050254976/529, 4984689957571812600/12167]]]
];}

{fd_73_24 = [
  ["ef", [1, 0, 0, -94673377998924, -353919433762272635136],
    [[165941785735922/12623809, 1163275227623665811672/44852393377], [6849182848/81, 562873824313264/729], [276999061104/7225, 140527561829356872/614125]]],
  ["eg", [1, 0, 0, -153339850777260, -719732586296951884800],
    [[-42541443885113161861730/5427805672891449, 319785349496311701796684269070120/399886217417979391378707]]],
  ["Hp", [0, -1, 0, -127910198192064, 83501181854697176064],
    [[88658114, 828021224354], [30793058, 159195207710]]]
];}

{fd_88_35 = [
  ["ef", [1, 0, 0, -537960923191390, -4802565205544754983500],
    [[-34841060150/2601, 13964400757400/132651], [25919773828/9, 4172810253009322/27], [3696166969/64, 202697616686609/512]]],
  ["eg", [1, 1, 1, -1055111008889790, -13136825392429479796245],
    [[493309649203/12321, 128279863244983943/1367631], [35343087406767440245/28508296336, 210038999126499461339776928945/4813454786555584]]],
  ["Hp", [0, -1, 0, -544435463254240, 4681038068313777913600],
    [[16691472, 15618579328], [233538960, 3551739445760], [2691779600/169, 15559202910720/2197], [815573130/49, 5205476411710/343]]]
];}

{fd_99_28 = [
  ["ef", [1, 0, 0, -886286644253514, -10038599072058161134656],
    [[758166810293/13456, 538177750662874261/1560896], [384807279/4, 7132756622421/8], [2260062957/16, 104829817463691/64], [12292351281/256, 987318939754287/4096]]],
  ["eg", [1, 0, 0, -1285630732110690, -17118244345470634548000],
    [[1458435615/4, 55415570231385/8], [-4457796585631984/200364025, 61661648413522032494024/2836152773875]]],
  ["fg", [0, -1, 0, -3056260378721760, -65023932923994267595008],
    [[-660722766623/20736, 8838261973652561/2985984]]],
  ["Hp", [0, -1, 0, -1685461832548704, -10854385900968766899456],
    [[-29443120, 115094337568]]]
];}

sieve_all_factors(label, fdata) = {
  my(total_log);
  total_log = 0.0;
  print("\n========== MW sieve (30 primes) on ", label, " ==========");
  for(i = 1, #fdata,
    total_log = total_log + sieve_factor_30(fdata[i][1], fdata[i][2], fdata[i][3], sieve_primes_30)
  );
  print("\n  TOTAL log10(density) for ", label, " = ", total_log / log(10),
        "    total density = ", exp(total_log));
  return(total_log);
};

print("=== 30-prime MW sieve on all 5 BEYOND-QC fibers ===");
print("Sieve primes: ", sieve_primes_30);

t_61 = sieve_all_factors("(61,38)", fd_61_38);
t_63 = sieve_all_factors("(63,38)", fd_63_38);
t_73 = sieve_all_factors("(73,24)", fd_73_24);
t_88 = sieve_all_factors("(88,35)", fd_88_35);
t_99 = sieve_all_factors("(99,28)", fd_99_28);

print("\n========== Aggregate MW-sieve density across 5 fibers ==========");
print("  log10 density (61,38) = ", t_61 / log(10));
print("  log10 density (63,38) = ", t_63 / log(10));
print("  log10 density (73,24) = ", t_73 / log(10));
print("  log10 density (88,35) = ", t_88 / log(10));
print("  log10 density (99,28) = ", t_99 / log(10));
print("  Sum log10 density     = ", (t_61+t_63+t_73+t_88+t_99) / log(10));

print("\n=== DONE 30-prime MW SIEVE ===");
quit;
