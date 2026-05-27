\\ Isogeny descent on E_Hm for (61,38) borderline genus-2 fiber.
\\
\\ Goal: sharpen rk(E_Hm) ∈ [0, 2] via 2-isogenous descent on the full
\\ 2-isogeny class.
\\
\\ PARI ellrank signature: [r_lo, r_hi, s, L]
\\   r_lo / r_hi : rank bounds (rigorous given completion of 2-descent).
\\   s          : encodes 2-Sha info (related to 2*rank+dim Sel/Sha).
\\   L          : list of independent non-torsion rational points found.
\\
\\ Multi-line for / iferr blocks wrapped in {...} per PARI/GP file mode.

default(parisize, 500000000);
default(realprecision, 60);

E_Hm = ellinit([1, 0, 0, -4201713691887954766021162410, 103564307677747011646913552825626935447972]);
print("=== E_Hm (61,38) ===");
print("a-invariants: ", E_Hm[1..5]);
N_Hm = ellglobalred(E_Hm)[1];
print("conductor N(E_Hm) = ", N_Hm);
print("log10 N = ", log(N_Hm*1.0)/log(10.0));
print("torsion: ", elltors(E_Hm)[1..2]);
print();

print("=== Step 1: ellisomat(E_Hm, 2) — 2-isogeny class ===");
t_iso0 = getwalltime();
iso = ellisomat(E_Hm, 2);
t_iso1 = getwalltime();
print("wall(ellisomat) = ", (t_iso1 - t_iso0)/1000.0, " s");
n_curves = #iso[1];
print("number of curves in 2-isogeny class: ", n_curves);
print("isogeny degree matrix: ");
print(iso[2]);
print();

results = vector(n_curves);
mapped_pts = vector(n_curves);

print("=== Step 2: Per-curve analysis ===");

{
for(k = 1, n_curves,
  print();
  print("--- Curve E'_", k, " ---");
  ainv = iso[1][k][1];
  print("a-invariants: ", ainv);
  E_k = ellinit(ainv);
  N_k = ellglobalred(E_k)[1];
  print("conductor: ", N_k);
  print("log10 N: ", log(N_k*1.0)/log(10.0));
  tors_k = elltors(E_k);
  print("torsion order: ", tors_k[1], "  structure: ", tors_k[2]);
  E_min = ellminimalmodel(E_k);
  print("minimal model a-invariants: ", E_min[1..5]);
  print("ellrank(E'_", k, ", 5) ...");
  rk_res = 0;
  t_r0 = getwalltime();
  iferr(rk_res = alarm(600, ellrank(E_k, 5)), E2, print("  RANK_EXCEPTION: ", E2));
  t_r1 = getwalltime();
  print("  ellrank wall: ", (t_r1 - t_r0)/1000.0, " s");
  print("  ellrank result: ", rk_res);
  results[k] = rk_res;
  if(type(rk_res) == "t_VEC" && #rk_res >= 4 && type(rk_res[4]) == "t_VEC" && #rk_res[4] >= 1,
    L_gens = rk_res[4];
    print("  *** ", #L_gens, " generator(s) found on E'_", k);
    for(j = 1, #L_gens,
      P = L_gens[j];
      print("    P[", j, "] = ", P);
      iferr(onE = ellisoncurve(E_k, P); print("    ellisoncurve(E'_", k, ", P) = ", onE);
            ht = ellheight(E_k, P); print("    canonical height on E'_", k, ": ", ht);
            if(k > 1,
              dual_phi = iso[1][k][3];
              Q = ellisogenyapply(dual_phi, P);
              print("    phi_dual(P) -> E_Hm: ", Q);
              onEHm = ellisoncurve(E_Hm, Q);
              print("    ellisoncurve(E_Hm, Q) = ", onEHm);
              if(onEHm,
                ht_Q = ellheight(E_Hm, Q);
                print("    canonical height on E_Hm: ", ht_Q);
                mapped_pts[k] = [P, Q, ht_Q]
              )
            );
            if(k == 1, mapped_pts[k] = [P, P, ht]),
            E3, print("    POINT_EXCEPTION: ", E3))
    )
  )
);
}

print();
print("=== Step 3: ellanalyticrank for low-conductor curves ===");

{
for(k = 1, n_curves,
  ainv = iso[1][k][1];
  E_k = ellinit(ainv);
  N_k = ellglobalred(E_k)[1];
  if(N_k < 10^15,
    print();
    print("ellanalyticrank(E'_", k, ", 0.01) with N = ", N_k);
    iferr(t0 = getwalltime(); ar = alarm(300, ellanalyticrank(E_k, 0.01)); t1 = getwalltime();
          print("  analytic rank: ", ar); print("  wall: ", (t1 - t0)/1000.0, " s"),
          Ea, print("  ANAL_EXCEPTION: ", Ea))
  )
);
}

print();
print("=== Step 4: SUMMARY ===");
print("Per-curve [r_lo, r_hi, gens]:");

{
for(k = 1, n_curves,
  if(type(results[k]) == "t_VEC" && #results[k] >= 4,
    n_gens = if(type(results[k][4]) == "t_VEC", #results[k][4], 0);
    print("  E'_", k, ": [r_lo=", results[k][1], ", r_hi=", results[k][2], "], s=", results[k][3], ", n_gens=", n_gens)
  ,
    print("  E'_", k, ": <no result> -- raw: ", results[k])
  )
);
}

print();
print("Mapped-back generators on E_Hm (non-torsion candidates):");
found_any = 0;

{
for(k = 1, n_curves,
  if(type(mapped_pts[k]) == "t_VEC" && #mapped_pts[k] >= 3,
    if(mapped_pts[k][3] > 0.0001,
      print("  via E'_", k, ": P_back = ", mapped_pts[k][2]);
      print("    canonical height on E_Hm = ", mapped_pts[k][3]);
      found_any = 1
    )
  )
);
}

if(!found_any, print("  NONE — no non-torsion generator on E_Hm via 2-isogenous descent."));

print();
print("Verdict:");

{
if(found_any,
  print("  rk(E_Hm) >= 1, combined with parity (w=+1) -> rk(E_Hm) = 2 EXACTLY.")
,
  print("  rk(E_Hm) ∈ [0, 2] UNCHANGED; remaining gap is in Sha[2] visibility.");
  print("  Magma FourDescent / EightDescent still required to close.")
);
}

quit;
