\\ Extended hunt [1000, 2500]: ellrank(Emin, 2) — smaller effort for speed
\\ For lo >= 4, escalate to effort 4 (and later effort 6)
default(parisize, 1200000000);

INFILE = "/root/proof/perfect-cuboid-problem/scripts/rank5_hunt_ext/ext_sieve.txt";
OUTFILE = "/root/proof/perfect-cuboid-problem/scripts/rank5_hunt_ext/ext_hunt.txt";
SURVFILE = "/root/proof/perfect-cuboid-problem/scripts/rank5_hunt_ext/ext_survivors.txt";

load_sieve(fname) = {
  my(L = List(), s = readstr(fname));
  for(i=1, length(s),
    my(line = s[i]);
    if(length(line) == 0, next);
    my(v = Vecsmall(line));
    if(length(v) > 0 && v[1] == 35, next);
    my(parts = strsplit(line, " "));
    if(length(parts) < 2, next);
    listput(L, [eval(parts[1]), eval(parts[2])]);
  );
  return(L);
};

write(OUTFILE, "# m n lo up gens time_s logN");
write(SURVFILE, "# m n lo up gens time_s logN [lo>=4 or up>=5]");

S = load_sieve(INFILE);
print("Loaded ", length(S), " ext candidates");

global_count = 0; global_promising = 0; global_t0 = getwalltime();

{
for(k=1, length(S),
  my(p = S[k], m = p[1], n = p[2]);
  my(q = (m^2-n^2)/(2*m*n));
  my(E = ellinit([0, 1+q^2, 0, q^2, 0]));
  my(Emin = ellminimalmodel(E));
  my(N = ellglobalred(Emin)[1]);
  my(logN = log(N*1.0)/log(10));
  my(t0 = getwalltime());
  my(rk = ellrank(Emin, 2));
  my(dt = (getwalltime() - t0)/1000.0);
  my(lo = rk[1], up = rk[2], gens = length(rk[4]));
  write(OUTFILE, m, " ", n, " ", lo, " ", up, " ", gens, " ", dt, " ", logN);
  global_count = global_count + 1;
  if(lo >= 4 || up >= 5,
    global_promising = global_promising + 1;
    write(SURVFILE, m, " ", n, " ", lo, " ", up, " ", gens, " ", dt, " ", logN);
    print("  *** PROMISING (", m, ",", n, ") lo=", lo, " up=", up, " gens=", gens, " t=", dt, "s ***");
  );
  if(global_count % 100 == 0,
    my(elapsed = (getwalltime() - global_t0)/1000.0);
    my(pct = 100.0*global_count/length(S));
    print("  ", global_count, "/", length(S), " (", pct, "%) promising=", global_promising,
          " elapsed=", elapsed, "s eta=", elapsed*(length(S)-global_count)/global_count, "s");
  );
);
}

my(elapsed = (getwalltime() - global_t0)/1000.0);
print();
print("=== EXT HUNT DONE ===");
print("Candidates processed: ", global_count);
print("Promising (lo>=4 or up>=5): ", global_promising);
print("Elapsed: ", elapsed, "s");
quit;
