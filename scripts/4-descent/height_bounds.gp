\\ Compute height bounds for E_Hm: difference between naive and canonical height,
\\ to translate search bounds into height bounds.

default(parisize, 2000000000);
default(realprecision, 38);

E_Hm = ellinit([1, 0, 0, -4201713691887954766021162410, 103564307677747011646913552825626935447972]);
A2 = 4*E_Hm.a2 + E_Hm.a1^2;
A4 = 16*E_Hm.a4;
A6 = 64*E_Hm.a6;
E_short = ellinit([0, A2, 0, A4, A6]);

print("E_short = ", E_short[1..5]);
print();

\\ Silverman bound: |h(P) - h_hat(P)| <= bound dependent on disc
\\ Use PARI's ellheightseg / ellheight diff
\\ Actually ellheight_naive(E, P) = log max(|num x|, |denom x|) for x in Q
\\ ellheight(E, P) = canonical = h_hat

\\ Compute Silverman's bound:
\\ |h(P) - h_hat(P)| <= (1/12) log |Delta| + h_W(j) / 6 + something
disc_E = abs(E_short.disc);
j_E = E_short.j;

print("disc = ", disc_E);
print("log|disc| = ", log(1.0*disc_E));
print("j-invariant = ", j_E);

\\ Crude Silverman: difference bounded by (1/12) log|disc| + (1/12) log(j or 1)
silv_bound = (1/12) * log(1.0*disc_E);
print("Silverman bound est: |h - h_hat| <= (1/12) log|disc| = ", silv_bound);
print();

\\ Naive height of search bound 2*10^6: log(2*10^6) ~ 14.5
print("Naive height of x = 2*10^6: ", log(2.0*10^6));
print("So canonical height of smallest searched point >= ", log(2.0*10^6) - silv_bound);
print();

\\ Lower bound on canonical height of non-torsion point (Lang's conjecture, Hindry-Silverman bound)
\\ For E/Q, h_hat(P) >= c / log|disc| or so. PARI's ellheight gives upper bound on min height.

\\ Use ellheightmatrix etc to estimate. Actually:
\\ Hindry-Silverman: h_hat(P) >= c(E) for some constant. For "generic" curves
\\ c(E) ~ 0.001 to 1.0.

\\ Practical heuristic: rank-2 curves of comparable conductor typically have generators with
\\ canonical height in range 1 to 100. So our search up to x = 2*10^6 (naive height ~14.5)
\\ gives canonical height up to ~14.5 + 15 = ~30, which IS in the relevant range.

print("Summary: search bound x <= 2*10^6 corresponds to canonical height <= ~14.5 + ", silv_bound);
print("This is in the range of typical rank-2 generators for conductor ~10^17.");
print("So absence of point in search is meaningful evidence (but NOT proof) of rk = 0.");

quit;
