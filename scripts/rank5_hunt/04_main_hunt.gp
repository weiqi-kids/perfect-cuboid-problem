\\ Rank-5 hunt — main pass: ellrank(E,3) on every sieve survivor
\\ Record: lower bound, upper bound, time, conductor (log10), generators count
default(parisize, 1500000000);

\\ Inputs
SIEVE_FILES = ["/root/proof/perfect-cuboid-problem/scripts/rank5_hunt/sieve2_300_600.txt", "/root/proof/perfect-cuboid-problem/scripts/rank5_hunt/sieve2_600_1000.txt"];
OUTFILE = "/root/proof/perfect-cuboid-problem/scripts/rank5_hunt/main_hunt.txt";
SURVFILE = "/root/proof/perfect-cuboid-problem/scripts/rank5_hunt/main_hunt_survivors.txt";  \\ rank >=4 promising

\\ Load candidates from file: skip lines starting with '#'
load(fname) = {
  my(L = List(), s = readstr(fname));
  for(i=1, #s,
    my(line = s[i]);
    if(#line == 0, next);
    \\ Check leading char by extracting it as a Vec
    my(v = Vecsmall(line));
    if(#v > 0 && v[1] == 35, next);  \\ ASCII '#' = 35
    my(parts = strsplit(line, " "));
    if(#parts < 2, next);
    listput(L, [eval(parts[1]), eval(parts[2])]);
  );
  return(L);
};

write(OUTFILE, "# m n lo up gens time_s logN");
write(SURVFILE, "# m n lo up gens time_s logN");

global_count = 0;
global_promising = 0;
global_t0 = getwalltime();

{
for(fi = 1, #SIEVE_FILES,
  my(S = load(SIEVE_FILES[fi]));
  print("Loaded ", #S, " candidates from ", SIEVE_FILES[fi]);
  for(k = 1, #S,
    my(p = S[k], m = p[1], n = p[2], q, E, rk, t0, dt, logN, lo, up, gens);
    q = (m^2 - n^2)/(2*m*n);
    E = ellinit([0, 1+q^2, 0, q^2, 0]);
    logN = log(abs(E.disc)*1.0)/log(10);  \\ log10|Delta|
    t0 = getwalltime();
    rk = ellrank(E, 3);
    dt = (getwalltime() - t0)/1000.0;
    lo = rk[1]; up = rk[2]; gens = #rk[4];
    write(OUTFILE, m, " ", n, " ", lo, " ", up, " ", gens, " ", dt, " ", logN);
    global_count = global_count + 1;
    if(lo >= 4 || up >= 5,
      global_promising = global_promising + 1;
      write(SURVFILE, m, " ", n, " ", lo, " ", up, " ", gens, " ", dt, " ", logN);
      print("  PROMISING (", m, ",", n, ") lo=", lo, " up=", up, " gens=", gens, " t=", dt, "s");
    );
    if(global_count % 100 == 0,
      my(elapsed = (getwalltime() - global_t0)/1000.0);
      print("  progress: ", global_count, " done, promising=", global_promising,
            ", elapsed=", elapsed, "s");
    );
  );
);
}

my(elapsed = (getwalltime() - global_t0)/1000.0);
print();
print("=== MAIN HUNT DONE ===");
print("Total candidates processed: ", global_count);
print("Promising (lo>=4 or up>=5): ", global_promising);
print("Elapsed: ", elapsed, "s");
quit;
