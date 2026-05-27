\\ ULTRA: walk isogeny class for (1099, 358) to resolve ambig5
default(parisize, 1200000000);

m = 1099; n = 358;
q = (m^2 - n^2)/(2*m*n);
E = ellinit([0, 1+q^2, 0, q^2, 0]);
chv = 0;
Emin = ellminimalmodel(E, &chv);
print("E_min coefficients: ", Emin[1..5]);
print("Root number: ", ellrootno(Emin), "  (=> odd rank)");

iso = ellisomat(Emin, 0, 1);
print("# isogenous curves: ", length(iso[1]));

{
for(j=1, length(iso[1]),
  print();
  print("--- iso[", j, "] ---");
  my(Ej = ellinit(iso[1][j]));
  print("  coefficients: ", Ej[1..5]);
  t0 = getwalltime();
  my(rj = ellrank(Ej, 8));
  print("  ellrank effort 8: [", rj[1], ",", rj[2], "] gens=", length(rj[4]), " t=", (getwalltime()-t0)/1000.0, "s");
  if(rj[1] == rj[2], print("  RESOLVED: rank = ", rj[1]); break);
  if(rj[1] >= 5, print("  *** RANK >= 5 ***"));
  if(rj[2] >= 5,
    t0 = getwalltime();
    my(rj2 = ellrank(Ej, 12));
    print("  effort 12: [", rj2[1], ",", rj2[2], "] gens=", length(rj2[4]), " t=", (getwalltime()-t0)/1000.0, "s");
  );
);
}

quit;
