default(parisize, 200000000);
default(realprecision, 38);

A4 = -4296889542830417930548255320;
A6 = 69513195990628448299367172717433334517312;
E = ellinit([1, 0, 0, A4, A6]);

e1 = -289985899459969;
e2 =  69618111281856;
e3 =  220367788178112;

myf(x) = x^3 + x^2 + 16*A4*x + 64*A6;
print("Root check: ", myf(e1) == 0, " ", myf(e2) == 0, " ", myf(e3) == 0);

trips = [[97, -3, -291], [97, -73, -7081], [1249, 7494, 6]];
B = 1000;

{
for(k = 1, #trips,
  trip = trips[k];
  d1 = trip[1]; d2 = trip[2]; d3 = trip[3];
  myhits = 0;
  for(z1 = 0, B,
    X = d1*z1^2 + e1;
    Aw = X - e2;
    Bw = X - e3;
    if(d2*Aw < 0 || d3*Bw < 0, next);
    if(issquare(Aw*d2) && issquare(Bw*d3),
      myhits++;
      print("  HIT: triple ", trip, " z1=", z1, " X=", X);
    );
  );
  print("triple ", trip, " B=", B, " hits=", myhits);
);
}
quit;
