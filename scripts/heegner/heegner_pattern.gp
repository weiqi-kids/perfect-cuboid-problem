\\ Pattern search: does Dmin (or some D in the Heegner set) relate to m, n?
\\ Test candidates:
\\   T1: D = -mn (squarefree part)
\\   T2: D = -(m+n)  (squarefree part * 4 if needed)
\\   T3: D = -(m^2 + n^2) sqfree
\\   T4: D = -(m^2 - n^2) sqfree
\\   T5: D = -mn(m+n) sqfree
\\   T6: D = -(m^2 + n^2) * (m-n) sqfree, etc.
\\ For each (m,n), compute the candidate D values and ask whether ANY of them
\\ satisfy the Heegner hypothesis for our conductor.

default(parisize, 2000000000);
default(realprecision, 19);

rank1_pairs = [[4,3], [5,2], [7,6], [8,3], [8,5], [10,1], [10,3], [11,2], [11,6], [11,8], [12,7], [12,11], [13,8], [13,10], [13,12], [14,1], [14,3], [14,5], [15,4], [15,8], [15,14], [16,3], [16,5], [16,11], [16,13], [16,15], [17,8], [17,10], [17,16], [18,1], [18,7], [18,13], [19,2], [19,4], [19,10], [19,12], [19,16], [20,1], [20,3], [20,9], [20,11], [20,13], [20,17], [20,19], [21,2], [21,4], [21,8], [21,10], [21,16], [22,1], [22,3], [22,5], [22,9], [22,13], [22,15], [23,2], [23,4], [23,6], [23,8], [23,10], [23,18], [24,5], [24,7], [24,11], [24,13], [24,17], [24,19], [24,23], [25,2], [25,4], [25,8], [25,14], [25,18], [25,22], [26,1], [26,3], [26,9], [26,11], [26,15], [26,17], [26,21], [27,2], [27,4], [27,8], [27,10]];

\\ Reduce x to a fundamental discriminant (negative)
fund_disc_neg(x) = {
  my(y, sf);
  if(x == 0, return(0));
  y = -abs(x);
  sf = core(-y);  \\ squarefree part of |x|
  \\ Construct fundamental: -sf if sf mod 4 == 3, else -4*sf
  if((-sf) % 4 == 1, return(-sf));
  return(-4 * sf);
}

heegner_ok(Nval, D) = {
  my(badp, ok, p);
  if(!isfundamental(D), return(0));
  badp = factor(Nval)[, 1];
  for(i = 1, #badp,
    p = badp[i];
    if(kronecker(D, p) != 1, return(0));
  );
  return(1);
}

{
  print("mm nn Ncond D_mn D_mpn D_m2pn2 D_m2mn2 D_mn_mpn ok_mn ok_mpn ok_m2pn2 ok_m2mn2 ok_mn_mpn");
  total = 0;
  ok_mn = 0; ok_mpn = 0; ok_m2pn2 = 0; ok_m2mn2 = 0; ok_prod = 0;
  for(k = 1, #rank1_pairs,
    mm = rank1_pairs[k][1];
    nn = rank1_pairs[k][2];
    aa = mm^2 - nn^2;
    bb = 2*mm*nn;
    EE = ellinit([0, aa^2 + bb^2, 0, aa^2*bb^2, 0]);
    EEmin = ellminimalmodel(EE);
    Ncond = ellglobalred(EEmin)[1];

    Dmn = fund_disc_neg(mm*nn);
    Dmpn = fund_disc_neg(mm + nn);
    Dm2pn2 = fund_disc_neg(mm^2 + nn^2);
    Dm2mn2 = fund_disc_neg(mm^2 - nn^2);
    Dprod = fund_disc_neg(mm*nn*(mm+nn));

    o1 = heegner_ok(Ncond, Dmn);
    o2 = heegner_ok(Ncond, Dmpn);
    o3 = heegner_ok(Ncond, Dm2pn2);
    o4 = heegner_ok(Ncond, Dm2mn2);
    o5 = heegner_ok(Ncond, Dprod);

    total++;
    ok_mn += o1; ok_mpn += o2; ok_m2pn2 += o3; ok_m2mn2 += o4; ok_prod += o5;

    print(mm, " ", nn, " ", Ncond, " ", Dmn, " ", Dmpn, " ", Dm2pn2, " ", Dm2mn2, " ", Dprod, " ", o1, " ", o2, " ", o3, " ", o4, " ", o5);
  );
  print("");
  print("Total: ", total);
  print("D=-mn (sqfree) Heegner-ok: ", ok_mn);
  print("D=-(m+n) (sqfree) Heegner-ok: ", ok_mpn);
  print("D=-(m^2+n^2) (sqfree) Heegner-ok: ", ok_m2pn2);
  print("D=-(m^2-n^2) (sqfree) Heegner-ok: ", ok_m2mn2);
  print("D=-mn(m+n) (sqfree) Heegner-ok: ", ok_prod);
}
quit;
