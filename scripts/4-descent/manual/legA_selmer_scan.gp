\\ Leg A: Systematic Selmer-class integer scan for (73, 24) E_Hm.

default(parisize, 400000000);
default(parisizemax, 800000000);
default(realprecision, 38);

A4 = -4296889542830417930548255320;
A6 = 69513195990628448299367172717433334517312;
E = ellinit([1, 0, 0, A4, A6]);

e1 = -289985899459969;
e2 =  69618111281856;
e3 =  220367788178112;

\\ Verify roots
fcheck = e1^3 + e1^2 + 16*A4*e1 + 64*A6;
print("f(e1) = ", fcheck);
fcheck = e2^3 + e2^2 + 16*A4*e2 + 64*A6;
print("f(e2) = ", fcheck);
fcheck = e3^3 + e3^2 + 16*A4*e3 + 64*A6;
print("f(e3) = ", fcheck);

{triples = [[1,1,1],[1,219,219],[97,-3,-291],[97,-73,-7081],[8257,-49542,-6],[8257,-1205522,-146],[800929,16514,194],[800929,3616566,42486],[5905,5905,1],[5905,1293195,219],[572785,-17715,-291],[572785,-431065,-7081],[48757585,-292545510,-6],[48757585,-7118607410,-146],[4729485745,97515170,194],[4729485745,21355822230,42486],[1249,7494,6],[1249,182354,146],[121153,-2498,-194],[121153,-547062,-42486],[10312993,-10312993,-1],[10312993,-2258545467,-219],[1000360321,30938979,291],[1000360321,752848489,7081],[7375345,44252070,6],[7375345,1076800370,146],[715408465,-14750690,-194],[715408465,-3230401110,-42486],[60898223665,-60898223665,-1],[60898223665,-13336710982635,-219],[5907127695505,182694670995,291],[5907127695505,4445570327545,7081]];}

print("Total Selmer triples: ", #triples);
B = 2000000;
print("Search bound: |z_1| <= ", B);
print();

hits = 0;
t_start = getwalltime();

{
for(k = 1, #triples,
  trip = triples[k];
  d1 = trip[1]; d2 = trip[2]; d3 = trip[3];
  if(d1 == 1 && d2 == 1 && d3 == 1, print("[",k,"/",#triples,"] skip trivial [1,1,1]"); next);
  print("[", k, "/", #triples, "] triple = ", trip);
  t0 = getwalltime();
  found_this = 0;
  for(z1 = 0, B,
    X = d1*z1^2 + e1;
    Aw = X - e2;
    Bw = X - e3;
    if(d2*Aw < 0, next);
    if(d3*Bw < 0, next);
    if(!issquare(Aw*d2), next);
    if(!issquare(Bw*d3), next);
    Y2 = (X - e1) * (X - e2) * (X - e3);
    if(Y2 < 0, next);
    if(!issquare(Y2), next);
    Yt = sqrtint(Y2);
    \\ Recover P on E: x = X/4, y = (Yt - X/2)/8 (or with -Yt)
    if(X % 4 != 0, print("    X=",X," not divisible by 4 — non-integer point"); next);
    x_E = X/4;
    for(sgn = 0, 1,
      Yu = (-1)^sgn * Yt;
      if((Yu - X/2) % 8 != 0, next);
      y_E = (Yu - X/2)/8;
      P = [x_E, y_E];
      if(ellisoncurve(E, P),
        ord = ellorder(E, P);
        print("    *** HIT *** z1=", z1, "  X=", X, "  Y=", Yu);
        print("       P_E = ", P);
        print("       ellorder = ", ord);
        if(ord == 0,
          ht = ellheight(E, P);
          print("       *** NON-TORSION GENERATOR *** canonical height = ", ht);
          print("       triple_index = ", k, "  triple = ", trip);
          hits = hits + 1;
          found_this = 1;
        );
      );
    );
  );
  t1 = getwalltime();
  if(found_this == 0, print("    no hit  wall = ", (t1-t0)/1000.0, "s"));
  print();
);
}

t_end = getwalltime();
print("=== Leg A complete ===");
print("Total wall: ", (t_end - t_start)/1000.0, "s");
print("Total hits: ", hits);

quit;
