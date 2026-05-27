\\ Leg D: rational z_1 = p/q for each non-trivial Selmer triple.
\\ For X̃ = (d_1*p^2 + e_1*q^2)/q^2 to lift to a Q-point on E:
\\   d_2 * (d_1*p^2 - (e_2-e_1)*q^2) must be a perfect integer square,
\\   d_3 * (d_1*p^2 - (e_3-e_1)*q^2) must be a perfect integer square.
\\ Loop (p, q) ∈ Z × Z>0 with gcd(p,q) = 1.

default(parisize, 400000000);
default(parisizemax, 800000000);
default(realprecision, 38);

A4 = -4296889542830417930548255320;
A6 = 69513195990628448299367172717433334517312;
E = ellinit([1, 0, 0, A4, A6]);

e1 = -289985899459969;
e2 =  69618111281856;
e3 =  220367788178112;
C21 = e2 - e1;
C31 = e3 - e1;

{triples = [[1,1,1],[1,219,219],[97,-3,-291],[97,-73,-7081],[8257,-49542,-6],[8257,-1205522,-146],[800929,16514,194],[800929,3616566,42486],[5905,5905,1],[5905,1293195,219],[572785,-17715,-291],[572785,-431065,-7081],[48757585,-292545510,-6],[48757585,-7118607410,-146],[4729485745,97515170,194],[4729485745,21355822230,42486],[1249,7494,6],[1249,182354,146],[121153,-2498,-194],[121153,-547062,-42486],[10312993,-10312993,-1],[10312993,-2258545467,-219],[1000360321,30938979,291],[1000360321,752848489,7081],[7375345,44252070,6],[7375345,1076800370,146],[715408465,-14750690,-194],[715408465,-3230401110,-42486],[60898223665,-60898223665,-1],[60898223665,-13336710982635,-219],[5907127695505,182694670995,291],[5907127695505,4445570327545,7081]];}

P_BOUND = 50000;   \\ |p| up to 50K
Q_BOUND = 200;     \\ q up to 200

print("Leg D: rational z_1 = p/q, |p| <= ", P_BOUND, ", 1 <= q <= ", Q_BOUND);
print();

hits = 0;
t_start = getwalltime();

{
for(k = 1, #triples,
  trip = triples[k];
  d1 = trip[1]; d2 = trip[2]; d3 = trip[3];
  if(d1 == 1 && d2 == 1 && d3 == 1, next);
  print("[", k, "/", #triples, "] triple = ", trip);
  t0 = getwalltime();
  found_this = 0;
  for(q = 1, Q_BOUND,
    if(found_this, break);
    for(p = 0, P_BOUND,
      if(found_this, break);
      if(gcd(p, q) != 1, next);
      \\ X̃ = (d1*p^2 + e1*q^2) / q^2
      \\ d_i * (X̃ - e_i) = d_i * (d1*p^2 - (e_i - e1)*q^2) / q^2; square iff numerator * d_i is square in Z.
      val2 = d2 * (d1*p^2 - C21*q^2);
      if(val2 < 0, next);
      if(!issquare(val2), next);
      val3 = d3 * (d1*p^2 - C31*q^2);
      if(val3 < 0, next);
      if(!issquare(val3), next);
      \\ X̃ = (d1*p^2 + e1*q^2)/q^2
      Xtilde_num = d1*p^2 + e1*q^2;
      Y2 = (Xtilde_num - e1*q^2) * (Xtilde_num - e2*q^2) * (Xtilde_num - e3*q^2);
      \\ Need Y2 to be q^6 times a square
      Y2_scaled = Y2;  \\ this is Y_short^2 * q^6
      if(!issquare(Y2_scaled), next);
      Yt_scaled = sqrtint(Y2_scaled);
      \\ x_E = X̃/4 = Xtilde_num/(4*q^2); y_E = (Y - X̃/2)/8
      x_E = Xtilde_num / (4*q^2);
      for(sgn = 0, 1,
        Yu_scaled = (-1)^sgn * Yt_scaled;
        \\ Y = Yu_scaled / q^3 (matches scaling), y_E = (Y - X̃/2)/8
        Y_actual = Yu_scaled / q^3;
        y_E = (Y_actual - (Xtilde_num/q^2)/2)/8;
        P = [x_E, y_E];
        if(ellisoncurve(E, P),
          ord = ellorder(E, P);
          print("    *** HIT *** (p, q) = (", p, ", ", q, ")");
          print("       X̃ = ", Xtilde_num, " / ", q^2);
          print("       Y = ", Y_actual);
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
  );
  t1 = getwalltime();
  if(found_this == 0, print("    no hit  wall = ", (t1-t0)/1000.0, "s"));
  print();
);
}

t_end = getwalltime();
print("=== Leg D complete ===");
print("Total wall: ", (t_end - t_start)/1000.0, "s");
print("Total hits: ", hits);

quit;
