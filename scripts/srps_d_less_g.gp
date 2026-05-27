read("/tmp/legs.gp");

analyze_g(g) = {
  my(L, NL, a, b, d, L_set, in_legs, df, d_primes, g_primes, d_extra, found);
  L = compute_legs(g);
  L_set = Set(L);
  NL = #L;
  found = 0;
  for(i=1, NL, for(j=i+1, NL,
    a = L[i]; b = L[j];
    if(issquare(a^2 + b^2),
      d = sqrtint(a^2 + b^2);
      if(d < g,
        found = found + 1;
        in_legs = setsearch(L_set, d) > 0;
        df = factor(d);
        d_primes = Vec(df[,1]);
        g_primes = Vec(factor(g)[,1]);
        d_extra = setminus(Set(d_primes), Set(g_primes));
        print("  g=", g, " (a,b,d)=(", a, ",", b, ",", d, ") g-d=", g-d, " extra=", Vec(d_extra), " in legs? ", in_legs)
      )
    )
  ));
  found
}

is_valid_g(g) = {
  my(fct, pp, k);
  if(!issquarefree(g), return(0));
  fct = factor(g);
  pp = fct[,1];
  for(k=1, #pp, if(Mod(pp[k], 4) != 1, return(0)));
  if(#pp >= 3, 1, 0)
}

print("=== Scan g <= 30000 ===");
total_found = 0;
for(g = 2, 30000, if(is_valid_g(g), total_found = total_found + analyze_g(g)));
print("Total d<g pair-hits: ", total_found);
