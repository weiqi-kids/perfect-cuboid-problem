\\ Debug ellisomat output structure.

default(parisize, 500000000);

\\ Small test curve
E = ellinit([0, 0, 0, -1, 0]);
print("Test curve: y^2 = x^3 - x");
print("ellisomat(E, 2):");
ISO = ellisomat(E, 2);
print("  length: ", #ISO);
print("  type: ", type(ISO));
for(i = 1, #ISO,
  print("  ISO[", i, "] = ", ISO[i], "  (type ", type(ISO[i]), ")");
);
print();
print("ISO[1][1] type: ", type(ISO[1][1]));
print("ISO[1][1]: ", ISO[1][1]);

\\ Try ellrank on each
print();
print("--- ellrank tests ---");
for(k = 1, #ISO[1],
  Ek_data = ISO[1][k];
  print();
  print("  iso[", k, "] data: ", Ek_data);
  print("  type: ", type(Ek_data), "  length: ", #Ek_data);
  if(type(Ek_data) == "t_VEC" && #Ek_data == 5,
    \\ It's a 5-tuple [a1..a6]
    Ek = ellinit(Ek_data);
    print("    ellinit'd OK, ellrank:");
    r = ellrank(Ek, 2);
    print("    ", r);
  );
  if(type(Ek_data) == "t_VEC" && #Ek_data >= 13,
    \\ It's already an ellinit
    print("    already ellinit'd, ellrank:");
    r = ellrank(Ek_data, 2);
    print("    ", r);
  );
);

quit;
