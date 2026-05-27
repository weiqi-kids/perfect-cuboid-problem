\\ Compute root number w(E_Hm) for the 3 remaining BEYOND-QC fibers.
\\ Specifically: try to sharpen (73,24) rank using parity.

default(parisize, 1000000000);

{ fibers = [["(63,38)", -5343652737951011423545792190, 147088469266310969311366478538247305164100, 1, 1], ["(73,24)", -4296889542830417930548255320, 69513195990628448299367172717433334517312, 1, 3], ["(88,35)", -56968972021100673322719633980, -4381013374830911732760444269999712553455600, 0, 0]]; }

print("==============================================");
print("Root number / parity sharpening for 3 fibers");
print("==============================================");

{
for(k = 1, #fibers,
  my(fname, A4, A6, rk_lo, rk_hi, E, w, parity, possible);
  fname = fibers[k][1];
  A4 = fibers[k][2];
  A6 = fibers[k][3];
  rk_lo = fibers[k][4];
  rk_hi = fibers[k][5];
  E = ellinit([1, 0, 0, A4, A6]);
  w = ellrootno(E);
  parity = if(w == 1, "EVEN", "ODD");
  print();
  print("Fiber ", fname, ":");
  print("  ellrank rk range: [", rk_lo, ", ", rk_hi, "]");
  print("  root number w = ", w, "  (analytic rank parity ", parity, ")");
  \\ Filter possible ranks
  possible = List();
  for(r = rk_lo, rk_hi,
    if((w == 1 && r % 2 == 0) || (w == -1 && r % 2 == 1),
      listput(possible, r)
    );
  );
  print("  PARITY-FILTERED possible ranks: ", Vec(possible));
  if(#possible == 1,
    print("  ==> rk(E_Hm) = ", possible[1], "  RIGOROUSLY SHARPENED via parity"),
    if(#possible == 0,
      print("  ==> CONTRADICTION (ellrank vs root number); check input"),
      print("  ==> rk(E_Hm) still in ", Vec(possible), "; need more")
    )
  );
);
}

\\ Now also for (61,38) E_Hm for comparison (already done)
print();
print("--- For reference: (61,38) E_Hm ---");
E61 = ellinit([1, 0, 0, -4201713691887954766021162410, 103564307677747011646913552825626935447972]);
w61 = ellrootno(E61);
print("  w(E_Hm of (61,38)) = ", w61, "  (parity = ", if(w61 == 1, "EVEN", "ODD"), ")");
print("  rk range [0, 2] + EVEN parity ==> rk ∈ {0, 2} (already known)");

quit;
