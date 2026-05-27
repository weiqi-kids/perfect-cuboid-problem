\\ ============================================================
\\ Van Luijk discriminant test for ρ_{Qbar} = 20 vs 18.
\\
\\ At p=3: trans pair (α, ᾱ) with α = 1 + 2i√2, |α|^2 = 9. Trans factor:
\\   T(T) = (1 - α T)(1 - ᾱ T) = 1 - 2T + 9T^2.
\\
\\ At p=11: α = 4 + i√105, |α|^2 = 121. Trans factor:
\\   T(T) = 1 - 8T + 121T^2.
\\
\\ By Artin-Tate formula for K3 over F_p:
\\   |disc(NS(X_{F_p}))| · |Br(X_{F_p})|  =  lim_{T -> 1/p}  L_p(T) · (1 - pT)^{-rho} / p^{(b_2 - rho)/2}
\\ Up to known cyclotomic factors and Brauer order, the SQUARE CLASS of disc(NS)
\\ is the same as the square class of the discriminant of the transcendental
\\ lattice, which equals discriminant of T(T) up to sign and p-power.
\\
\\ Specifically: disc(T(T)) for T(T) = 1 + a T + p^2 T^2  (after normalization,
\\ a = -2 Re(α)):
\\   disc(quadratic poly p^2 T^2 + a T + 1) = a^2 - 4 p^2
\\
\\ Square class of disc(NS_{F_p})  ~  -(a^2 - 4 p^2)  modulo squares
\\ (the sign flips because NS has signature (1, rho-1) so disc is negative).
\\
\\ For p=3:  disc_trans = 4 - 36 = -32 → square class -2.
\\ For p=11: disc_trans = 64 - 484 = -420 → square class -105.
\\
\\ -2 / -105 = 2/105 = 2 / (3*5*7).  v_3(2/105) = -1, ODD → not a square.
\\
\\ Therefore disc(NS_{F_3}) and disc(NS_{F_11}) lie in DIFFERENT square classes.
\\
\\ If ρ_{Qbar} = 20 = ρ_{F_p} for both p, the specialization map
\\ NS(X_{Qbar}) → NS(X_{F_p}) ⊗ Q must be an isomorphism, so
\\ disc(NS_{Qbar}) / disc(NS_{F_p}) must be a SQUARE (image is sublattice of
\\ same rank, index = sqrt(disc ratio)).
\\
\\ Since disc(NS_{F_3}) and disc(NS_{F_11}) differ mod squares, we cannot have
\\ both equal to disc(NS_{Qbar}) mod squares. Therefore ρ_{Qbar} < 20.
\\
\\ ρ_{Qbar} ≤ 18.
\\ ============================================================

{
  print("\n=== Van Luijk discriminant test ===");
  print();
  print("At p = 3:");
  print("  Frobenius data (t_1, t_2, t_3) = (38, 166, 278)");
  print("  Algebraic eigenvalues: 16 of +3, 4 of -3 (rho = 20)");
  print("  Transcendental pair: α = 1 + 2i√2, |α|² = 9");
  print("  Trans char poly: f_3(T) = 1 - 2T + 9T²");
  my(d3 = 4 - 36);  \\ discriminant of 9T^2 - 2T + 1 in T-variable
  print("  disc(f_3) = ", d3, "  (= -2^5)");
  my(sq3 = core(d3));
  print("  Square class: ", sq3);
  print();
  print("At p = 11:");
  print("  Frobenius data (t_1, t_2) = (118, 2374)");
  print("  Algebraic eigenvalues: 15 of +11, 5 of -11 (rho = 20)");
  print("  Transcendental pair: α = 4 + i√105, |α|² = 121");
  print("  Trans char poly: f_11(T) = 1 - 8T + 121T²");
  my(d11 = 64 - 484);
  print("  disc(f_11) = ", d11, "  (= -2²·3·5·7)");
  my(sq11 = core(d11));
  print("  Square class: ", sq11);
  print();
  print("Square class ratio: ", sq3, " / ", sq11, " = ", sq3/sq11, "  (square? ", issquare(Mod(sq3*sq11, 1)), ")");
  print();
  if(core(sq3 * sq11) != 1,
    print("DIFFERENT square classes!");
    print("If rho_{Qbar} = 20, then disc(NS_{Qbar}) would have to lie in both");
    print("square classes (image in both NS_{F_p}), which is impossible.");
    print("Therefore rho_{Qbar} <= 18.");
    print();
    print("Combined with rho_{Qbar} >= 16 from explicit classes:");
    print("  rho_{Qbar}(V'_min) ∈ {16, 18}.");
  );
}
