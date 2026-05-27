default(parisize, 400000000);
default(realprecision, 38);

A4 = -4296889542830417930548255320;
A6 = 69513195990628448299367172717433334517312;
E = ellinit([1, 0, 0, A4, A6]);

\\ Investigate ellisomat structure
t0 = getwalltime();
iso = ellisomat(E, 2);
t1 = getwalltime();
print("ellisomat wall = ", (t1-t0)/1000.0, "s");
print("type(iso) = ", type(iso));
print("#iso = ", #iso);
print("type(iso[1]) = ", type(iso[1]));
print("#iso[1] = ", #iso[1]);
if(#iso[1] > 0,
  print("type(iso[1][1]) = ", type(iso[1][1]));
  print("iso[1][1] = ", iso[1][1]);
  if(type(iso[1][1]) == "t_VEC",
    print("  #iso[1][1] = ", #iso[1][1]);
    print("  type(iso[1][1][1]) = ", type(iso[1][1][1]));
  );
);
quit;
