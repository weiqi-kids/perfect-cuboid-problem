\\ Extra: try ellrank with very high effort to see if it breaks [0, 2]
default(parisize, 1500000000);

read("/root/proof/perfect-cuboid-problem/scripts/4-descent/EHm_short_data.gp");
E_short = ellinit([0, A2_short, 0, A4_short, A6_short]);

print("===========================================");
print("High-effort ellrank attempts:");
print("===========================================");

\\ effort 9
print("ellrank(E_short, 8) ...");
t0 = getwalltime();
r = ellrank(E_short, 8);
t1 = getwalltime();
print("  result = ", r, "  wall = ", (t1-t0)/1000.0, "s");

print("ellrank(E_short, 9) ...");
t0 = getwalltime();
r = ellrank(E_short, 9);
t1 = getwalltime();
print("  result = ", r, "  wall = ", (t1-t0)/1000.0, "s");

print("ellrank(E_short, 10) ...");
t0 = getwalltime();
r = ellrank(E_short, 10);
t1 = getwalltime();
print("  result = ", r, "  wall = ", (t1-t0)/1000.0, "s");

\\ Try ellrankinit + multiple rounds
print();
print("ellrankinit-based search:");
ri = ellrankinit(E_short);
print("  ellrankinit returned, type = ", type(ri));
print("Searching points with ellrank(ri, 10) ...");
t0 = getwalltime();
r = ellrank(ri, 10);
t1 = getwalltime();
print("  result = ", r, "  wall = ", (t1-t0)/1000.0, "s");

\\ Try ellsearch (does this exist?)
print();
print("Try ellheegner / Heegner approach:");
trap_eh = trap(, "not implemented", ellheegner(E_short));
print("  ellheegner: ", trap_eh);

quit;
