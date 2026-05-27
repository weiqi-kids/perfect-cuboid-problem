default(parisize,1000000000);
\\ RIGOROUS argument that sigma is bounded by an ABSOLUTE constant for ALL Pythagorean q.
\\
\\ Setup: E_q: y^2 = x(x+1)(x+q^2). q=u/v lowest terms (so q in lowest terms).
\\ Non-minimal Delta_0 = 16 q^4 (q^2-1)^2.
\\ j = 256 (q^4-q^2+1)^3 / [ q^4 (q^2-1)^2 ].
\\
\\ For an elliptic curve with potentially-mult reduction at p (i.e. v_p(j)<0),
\\ the reduction is MULTIPLICATIVE (not additive after twist) and v_p(Delta_min) = -v_p(j).
\\ We VERIFIED all bad reduction here is multiplicative (no additive). So:
\\    log|Delta_min| = sum_{p: v_p(j)<0} (-v_p(j)) log p = sum of pole orders of j.
\\    log N          = sum_{p: v_p(j)<0} 1 * log p   = sum over the SAME primes of log p.
\\ Therefore sigma = [sum (-v_p(j)) log p] / [sum 1 * log p] = weighted avg of pole orders.
\\
\\ Now: -v_p(j) for p | denominator of j. j-denominator = q^4(q^2-1)^2 / gcd-with-numerator.
\\ The numerator N_j = 256(q^4-q^2+1)^3, denominator D_j = q^4(q^2-1)^2 (before reduction).
\\ For p odd, p | D_j: the pole order is v_p(D_j) - v_p(N_j). Since (q^4-q^2+1) and q(q^2-1)
\\ are COPRIME as polynomials? Check resultants -> bounded common factors -> -v_p(j) <= 6 + O(1).
\\
\\ KEY: as a RATIONAL FUNCTION of q, j has a pole of order exactly:
\\   at q=0: D_j ~ q^4, N_j -> 256 (q^4-q^2+1)^3 -> 256 (nonzero). pole order 4.
\\   at q=1: (q^2-1)^2 ~ (q-1)^2, pole order 2. at q=-1: pole order 2. at q=inf: order 4.
\\ The GEOMETRIC pole orders are {4,2,2,4} (the I_4,I_2,I_2,I_4 fibers). For an ARITHMETIC prime p,
\\ v_p(-j) is bounded by the MAX geometric pole order times the ramification = combination,
\\ BUT a single prime p can divide u, v, (u-v), or (u+v) -> contributes via the q=0,inf,1,-1 specializations.
\\
\\ Let me just compute -v_p(j) symbolically via resultants to BOUND it. The point: any prime p
\\ divides at most a bounded number of the four factors {u, v, u-v, u+v} (in fact: p|u and p|v impossible
\\ (coprime); p|(u-v),(u+v) and p|u => p|2v ... ). Compute the max possible -v_p(j) structurally.

\\ Compute resultants to show numerator and denominator of j share only bounded factors:
q='q;
Nj = 256*(q^4-q^2+1)^3;
Dj = q^4*(q^2-1)^2;
print("Resultant_q(q^4-q^2+1, q) = ", polresultant(q^4-q^2+1, q));
print("Resultant_q(q^4-q^2+1, q^2-1) = ", polresultant(q^4-q^2+1, q^2-1));
print("Resultant_q(q^4-q^2+1, q-1) = ", polresultant(q^4-q^2+1, q-1));
print("Resultant_q(q^4-q^2+1, q+1) = ", polresultant(q^4-q^2+1, q+1));
\\ gcd of the pieces:
print("gcd(q^4-q^2+1, q^4(q^2-1)^2) = ", gcd(q^4-q^2+1, Dj));
\\ The numerator factor (q^4-q^2+1) is coprime to q,(q-1),(q+1): resultants are +-1 or small.
\\ Evaluate at integers: q^4-q^2+1 at q=0 is 1; at q=1 is 1; at q=-1 is 1. So COPRIME to q(q^2-1).
print("(q^4-q^2+1) at q=0: ", subst(q^4-q^2+1,q,0));
print("(q^4-q^2+1) at q=1: ", subst(q^4-q^2+1,q,1));
print("(q^4-q^2+1) at q=-1: ", subst(q^4-q^2+1,q,-1));
