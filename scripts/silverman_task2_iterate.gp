\\ Task 2: Iterate generators on E_PCP(q), compute c_n and a_n = c_n^2 + 1 + q^2
\\ Check (a) is a_n a rational square? (b) factor numerator
\\
\\ Map: phi(T,Y) = c = 2 Y q / (q^2 - T^2)
\\ Face 3 condition: c^2 + 1 + q^2 must be a rational square.

default(parisize, 2000000000);

\\ Helper: convert minimal model point to original-curve point
\\ Actually, for c_n computation we use the ORIGINAL E: Y^2 = X(X+1)(X+q^2)
\\ with coords (T,Y). We map Heegner P from Emin back via ellchangepointinv.

iterate_fiber(q, P0_orig, Nmax) = {
  my(a2 = 1 + q^2, a4 = q^2, E, results);
  E = ellinit([0, a2, 0, a4, 0]);
  print("q = ", q);
  print("  P0 on original E? ", ellisoncurve(E, P0_orig));
  if(!ellisoncurve(E, P0_orig),
    print("  ABORT: P0 not on E");
    return();
  );
  print("  height P0: ", ellheight(E, P0_orig));
  print();

  results = [];
  for(n = 1, Nmax,
    Pn = ellmul(E, P0_orig, n);
    if(Pn == [0],
      print("  n=", n, ": Pn = O (infinity)");
      next;
    );
    Tn = Pn[1]; Yn = Pn[2];
    denom = q^2 - Tn^2;
    if(denom == 0,
      print("  n=", n, ": pole (T=±q)");
      next;
    );
    cn = 2 * Yn * q / denom;
    an = cn^2 + 1 + q^2;

    \\ Is an a rational square?
    valnum = numerator(an);
    valden = denominator(an);
    is_sq_num = issquare(valnum);
    is_sq_den = issquare(valden);
    is_sq = is_sq_num && is_sq_den;

    print("  n=", n, ":");
    print("    Tn = ", Tn);
    print("    Yn = ", Yn);
    print("    cn = ", cn);
    print("    an = ", an);
    print("    is_square: ", is_sq);
    if(is_sq,
      print("    !!! WARNING: a_n IS a rational square — INVESTIGATE !!!");
    );
    \\ factor numerator
    if(valnum != 0 && abs(valnum) < 10^200,
      print("    factor(num): ", factor(valnum));
    ,
      print("    num too large to factor quickly");
    );
  );
  print();
};

\\ === All rank-jump fibers ===

print("===== Task 2: Iteration check =====");
print();

print("[1/6] q = 20/21");
iterate_fiber(20/21, [4/21, 220/441], 20);

print("[2/6] q = 80/39");
iterate_fiber(80/39, [32/9, 1312/117], 20);

print("[3/6] q = 24/7");
iterate_fiber(24/7, [3/28, 465/392], 20);

print("[4/6] q = 84/13");
iterate_fiber(84/13, [56700/36517, 329627340/25160213], 20);

print("[5/6] q = 48/55");
iterate_fiber(48/55, [288/55, 42336/3025], 20);

print("===== End Task 2 (rank 1 fibers) =====");
