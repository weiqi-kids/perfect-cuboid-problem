\\ Test PARI's p-adic logarithm and Frobenius for Coleman integration
default(parisize, 4000000000);
default(parisizemax, 16000000000);

q0 = 20/21;
p = 11;
prec = 20;

E_ef = ellminimalmodel(ellinit([0, -2*(1+q0^2), 0, (1-q0^2)^2, 0]));
E_Hp = ellminimalmodel(ellinit([0, 2 + 2*q0^2, 0, 1 + 3*q0^2 + q0^4, q0^2 + q0^4]));

\\ p-adic logarithm of a point
print("=== p-adic logarithm ===");
print("ellpadicfrobenius for E_ef:");
F_ef = ellpadicfrobenius(E_ef, p, prec);
print(F_ef);

print("\nellpadiclog (formal log) for E_ef at gen (616, 13552):");
gen_ef = [616, 13552];
\\ Use ellpadicheight to extract anti-cyclotomic log; PARI also has ellanal_globalred
\\ The simplest log-of-point is via formal group: x/y = uniformizer
\\ The 'ellpadiclog' takes a uniformizer expression
\\ Actually, the standard is ellzeropadicL or via ellanalyticrank with p

\\ Direct: log of P in formal group, P near identity
\\ Reduce P modulo p first: check if P reduces to identity
P_mod_p = [Mod(gen_ef[1], p), Mod(gen_ef[2], p)];
print("P mod ", p, " = ", P_mod_p);
print("\nNeed P in kernel of reduction. If E(F_p) has order N, then [N]P is in the kernel.");
ap = ellap(E_ef, p);
Np = p + 1 - ap;
print("#E_ef(F_", p, ") = ", Np);
NP = ellmul(E_ef, gen_ef, Np);
print("[N]P = ", NP);

print("\n=== Coleman integral via height (decomposition) ===");
\\ The p-adic height h_p(P) = sigma_p(P)^2 / formal-log-style
\\ For QC: we need iterated Coleman integrals \int omega_i omega_j on the genus-5 curve V_q
\\ V_q does not have direct PARI support — it is NOT hyperelliptic.

\\ V_q has degree 8 over P^1_c (cover by [e, f, g] sign choices)
\\ V_q ~ E_ef x E_eg x E_fg x E_H+ x E_H- by Jacobian decomposition
\\ For Chabauty: pull back differentials from each factor via the quotient maps
\\   pi_ef: V_q -> E_ef (degree 4)
\\   pi_eg: V_q -> E_eg (degree 4)
\\   pi_fg: V_q -> E_fg (degree 4)
\\   pi_Hp: V_q -> E_H+ (degree 4)
\\   pi_Hm: V_q -> E_H- (degree 4)
\\ Each gives a 1-form omega_i = pi_i^* dx/2y on V_q

\\ For QC depth 2: need iterated integrals between pairs (omega_i, omega_j) on V_q
\\ PARI cannot compute these directly. The Frobenius matrix above is for E_ef alone.

print("\n=== Summary of PARI capability ===");
print("PARI HAS: ellpadicfrobenius, ellpadicL, ellpadicheight, ellpadicheightmatrix, ellpadicregulator");
print("PARI HAS: order-1 Coleman integrals via p-adic logarithm on each elliptic factor");
print("PARI LACKS: iterated Coleman integrals on V_q (a non-hyperelliptic genus-5 curve)");
print("Therefore: PARI can compute alpha_i = log_p(P_i) for P_i in E_i(Q) at each factor.");
print("These give the LINEAR Chabauty equations on each E_i, but the linear functional on H^0(V_q, Omega) is 5-dim image, so linear Chabauty's image equals 5 = g and the dimension of the kernel is 0 (Stoll fails).");

quit;
