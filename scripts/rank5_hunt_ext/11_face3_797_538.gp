\\ Face-3 verification on (797, 538)
default(parisize, 1200000000);

m = 797; n = 538;
q = (m^2-n^2)/(2*m*n);
E = ellinit([0, 1+q^2, 0, q^2, 0]);
chv = 0;
Emin = ellminimalmodel(E, &chv);
print("(", m, ",", n, ") logN=", log(ellglobalred(Emin)[1]*1.0)/log(10));

t0 = getwalltime();
rk6 = ellrank(Emin, 6);
print("effort 6: [", rk6[1], ",", rk6[2], "] gens=", length(rk6[4]), " t=", (getwalltime()-t0)/1000.0, "s");

gens = rk6[4];
num_g = length(gens);
H = matrix(num_g, num_g, i, j, ellheight(Emin, gens[i], gens[j]));
print("det H = ", matdet(H));

print("--- omega data ---");
print("ω(m²+n²)=", omega(m^2+n^2), " ω(m²-n²)=", omega(m^2-n^2), " ω(mn)=", omega(m*n), " ω(m+n)=", omega(m+n), " ω(m-n)=", omega(m-n));

print("--- Face-3 ---");
n_sq = 0;
{
for(i=1, num_g,
  P = gens[i];
  PE = ellchangepointinv(P, chv);
  x = PE[1]; y = PE[2];
  c = 2*q*y/(q^2 - x^2);
  F3 = c^2 + 1 + q^2;
  sq = issquare(F3);
  print("G", i, ": F3=", F3, " sq=", sq);
  if(sq, n_sq = n_sq + 1);
);
}
print("Total F3 squares: ", n_sq);
quit;
