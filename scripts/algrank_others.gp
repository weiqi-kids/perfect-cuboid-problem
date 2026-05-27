\\ ellrank for (35,22) and (37,26)
default(parisize, 4000000000);
default(realprecision, 25);

go(m, n) = {
  print("=== (", m, ",", n, ") ===");
  my(a=m^2-n^2, b=2*m*n);
  my(E=ellinit([0, a^2+b^2, 0, a^2*b^2, 0]));
  my(Emin=ellminimalmodel(E));
  print("conductor: ", ellglobalred(Emin)[1]);
  my(r = ellrank(Emin, 0));
  print("ellrank(0): ", r);
};

go(35, 22);
go(37, 26);
quit;
