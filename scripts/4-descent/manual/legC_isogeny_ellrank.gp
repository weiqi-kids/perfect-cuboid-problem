\\ Leg C: ellrank on each 2-isogenous curve in the isogeny class.

default(parisize, 600000000);
default(parisizemax, 1000000000);
default(realprecision, 38);

A4 = -4296889542830417930548255320;
A6 = 69513195990628448299367172717433334517312;
E = ellinit([1, 0, 0, A4, A6]);
print("E_Hm(73,24): conductor = ", ellglobalred(E)[1]);

t0 = getwalltime();
iso = ellisomat(E, 2);
t1 = getwalltime();
print("ellisomat wall = ", (t1-t0)/1000.0, "s");

curves = iso[1];
print("Number of curves in isogeny class: ", #curves);
print();

hits = 0;
best_n_gens = 0;
best_k = 0;
best_gens = [];

{
for(k = 1, #curves,
  print("[", k, "/", #curves, "] curve ", k);
  short_ab = curves[k][1];
  a4_s = short_ab[1]; a6_s = short_ab[2];
  print("  short [a4, a6]: ", short_ab);
  Ek = ellinit([0, 0, 0, a4_s, a6_s]);
  print("  conductor: ", ellglobalred(Ek)[1]);
  t0 = getwalltime();
  res = 0;
  iferr(alarm(900, res = ellrank(Ek, 5)), err, print("    ellrank ERROR: ", err));
  t1 = getwalltime();
  if(type(res) == "t_VEC",
    rk_lo = res[1]; rk_hi = res[2]; ngens = #res[4];
    print("    rank [", rk_lo, ", ", rk_hi, "]  n_gens = ", ngens, "  wall = ", (t1-t0)/1000.0, "s");
    if(ngens > best_n_gens,
      best_n_gens = ngens;
      best_gens = res[4];
      best_k = k;
    );
    for(g = 1, ngens,
      gen_g = res[4][g];
      ht_g = ellheight(Ek, gen_g);
      print("      gen[", g, "] = ", gen_g, "  canonical height = ", ht_g);
    );
    if(ngens >= 1, hits = hits + 1; print("    *** GENERATOR FOUND ON CURVE ", k, " ***"));
  );
  print();
);
}

print("=== Leg C complete ===");
print("Total curves with ngens >= 1: ", hits);
print("Best: curve_", best_k, "  n_gens = ", best_n_gens);
if(best_n_gens >= 1, print("Generators (on curve ", best_k, "): ", best_gens));

quit;
