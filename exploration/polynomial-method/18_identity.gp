/* PCP via (d,e,f,g) parametrization */

countOrbit(G) = {
  my(g, d, e, f, count);
  for(g = 1, G,
    count = 0;
    for(d = 1, 2*g, for(e = d, 2*g, for(f = e, 2*g, if(d^2+e^2+f^2 == 2*g^2, count = count + 1;))));
    if(count > 0, print("  g=", g, " count=", count));
  );
}

searchPCP(D) = {
  my(d, e, f, s, g2, g, t_a, t_b, t_c, a2, b2, c2, a, b, c, hits);
  hits = 0;
  for(d = 1, D, for(e = d, D, for(f = e, D,
    s = d^2 + e^2 + f^2;
    if(s % 2 != 0, , g2 = s/2; g = sqrtint(g2); if(g*g != g2, , t_a = d^2+f^2-e^2; t_b = d^2+e^2-f^2; t_c = -d^2+e^2+f^2;
    if(t_a < 0 || t_b < 0 || t_c < 0, , if(t_a%2!=0 || t_b%2!=0 || t_c%2!=0, , a2 = t_a/2; b2 = t_b/2; c2 = t_c/2;
    if(!issquare(a2) || !issquare(b2) || !issquare(c2), , a = sqrtint(a2); b = sqrtint(b2); c = sqrtint(c2);
    if(a*b*c == 0, , hits = hits + 1; print("  HIT (a,b,c,d,e,f,g)=(", a, ",", b, ",", c, ",", d, ",", e, ",", f, ",", g, ")");))))))
  )));
  print("Total nontrivial PCP, d<=", D, ": ", hits);
}

print("Orbit counts (d^2+e^2+f^2 = 2g^2):");
countOrbit(20);
print("\nFull PCP search:");
searchPCP(50);
quit;
