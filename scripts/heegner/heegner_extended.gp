\\ Extended Heegner search for fibers that had no D <= 2000.
\\ Search up to |D| = 20000.

default(parisize, 4000000000);
default(realprecision, 19);

no_D_pairs = [[8,5], [12,7], [15,4], [15,14], [16,5], [16,13], [17,8], [19,4], [19,16], [20,1], [20,3], [20,9], [20,11], [20,13], [20,17], [20,19], [21,8], [23,2], [23,4], [23,8], [23,18], [24,5], [24,11], [24,13], [24,19], [25,4], [25,8], [26,11], [26,17]];

heegner_D(Nval, lim) = {
  my(badp, D, ok, p);
  badp = factor(Nval)[, 1];
  for(absD = 3, lim,
    D = -absD;
    if(!isfundamental(D), next);
    ok = 1;
    for(i = 1, #badp,
      p = badp[i];
      if(kronecker(D, p) != 1, ok = 0; break);
    );
    if(ok, return(D));
  );
  return(0);
}

{
  print("mm nn q Ncond Dmin_20000 badprimes");
  for(k = 1, #no_D_pairs,
    mm = no_D_pairs[k][1];
    nn = no_D_pairs[k][2];
    qq = (mm^2 - nn^2)/(2*mm*nn);
    aa = mm^2 - nn^2;
    bb = 2*mm*nn;
    EE = ellinit([0, aa^2 + bb^2, 0, aa^2*bb^2, 0]);
    EEmin = ellminimalmodel(EE);
    Ncond = ellglobalred(EEmin)[1];
    Dmin = heegner_D(Ncond, 20000);
    badp = factor(Ncond)[, 1];
    print(mm, " ", nn, " ", qq, " ", Ncond, " ", Dmin, " ", badp);
  );
}
quit;
