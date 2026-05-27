\\ ====================================================================
\\ Gap 3 / Pick 10 Refinement — Step 1: Hindry-Silverman effective h_0
\\ ====================================================================
\\ Author: CL / Lightman Chang
\\ Date:   2026-05-20

default(parisize, 500000000);
default(realprecision, 30);

{
print("================================================================");
print("Step 1. Hindry-Silverman effective canonical height lower bound");
print("================================================================");
print();

DEGJ = 12;
CHI = 24;
C1 = 1.0 / (DEGJ * CHI / 2);
H0_THM_LOG2 = C1 * log(2);
H0_THM_LOG1 = C1 * 0.5;

print("Theoretical Hindry constants for V' -> P^1:");
print("  deg(j) = ", DEGJ);
print("  chi_top(V') = ", CHI);
print("  chi/2 = ", CHI/2);
print("  c_1 = 1/(deg(j) * chi/2) = ", C1);
print("  h_0_thm (conservative, h_B >= log 2) = ", H0_THM_LOG2);
print("  h_0_thm (very conservative, h_B >= 1/2) = ", H0_THM_LOG1);
print();
}

\\ All rank-jump fibers we know about.
\\ Format: [u, v, N, rank]  (q = u/v as written; we will compute conductor again)
{
fibers = [
  [20,  21,    4305,    1],
  [7,   24,    22134,   1],
  [11,  60,    82005,   2],
  [48,  55,    237930,  1],
  [20,  99,    1551165, 1],
  [96,  247,   1566474, 1],
  [13,  84,    1880151, 1],
  [39,  80,    1902810, 1],
  [17,  144,   2085594, 2],
  [104, 153,   2385474, 2],
  [195, 748,   0,       3],
  [741, 1540,  0,       3]
];

h_emp_min = 9999.0;
h_emp_max = 0.0;

fiber_data = vector(#fibers);

print("================================================================");
print("Step 2. Empirical hat_h(P_0) across all known rank-jump fibers");
print("================================================================");
print();

for(i = 1, #fibers,
  u = fibers[i][1];
  v = fibers[i][2];
  Ndecl = fibers[i][3];
  r = fibers[i][4];
  q = u/v;
  E = ellinit([0, 1+q^2, 0, q^2, 0]);
  Emin = ellminimalmodel(E);
  Ncond = ellglobalred(Emin)[1];
  Dmin = Emin.disc;
  print("--- (u,v) = (", u, ", ", v, "), q = ", q, ", rank = ", r, " ---");
  print("  conductor N(E) = ", Ncond, "  (declared = ", Ndecl, ")");
  print("  |Delta_min| = ", abs(Dmin));
  print("  log N(E) = ", precision(log(Ncond * 1.0), 8));

  rk_data = ellrank(Emin, 5);
  print("  ellrank low/high = ", rk_data[1], "/", rk_data[2]);
  gens = rk_data[4];
  print("  number of generators found = ", #gens);

  lambda_min = 9999.0;
  if(#gens >= 1,
    if(r == 1 || #gens == 1,
      lambda_min = ellheight(Emin, gens[1]);
      print("  hat_h(G1) = ", precision(lambda_min, 12));
    );
    if(r >= 2 && #gens >= 2,
      h1 = ellheight(Emin, gens[1]);
      h2 = ellheight(Emin, gens[2]);
      hP1Q = ellheight(Emin, elladd(Emin, gens[1], gens[2]));
      h12 = (hP1Q - h1 - h2) / 2;
      \\ short search over small integer combinations
      lambda_min = min(h1, h2);
      for(a = -3, 3, for(b = -3, 3,
        if(a == 0 && b == 0, next);
        Q = h1*a^2 + 2*h12*a*b + h2*b^2;
        if(Q > 0 && Q < lambda_min, lambda_min = Q);
      ));
      print("  hat_h(G1) = ", precision(h1, 12));
      print("  hat_h(G2) = ", precision(h2, 12));
      print("  <G1,G2>  = ", precision(h12, 12));
    );
    if(r >= 3 && #gens >= 3,
      h3 = ellheight(Emin, gens[3]);
      h13 = (ellheight(Emin, elladd(Emin, gens[1], gens[3])) - h1 - h3) / 2;
      h23 = (ellheight(Emin, elladd(Emin, gens[2], gens[3])) - h2 - h3) / 2;
      print("  hat_h(G3) = ", precision(h3, 12));
      print("  <G1,G3>  = ", precision(h13, 12));
      print("  <G2,G3>  = ", precision(h23, 12));
      \\ 3x3 height pairing matrix
      M = matrix(3, 3);
      M[1,1] = h1; M[2,2] = h2; M[3,3] = h3;
      M[1,2] = h12; M[2,1] = h12;
      M[1,3] = h13; M[3,1] = h13;
      M[2,3] = h23; M[3,2] = h23;
      \\ search short vectors |a|,|b|,|c| <= 2
      lambda_min = min(min(h1, h2), h3);
      for(a = -2, 2, for(b = -2, 2, for(c = -2, 2,
        if(a == 0 && b == 0 && c == 0, next);
        Q = h1*a^2 + h2*b^2 + h3*c^2 + 2*h12*a*b + 2*h13*a*c + 2*h23*b*c;
        if(Q > 0 && Q < lambda_min, lambda_min = Q);
      )));
    );
    print("  lambda_min = ", precision(lambda_min, 12));
    if(lambda_min < h_emp_min, h_emp_min = lambda_min);
    if(lambda_min > h_emp_max, h_emp_max = lambda_min);
  );
  fiber_data[i] = [u, v, Ncond, r, lambda_min, abs(Dmin)];
  print();
);

print("================================================================");
print("Summary: empirical vs theoretical h_0");
print("================================================================");
print();
print("Theoretical h_0_thm (conservative)            = ", H0_THM_LOG2);
print("Empirical h_0_emp (smallest observed)         = ", precision(h_emp_min, 12));
print("Empirical h_max (largest observed)            = ", precision(h_emp_max, 12));
print();
print("Ratio h_0_emp / h_0_thm                       = ", precision(h_emp_min / H0_THM_LOG2, 8));
print();
print("INTERPRETATION:");
print("- Hindry's theoretical bound is the worst-case slope; empirical");
print("  values are 2+ orders of magnitude larger.");
print();
print("Fiber data table:");
print("(u, v)        | N(E)            | rank | lambda_min        | log|Delta|");
print("--------------|-----------------|------|-------------------|------------");
for(i = 1, #fiber_data,
  fd = fiber_data[i];
  print(fd[1], "/", fd[2], "  | ", fd[3], "  | ", fd[4], "  | ",
        precision(fd[5], 8), " | ", precision(log(fd[6]*1.0), 8));
);

print();
print("=== End Step 1 ===");
}
quit;
