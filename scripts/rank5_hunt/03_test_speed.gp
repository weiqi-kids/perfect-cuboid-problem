default(parisize, 1500000000);
\\ Quick speed test: ellrank effort 2 on a few candidates

samples = [[301, 158], [400, 113], [500, 387], [571, 252], [598, 425]];

{
for(j=1, #samples,
  my(p = samples[j], m = p[1], n = p[2], q, E, t0, rk, dt);
  q = (m^2 - n^2)/(2*m*n);
  E = ellinit([0, 1+q^2, 0, q^2, 0]);
  t0 = getwalltime();
  rk = ellrank(E, 2);
  dt = (getwalltime() - t0)/1000.0;
  print("(", m, ",", n, "): ellrank(E,2)=[", rk[1], ",", rk[2], "] gens=", #rk[4], " time=", dt, "s");
);
}
quit;
