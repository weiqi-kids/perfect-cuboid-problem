default(parisize, 200000000);
default(realprecision, 38);
A4 = -4296889542830417930548255320;
A6 = 69513195990628448299367172717433334517312;
E = ellinit([1, 0, 0, A4, A6]);
e1 = -289985899459969;
e2 =  69618111281856;
e3 =  220367788178112;
f(x) = x^3 + x^2 + 16*A4*x + 64*A6;
print("Root check: ", f(e1) == 0, " ", f(e2) == 0, " ", f(e3) == 0);
\\ Quick small-B scan on triple [97, -3, -291] and [97, -73, -7081]
trips = [[97, -3, -291], [97, -73, -7081], [1249, 7494, 6]];
B = 1000;
for(k=1, #trips,
  trip = trips[k]; d1=trip[1]; d2=trip[2]; d3=trip[3];
  hits = 0;
  for(z1 = 0, B,
    X = d1*z1^2 + e1;
    A_ = X - e2; Bc = X - e3;
    if(d2*A_ < 0 || d3*Bc < 0, next);
    if(issquare(A_*d2) && issquare(Bc*d3),
      hits++;
      print("  triple ", trip, " z1=", z1, " X̃=", X);
    );
  );
  print("triple ", trip, " hits=", hits);
);
quit;
