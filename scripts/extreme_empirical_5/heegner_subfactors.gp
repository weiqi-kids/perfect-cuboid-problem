\\ Heegner search on the J(V_q) elliptic sub-factors that have analytic
\\ rank = 1 (so ellheegner can find a generator). Even partial coverage is
\\ useful for extending the sub-factor box scan to find Face-3 conflicts.

default(parisize, 8000000000);
default(realprecision, 50);

heegner_factor(label, fname, coefs) = {
  my(E, P, ord, h);
  E = ellinit(coefs);
  print("\n--- ", label, "  E_", fname, "   coefs = ", coefs, " ---");
  iferr(P = ellheegner(E); \
        print("    ellheegner returned: ", P); \
        print("    onCurve = ", ellisoncurve(E, P)); \
        ord = ellorder(E, P); \
        print("    order   = ", ord); \
        if(ord == 0, h = ellheight(E, P); print("    h_can   = ", h)), \
        E1, print("    ellheegner failed (analytic rank > 1 or other): ", E1));
};

\\ Factors with rank 1 in the MASSIVE-DIRECT-5 data:
\\ (61,38): E_eg rank 1 (gens 0), E_fg rank 2 (gens 2)
\\ (63,38): E_eg rank 1 (gens 1), E_Hm rank 1 (gens 0)
\\ (73,24): E_eg rank 1 (gens 1), E_Hm rank 1 (gens 0)
\\ (88,35): E_eg rank 2 (gens 2)
\\ (99,28): E_eg rank 2, E_fg rank 1 (gens 1), E_Hp rank 1 (gens 1), E_Hm rank 1 (gens 0)

print("=== Heegner on rank-1 sub-factors with missing generators ===");

\\ Try the rank-1 factors whose generators are missing or known to confirm them.
\\ The coefficients are taken from the MW sieve data.

\\ (61,38) E_eg
heegner_factor("(61,38)", "eg", [1, 0, 0, -86535636516675, -370572931244620213600]);

\\ (63,38) E_Hm
heegner_factor("(63,38)", "Hm", [1, 0, 0, -114338046691720, 1495068849011232460800]);

\\ (73,24) E_Hm
heegner_factor("(73,24)", "Hm", [0, -1, 0, -127910198192064, -83501181854697176064]);

\\ (99,28) E_Hm
heegner_factor("(99,28)", "Hm", [1, 0, 0, -1685461832548704, 10854385900968766899456]);

print("\n=== DONE Heegner sub-factor ===");
quit;
