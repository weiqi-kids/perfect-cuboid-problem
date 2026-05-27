\\ Leg H: Heavy concentration on small-d_1 triples with p_extension=50.

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

\\ ONLY small-d_1 triples (d_1 ≤ 10^4) — these are the ones Leg G2 covered with p_extension=5.
\\ Now extend to p_extension=50.
{triples_focus = [[1,219,219],[97,-3,-291],[97,-73,-7081],[8257,-49542,-6],[8257,-1205522,-146],[5905,5905,1],[5905,1293195,219],[1249,7494,6],[1249,182354,146]];}

P_EXT = 50;   \\ extend p above p_lo by factor 50
print("Leg H: small-d_1 triples, p_extension = ", P_EXT);
print("  triples_focus count = ", #triples_focus);
print();

hits = 0;
t_start = getwalltime();

{
for(k = 1, #triples_focus,
  trip = triples_focus[k];
  d1 = trip[1]; d2 = trip[2]; d3 = trip[3];
  print("[", k, "/", #triples_focus, "] triple = ", trip);

  \\ q_max scales with d_1: small d_1 → small q_max because each q dramatically scales p_lo
  ad1 = abs(d1);
  q_max = 0;
  if(ad1 < 100,            q_max = 4,
    if(ad1 < 10000,        q_max = 10,
                           q_max = 30));
  print("    q_max = ", q_max, "  p_extension = ", P_EXT);

  t0 = getwalltime();
  found_this = 0;
  for(q = 1, q_max,
    if(found_this, break);
    p_lo_val2 = 0; p_hi_val2 = -1;
    p_lo_val3 = 0; p_hi_val3 = -1;
    if(d1 > 0,
      if(d2 > 0, p_lo_val2 = sqrtint((C21 * q^2) \ d1) + 1; p_hi_val2 = -1,
                 p_hi_val2 = sqrtint((C21 * q^2) \ d1); p_lo_val2 = 0);
      if(d3 > 0, p_lo_val3 = sqrtint((C31 * q^2) \ d1) + 1; p_hi_val3 = -1,
                 p_hi_val3 = sqrtint((C31 * q^2) \ d1); p_lo_val3 = 0);
    );
    p_lo = max(p_lo_val2, p_lo_val3);
    if(p_hi_val2 == -1 && p_hi_val3 == -1,
      p_hi = p_lo * (1 + P_EXT) + 1000,
      if(p_hi_val2 == -1, p_hi = p_hi_val3,
        if(p_hi_val3 == -1, p_hi = p_hi_val2,
          p_hi = min(p_hi_val2, p_hi_val3)
        )
      )
    );
    if(p_hi > 2*10^9, p_hi = 2*10^9);
    if(p_lo > p_hi, next);
    print("      q=", q, "  p in [", p_lo, ", ", p_hi, "]  range ", p_hi - p_lo);

    for(p = p_lo, p_hi,
      if(found_this, break);
      if(gcd(p, q) != 1, next);
      val2 = d2 * (d1*p^2 - C21*q^2);
      if(val2 < 0, next);
      if(!issquare(val2), next);
      val3 = d3 * (d1*p^2 - C31*q^2);
      if(val3 < 0, next);
      if(!issquare(val3), next);
      Xnum = d1*p^2 + e1*q^2;
      Y2 = (Xnum - e1*q^2) * (Xnum - e2*q^2) * (Xnum - e3*q^2);
      if(!issquare(Y2), next);
      Yt = sqrtint(Y2);
      x_E = Xnum / (4*q^2);
      for(sgn = 0, 1,
        Yu = (-1)^sgn * Yt;
        Y_actual = Yu / q^3;
        y_E = (Y_actual - (Xnum/q^2)/2)/8;
        P = [x_E, y_E];
        if(ellisoncurve(E, P),
          ord = ellorder(E, P);
          print("      *** HIT *** (p,q)=(", p, ",", q, ")");
          print("         P_E = ", P);
          print("         ellorder = ", ord);
          if(ord == 0,
            ht = ellheight(E, P);
            print("         *** NON-TORSION GENERATOR *** canonical ht = ", ht);
            hits = hits + 1;
            found_this = 1;
          );
        );
      );
    );
  );
  t1 = getwalltime();
  if(found_this == 0, print("    no hit  wall = ", (t1-t0)/1000.0, "s"));
);
}

t_end = getwalltime();
print("=== Leg H complete ===  wall = ", (t_end - t_start)/1000.0, "s  hits = ", hits);
quit;
