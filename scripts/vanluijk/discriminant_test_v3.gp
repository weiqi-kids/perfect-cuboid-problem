\\ Corrected van Luijk discriminant test.
\\ At p=11, the CONSISTENT configuration (S_2 = 2 S_1^2 - 1) is (a,b,c,d,e) = (16, 4, 0, 0, 0).
\\ Trans pair has c = alpha + alpha_bar = -14 (NOT +8 as in the inconsistent (15,5,0,0,0) config).

square_class(x) = {
  if(x == 0, return(0));
  core(abs(x)) * sign(x);
}

{
  print("=== Corrected van Luijk discriminant test ===");
  print();

  \\ p=3
  my(p=3, c=2);   \\ trans pair sums to c=2
  my(disc3 = 4*p^2 - c^2);
  print("p=3:   alpha+alpha_bar = ", c, ", trans factor T^2 - ", c, " T + ", p^2);
  print("       (a,b) = (16, 4) algebraic eigenvalues (+3)^16, (-3)^4");
  print("       4p^2 - c^2 = ", disc3, "  square class of disc(NS): ", square_class(disc3));
  print();

  \\ p=11 (corrected)
  p=11; c=-14;
  my(disc11 = 4*p^2 - c^2);
  print("p=11:  alpha+alpha_bar = ", c, ", trans factor T^2 + ", -c, " T + ", p^2);
  print("       (a,b) = (16, 4) algebraic eigenvalues (+11)^16, (-11)^4  [SAME as p=3!]");
  print("       4p^2 - c^2 = ", disc11, "  square class of disc(NS): ", square_class(disc11));
  print();

  print("Ratio sq class disc(NS_{F_3}) / disc(NS_{F_11}) = ");
  print("  ", square_class(disc3), " / ", square_class(disc11), " = ", square_class(disc3 * disc11));
  print();

  if(square_class(disc3 * disc11) != 1,
    print("DIFFERENT square classes => rho_Qbar <= 18.");
  );
  if(square_class(disc3 * disc11) == 1,
    print("SAME square class => van Luijk test does NOT rule out rho_Qbar = 20.");
    print("(Need more primes or higher-order Newton sums.)");
  );
}
