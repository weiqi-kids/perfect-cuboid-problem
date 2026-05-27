\\ Analysis: omega signatures of all newly found rank-4 fibers
default(parisize, 1200000000);

\\ All new rank-4 hits from this extended hunt
HITS = [[421, 344], [454, 131], [488, 293], [592, 59], [640, 317], [752, 353], [1012, 223], [1012, 301], [1017, 512], [1021, 328], [1048, 707]];

print("# (m,n) wp wm wmn wsp wsm sum_omega ω(N) logN");
{
for(i=1, length(HITS),
  my(p = HITS[i], m = p[1], n = p[2]);
  my(q = (m^2-n^2)/(2*m*n));
  my(E = ellinit([0, 1+q^2, 0, q^2, 0]));
  my(Emin = ellminimalmodel(E));
  my(N = ellglobalred(Emin)[1]);
  my(wp = omega(m^2+n^2), wm = omega(m^2-n^2), wmn = omega(m*n));
  my(wsp = omega(m+n), wsm = omega(m-n));
  my(sum_omega = wp + wm + wsp + wsm);
  my(omegaN = omega(N));
  my(logN = log(N*1.0)/log(10));
  print("(", m, ",", n, ") wp=", wp, " wm=", wm, " wmn=", wmn, " wsp=", wsp, " wsm=", wsm, " sum=", sum_omega, " ωN=", omegaN, " logN=", logN);
);
}

\\ Aggregate stats vs Pick 13 R=4 conjecture
print();
print("=== Pick 13 R=4 empirical check ===");
my(min_wp = 99, max_wp = 0, min_wm = 99, max_wm = 0, mean_wp = 0, mean_wm = 0);
{
for(i=1, length(HITS),
  my(p = HITS[i], m = p[1], n = p[2]);
  my(wp = omega(m^2+n^2), wm = omega(m^2-n^2));
  min_wp = min(min_wp, wp); max_wp = max(max_wp, wp);
  min_wm = min(min_wm, wm); max_wm = max(max_wm, wm);
  mean_wp = mean_wp + wp;
  mean_wm = mean_wm + wm;
);
}
mean_wp = mean_wp*1.0/length(HITS);
mean_wm = mean_wm*1.0/length(HITS);
print("ω(m²+n²): min=", min_wp, " max=", max_wp, " mean=", mean_wp);
print("ω(m²-n²): min=", min_wm, " max=", max_wm, " mean=", mean_wm);
quit;
