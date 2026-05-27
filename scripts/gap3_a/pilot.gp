\\ Pilot run to estimate ellrank cost at moderate-to-large conductors.
default(parisize, 800000000);
default(realprecision, 30);

\\ Reuse known fibers and a fresh one to gauge.
print("=== Pilot timing ===");

\\ Known small-N rank-1 fiber.
test_q(q) = {
  my(a2 = 1 + q^2, a4 = q^2, E, Emin, NE, t0, rk, ar);
  E = ellinit([0, a2, 0, a4, 0]);
  Emin = ellminimalmodel(E);
  NE = ellglobalred(Emin)[1];
  t0 = getwalltime();
  rk = ellrank(Emin, 2);
  print("  q=", q, "  N=", NE, "  ellrank=[", rk[1], ",", rk[2], "]  ngens=", #rk[4], "  t=", (getwalltime()-t0)/1000.0, "s");
};

test_q(20/21);    \\ known rank 1, N=4305
test_q(7/24);     \\ known rank 1, N=22134
test_q(11/60);    \\ known rank 2, N=82005
test_q(20/99);    \\ known rank 1, N=1551165
test_q(104/153);  \\ known rank 2, N=2385474

\\ Test a fresh higher-conductor Pythagorean q.
test_q(35/612);   \\ from (m,n) = (18,17), if valid
test_q(220/21);   \\ reciprocal of 21/220

\\ Test rank-3 fiber from PICK-9.
test_q(195/748);   \\ (22,17), known rank 3, N ~ 1.9e10 — likely too big

print("=== End pilot ===");
quit;
