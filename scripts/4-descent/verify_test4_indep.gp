\\ Verify: on test curve T4 (rank 1, gen (25, 120)), all our found points are in <(25,120)>.

default(parisize, 1000000000);
default(realprecision, 38);

E4 = ellinit([0, 0, 0, -49, 0]);
G = [25, 120];
print("E4: y^2 = x^3 - 49 x, gen G = ", G);
print("ord G = ", ellorder(E4, G));
print("height G = ", ellheight(E4, G));
print();

pts = [[-89383/214369, 447832560/99252847], [-89383/214369, -447832560/99252847], [-705600/113569, 307635720/38272753], [-705600/113569, -307635720/38272753], [-63/16, -735/64], [-63/16, 735/64]];

\\ For each, compute log(height) / log(height(G)) to see multiplicity, and try ellbil to detect.
{
for(i = 1, #pts,
    P = pts[i];
    if(ellisoncurve(E4, P),
      h = ellheight(E4, P);
      \\ Project onto <G>: a = <P, G> / <G, G>
      pair = ellheight(E4, P, G);
      a = pair / ellheight(E4, G);
      print("P", i, " = ", P, "  h=", h, "  a=<P,G>/<G,G>=", a);
    , print("P", i, " not on curve"));
);
}

print();
print("Expected: a is an integer for each (since P = a*G in MW group)");

quit;
