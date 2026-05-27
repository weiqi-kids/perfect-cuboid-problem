\\ Universal Heegner D search: for each small |D|, count how many of the 84 rank-1
\\ fibers satisfy the Heegner hypothesis. If some D works for all 84, we have a
\\ "universal" Heegner field.

default(parisize, 2000000000);
default(realprecision, 19);

rank1_pairs = [[4,3], [5,2], [7,6], [8,3], [8,5], [10,1], [10,3], [11,2], [11,6], [11,8], [12,7], [12,11], [13,8], [13,10], [13,12], [14,1], [14,3], [14,5], [15,4], [15,8], [15,14], [16,3], [16,5], [16,11], [16,13], [16,15], [17,8], [17,10], [17,16], [18,1], [18,7], [18,13], [19,2], [19,4], [19,10], [19,12], [19,16], [20,1], [20,3], [20,9], [20,11], [20,13], [20,17], [20,19], [21,2], [21,4], [21,8], [21,10], [21,16], [22,1], [22,3], [22,5], [22,9], [22,13], [22,15], [23,2], [23,4], [23,6], [23,8], [23,10], [23,18], [24,5], [24,7], [24,11], [24,13], [24,17], [24,19], [24,23], [25,2], [25,4], [25,8], [25,14], [25,18], [25,22], [26,1], [26,3], [26,9], [26,11], [26,15], [26,17], [26,21], [27,2], [27,4], [27,8], [27,10]];

{
  conds = vector(#rank1_pairs);
  for(k = 1, #rank1_pairs,
    mm = rank1_pairs[k][1];
    nn = rank1_pairs[k][2];
    aa = mm^2 - nn^2;
    bb = 2*mm*nn;
    EE = ellinit([0, aa^2 + bb^2, 0, aa^2*bb^2, 0]);
    EEmin = ellminimalmodel(EE);
    conds[k] = ellglobalred(EEmin)[1];
  );

  print("Best universal D candidates (|D| <= 5000):");
  print("D  count_of_fibers_satisfying_Heegner");
  best_count = 0;
  best_D = 0;
  for(absD = 3, 5000,
    D = -absD;
    if(!isfundamental(D), next);
    cnt = 0;
    for(k = 1, #conds,
      badp = factor(conds[k])[, 1];
      ok = 1;
      for(i = 1, #badp,
        p = badp[i];
        if(kronecker(D, p) != 1, ok = 0; break);
      );
      if(ok, cnt++);
    );
    if(cnt > best_count,
      best_count = cnt;
      best_D = D;
      print(D, " ", cnt, "  <-- new best");
    );
    if(cnt == #conds, print("UNIVERSAL D = ", D); break);
  );
  print("");
  print("Total rank-1 fibers: ", #conds);
  print("Best D: ", best_D, " covers ", best_count, " / ", #conds);
}
quit;
