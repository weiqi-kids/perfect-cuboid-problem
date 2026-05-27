data = [[61,38],[63,38],[73,24],[88,35],[99,28]];
for(i=1, length(data), \
  mn = data[i]; \
  m = mn[1]; n = mn[2]; \
  num = 2*m*n; \
  den = m^2 - n^2; \
  qval = num/den; \
  one_plus_qsq = 1 + qval^2; \
  print(mn, "  q = ", num, "/", den, " = ", qval, "    1+q^2 = ", one_plus_qsq); \
);
quit;
