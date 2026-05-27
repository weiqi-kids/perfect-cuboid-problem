m = 63; n = 38;
a = m^2 - n^2;   X2 = a^2;
b = 2*m*n;       X3 = b^2;
dab = m^2 + n^2; X1 = dab^2;
S = X1+X2+X3; P = X1*X2 + X1*X3 + X2*X3; QQ = X1*X2*X3;

chab(p) = {
  local(Ep, allpts, xv, rhs, r, sq, pt, xx, s_mod, sqcount, branches, nonbr, s_val, X1p, X2p, X3p);
  X1p = X1 % p; X2p = X2 % p; X3p = X3 % p;
  print();
  print("=== Prime p = ", p, " ===");
  print("X1 mod p = ", X1p, "   X2 mod p = ", X2p, "   X3 mod p = ", X3p);
  Ep = ellinit([Mod(0,p), Mod(P,p), Mod(0,p), Mod(QQ*S,p), Mod(QQ^2,p)]);
  print("|E(F_p)| = ", ellcard(Ep));

  allpts = List();
  listput(allpts, [0]);
  for(xv = 0, p-1,
    rhs = (xv^3 + P*xv^2 + QQ*S*xv + QQ^2) % p;
    r = Mod(rhs, p);
    if(issquare(r),
      sq = lift(sqrt(r));
      if(sq == 0,
        listput(allpts, [xv, 0])
      ,
        listput(allpts, [xv, sq]);
        listput(allpts, [xv, p - sq])
      )
    )
  );
  print("Enumerated points: ", length(allpts));

  sqcount = 0; branches = 0; nonbr = 0;
  for(i = 2, length(allpts),
    pt = allpts[i];
    xx = pt[1];
    if(xx == 0, next);
    s_mod = Mod(-QQ, p) / Mod(xx, p);
    if(s_mod == 0, next);
    if(issquare(s_mod),
      sqcount += 1;
      s_val = lift(s_mod);
      if(s_val == X1p || s_val == X2p || s_val == X3p,
        branches += 1;
        print("  BRANCH:  x=", xx, "  y=", pt[2], "  s mod p = ", s_val)
      ,
        nonbr += 1;
        print("  NON-BRANCH:  x=", xx, "  y=", pt[2], "  s mod p = ", s_val)
      )
    )
  );
  print("==> Total s-square points: ", sqcount, "    branches: ", branches, "    NON-branches: ", nonbr);
};

chab(11);
chab(13);
chab(17);
chab(23);
