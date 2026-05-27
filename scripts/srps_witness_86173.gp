\\ Deep structural analysis of the witness g=86173

nf = nfinit(x^2 + 1);
i_pol = Mod(x, x^2 + 1);

g = 86173;
a = 30940; e_a = 80427;  \\ alpha = a + e_a*i, norm = g^2, factors over g's primes
b = 79920; f_b = 32227;  \\ beta = b + f_b*i, norm = g^2

\\ For PCP, we want (a, b) in legs(g) such that ALSO sqrt(a^2+b^2) in legs(g).
\\ legs(g) means: there exists e_a (resp f_b) with a^2 + e_a^2 = g^2.

\\ Consider the product alpha * beta:
alpha = a + e_a * i_pol;
beta  = b + f_b * i_pol;
\\
\\ alpha * beta has norm g^4.
\\ Its real and imaginary parts are determined by a, b, e_a, f_b.

ab = alpha * beta;
re = polcoeff(lift(ab), 0);
im = polcoeff(lift(ab), 1);
print("alpha * beta = (a*b - e_a*f_b) + (a*f_b + b*e_a)*i");
print("            = ", re, " + ", im, " * i");
print("Re = a*b - e_a*f_b = ", a*b - e_a*f_b);
print("Im = a*f_b + b*e_a = ", a*f_b + b*e_a);
print("Norm = ", norm(ab), " = g^4 = ", g^4);
print();

\\ Consider alpha * conj(beta)
abc = alpha * conj(beta);
re2 = polcoeff(lift(abc), 0);
im2 = polcoeff(lift(abc), 1);
print("alpha * conj(beta) = (a*b + e_a*f_b) + (b*e_a - a*f_b)*i");
print("                  = ", re2, " + ", im2, " * i");
print("Re = a*b + e_a*f_b = ", a*b + e_a*f_b);
print("Im = b*e_a - a*f_b = ", b*e_a - a*f_b);
print();

\\ Note: Re^2 + Im^2 = (alpha*conj(beta))(conj(alpha)*beta) = |alpha|^2 |beta|^2 = g^4

\\ KEY IDEA: For a^2 + b^2 = d^2 with a, b real:
\\ (a+bi)(a-bi) = a^2 + b^2 = d^2
\\
\\ If we want to express (a+bi) in terms of alpha, beta...
\\ (a+bi) has norm d^2.
\\
\\ Try (alpha - conj(beta) * I)?
\\ alpha = a + e_a*i, conj(beta) = b - f_b*i
\\ conj(beta) * (-i) = -i*(b - f_b*i) = -f_b - b*i
\\ alpha + i*conj(beta) = (a + e_a*i) + i*(b - f_b*i) = (a + f_b) + (e_a + b)*i
\\ That's not it either.

\\ Try (a + b*i) directly as a function of alpha, beta:
\\ alpha = a + e_a*i, so a = Re(alpha), e_a = Im(alpha)
\\ beta = b + f_b*i, so b = Re(beta), f_b = Im(beta)
\\ a + b*i = Re(alpha) + Re(beta)*i

\\ Re(alpha) = (alpha + conj(alpha))/2
\\ Re(beta) = (beta + conj(beta))/2
\\ a + b*i = (alpha + conj(alpha))/2 + (beta + conj(beta))/2 * i

print("So (a + b*i) is NOT a multiplicative combination of alpha and beta.");
print("It's an ADDITIVE combination of their real parts.");
print();

\\ This is the KEY. In Z[i], (a + b*i) is unrelated to (a + e_a*i)*(b + f_b*i)
\\ in any multiplicative sense, because we're taking REAL PARTS of two different Gaussian integers.

\\ The obstruction theorem we want:
\\ THEOREM (target): For g with >= 3 distinct primes == 1 mod 4, the set
\\   legs(g) = { Re(zeta) : zeta in Z[i], N(zeta) = g^2 } u { Im(zeta) : ... }
\\ is not closed under (a, b) -> sqrt(a^2 + b^2).
\\
\\ Equivalently: there does NOT exist (alpha, beta) in Z[i]^2 each of norm g^2
\\ such that (Re(alpha))^2 + (Re(beta))^2 is a perfect square AND its sqrt is in legs(g).

\\ This is a Diophantine condition. The empirical data shows it fails for g <= 200000.
\\ The PROOF is NOT immediate from Z[i] UFD because legs(g) is defined by REAL/IMAG parts,
\\ not by multiplicative conditions.

\\ Let's quantify: legs(g) has |L(g)| = 2 * (3^k - 1)/2 / 2 + ... distinct integers.
\\ For g = p_1...p_k with k primes == 1 mod 4 (squarefree),
\\ |L(g)| = (3^k - 1)/2 PAIRS, hence at most (3^k-1) distinct integers.
\\ But some real parts coincide with imaginary parts of other reps.

print("=== Lemma attempt ===");
print("LEMMA: For a in legs(g), a appears as Re(alpha) for some alpha with N(alpha)=g^2,");
print("alpha = u * prod pi_i^{a_i} pibar_i^{2*e_i - a_i}, with sum_i (a_i + (2e_i-a_i)) = 2*sum_i e_i.");
print();
print("For (a, b, d) Pythagorean with all three in legs(g):");
print("  - Exists alpha = a + e_a*i with N(alpha) = g^2");
print("  - Exists beta = b + f_b*i with N(beta) = g^2");
print("  - Exists delta = d + e_d*i with N(delta) = g^2");
print("  AND (a + b*i)(a - b*i) = d^2");
print();
print("The Gaussian integer (a+b*i) has norm d^2 -- it factors over d's primes.");
print("Question: must (a+b*i) be related to alpha, beta, delta?");

\\ Let me compute (a+b*i)*(conj(delta)) for the case d in legs(g) hypothetically:
\\ If delta = d + e_d*i has norm g^2, then conj(delta)*(a+b*i) has norm g^2 * d^2.
\\ The product is (d - e_d*i)(a + b*i) = (d*a + e_d*b) + (d*b - e_d*a)*i

\\ Hmm. Let's see: if we could write a + b*i = something * delta or similar.

\\ Actually the right idea: (a+b*i) has norm d^2.
\\ Suppose d in legs(g). Then d = Re(delta) for some delta with N(delta) = g^2.
\\ But this doesn't relate (a+b*i) to delta directly.

EOF
