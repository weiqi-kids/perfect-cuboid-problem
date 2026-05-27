\\ Task 2 (fast): Iterate generators on E_PCP(q), check Face 3 condition
\\ Critical question: is a_n = c_n^2 + 1 + q^2 a rational square?

default(parisize, 2000000000);

\\ Iterate over fiber - just check is_square and small-prime factorization
\\ For large numerators (> 10^60), skip full factorization; do trial division up to 10^5

trial_div(N, B) = {
  my(facs = [], n = abs(N), p = 2);
  while(p <= B && p*p <= n,
    if(n % p == 0,
      my(e = 0);
      while(n % p == 0, n = n/p; e = e+1);
      facs = concat(facs, [[p, e]]);
    );
    p = nextprime(p+1);
  );
  if(n > 1, facs = concat(facs, [[n, 1]]));
  facs;
};

iterate_fiber(q, P0_orig, Nmax) = {
  my(a2 = 1 + q^2, a4 = q^2, E);
  E = ellinit([0, a2, 0, a4, 0]);
  print("=== q = ", q, " ===");
  if(!ellisoncurve(E, P0_orig),
    print("ABORT: P0 not on E"); return();
  );
  print("P0 = ", P0_orig);
  print("h(P0) = ", ellheight(E, P0_orig));
  print();

  for(n = 1, Nmax,
    Pn = ellmul(E, P0_orig, n);
    if(Pn == [0],
      print("n=", n, ": Pn = O"); next;
    );
    Tn = Pn[1]; Yn = Pn[2];
    denom = q^2 - Tn^2;
    if(denom == 0,
      print("n=", n, ": pole (T=±q) — SINGULAR FIBER POINT"); next;
    );
    cn = 2 * Yn * q / denom;
    an = cn^2 + 1 + q^2;

    valnum = numerator(an);
    valden = denominator(an);
    is_sq_num = issquare(valnum);
    is_sq_den = issquare(valden);
    is_sq = is_sq_num && is_sq_den;

    print("n=", n, ": is_sq(a_n)=", is_sq, ", digits(num)=", #Str(valnum), ", digits(den)=", #Str(valden));

    if(is_sq,
      print("  !!! WARNING: a_n IS a rational square !!!");
      print("  a_n = ", an);
      print("  sqrt(num) = ", sqrt(valnum));
      print("  sqrt(den) = ", sqrt(valden));
      print("  c_n = ", cn);
      print("  T_n = ", Tn);
      print("  Y_n = ", Yn);
    );

    \\ Show factorization for small n only
    if(n <= 5 && #Str(valnum) <= 200,
      print("  factor(num) = ", factor(valnum));
    );
    if(n <= 5 && #Str(valnum) > 200,
      \\ trial division up to 1000
      print("  trial_div(num, 1000) = ", trial_div(valnum, 1000));
    );
  );
  print();
};

print("==========================================");
print("Task 2: Face 3 check on rank-jump fibers");
print("==========================================");

iterate_fiber(20/21, [4/21, 220/441], 20);
iterate_fiber(80/39, [32/9, 1312/117], 20);
iterate_fiber(24/7, [3/28, 465/392], 20);
iterate_fiber(84/13, [56700/36517, 329627340/25160213], 20);
iterate_fiber(48/55, [288/55, 42336/3025], 20);

print("===== End rank-1 fibers =====");
