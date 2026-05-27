\\ Leg G: Smart starting point for small-d_1 Selmer triples.
\\ For each triple, compute p_min = ceil(sqrt(C31 * q^2 / d_1)) when positive,
\\ then scan p in [p_min, p_min * factor] for each q in [1, Q_MAX].

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

\\ For each triple, compute "natural" lower bound on |p| for q=1 such that all 3 vals ≥ 0.
\\ For (X̃ ≥ e_3) regime: p² > C31·q²/d_1 if d_1 > 0; this is one regime.
\\ Other regimes: e.g. X̃ < e_1 (so X̃-e_i < 0 for all i, but d_i flips sign).
\\ Combined: the cover has REAL points in specific X-intervals, and corresponding (p, q) lie in specific ranges.

\\ For simplicity, just try p in [p_min, P_MAX] for q in [1, Q_MAX].
P_MAX_MULT = 30;  \\ extends p_min by factor of 30
Q_MAX = 50;

print("Leg G: smart p_min start, q up to ", Q_MAX, ", p up to p_min * ", P_MAX_MULT);
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
  for(q = 1, Q_MAX,
    if(found_this, break);
    \\ Compute p_min from val3 constraint: d3*(d1 p² - C31 q²) ≥ 0
    \\ If d3 > 0: need d1 p² ≥ C31 q² → p² ≥ C31 q² / d1 (assuming d1 > 0)
    \\ If d3 < 0: need d1 p² ≤ C31 q² → p² ≤ C31 q² / d1
    \\ Similarly for val2.
    \\ Strategy: compute four regions, scan each.

    p_min_val3 = 0; p_max_val3 = 0;
    if(d1 > 0 && d3 > 0,  \\ p² ≥ C31 q² / d1
      base = (C31 * q^2) / d1;
      if(base > 0, p_min_val3 = sqrtint(base) + 1; p_max_val3 = -1,  \\ no upper limit
        p_min_val3 = 0; p_max_val3 = -1
      ),
      if(d1 > 0 && d3 < 0,  \\ p² ≤ C31 q² / d1 (and assume C31 > 0)
        base = (C31 * q^2) / d1;
        p_min_val3 = 0; p_max_val3 = sqrtint(base),
        \\ Other cases: just give up bounding
        p_min_val3 = 0; p_max_val3 = 10^9
      )
    );

    p_min_val2 = 0; p_max_val2 = 0;
    if(d1 > 0 && d2 > 0,
      base = (C21 * q^2) / d1;
      if(base > 0, p_min_val2 = sqrtint(base) + 1; p_max_val2 = -1,
        p_min_val2 = 0; p_max_val2 = -1
      ),
      if(d1 > 0 && d2 < 0,
        base = (C21 * q^2) / d1;
        p_min_val2 = 0; p_max_val2 = sqrtint(base),
        p_min_val2 = 0; p_max_val2 = 10^9
      )
    );

    \\ Intersect ranges: p must satisfy both val2 ≥ 0 and val3 ≥ 0
    p_lo = max(p_min_val2, p_min_val3);
    \\ Effective upper: if any p_max is -1, no upper from that; else min of all positives.
    if(p_max_val2 == -1 && p_max_val3 == -1,
      p_hi = p_lo * P_MAX_MULT + 1000,
      if(p_max_val2 == -1, p_hi = p_max_val3,
        if(p_max_val3 == -1, p_hi = p_max_val2,
          p_hi = min(p_max_val2, p_max_val3)
        )
      )
    );
    \\ Cap at reasonable
    if(p_hi > 10^9, p_hi = 10^9);
    if(p_lo == 0 && p_hi == 0, next);
    if(p_lo > p_hi, next);

    \\ Now scan p in [p_lo, p_hi]
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
          print("    *** HIT *** (p,q)=(", p, ",", q, ")  X̃num=", Xnum);
          print("       P_E = ", P);
          print("       ellorder = ", ord);
          if(ord == 0,
            ht = ellheight(E, P);
            print("       *** NON-TORSION GENERATOR *** canonical ht = ", ht);
            print("       triple_index = ", k);
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
print("=== Leg G complete ===  wall = ", (t_end - t_start)/1000.0, "s  hits = ", hits);
quit;
