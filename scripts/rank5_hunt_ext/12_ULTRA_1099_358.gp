\\ ULTRA-VERIFY (1099, 358) — first rank-5 candidate
default(parisize, 1200000000);

m = 1099; n = 358;
print("=== ULTRA-VERIFY (", m, ",", n, ") ===");
print("Checking primitivity: gcd=", gcd(m,n), " (m+n)%2=", (m+n)%2);

q = (m^2 - n^2)/(2*m*n);
print("q = ", q);
print("a = m²-n² = ", m^2-n^2, " = ", factor(m^2-n^2));
print("b = 2mn = ", 2*m*n, " = ", factor(2*m*n));
print("d = m²+n² = ", m^2+n^2, " = ", factor(m^2+n^2));
print("Pythagorean: a²+b²=d²? ", (m^2-n^2)^2 + (2*m*n)^2 == (m^2+n^2)^2);

E = ellinit([0, 1+q^2, 0, q^2, 0]);
chv = 0;
Emin = ellminimalmodel(E, &chv);
N = ellglobalred(Emin)[1];
print("E_min coefficients: ", Emin[1..5]);
print("conductor N = ", N);
print("log10(N) = ", log(N*1.0)/log(10));
print("ω(N) = ", omega(N));
print("Torsion: ", elltors(Emin));
print("Root number: ", ellrootno(Emin));

print();
print("=== Effort 4 ===");
t0 = getwalltime();
rk4 = ellrank(Emin, 4);
print("ellrank=[", rk4[1], ",", rk4[2], "] gens=", length(rk4[4]), " t=", (getwalltime()-t0)/1000.0, "s");

print();
print("=== Effort 6 ===");
t0 = getwalltime();
rk6 = ellrank(Emin, 6);
print("ellrank=[", rk6[1], ",", rk6[2], "] gens=", length(rk6[4]), " t=", (getwalltime()-t0)/1000.0, "s");

print();
print("=== Effort 8 ===");
t0 = getwalltime();
rk8 = ellrank(Emin, 8);
print("ellrank=[", rk8[1], ",", rk8[2], "] gens=", length(rk8[4]), " t=", (getwalltime()-t0)/1000.0, "s");

print();
print("=== Effort 10 ===");
t0 = getwalltime();
rk10 = ellrank(Emin, 10);
print("ellrank=[", rk10[1], ",", rk10[2], "] gens=", length(rk10[4]), " t=", (getwalltime()-t0)/1000.0, "s");

\\ Best result
rk = rk10;
if(length(rk6[4]) > length(rk10[4]), rk = rk6);
if(length(rk8[4]) > length(rk[4]), rk = rk8);

gens = rk[4];
num_g = length(gens);
print();
print("Using ", num_g, " gens from best ellrank result");

print();
print("=== Generator verification ===");
{
for(i=1, num_g,
  P = gens[i];
  print("G", i, " (Emin): ", P);
  print("  ellisoncurve(Emin) = ", ellisoncurve(Emin, P));
  print("  height = ", ellheight(Emin, P));
);
}

print();
print("=== Height pairing matrix ===");
H = matrix(num_g, num_g, i, j, ellheight(Emin, gens[i], gens[j]));
print("H = ", H);
print("det H = ", matdet(H));
print("Rank from H rank: ", matrank(H));

\\ Face-3 on each generator
print();
print("=== Face-3 verification ===");
n_sq = 0;
{
for(i=1, num_g,
  P = gens[i];
  PE = ellchangepointinv(P, chv);
  if(!ellisoncurve(E, PE),
    print("    G", i, ": pullback failed!");
    next);
  x = PE[1]; y = PE[2];
  c = 2*q*y/(q^2 - x^2);
  F3 = c^2 + 1 + q^2;
  sq = issquare(F3);
  print("G", i, ":");
  print("  x_E = ", x);
  print("  c = ", c);
  print("  F3 = ", F3);
  print("  issquare(F3) = ", sq);
  if(sq, n_sq = n_sq + 1; print("  *** PCP CANDIDATE ***"));
);
}
print("Total F3 squares: ", n_sq, " / ", num_g);

\\ Also try simple linear combinations
if(num_g >= 2,
  print();
  print("=== Simple linear combinations ===");
  for(i=1, num_g,
    for(j=i+1, num_g,
      my(sum_pt = elladd(Emin, gens[i], gens[j]));
      my(diff_pt = elladd(Emin, gens[i], ellneg(Emin, gens[j])));
      for(which=1, 2,
        my(P, label);
        if(which == 1, P = sum_pt; label = Str("G",i,"+G",j),
                       P = diff_pt; label = Str("G",i,"-G",j));
        my(PE = ellchangepointinv(P, chv));
        if(!ellisoncurve(E, PE), next);
        my(x = PE[1], y = PE[2]);
        if(q^2 - x^2 == 0, next);  \\ avoid div by zero
        my(c = 2*q*y/(q^2 - x^2));
        my(F3 = c^2 + 1 + q^2);
        my(sq = issquare(F3));
        print(label, ": F3 sq=", sq);
        if(sq, n_sq = n_sq + 1; print("  *** PCP CANDIDATE ***"));
      );
    );
  );
);
print("Total F3 squares (with combos): ", n_sq);

\\ Try isogeny walk if still ambiguous
if(rk10[1] < rk10[2],
  print();
  print("=== Isogeny class walk (still ambiguous) ===");
  iso = ellisomat(Emin, 0, 1);
  print("# isogenous curves: ", length(iso[1]));
  for(j=2, length(iso[1]),
    my(Ej = ellinit(iso[1][j]));
    my(rj = ellrank(Ej, 8));
    print("  iso[", j, "]: [", rj[1], ",", rj[2], "] gens=", length(rj[4]));
    if(rj[1] >= 5,
      print("  *** ISO RANK >= 5 ***");
    );
  );
);

quit;
