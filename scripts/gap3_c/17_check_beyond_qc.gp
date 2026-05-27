\\ Check rank of E_PCP for the 5 BEYOND-QC fibers from AUXILIARY-CURVES-5.md
default(parisize, 1500000000);
print("=== Check E_PCP rank for 5 BEYOND-QC fibers ===");

beyond_qc = [[61,38], [63,38], [73,24], [88,35], [99,28]];
for(i=1, length(beyond_qc), my(pair=beyond_qc[i], m=pair[1], n=pair[2], q, E, Em, r); q = (m^2-n^2)/(2*m*n); E = ellinit([0, 1+q^2, 0, q^2, 0]); Em = ellminimalmodel(E); r = ellrank(Em, 10); print("(",m,",",n,") q=", q, " rk=[",r[1],",",r[2],"] unprov=", r[3], " #gens=", length(r[4])));
quit;
