read("/tmp/legs.gp");

is_valid_g(g) = {
  my(fct, pp, k);
  if(!issquarefree(g), return(0));
  fct = factor(g);
  pp = fct[,1];
  for(k=1, #pp, if(Mod(pp[k], 4) != 1, return(0)));
  if(#pp >= 3, 1, 0)
}

scan(BOUND) = {
  my(g, L, L_set, NL, a, b, d, c2, sf, total, sf_one);
  total = 0;
  sf_one = 0;
  for(g = 2, BOUND, if(is_valid_g(g),
    L = compute_legs(g);
    L_set = Set(L);
    NL = #L;
    for(i=1, NL, for(j=i+1, NL,
      a = L[i]; b = L[j];
      if(issquare(a^2 + b^2),
        d = sqrtint(a^2 + b^2);
        if(d < g,
          total = total + 1;
          c2 = g^2 - d^2;
          sf = core(c2);
          if(sf == 1, sf_one = sf_one + 1; print("LEG-HIT: g=", g, " d=", d, " (c=sqrt(c2)=", sqrtint(c2), ")"));
          if(total <= 30, print("g=", g, " d=", d, " core(g^2-d^2)=", sf))
        )
      )
    ))
  ));
  print("BOUND=", BOUND, ": total d<g cases = ", total, ", with c^2=g^2-d^2 a square = ", sf_one)
}

scan(50000);
