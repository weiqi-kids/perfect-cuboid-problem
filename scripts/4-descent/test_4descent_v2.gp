\\ Test framework v2: search cover, LIFT to E(Q), check non-torsion.

default(parisize, 1500000000);
default(realprecision, 38);

\\ Search rational points on quartic y^2 = q(x), x = a/b with |a|/b in box,
\\ and LIFT each hit via the encoded map P = [X(x,y), Y(x,y)].
{
search_and_lift(E, cover_data, H) = my(q, P_map, a, b, val, ysq, y, denom, num, hits, X_E, Y_E, nontorsion);
  q = cover_data[1];
  P_map = cover_data[2];  \\ [X_func(x,y), Y_func(x,y)] as rational functions in x, y
  hits = List();
  nontorsion = List();
  for(b = 1, H,
    for(a = -H*b, H*b,
      if(gcd(a, b) != 1, next);
      val = subst(q, x, a/b);
      scaled = b^poldegree(q) * val;
      if(type(scaled) != "t_INT", next);
      if(scaled < 0, next);
      if(!issquare(scaled, &y_scaled), next);
      \\ Got (x, y) with y_scaled = y * b^2. The actual y on cover = y_scaled / b^2.
      \\ But the map P_map is in terms of x, y (not scaled).
      x_val = a/b;
      y_val = y_scaled / b^2;
      \\ Now compute X_E = subst(P_map[1], [x, y], [x_val, y_val]) — but it's rational functions
      \\ in x and y.
      \\ P_map[1] is a polynomial in x, y. We substitute.
      \\ Trick: PARI returns these as polynomials in x with coefficients involving 1/y^2 etc.
      \\ The formulae are typically Y_E = (poly)/y^2 and similar.
      \\ Let's evaluate:
      X_E_raw = subst(subst(P_map[1], 'x, x_val), 'y, y_val);
      Y_E_raw = subst(subst(P_map[2], 'x, x_val), 'y, y_val);
      if(type(X_E_raw) == "t_RFRAC" || type(X_E_raw) == "t_POL",
         \\ shouldn't happen if x, y substituted to numbers; might be polrational
         X_E_raw = X_E_raw + 0;
         Y_E_raw = Y_E_raw + 0;
      );
      pt = [X_E_raw, Y_E_raw];
      \\ verify on curve
      if(!ellisoncurve(E, pt),
        \\ try negation of y
        y_val_neg = -y_val;
        X_E_raw = subst(subst(P_map[1], 'x, x_val), 'y, y_val_neg);
        Y_E_raw = subst(subst(P_map[2], 'x, x_val), 'y, y_val_neg);
        pt = [X_E_raw, Y_E_raw];
        if(!ellisoncurve(E, pt),
          print("    [WARN] lift not on curve for x=", a, "/", b);
          next;
        );
      );
      \\ Get the order
      ord = ellorder(E, pt);
      listput(hits, [a, b, pt, ord]);
      if(ord == 0,
        listput(nontorsion, [a, b, pt]);
        print("    [NONTORSION] x=", a, "/", b, " lifts to ", pt);
      ,
        \\ print("    [torsion ord=", ord, "] x=", a, "/", b, " lifts to ", pt);
      );
    );
  );
  [hits, nontorsion];
}

{ test_curve(label, ainvs, expected_rank, H) = my(E, T, r, covers, k, q, result, total_nt);
  print();
  print("==================================================");
  print("=== ", label);
  print("==================================================");
  E = ellinit(ainvs);
  Emin = ellminimalmodel(E);
  T = elltors(Emin);
  print("Torsion: order=", T[1], " struct=", T[2]);
  r = ellrank(Emin, 4);
  print("ellrank = ", r);
  print("Expected rank: ", expected_rank);
  covers = ell2cover(Emin);
  print("Non-trivial cover count: ", #covers);
  total_nt = 0;
  if(#covers > 0,
    for(k = 1, #covers,
      print("  --- Cover #", k, " ---");
      q = covers[k][1];
      print("    q(x) = ", q);
      print("    searching |a|, b <= ", H);
      result = search_and_lift(Emin, covers[k], H);
      print("    rational pts on cover: ", #result[1]);
      print("    non-torsion lifts:     ", #result[2]);
      total_nt += #result[2];
    );
  );
  print("  TOTAL non-torsion across covers: ", total_nt);
  print("  Expected: at most ", expected_rank, " independent generators visible");
}

test_curve("Test 1: y^2 = x(x-1)(x-2), rk=0", [0,-3,0,2,0], 0, 30);
test_curve("Test 2: y^2 = x(x-1)(x+1), rk=0", [0,0,0,-1,0], 0, 30);
test_curve("Test 3: y^2 = x(x-4)(x+1)", [0,-3,0,-4,0], "?", 30);
test_curve("Test 4: y^2 = x(x-7)(x+7), rk=1", [0,0,0,-49,0], 1, 50);

quit;
