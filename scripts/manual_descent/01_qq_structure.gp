\\ 01_qq_structure.gp — Setup function field Q(q) structure for E_PCP descent
\\ Goal: enumerate the support set S of places of Q(q) where d_i can be non-trivial,
\\ and compute the local descent images at each.

default(parisize, 1000000000);

\\ E_PCP(q): Y^2 = X(X+1)(X+q^2) over Q(q)
\\ e_1 = 0, e_2 = -1, e_3 = -q^2
\\ Differences:
\\   e_1 - e_2 = 1        (square)
\\   e_1 - e_3 = q^2      (square)
\\   e_2 - e_3 = q^2 - 1 = (q-1)(q+1)    (NOT square in Q(q), key non-square direction)
\\   (signs swapped from above using e_i = {0, -1, -q^2} and which is "larger")

\\ For 2-descent over Q(q), the support set S consists of places where the discriminant
\\ Disc(E) = 16 * (e_2-e_1)^2 * (e_3-e_1)^2 * (e_3-e_2)^2
\\         = 16 * 1 * q^4 * (q-1)^2 (q+1)^2
\\ has odd valuation, plus places of bad reduction. In our case:
\\   Bad places = { (q), (q-1), (q+1), (infty) } at "infinite" (geometric) places
\\   Plus rational places: { 2, infty_Q } from the coefficient 16 and signs.
\\
\\ So S = { (q), (q-1), (q+1), (1/q at infty), 2, R_infty }
\\
\\ The image of E[2] under delta = (x-e_1, x-e_2) in (Q(q)*/sq)^2:
\\   P_1 = (0, 0):    d_1 = 0... use the alternative formula:
\\                    Image is ((e_1-e_2)(e_1-e_3), 0_avoid)
\\                    = ((0-(-1))(0-(-q^2)), -)
\\                    = (q^2, -)  -- but the second slot needs a non-zero value
\\
\\ Standard 2-torsion image (using the convention that (e_i, 0) maps to its non-zero
\\ x-coordinate differences):
\\   image(P_1=(0,0))    = ((e_1-e_2)(e_1-e_3), e_1-e_2, e_1-e_3) = (q^2, 1, q^2)
\\                                                                 ~ (1, 1, 1) mod squares!
\\   image(P_2=(-1,0))   = (e_2-e_1, (e_2-e_1)(e_2-e_3), e_2-e_3) = (-1, -1*(1-q^2), 1-q^2)
\\                                                                 = (-1, q^2-1, 1-q^2)
\\                                                                 ~ (-1, q^2-1, -(q^2-1))
\\                                                                 = (-1, q^2-1, -(q^2-1))
\\   image(P_3=(-q^2,0)) = (e_3-e_1, e_3-e_2, (e_3-e_1)(e_3-e_2))
\\                       = (-q^2, -q^2+1, -q^2*(-q^2+1))
\\                       = (-q^2, 1-q^2, q^2(q^2-1))
\\                       ~ (-1, -(q^2-1), q^2-1)
\\
\\ Verify the product is a square:
\\ For P_2: (-1) * (q^2-1) * (-(q^2-1)) = (q^2-1)^2 ✓
\\ For P_3: (-1) * (-(q^2-1)) * (q^2-1) = (q^2-1)^2 ✓
\\ For P_1: (1)(1)(1) = 1 ✓
\\
\\ So 2-torsion image as subgroup of K*/K*^2 x K*/K*^2 (first two coords, third is product):
\\   T_1 = (1, 1)
\\   T_2 = (-1, q^2-1)
\\   T_3 = (-1, -(q^2-1)) = (-1, 1-q^2)
\\   T_1 + T_2 + T_3 = O (the trivial point)
\\
\\ Equivalently, the image is the F_2-span of T_2, T_3 in (K*/K*^2)^2, which is 2-dim.

\\ Let me verify these images symbolically.
print("=== Verification of 2-torsion images ===");
P1 = [0, 1];  \\ (d_1, d_2) = (1, 1) after normalization (we use d_1 = (e_1-e_2)(e_1-e_3) = q^2 ~ 1)
              \\ d_2 for P_1: (e_1-e_2) = 1
print("P1: (e1-e2)(e1-e3) = ", (0-(-1))*(0-(-'q^2)));
print("    e1-e2 = ", 0-(-1));
print("    e1-e3 = ", 0-(-'q^2));

print("P2: e2-e1 = ", -1 - 0);
print("    (e2-e1)(e2-e3) = ", (-1 - 0)*(-1 - (-'q^2)));
print("    e2-e3 = ", -1 - (-'q^2));

print("P3: e3-e1 = ", -'q^2 - 0);
print("    e3-e2 = ", -'q^2 - (-1));
print("    (e3-e1)(e3-e2) = ", (-'q^2 - 0)*(-'q^2 - (-1)));

\\ Now check: in Q(q)*/Q(q)*^2 mod squares, what's the structure?
\\ q^2 is always a square. So {q^2, 1, q^2} ~ {1, 1, 1}.
\\ -1 is a square in Q only if we extend to Q(i); over Q(q), it's not a square.
\\ q^2 - 1 = (q-1)(q+1) — square in Q(q) iff both (q-1) and (q+1) are squares, no.

\\ So the square classes of our 2-torsion images:
\\   T_1 = (1, 1)
\\   T_2 = (-1, q^2-1) = (-1, (q-1)(q+1))
\\   T_3 = (-1, 1-q^2) = (-1, -(q-1)(q+1))
\\
\\ These generate an F_2-subspace of rank 2 (since T_1=O, T_2, T_3 independent).

\\ The descent image of E(Q(q))/2E(Q(q)) lies in:
\\   { (d_1, d_2) in (K*/K*^2)^2 : d_1*d_2 = -q^2 mod squares, i.e. d_1*d_2 ~ -1 }
\\ This subgroup has F_2-codim 1 in (K*/K*^2)^2, but with the local-support constraint
\\ it becomes much smaller.

print();
print("=== Support set S of bad places ===");
print("Geometric (places of Q[q]):");
print("  (q)     -- q=0  (Kodaira I_4)");
print("  (q-1)   -- q=1  (Kodaira I_2)");
print("  (q+1)   -- q=-1 (Kodaira I_2)");
print("  infty   -- q=infty (Kodaira I_4)");
print("Arithmetic (places of Q over which Q(q) sits):");
print("  prime 2   (from discriminant constant 16)");
print("  archimedean R");
print();
print("Square classes supported on S of Q(q)*/Q(q)*^2:");
print("  Generators: -1, 2, q, q-1, q+1");
print("  (No 'infty' generator needed: it's controlled by total degree being even.)");
print("  Dimension as F_2 vector space: 5");
print("  Ambient (d_1, d_2) space: dim = 10");
print("  After product constraint d_1*d_2 = -1: dim = 9");

print();
print("=== Key strategic observation ===");
print("Over Q(q), the local conditions at the FOUR geometric places (q), (q-1), (q+1), inf");
print("can be computed by direct substitution and local Hilbert symbols on Laurent series.");
print("Over Q (i.e. at place 2 and infty), we use standard Hilbert symbols.");
