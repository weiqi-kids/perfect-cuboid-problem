\\ Face-3 verification of Track D's new E_PCP generators on
\\ fibers (73,24), (88,35), (99,28).

default(parisize, 500000000);
default(realprecision, 60);

face3_check_fiber(mm, nn, gens_min_model) = {
  my(uu, vv, qq, Eq, Emin, V, P_min, P_q, X, Y, oncurve_min, oncurve_q, xq, yq, cc, F3, is_sq);
  uu = 2*mm*nn;
  vv = mm^2 - nn^2;
  qq = vv/uu;
  print("=========================================");
  print("Face-3 check for (m,n) = (", mm, ", ", nn, "), q = ", vv, "/", uu, " = ", qq*1.0);
  print("=========================================");
  Eq = ellinit([0, 1 + qq^2, 0, qq^2, 0]);
  Emin = ellminimalmodel(Eq, &V);
  print("  Minimal model coefs: ", Emin[1..5]);
  print("  Change-of-variables [u,r,s,t]: ", V);
  for(k=1, #gens_min_model,
    P_min = gens_min_model[k];
    X = P_min[1]; Y = P_min[2];
    oncurve_min = ellisoncurve(Emin, P_min);
    print();
    print("  gen[", k, "] in Emin = ", P_min);
    print("    ellisoncurve(Emin, P_min) = ", oncurve_min);
    if(!oncurve_min, print("    *** SKIP: not on minimal model ***"); next);
    P_q = ellchangepointinv(P_min, V);
    oncurve_q = ellisoncurve(Eq, P_q);
    print("    P_q = ", P_q);
    print("    ellisoncurve(Eq, P_q) = ", oncurve_q);
    if(!oncurve_q, print("    *** SKIP: q-model transform failed ***"); next);
    xq = P_q[1];
    yq = P_q[2];
    if(xq == 0 || xq == -1 || xq == -qq^2,
      print("    *** torsion (degenerate per Lemma 1) ***"); next);
    if(qq^2 - xq^2 == 0, print("    *** POLE ***"); next);
    cc = 2 * qq * yq / (qq^2 - xq^2);
    F3 = cc^2 + 1 + qq^2;
    is_sq = issquare(F3);
    print("    c(P) = ", cc);
    print("    Face-3 = c^2 + 1 + q^2 = ", F3);
    print("    Face-3 is rational square? ", is_sq);
    if(is_sq, print("    *** !! PCP CANDIDATE — REQUIRES INVESTIGATION !! ***"));
  );
  print();
};

print("=== TRACK D — Face-3 verification on new generators ===\n");

{ gens_73_24 = [[-1682736, 2717991012], [-29494179/16, 171407894163/64], [85048836/25, 411918794376/125]]; }
face3_check_fiber(73, 24, gens_73_24);

{ gens_88_35 = [[94215620, 912659713370], [-2343500920/841, 4930454141290/24389], [3564505145/64, 211583341526545/512]]; }
face3_check_fiber(88, 35, gens_88_35);

{ gens_99_28 = [[13917204, 37398199734], [-10428138780/3481, 4396997894244282/205379], [-2384298, 20180650644], [-1158637696335/473344, 6616884937441228191/325660672]]; }
face3_check_fiber(99, 28, gens_99_28);

print("=== DONE Face-3 check ===");
quit;
