\\ Critical: figure out which of the 4 covers come from torsion (E(Q)_tors / 2 E(Q)_tors)
\\ vs which are genuine Sha[2].

default(parisize, 2000000000);
default(realprecision, 38);

E_Hm = ellinit([1, 0, 0, -4201713691887954766021162410, 103564307677747011646913552825626935447972]);
A2 = 4*E_Hm.a2 + E_Hm.a1^2;
A4 = 16*E_Hm.a4;
A6 = 64*E_Hm.a6;
E_short = ellinit([0, A2, 0, A4, A6]);

T = elltors(E_short);
print("Torsion structure: ", T[1], " ", T[2]);
print("Torsion generators: ", T[3]);

\\ For Z/8 x Z/2 torsion, E(Q)_tors = <G8> + <G2> where G8 has order 8, G2 has order 2.
\\ E(Q)_tors / 2 E(Q)_tors = <G8 mod 2 G8> + <G2 mod 0> = (Z/2)^2
\\ where representatives mod 2 are: 0, G8, G2, G8+G2 (4 classes).
\\ Now: E[2](Q) = {0, 4*G8, G2, 4*G8 + G2} = 2-torsion.
\\ So  E(Q)_tors / E[2](Q) = <G8 mod 4 G8> = Z/4? No wait:
\\
\\ E[2](Q) is the kernel of 2 on E(Q)_tors:
\\   2*P = 0 in Z/8 x Z/2 means P in {0, 4*G8, G2, 4*G8 + G2}, so #E[2] = 4 = 2^2.
\\
\\ E(Q)_tors / 2 E(Q)_tors: image of "multiply by 2" map on Z/8 x Z/2.
\\   2*(Z/8) = (Z/4)  (mod 8 image = even residues = 4-element set)
\\   wait: 2*(Z/8) means 2*Z/8 = {0,2,4,6} = Z/4 inside Z/8.
\\   So Z/8 / 2*(Z/8) = Z/8 / Z/4 = Z/2.
\\   Z/2 / 2*(Z/2) = Z/2 / 0 = Z/2.
\\   So E(Q)_tors / 2 E(Q)_tors = Z/2 x Z/2. dim_F2 = 2.
\\
\\ Now ell2cover returns a basis of S^2(E/Q) / E(Q)/2E(Q)? Or / E[2](Q)?
\\ The docs say "everywhere locally soluble 2-covers". The Selmer group naturally
\\ injects into S^2(E/Q) which is H^1(Q, E[2])_{everywhere locally soluble}.
\\ The image of E(Q)/2E(Q) -> S^2(E/Q) is the "trivial" part.
\\
\\ With our T = Z/8 x Z/2: E(Q)/2E(Q) injects into S^2 with image of dim 2.
\\ ell2cover returns 4 = dim_F2(S^2/?). If returns S^2 / image(E(Q)/2E(Q)),
\\ then dim S^2 = 4 + 2 = 6. Sha[2] = S^2/image E(Q), dim Sha[2] = 6 - rk - dim_F2(tors/2tors)
\\   = 6 - rk - 2.  For rk=0: dim Sha[2] = 4. For rk=2: dim Sha[2] = 2.
\\
\\ BUT: if any of the 4 covers actually lifts a 8-torsion point (not just 2-torsion),
\\ that cover represents the class of the 8-torsion in S^2/E[2], which is NOT in
\\ Sha (it's in the torsion image). So we'd be double-counting.
\\
\\ The fact that Cover #1 has x=0 lifting to an 8-torsion point means this cover
\\ is the IMAGE OF AN ORDER-8 TORSION POINT in S^2, not a Sha class!
\\
\\ ell2cover MUST then return basis of S^2 mod (the trivial class), or mod E[2](Q)
\\ image but NOT mod the entire E(Q)_tors image.

print();
print("=== Test: ell2cover on a torsion-only curve ===");
\\ Take a curve known to have rank 0 and Z/2 x Z/2 torsion only:
E_test = ellinit([0,0,0,-25,0]);  \\ y^2 = x^3 - 25 x = x(x-5)(x+5) — y^2 = x(x-5)(x+5)
print("E_test: y^2 = x^3 - 25x");
print("Torsion: ", elltors(E_test));
print("ellrank: ", ellrank(E_test, 4));
covs = ell2cover(E_test);
print("ell2cover count = ", #covs);
print("If torsion is Z/2 x Z/2 and rank = ?, then ell2cover returns rk + dim Sha[2] basis.");
print();

\\ Now test on a curve with Z/4 torsion to see:
\\ y^2 = x^3 + x^2 - 4x - 4 = (x-2)(x+1)(x+2) — wait, has full 2-tors.
\\ y^2 + y = x^3 - x^2 (curve "37a"): rank 0, torsion Z/3 (no 2-tors).
\\ Curve 30a3: torsion Z/6, rank 0
E_z6 = ellinit([1,0,1,-29,-115]);  \\ "162B1" or similar with Z/6
print("=== E_z6 = ellinit([1,0,1,-29,-115]) ===");
print("Torsion: ", elltors(E_z6));
print("ellrank: ", ellrank(E_z6, 3));
covs6 = ell2cover(E_z6);
print("ell2cover count = ", #covs6);

\\ Curve 15a1 has Z/8 torsion
print();
E_z8 = ellinit([1,1,1,-10,-10]);
print("=== ellinit([1,1,1,-10,-10]) — possibly Z/8 tors ===");
print("Torsion: ", elltors(E_z8));
print("ellrank: ", ellrank(E_z8, 3));
covs8 = ell2cover(E_z8);
print("ell2cover count = ", #covs8);

quit;
