\\ Sanity check Kodaira types at bad fibers of pi_d using PARI on specializations.
\\ At each bad q-value, we look at the elliptic curve as q varies over a small puncture.

default(parisize, 500000000);

\\ Use a "near q=0" specialization, say q = 1/k for large k.
\\ E: y^2 = x(x+1)(x+q^2)
\\ Plug q = epsilon = 1/N for large N: discriminant gets small near 0.
\\ We can directly compute the local data at the singular fiber.

\\ The local model of pi_d near q=0:
\\ Set t = q (uniformizer at q=0 in P^1).
\\ Generic fiber: y^2 = x(x+1)(x+t^2)
\\ This is a Weierstrass model over Q[[t]] with:
\\   a1=0, a2=t^2+1, a3=0, a4=t^2, a6=0.
\\ Discriminant Delta = -16 * (4 a2^3 a6 - a2^2 a4^2 + 4 a4^3 + 27 a6^2 - 18 a2 a4 a6)
\\   For a6=0: Delta = -16 * (-a2^2 a4^2 + 4 a4^3) = -16 a4^2 (4 a4 - a2^2)
\\   = -16 t^4 (4 t^2 - (t^2+1)^2) = -16 t^4 (4t^2 - t^4 - 2t^2 - 1)
\\   = -16 t^4 (-(t^4 - 2t^2 + 1)) = 16 t^4 (t^2 - 1)^2.

print("=== Verify Delta of E(q): y^2 = x(x+1)(x+q^2) ===");
\\ Symbolic check
qq = 'q;
poly = qq*(qq+1)*(qq+qq^2); \\ wrong - this is x*(x+1)*(x+q^2) in 'q'? No.
\\ Treat as polynomial in x with coefficients in Q[q]:
\\ x*(x+1)*(x+q^2) = x^3 + (1+q^2) x^2 + q^2 x.
\\ a1=0, a2=1+q^2, a3=0, a4=q^2, a6=0.

\\ Use ellinit over Q(q) by specializing at many q-values and inferring:
E1 = ellinit([0, 2, 0, 1, 0]); \\ at q=1: a2 = 2, a4 = 1
print("Specialize at q=1 -> [0,2,0,1,0]:");
print("  discriminant: ", E1.disc);
print("  j-invariant: ", E1.j);
print("  expected Delta = 16 * 1 * (1-1)^2 = 0 (bad)");

\\ Try at q = 2:
E2 = ellinit([0, 5, 0, 4, 0]);
print("Specialize at q=2 -> [0,5,0,4,0]:");
print("  discriminant: ", E2.disc);
print("  expected Delta = 16 * 16 * (4-1)^2 = 16*16*9 = 2304");

\\ Confirm:
print("Match? ", E2.disc == 2304);

\\ At q = 3:
E3 = ellinit([0, 10, 0, 9, 0]);
print("Specialize at q=3 -> [0,10,0,9,0]:");
print("  discriminant: ", E3.disc);
print("  expected Delta = 16 * 81 * (9-1)^2 = 16*81*64 = 82944");

\\ The discriminant formula matches.
\\ Now the Tate algorithm at each bad q:

print("");
print("=== Tate types via local analysis ===");
print("");
print("At q = 0: Delta = 16 q^4 (q^2-1)^2, so v_0(Delta) = 4.");
print("  c4 of Weierstrass form: c4 = 16*(a2^2 - 3*a4) = 16*((q^2+1)^2 - 3 q^2)");
print("                              = 16*(q^4 - q^2 + 1).");
print("  v_0(c4) = 0.");
print("  Since v(c4) = 0 < v(Delta), reduction is MULTIPLICATIVE.");
print("  Kodaira type I_n where n = v_0(Delta) = 4.");
print("  Number of components: 4.");
print("");
print("At q = 1: write q = 1 + s near s=0.");
print("  q^2 - 1 = (q-1)(q+1) = s * (2+s).");
print("  Delta = 16 (1+s)^4 * s^2 * (2+s)^2.");
print("  v_s(Delta) = 2.");
print("  c4 at q=1: 16*(1 - 1 + 1) = 16. v_s(c4) = 0.");
print("  Type I_2, components: 2.");
print("");
print("At q = -1: similar to q = 1, type I_2, components: 2.");
print("");
print("At q = infinity: substitute Q = 1/q.");
print("  Need to find minimal Weierstrass model at Q = 0.");
print("  Curve: y^2 = x(x+1)(x + 1/Q^2).");
print("  Rescale: x = X/Q^2, y = Y/Q^3.");
print("  (Y/Q^3)^2 = (X/Q^2) * (X/Q^2 + 1) * (X/Q^2 + 1/Q^2)");
print("    = (X/Q^2) * ((X+Q^2)/Q^2) * ((X+1)/Q^2)");
print("    = X (X+Q^2) (X+1) / Q^6");
print("  So Y^2 = X (X+1) (X+Q^2).");
print("  By symmetry with q=0 case: type I_4, components: 4.");
print("");
print("Sum (m_v - 1) over bad fibers:");
print("  (4-1) + (4-1) + (2-1) + (2-1) = 3 + 3 + 1 + 1 = 8.");
print("");

\\ Now verify with actual Tate algorithm on a specific specialization that
\\ exposes the local type. Use small primes to be safe.
print("=== Verification via ellap / elllocalred at specialized values ===");
\\ Take a curve where q is small and check the local conductor.
\\ Or do: for q being a parameter, use elliptic curves over Q[t] with t -> q.
\\ PARI doesn't directly support this, so we use indirect verification:
\\ pick a Pythagorean q far from the bad locus and verify the discriminant
\\ has the right factorization in q^2 - 1.

print("Curve at q=3/2: y^2 = x*(x+1)*(x+9/4)");
print("  Equivalent Weierstrass with cleared denominators: ");
\\ Multiply x -> 4x, y -> 8y:  64 y^2 = 4x (4x+1)(4x+9). Divide by 64:
\\   y^2 = (x/16)(4x+1)(4x+9)... not standard.
\\ Easier: just verify the disc:
E = ellinit([0, 1 + 9/4, 0, 9/4, 0]);
print("  disc(E) = ", E.disc);
print("  expected = 16 * (3/2)^4 * ((3/2)^2 - 1)^2 = 16 * 81/16 * (5/4)^2 = 81 * 25/16 = 2025/16");
print("  match? ", E.disc == 2025/16);

quit;
