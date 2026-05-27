\\ Face-3 on (1136, 343)
default(parisize, 1200000000);

m = 1136; n = 343;
q = (m^2-n^2)/(2*m*n);
E = ellinit([0, 1+q^2, 0, q^2, 0]);
chv = 0;
Emin = ellminimalmodel(E, &chv);
N = ellglobalred(Emin)[1];
print("(", m, ",", n, ")");
print("omega: wp=", omega(m^2+n^2), " wm=", omega(m^2-n^2), " wmn=", omega(m*n), " wsp=", omega(m+n), " wsm=", omega(m-n));
print("logN=", log(N*1.0)/log(10), " ω(N)=", omega(N));

t0 = getwalltime();
rk6 = ellrank(Emin, 6);
print("effort 6: [", rk6[1], ",", rk6[2], "] gens=", length(rk6[4]), " t=", (getwalltime()-t0)/1000.0, "s");

gens = rk6[4];
num_g = length(gens);
H = matrix(num_g, num_g, i, j, ellheight(Emin, gens[i], gens[j]));
print("det H = ", matdet(H));

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
  print("G", i, ": F3 sq=", sq);
  if(sq, n_sq = n_sq + 1; print("  *** PCP CANDIDATE ***"));
);
}
print("Total F3 squares: ", n_sq);
quit;
