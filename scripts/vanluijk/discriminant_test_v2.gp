\\ Refined van Luijk discriminant test using also p=17 data.
\\ At p=17, max rho_{F_17} = 20 with one trans pair, alg = +-17 + one (17 omega, 17 omega^bar) for omega = primitive 6th root of unity (d=1 case in our enumeration).
\\ This makes p=17 a useful third reference.

\\ For a K3 with one transcendental pair (alpha, alpha_bar), alpha = (c + i sqrt(4p^2 - c^2))/2 * ... wait,
\\ let alpha + alpha_bar = c, alpha * alpha_bar = p^2.  Trans factor: T^2 - cT + p^2.
\\ Discriminant of T^2 - cT + p^2 in T = c^2 - 4p^2 (negative since |alpha|^2 = p^2 > (c/2)^2 in trans case).
\\
\\ The square class of disc(NS_{F_p}) (mod (Q*)^2) is given by:
\\   sq_class(disc(NS_{F_p})) = sq_class( 4*p^2 - c^2 )   (Artin-Tate)
\\
\\ Provided alg part has disc that is a SQUARE in Q* (which happens when alg eigenvalues are all +-p
\\ with even count of -p's, ie b even; in our case at p=3, b=4 even; at p=11, b=5 odd; at p=17, b=0 even).

square_class(x) = {
  if(x == 0, return(0));
  core(abs(x)) * sign(x);
}

\\ p=3:  trans pair alpha+alpha_bar = c.  From t_1 = 38 = 3(a-b) + c with a-b=12, c=2.
\\ p=11: t_1 = 118 = 11(a-b) + c with a-b=10, c=8.
\\ p=17: t_1 = 342 = 17(a-b) + c with a-b=18, c=36.  But |c| <= 2p = 34, so c=36 is impossible.
\\        => need to reconsider p=17 trans structure.

{
  print("=== Verifying trans pair coefficients ===");
  print();

  \\ p=3
  my(p=3, t1=38, abdiff=12);
  my(c = t1 - p*abdiff);
  print("p=3:  c = t_1 - p(a-b) = ", t1, " - ", p, "*", abdiff, " = ", c, "  (|c| <= 2p = ", 2*p, ")");
  my(disc3 = 4*p^2 - c^2);
  print("       4p^2 - c^2 = ", disc3, "  square class: ", square_class(disc3));

  \\ p=11
  p=11; t1=118; abdiff=10;
  c = t1 - p*abdiff;
  print("p=11: c = ", t1, " - ", p, "*", abdiff, " = ", c, "  (|c| <= 2p = ", 2*p, ")");
  my(disc11 = 4*p^2 - c^2);
  print("       4p^2 - c^2 = ", disc11, "  square class: ", square_class(disc11));

  \\ p=17: in our enumeration we had (a, b, c=0, d=1, e=0, M=1)
  \\ That means alg eigenvalues: 18*(+17), 0*(-17), pair (17*omega, 17*omega_bar) for omega = primitive 6th root of unity
  \\ (since d=1 corresponds to the "n=6" cyclotomic case in our notation)
  \\ Plus 1 trans pair (17 e^{i theta}, 17 e^{-i theta}) with cos theta = S_1 = 19/34.
  \\ Trans pair sum to t_1^trans = 2*17*(19/34) = 19.
  \\ Algebraic contribution to t_1: 17*18 + 0 + 17*(omega+omega_bar) = 306 + 17 = 323.
  \\   (omega + omega_bar = 2 cos(60deg) = 1 for primitive 6th root)
  \\ Total: 323 + 19 = 342. ✓
  print();
  print("p=17: structure has 18 *(+17), pair (17 omega, 17 omega_bar) [omega = e^{i pi/3}],");
  print("      and 1 trans pair (17 e^{i theta}, 17 e^{-i theta}), cos(theta) = 19/34.");
  print("      Trans pair c = 2*17*(19/34) = 19.");
  p = 17;
  c = 19;
  my(disc17 = 4*p^2 - c^2);
  print("       4p^2 - c^2 = ", disc17, "  square class: ", square_class(disc17));
  print();
  print("  HOWEVER: at p=17 there are MORE algebraic classes (the omega pair),");
  print("  so disc(NS_{F_17}) gets an extra factor from this pair.");
  print("  The omega pair (17 omega, 17 omega_bar), omega = primitive 6th root, contributes");
  print("    factor (T^2 - 17 T + 17^2) to cyclotomic part, disc = 17^2 - 4*17^2 = -3*17^2.");
  print("  square class of this factor's contribution: square_class(-3*17^2) = ", square_class(-3*17^2));
  print("  Combined trans+alg(non-real) disc square class: ", square_class(disc17 * (-3*17^2)));
  print();

  print("=== Final square classes of disc(NS_{F_p}) ===");
  print("  p=3:  ", square_class(disc3));
  print("  p=11: ", square_class(disc11));
  print("  p=17: ", square_class(disc17 * (-3*17^2)));
  print();
  print("Ratio (p=3)/(p=11) square class: ", square_class(disc3 * disc11));
  print("  -> = 1 means same square class, != 1 means different (rho_Qbar < 20).");
  print();
  print("Ratio (p=3)/(p=17) square class: ", square_class(disc3 * disc17 * (-3*17^2)));
}
