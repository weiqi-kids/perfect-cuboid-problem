\\ Try to constrain rank at (217, 24) via analytic methods
default(parisize, 2000000000);
print("=== Try analytic rank at (217, 24) ===");
m = 217; n = 24;
q = (m^2-n^2)/(2*m*n);
E = ellinit([0, 1+q^2, 0, q^2, 0]);
Em = ellminimalmodel(E);
print("Conductor = ", ellglobalred(Em)[1]);

print("\nellanalyticrank (this may be slow for large conductor)...");
t0 = getwalltime();
ar = ellanalyticrank(Em, 0.01);
print("  time = ", (getwalltime()-t0)/1000.0, "s");
print("  analytic rank = ", ar[1]);
print("  L^(",ar[1],")(E, 1) = ", ar[2]);

\\ Also try Heegner point computation
print("\nTrying ellheegner...");
t0 = getwalltime();
H = ellheegner(Em);
print("  time = ", (getwalltime()-t0)/1000.0, "s");
print("  Heegner point H = ", H);
if(H != 0, print("  ellisoncurve(H)? ", ellisoncurve(Em, H)); print("  Heegner height = ", ellheight(Em, H)));

quit;
