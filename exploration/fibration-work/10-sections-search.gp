\\ Search for rational sections of E_H+ over Q(q)
\\ E_H+(q): Y^2 = (X + q^2)(X + 1)(X + 1 + q^2)

\\ Verify torsion sections:
X1 = -'q^2; Y1_sq = (X1 + 'q^2)*(X1 + 1)*(X1 + 1 + 'q^2);
X2 = -1; Y2_sq = (X2 + 'q^2)*(X2 + 1)*(X2 + 1 + 'q^2);
X3 = -1 - 'q^2; Y3_sq = (X3 + 'q^2)*(X3 + 1)*(X3 + 1 + 'q^2);
print("X = -q^2: Y^2 = ", Y1_sq);
print("X = -1: Y^2 = ", Y2_sq);
print("X = -1 - q^2: Y^2 = ", Y3_sq);

\\ All three 2-torsion. So (Z/2)^2 is in torsion over Q(q).

\\ Now look for free (non-torsion) sections:
\\ Try X = a + b q^2 + c q^4 polynomial
\\ Y^2 = (X + q^2)(X + 1)(X + 1 + q^2)

\\ Try X = -q^2 + q^4 (some polynomial guess):
search_sec(Xpol) = { my(Y_sq); Y_sq = (Xpol + 'q^2) * (Xpol + 1) * (Xpol + 1 + 'q^2); if(issquare(Y_sq), print("FOUND section: X = ", Xpol, ", Y^2 = ", Y_sq, " = (", sqrt(Y_sq), ")^2"); return(1), return(0)); }

\\ Try simple polynomials
search_sec(0);
search_sec('q);
search_sec(-'q);
search_sec('q^2 - 1);
search_sec(1 - 'q^2);
search_sec(-'q^2 / 2);
search_sec(2 * 'q^2);
search_sec(2 * 'q);
search_sec('q + 'q^2);

\\ Try X = a * q + b * q^2:
print("\nSystematic search over small coefficient combinations:");
found = 0;
for(a = -3, 3, for(b = -3, 3, for(c = -3, 3, Xpol = a + b*'q + c*'q^2; if(Xpol == -'q^2 || Xpol == -1 || Xpol == -1 - 'q^2, next); Y_sq = (Xpol + 'q^2) * (Xpol + 1) * (Xpol + 1 + 'q^2); if(issquare(Y_sq), Y_pol = sqrt(Y_sq); print("X = ", Xpol, " → Y = ", Y_pol); found += 1))))
print("\nFound ", found, " non-trivial sections.");

\\ Rational sections: X = (rational fn of q)
\\ Try X = u/q for some rational u
print("\nTry X = u/q:");
for(u = -5, 5, if(u != 0, Xpol = u / 'q; Y_sq = (Xpol + 'q^2) * (Xpol + 1) * (Xpol + 1 + 'q^2); Y_num = numerator(Y_sq); Y_den = denominator(Y_sq); if(issquare(Y_num) && issquare(Y_den), print("X = ", u, "/q → Y^2 = ", Y_sq))))

\\ Try X = uq:
print("\nTry X = u*q:");
for(u = -5, 5, if(u != 0, Xpol = u * 'q; Y_sq = (Xpol + 'q^2) * (Xpol + 1) * (Xpol + 1 + 'q^2); if(issquare(Y_sq), print("X = ", u, "*q → Y^2 = ", Y_sq))))

