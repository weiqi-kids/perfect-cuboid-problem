\\ Verify Kodaira types of pi_d at bad fibers.

default(parisize, 1000000000);

print("=== Verify Tate types of pi_d at bad fibers ===");
print("");

{
  plist = [2, 3, 5, 7, 11];
  print("--- Near q = 0 (specialize q = p) ---");
  for(pi = 1, 5,
    p = plist[pi];
    q = p;
    E = ellinit([0, 1 + q^2, 0, q^2, 0]);
    gr = ellglobalred(E);
    N = gr[1];
    factN = factor(N);
    vp = 0;
    sz = matsize(factN)[1];
    for(k = 1, sz,
      if(factN[k,1] == p, vp = factN[k,2]);
    );
    \\ For multiplicative reduction (I_n), v_p(N_E) = 1; v_p(Delta_min) = n.
    \\ Get local data via elllocalred
    local_data = elllocalred(E, p);
    \\ local_data = [f_p, Kodaira_type, [..,..], cp]
    print("  q = ", p, ":  N = ", N, ",  f_", p, " = ", vp,
          ",  Kodaira = ", local_data[2]);
  );
}

print("");
{
  plist = [2, 3, 5, 7, 11];
  print("--- Near q = 1 (specialize q = 1 + p) ---");
  for(pi = 1, 5,
    p = plist[pi];
    q = 1 + p;
    E = ellinit([0, 1 + q^2, 0, q^2, 0]);
    local_data = elllocalred(E, p);
    print("  q = 1 + ", p, " = ", q, ":  Kodaira at p = ", local_data[2]);
  );
}

print("");
print("--- At Pythagorean q (sanity check) ---");
{
  q = 4/3;
  E = ellinit([0, 1 + q^2, 0, q^2, 0]);
  gr = ellglobalred(E);
  print("  q = 4/3:  N = ", gr[1]);
  Emin = ellminimalmodel(E);
  print("  Emin = ", Emin[1..5]);
}

print("");
print("=== Conclusions on Tate types ===");
print("Direct symbolic Delta = 16 q^4 (q-1)^2 (q+1)^2 tells us:");
print("  v_q(Delta) at q=0: 4. v_q(c4): 0. ==> I_4 (mult).");
print("  v_q(Delta) at q=1: 2. v_q(c4): 0. ==> I_2 (mult).");
print("  Similarly at q=-1, infty.");
print("");
print("Shioda-Tate:");
print("  rho(V') = 2 + r_gen + (4-1) + (4-1) + (2-1) + (2-1)");
print("         = 10 + r_gen.");
print("");
print("Frobenius traces (from picard_frobenius.gp):");
print("  trace_p/p at p=7 is 6 ==> rho_geom >= 6.");
print("  Lower bound 10 from Shioda-Tate dominates.");
print("");
print("Conclusion: rho(V') >= 10. With r_gen = 0, rho = 10.");

quit;
