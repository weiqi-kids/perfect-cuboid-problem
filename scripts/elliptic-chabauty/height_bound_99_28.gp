\\ Height bound computation for the Bruin-Stoll Elliptic Chabauty closure
\\ of the H_q fiber (m, n) = (99, 28).
\\
\\ Goal: Compute a (heuristic, conditional) upper bound on |n| such that
\\ every rational point P in H_q(Q) projects via pi: H_q -> E_Hp to
\\ pi(P) = n*G + T with |n| bounded.
\\
\\ Setup: H_q : Y^2 = (X^2 + d^2)(X^2 + p^2)(X^2 + w^2),
\\        E_Hp : v^2 = (u+1)(u+q^2)(u+1+q^2),
\\        pi : (X,Y) |-> (X^2/d^2, Y/d^3) of degree 2,
\\        rk E_Hp = 1 with generator G = [-29443120, 115094337568] on
\\        the minimal model, h_hat(G) ~ 4.5927.
\\
\\ Standard Silverman 1990 height-difference bound: for any P on E
\\   |h_hat(P) - h_x(P)/2| <= C(E)
\\ where Silverman's explicit constant (Theorem 1.1, Math. Comp. 1990) is
\\
\\   C(E) <= (1/12) * log|Delta(E)|
\\         + (1/12) * h(j(E))
\\         + (1/2)  * log_+(|b_2|/12 + 1)  -- actually Silverman uses
\\         + (1/2)  * log_+(|b_2(E)|/6 + 1) in some formulations
\\         + 2
\\
\\ We use the original Silverman 1990 form (Math. Comp. 55, 723-743):
\\   h(P) - h_hat(P) <= (1/8) * h(j(E)) + (1/12) log|Delta(E)|
\\                    + (1/2) * log_+(|b_2|/12 + 1) + 1.946  (constant)
\\ Conservative: use the variant
\\   h_hat(P) - h(P)/2 <= upper bound C  computed below.
\\
\\ For the pullback under pi: if P_H in H_q(Q) and P_E = pi(P_H), then
\\ the naive heights on the y^2 = f(x) integer models satisfy
\\   h_x(P_E) = h_x(X^2/d^2) <= 2 * h_x(P_H) + 2*log|d|
\\ so
\\   h_hat(P_E) <= h_x(P_E)/2 + C <= h_x(P_H) + log|d| + C.
\\
\\ Since h_hat(P_E) = h_hat(n G + T) = n^2 * h_hat(G), we obtain
\\   n^2 <= (h_x(P_H) + log|d| + C) / h_hat(G).
\\
\\ The heuristic Hindry-Silverman 1996 height bound for genus-2 curves
\\ asserts h_max ~ log N(H_q); we adopt h_x(P_H) <= log N(H_q) as a
\\ conditional bound (NOT a theorem; see HEIGHT-BOUND-99-28.md).

default(parisize, 500000000);
default(realprecision, 38);
default(timer, 0);

t_start = getwalltime();

\\ ---- Setup ----
mm = 99; nn = 28;
q_num = 2*mm*nn;
q_den = mm^2 - nn^2;
g0 = gcd(q_num, q_den);
q_num /= g0; q_den /= g0;
q0 = q_num / q_den;

p_val = q_num;
d_val = q_den;
w_val = mm^2 + nn^2;

print("==========================================================");
print("Height bound for (99, 28) elliptic Chabauty closure");
print("PARI/GP ", version());
print("==========================================================");
print("p = 2mn  = ", p_val);
print("d = m^2-n^2 = ", d_val);
print("w = m^2+n^2 = ", w_val);

\\ Integer-model sextic for H_q
{fX = 'X^6 + (d_val^2 + p_val^2 + w_val^2) * 'X^4 + (d_val^2*p_val^2 + d_val^2*w_val^2 + p_val^2*w_val^2) * 'X^2 + d_val^2*p_val^2*w_val^2;}
print("\nH_q: Y^2 = ", fX);

\\ E_Hp minimal model
E_Hp_orig_coef = [0, 2 + 2*q0^2, 0, 1 + 3*q0^2 + q0^4, q0^2 + q0^4];
E_Hp_orig = ellinit(E_Hp_orig_coef);
E_Hp_min = ellinit(ellminimalmodel(E_Hp_orig, &v_Hp));
print("\nE_Hp minimal: ", E_Hp_min[1..5]);
NHp = ellglobalred(E_Hp_min)[1];
print("Conductor N(E_Hp) = ", NHp);

\\ Generator and its canonical height
G_Hp = [-29443120, 115094337568];
if(!ellisoncurve(E_Hp_min, G_Hp), print("FATAL: G not on curve"); quit);
h_G = ellheight(E_Hp_min, G_Hp);
print("Generator G = ", G_Hp, ", h_hat(G) = ", h_G);

\\ ---- Silverman 1990 height-difference constant for E_Hp ----
print("\n----------------------------------------------------------");
print("Silverman 1990 height-difference constant for E_Hp");
print("----------------------------------------------------------");

\\ Standard invariants of minimal model
b2 = E_Hp_min.b2;
b4 = E_Hp_min.b4;
b6 = E_Hp_min.b6;
b8 = E_Hp_min.b8;
c4 = E_Hp_min.c4;
c6 = E_Hp_min.c6;
disc_E = E_Hp_min.disc;
j_E = E_Hp_min.j;

print("b2(E_Hp) = ", b2);
print("b4(E_Hp) = ", b4);
print("c4(E_Hp) = ", c4);
print("c6(E_Hp) = ", c6);
print("Disc(E_Hp) = ", disc_E);
print("        |Disc| = ", abs(disc_E));
print("log|Disc| = ", log(abs(disc_E*1.0)));
print("j(E_Hp)  = ", j_E);

\\ h(j) = log max(|num j|, |den j|) using Weil/projective height
j_num = numerator(j_E);
j_den = denominator(j_E);
h_j = log(max(abs(j_num), abs(j_den)) * 1.0);
print("h(j) = log max(|num j|, |den j|) = ", h_j);

\\ Silverman's original 1990 bound (Math. Comp. 55, eq. just before Thm 1.1):
\\   mu(E) = (1/12) log|disc| + (1/12) h(j) + (1/2) log_+(|b2|/12 + 1) + 1.946
\\
\\ Theorem 1.1: |h(P) - h_hat(P)| <= mu(E)
\\
\\ Where h(P) = log max(|x_num|, |x_den|) is the naive Weil height of x(P).
\\ We use this as our C constant.

log_plus_b2 = log(max(abs(b2)/12.0 + 1, 1.0));
print("log_+(|b2|/12 + 1) = ", log_plus_b2);

C_silverman = (1.0/12) * log(abs(disc_E*1.0)) + (1.0/12) * h_j + (1.0/2) * log_plus_b2 + 1.946;
print("\nSilverman C = (1/12) log|Disc| + (1/12) h(j) + (1/2) log_+(|b2|/12+1) + 1.946");
print("            = ", (1.0/12) * log(abs(disc_E*1.0)), " + ", (1.0/12) * h_j, " + ", (1.0/2) * log_plus_b2, " + 1.946");
print("            = ", C_silverman);

\\ Cremona-Prickett-Siksek 2006 sharper bound (used by PARI ellheight)
\\ For comparison: PARI's height-pairing-matrix routines internally use this.
\\ Just print Silverman; we keep this conservative.

\\ ---- Heuristic h_max for H_q(Q) via log N(H_q) ----
print("\n----------------------------------------------------------");
print("Heuristic h_max for H_q(Q) (Hindry-Silverman type)");
print("----------------------------------------------------------");

\\ Conductor of H_q: we use the absolute value of the sextic discriminant
\\ as a proxy / upper estimate for the conductor (modulo bad primes).
disc_fX = poldisc(fX);
print("Disc(fX)   = ", disc_fX);
print("|Disc(fX)| = ", abs(disc_fX));
log_disc_fX = log(abs(disc_fX*1.0));
print("log|Disc(fX)| = ", log_disc_fX);

\\ Bad primes of H_q
bad_factor = factor(abs(disc_fX));
bad_primes = bad_factor[,1]~;
print("Bad primes of H_q: ", bad_primes);

\\ Conductor heuristic: N(H_q) <= |Disc(fX)|
\\ Hindry-Silverman 1996 / Vojta: h_max <~ log N for rational points on
\\ a curve of genus >= 2. For genus 2 of conductor N we adopt
\\
\\   h_max ~ log |Disc(fX)|       (very rough; conservative within order of magnitude)
\\
\\ A standard sharper heuristic: h_max ~ (1/g) log |Disc| with g=2.
\\ We compute several variants for reporting.

h_max_1 = log_disc_fX;
h_max_2 = log_disc_fX / 2.0;     \\ /(g) for g=2
print("h_max (raw   log|Disc|): ", h_max_1);
print("h_max (log|Disc|/g=2 ): ", h_max_2);

\\ ---- Combine: |n|_max bound from h_hat(nG) <= h_x(P)/2 + C ----
print("\n----------------------------------------------------------");
print("Combine: bound on |n|");
print("----------------------------------------------------------");

\\ For P_H in H_q(Q) with naive height h_x(P_H) = log max(|X|,|d|), the
\\ projected point pi(P_H) on E_Hp(Q) (minimal model coordinates) has
\\ naive x-height satisfying
\\   h_x_min(pi(P_H)) <= 2 * h_x(P_H) + |log u_change| + epsilon
\\
\\ Pullback factor: pi is degree 2, so heights scale by 2.
\\ Concretely u = X^2/d^2 with X,d integers => h(u) = 2 log|X| - 2 log|d|
\\ (Weil height of u as rational), bounded by 2 * h_x(P_H).
\\
\\ Then by Silverman:
\\   h_hat(pi(P_H)) <= h_x_min(pi(P_H))/2 + C
\\                  <= h_x(P_H) + (1/2)|log u_change| + C.
\\
\\ pi(P_H) = n G + T => h_hat(pi(P_H)) = n^2 h_hat(G) + 2 n <G, T> + h_hat(T)
\\ Since 2T = O, <G,T> = 0 and h_hat(T) = 0; so h_hat(pi(P_H)) = n^2 h_hat(G).
\\
\\ The change-of-variables (1/9017, ...) shifts the naive x-height; we
\\ pick a generous additive slack:
log_uchg = log(abs(v_Hp[1])*1.0);
print("Change-of-variables shift |log u| = ", log_uchg);
extra = 2 * log(d_val * 1.0);
print("Pullback extra (2 log d) = ", extra);

\\ Bound: n^2 * h_hat(G) <= h_max + extra + C
rhs_1 = h_max_1 + extra + C_silverman;
rhs_2 = h_max_2 + extra + C_silverman;

n_max_1 = sqrt(rhs_1 / h_G);
n_max_2 = sqrt(rhs_2 / h_G);

print("\nVariant 1 (h_max = log|Disc(fX)|):");
print("  RHS = h_max + 2 log d + C = ", h_max_1, " + ", extra, " + ", C_silverman, " = ", rhs_1);
print("  |n|_max = sqrt(RHS / h_hat(G)) = sqrt(", rhs_1, " / ", h_G, ") = ", n_max_1);

print("\nVariant 2 (h_max = log|Disc(fX)| / 2):");
print("  RHS = ", rhs_2);
print("  |n|_max = ", n_max_2);

\\ Conductor-only variant (use N(E_Hp) as proxy for global control)
h_max_3 = log(NHp * 1.0);
rhs_3 = h_max_3 + extra + C_silverman;
n_max_3 = sqrt(rhs_3 / h_G);
print("\nVariant 3 (h_max ~ log N(E_Hp) = ", h_max_3, "):");
print("  RHS = ", rhs_3);
print("  |n|_max = ", n_max_3);

\\ ---- Verdict ----
print("\n==========================================================");
print("VERDICT");
print("==========================================================");
print("Silverman C(E_Hp)   = ", C_silverman);
print("h_hat(G)            = ", h_G);
print("Search range tested = |n| <= 200");
print("");
print("Heuristic |n|_max (variant 1, conservative): ", ceil(n_max_1));
print("Heuristic |n|_max (variant 2, sharper)    : ", ceil(n_max_2));
print("Heuristic |n|_max (variant 3, via N(E_Hp)): ", ceil(n_max_3));
print("");
{if(n_max_1 <= 200, print("Variant 1: |n|_max <= 200, search COVERS heuristic bound."), print("Variant 1: |n|_max > 200, search does NOT cover heuristic bound."));}
{if(n_max_2 <= 200, print("Variant 2: |n|_max <= 200, search COVERS heuristic bound."), print("Variant 2: |n|_max > 200, search does NOT cover heuristic bound."));}
{if(n_max_3 <= 200, print("Variant 3: |n|_max <= 200, search COVERS heuristic bound."), print("Variant 3: |n|_max > 200, search does NOT cover heuristic bound."));}

print("");
print("CAVEAT: The bound h_x(P_H) <= log|Disc(fX)| (or log N) is");
print("the Hindry-Silverman/Vojta heuristic and is NOT a theorem.");
print("A fully rigorous closure requires Coleman integration on H_q");
print("(e.g. Magma QCMod) or an effective Vojta-type theorem.");

t_total = (getwalltime() - t_start) / 1000.0;
print("\nWall time: ", t_total, "s");
print("==========================================================");
quit;
