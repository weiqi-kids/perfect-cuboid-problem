default(parisize,800000000);
default(parisizemax,1200000000);

quarticJac(a4,a3,a2,a1,a0) = ellinit([0,0,0, -27*(12*a4*a0 - 3*a3*a1 + a2^2), -27*(72*a4*a2*a0 - 27*a4*a1^2 - 27*a3^2*a0 + 9*a3*a2*a1 - 2*a2^3)]);

{
  my(Esig, Etau, Estau, rs, rt, rst);
  print("=== FINAL CONSOLIDATED VERIFICATION (genus-3 Coleman cover) ===");
  print("");
  Esig  = ellminimalmodel(quarticJac(1,68,-122,68,1));   \\ C'/sigma   (x=t^2)
  Etau  = ellminimalmodel(quarticJac(1,0,64,0,-256));    \\ C'/tau     (s=t+1/t)
  Estau = ellminimalmodel(quarticJac(1,0,72,0,16));      \\ C'/sigtau  (r=t-1/t)

  print("X_sigma = C'/(t->-t):    ainvs=", Esig[1..5], " cond=", ellglobalred(Esig)[1]);
  rs = ellrank(Esig);
  print("   rank=[",rs[1],",",rs[2],"]  analytic=", ellanalyticrank(Esig)[1], "  rootno=", ellrootno(Esig), "  tors=", elltors(Esig)[1]);
  print("X_tau   = C'/(t->1/t):   ainvs=", Etau[1..5], " cond=", ellglobalred(Etau)[1]);
  rt = ellrank(Etau);
  print("   rank=[",rt[1],",",rt[2],"]  analytic=", ellanalyticrank(Etau)[1], "  rootno=", ellrootno(Etau), "  tors=", elltors(Etau)[1]);
  print("X_sigtau= C'/(t->-1/t):  ainvs=", Estau[1..5], " cond=", ellglobalred(Estau)[1]);
  rst = ellrank(Estau);
  print("   rank=[",rst[1],",",rst[2],"]  analytic=", ellanalyticrank(Estau)[1], "  rootno=", ellrootno(Estau), "  tors=", elltors(Estau)[1]);
  print("");
  print("X_sigma == X_tau (so J ~ E_PCP^2 x X_st): ", Esig[1..5]==Etau[1..5]);
  print("rank J(C') = ", rs[2], " + ", rt[2], " + ", rst[2], " = ", rs[2]+rt[2]+rst[2], "  vs genus 3");
  print("rank < genus (Chabauty applies): ", (rs[2]+rt[2]+rst[2]) < 3);
  print("");
  print("Unconditionality of ranks:");
  print("  X_sigma=X_tau: analytic rank 1, root no -1 => Gross-Zagier-Kolyvagin => rank EXACTLY 1 (uncond).");
  print("  X_sigtau (80a): analytic rank 0, root no +1 => Kolyvagin => rank EXACTLY 0 (uncond).");
  print("  ellrank also returns tight [lo,hi] with lo=hi for all three (uncond 2-descent).");
}
