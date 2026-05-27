\\ Leg B: qfsolve + conic parametrization on each non-trivial Selmer triple.

default(parisize, 400000000);
default(parisizemax, 800000000);
default(realprecision, 38);

A4 = -4296889542830417930548255320;
A6 = 69513195990628448299367172717433334517312;
E = ellinit([1, 0, 0, A4, A6]);

e1 = -289985899459969;
e2 =  69618111281856;
e3 =  220367788178112;

{triples = [[1,1,1],[1,219,219],[97,-3,-291],[97,-73,-7081],[8257,-49542,-6],[8257,-1205522,-146],[800929,16514,194],[800929,3616566,42486],[5905,5905,1],[5905,1293195,219],[572785,-17715,-291],[572785,-431065,-7081],[48757585,-292545510,-6],[48757585,-7118607410,-146],[4729485745,97515170,194],[4729485745,21355822230,42486],[1249,7494,6],[1249,182354,146],[121153,-2498,-194],[121153,-547062,-42486],[10312993,-10312993,-1],[10312993,-2258545467,-219],[1000360321,30938979,291],[1000360321,752848489,7081],[7375345,44252070,6],[7375345,1076800370,146],[715408465,-14750690,-194],[715408465,-3230401110,-42486],[60898223665,-60898223665,-1],[60898223665,-13336710982635,-219],[5907127695505,182694670995,291],[5907127695505,4445570327545,7081]];}

C21 = e2 - e1;
C31 = e3 - e1;
C32 = e3 - e2;
print("C21 = ", C21, "  C31 = ", C31, "  C32 = ", C32);
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

  \\ Conic: d1*z1^2 - d2*z2^2 - C21*w^2 = 0
  M = matdiagonal([d1, -d2, -C21]);
  sol = 0;
  iferr(sol = qfsolve(M), err, print("    qfsolve error: ", err); next);

  if(type(sol) == "t_INT",
    print("    qfsolve says locally insoluble at p = ", sol);
    next
  );

  if(type(sol) == "t_MAT", sol = sol[,1]);

  z1_0 = sol[1]; z2_0 = sol[2]; w_0 = sol[3];
  v_check = d1 * z1_0^2 - d2 * z2_0^2 - C21 * w_0^2;
  if(v_check != 0,
    print("    qfsolve verify failed: ", v_check);
    next
  );
  print("    qfsolve point: (z1,z2,w) = (", z1_0, ", ", z2_0, ", ", w_0, ")  maxht = ", max(max(abs(z1_0), abs(z2_0)), abs(w_0)));

  \\ Parametrize: substitute (z1_0 + s*p, z2_0 + s*q, w_0 + s*r) into conic.
  \\   A*s^2 + 2*B*s = 0 with A = d1*p^2 - d2*q^2 - C21*r^2,
  \\                          B = d1*z1_0*p - d2*z2_0*q - C21*w_0*r
  \\ Non-base s = -2B/A => (z1, z2, w) = (z1_0*A - 2Bp, z2_0*A - 2Bq, w_0*A - 2Br) (up to scalar A).
  \\ Then X = d1*z1^2 + e1*w^2 (over w^2 normalization), and need d3*((X-e3)/w^2) = square.

  N = 80;
  found_this = 0;
  for(p = -N, N,
    if(found_this, break);
    for(q = -N, N,
      if(found_this, break);
      for(r = 0, 3,
        if(found_this, break);
        if(p == 0 && q == 0 && r == 0, next);
        A_c = d1*p^2 - d2*q^2 - C21*r^2;
        if(A_c == 0, next);
        B_c = d1*z1_0*p - d2*z2_0*q - C21*w_0*r;
        z1_n = z1_0 * A_c - 2*B_c*p;
        z2_n = z2_0 * A_c - 2*B_c*q;
        w_n  = w_0  * A_c - 2*B_c*r;
        if(w_n == 0, next);
        \\ d3 * (d1*z1_n^2 - C31*w_n^2) should be a rational square (since w_n^2 is sq).
        val3 = d3 * (d1*z1_n^2 - C31*w_n^2);
        if(val3 < 0, next);
        if(!issquare(val3), next);
        val2 = d2 * (d1*z1_n^2 - C21*w_n^2);
        if(val2 < 0, next);
        if(!issquare(val2), next);
        Xt_num = d1*z1_n^2 + e1*w_n^2;
        Xt_den = w_n^2;
        Xtilde = Xt_num / Xt_den;
        Y2 = (Xtilde - e1) * (Xtilde - e2) * (Xtilde - e3);
        if(!issquare(Y2), print("    not square Y^2 — internal bug?"); next);
        Ytilde = sqrt(Y2);
        x_E = Xtilde / 4;
        for(sgn = 0, 1,
          Yu = (-1)^sgn * Ytilde;
          y_E = (Yu - Xtilde/2) / 8;
          P = [x_E, y_E];
          if(ellisoncurve(E, P),
            ord = ellorder(E, P);
            print("    *** HIT *** (p,q,r) = (", p, ",", q, ",", r, ")");
            print("       X = ", Xtilde);
            print("       Y = ", Yu);
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
  );
  t1 = getwalltime();
  if(found_this == 0, print("    no hit  wall = ", (t1-t0)/1000.0, "s"));
  print();
);
}

t_end = getwalltime();
print("=== Leg B complete ===");
print("Total wall: ", (t_end - t_start)/1000.0, "s");
print("Total hits: ", hits);

quit;
