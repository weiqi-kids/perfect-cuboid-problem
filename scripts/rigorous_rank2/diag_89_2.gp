\\ Diagnose (89, 2): can we recover G2 via deeper search?
default(parisize, 2000000000);
default(realprecision, 38);

mm = 89; nn = 2;
q = (mm^2 - nn^2) / (2 * mm * nn);
print("q = ", q);
E = ellinit([0, 1 + q^2, 0, q^2, 0]);
v = 0;
Emin = ellminimalmodel(E, &v);
print("conductor = ", ellglobalred(Emin)[1]);

\\ Effort 6, 7, 8
for(eff = 6, 8,
  print("Trying ellrank effort ", eff, "...");
  gettime();
  rkdata = iferr(ellrank(Emin, eff), ERR, "ERR");
  print("  time = ", gettime(), "ms");
  print("  result = ", rkdata);
  if(type(rkdata) == "t_VEC" && #rkdata >= 4 && #rkdata[4] >= 2,
    print("  RECOVERED 2 generators at effort ", eff);
    break;
  );
);
quit;
