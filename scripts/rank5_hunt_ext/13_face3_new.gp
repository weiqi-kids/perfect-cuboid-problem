\\ Face-3 + escalation on newly-found rank-4 fibers
default(parisize, 1200000000);

\\ Most recent (848, 617) plus others found later
HITS = [[848, 617]];

n_F3_sq = 0;

{
for(k=1, length(HITS),
  my(p = HITS[k], m = p[1], n = p[2]);
  print();
  print("=== (", m, ",", n, ") ===");
  print("omega: wp=", omega(m^2+n^2), " wm=", omega(m^2-n^2), " wmn=", omega(m*n), " wsp=", omega(m+n), " wsm=", omega(m-n));
  my(q = (m^2-n^2)/(2*m*n));
  my(E = ellinit([0, 1+q^2, 0, q^2, 0]));
  my(chv = 0);
  my(Emin = ellminimalmodel(E, &chv));
  my(N = ellglobalred(Emin)[1]);
  print("conductor N=", N, " log10=", log(N*1.0)/log(10), " ω(N)=", omega(N));

  my(t0 = getwalltime());
  my(rk6 = ellrank(Emin, 6));
  my(t6 = (getwalltime()-t0)/1000.0);
  print("effort 6: [", rk6[1], ",", rk6[2], "] gens=", length(rk6[4]), " t=", t6, "s");

  if(rk6[1] < 4, print("Not rank 4! skipping"); next);

  my(gens = rk6[4]);
  my(num_g = length(gens));
  my(H = matrix(num_g, num_g, i, j, ellheight(Emin, gens[i], gens[j])));
  print("det H = ", matdet(H));

  print("--- Face-3 ---");
  for(i=1, num_g,
    my(P = gens[i]);
    my(PE = ellchangepointinv(P, chv));
    if(!ellisoncurve(E, PE), print("G", i, ": pullback failed"); next);
    my(x = PE[1], y = PE[2]);
    my(c = 2*q*y/(q^2 - x^2));
    my(F3 = c^2 + 1 + q^2);
    my(sq = issquare(F3));
    print("G", i, ": F3 sq=", sq);
    if(sq, n_F3_sq = n_F3_sq + 1; print("  *** PCP CANDIDATE ***"));
  );
);
}

print();
print("Total F3 squares: ", n_F3_sq);
quit;
