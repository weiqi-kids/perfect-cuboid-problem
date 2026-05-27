\\ Check ellrank return structure
default(parisize, 4000000000);
default(realprecision, 38);

testcase(mm, nn) =
{
  my(q = (mm^2 - nn^2) / (2 * mm * nn));
  my(E = ellinit([0, 1 + q^2, 0, q^2, 0]));
  my(v, Emin = ellminimalmodel(E, &v));
  my(NE = ellglobalred(Emin)[1]);
  print("(", mm, ",", nn, ") cond=", NE);
  my(rkdata = iferr(ellrank(Emin, 4), ERR, "ERR"));
  print("  ellrank(Emin, 4) = ", rkdata);
}

testcase(99, 98);
testcase(50, 1);
testcase(89, 2);
quit;
