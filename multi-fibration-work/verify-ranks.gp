\\ Verify the BEYOND-QC ranks in QC-MAGMA-FRAMEWORK match what we recompute.
\\ Also illustrate that the 3 "natural" fibrations (pi_d, pi_e, pi_f) reduce to the
\\ SAME 5 elliptic factor formulas at the same numerical q. Hence same ranks.

compute_factors(q0) = { \
  my(c2, c1, c0, f_quart, E_Hm_coef, res); \
  res = vector(5); \
  res[1] = ellminimalmodel(ellinit([0, -2*(1+q0^2), 0, (1-q0^2)^2, 0])); \
  res[2] = ellminimalmodel(ellinit([0, -2*(1+2*q0^2), 0, 1, 0])); \
  res[3] = ellminimalmodel(ellinit([0, -2*(2+q0^2), 0, q0^4, 0])); \
  c2 = 2 + 2*q0^2; c1 = 1 + 3*q0^2 + q0^4; c0 = q0^2 + q0^4; \
  res[4] = ellminimalmodel(ellinit([0, c2, 0, c1, c0])); \
  f_quart = 'X * ('X + q0^2) * ('X + 1) * ('X + 1 + q0^2); \
  E_Hm_coef = ellfromeqn('y^2 - f_quart); \
  res[5] = ellminimalmodel(ellinit(E_Hm_coef)); \
  return(res); \
}

rank_pair(E) = { my(r); r = ellrank(E, 0); [r[1], r[2]]; }

data = [[61,38],[63,38],[73,24],[88,35],[99,28]];
print("Recomputing ranks for the 5 BEYOND-QC fibers.");
print("(m,n)   q                rk(E_ef)  rk(E_eg)  rk(E_fg)  rk(E_H+)  rk(E_H-)  TOTAL");

for(i = 1, length(data), \
  mn = data[i]; \
  m = mn[1]; n = mn[2]; \
  q0 = 2*m*n / (m^2 - n^2); \
  facs = compute_factors(q0); \
  r1 = rank_pair(facs[1]); \
  r2 = rank_pair(facs[2]); \
  r3 = rank_pair(facs[3]); \
  r4 = rank_pair(facs[4]); \
  r5 = rank_pair(facs[5]); \
  lo = r1[1] + r2[1] + r3[1] + r4[1] + r5[1]; \
  hi = r1[2] + r2[2] + r3[2] + r4[2] + r5[2]; \
  print(mn, "  q=", q0, "  ", r1, " ", r2, " ", r3, " ", r4, " ", r5, "  total=[", lo, ",", hi, "]"); \
);
quit;
