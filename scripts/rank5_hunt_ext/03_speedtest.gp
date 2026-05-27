\\ Speed test: ellrank on sample fibers from each range
default(parisize, 1200000000);

testcases = [[450, 23], [600, 451], [800, 277], [1000, 477], [1500, 691], [2000, 933], [2500, 1471]];

{
for(i=1, #testcases,
  my(p = testcases[i], m = p[1], n = p[2]);
  if(gcd(m,n) != 1 || (m+n)%2 == 0, print("Skip ", m, ",", n); next);
  my(q = (m^2-n^2)/(2*m*n));
  my(E = ellinit([0, 1+q^2, 0, q^2, 0]));
  my(Emin = ellminimalmodel(E));
  my(N = ellglobalred(Emin)[1]);
  my(logN = log(N*1.0)/log(10));
  print("(", m, ",", n, ") log10(N)=", logN);

  my(t0 = getwalltime());
  my(r2 = ellrank(Emin, 2));
  my(t = (getwalltime()-t0)/1000.0);
  print("  effort 2: [", r2[1], ",", r2[2], "] gens=", #r2[4], " t=", t, "s");

  t0 = getwalltime();
  my(r3 = ellrank(Emin, 3));
  t = (getwalltime()-t0)/1000.0;
  print("  effort 3: [", r3[1], ",", r3[2], "] gens=", #r3[4], " t=", t, "s");
);
}
quit;
