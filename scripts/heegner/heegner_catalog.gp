\\ Heegner discriminant catalog for rank-1 fibers, m <= 30.

default(parisize, 2000000000);
default(realprecision, 19);

rank1_pairs = [[4,3], [5,2], [7,6], [8,3], [8,5], [10,1], [10,3], [11,2], [11,6], [11,8], [12,7], [12,11], [13,8], [13,10], [13,12], [14,1], [14,3], [14,5], [15,4], [15,8], [15,14], [16,3], [16,5], [16,11], [16,13], [16,15], [17,8], [17,10], [17,16], [18,1], [18,7], [18,13], [19,2], [19,4], [19,10], [19,12], [19,16], [20,1], [20,3], [20,9], [20,11], [20,13], [20,17], [20,19], [21,2], [21,4], [21,8], [21,10], [21,16], [22,1], [22,3], [22,5], [22,9], [22,13], [22,15], [23,2], [23,4], [23,6], [23,8], [23,10], [23,18], [24,5], [24,7], [24,11], [24,13], [24,17], [24,19], [24,23], [25,2], [25,4], [25,8], [25,14], [25,18], [25,22], [26,1], [26,3], [26,9], [26,11], [26,15], [26,17], [26,21], [27,2], [27,4], [27,8], [27,10]];

heegner_D(Nval) = {
  my(badp, D, ok, p);
  badp = factor(Nval)[, 1];
  for(absD = 3, 2000,
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

heegner_D_count(Nval, bound) = {
  my(badp, D, cnt, ok, p);
  badp = factor(Nval)[, 1];
  cnt = 0;
  for(absD = 3, bound,
    D = -absD;
    if(!isfundamental(D), next);
    ok = 1;
    for(i = 1, #badp,
      p = badp[i];
      if(kronecker(D, p) != 1, ok = 0; break);
    );
    if(ok, cnt++);
  );
  return(cnt);
}

{
  print("mm nn q Ncond Dmin dcount badprimes");
  for(k = 1, #rank1_pairs,
    mm = rank1_pairs[k][1];
    nn = rank1_pairs[k][2];
    qq = (mm^2 - nn^2)/(2*mm*nn);
    aa = mm^2 - nn^2;
    bb = 2*mm*nn;
    EE = ellinit([0, aa^2 + bb^2, 0, aa^2*bb^2, 0]);
    EEmin = ellminimalmodel(EE);
    Ncond = ellglobalred(EEmin)[1];
    Dmin = heegner_D(Ncond);
    dcount = heegner_D_count(Ncond, 2000);
    badp = factor(Ncond)[, 1];
    print(mm, " ", nn, " ", qq, " ", Ncond, " ", Dmin, " ", dcount, " ", badp);
  );
}
quit;
