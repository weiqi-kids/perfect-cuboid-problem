/* Analyze ratios by residue class of p mod 8, mod 12, etc */

\\ Re-use computed values
data = [[3,7,49], [5,37,193], [7,55,721], [11,151,2161], [13,349,3649], [17,817,7681], [19,487,7345], [23,1079,16721], [29,3277,33601], [31,2431,38161], [37,4933,52417], [41,7321,88321], [43,5671,89713], [47,7775,123281], [53,14197,182209], [59,13399,212977], [61,20461,248641], [67,20791,331057], [71,25271,402641], [73,32185,403201], [79,34399,548497], [83,39607,631729], [89,62569,853249], [97,76321,1053697]];

print("\n--- By p mod 4 ---");
for(rr = 1, 3, m = 0; n = 0; for(i = 1, length(data), p = data[i][1]; if((p % 4) == rr, ratio = data[i][3]*1.0/p^3; print("  p=", p, " (", rr, " mod 4): Nproper/p^3=", ratio); m = m+ratio; n = n+1)); if(n>0, print("  Mean for ", rr, " mod 4: ", m/n)));

print("\n--- By p mod 8 ---");
for(rr = 1, 7, m = 0; n = 0; for(i = 1, length(data), p = data[i][1]; if((p % 8) == rr, ratio = data[i][3]*1.0/p^3; m = m+ratio; n = n+1)); if(n>0, print("  Mean for ", rr, " mod 8 (", n, " primes): ", m/n)));

\\ Hasse-Weil: |V(F_p)| ~ p^d + O(p^(d-1/2)) where d = dim(V) (affine)
\\ Try to fit error term
print("\n--- Hasse-Weil error analysis (affine dim 3 expected): Nproper/p^3 ---");
for(i = 1, length(data), p = data[i][1]; ratio = data[i][3]*1.0/p^3; err = (ratio - 1)*sqrt(p); print("  p=", p, " Nproper/p^3 = ", ratio, " (1-ratio)*sqrt(p) = ", err));

quit;
