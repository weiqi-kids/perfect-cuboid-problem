\\ attack_ambig.gp
\\ Resolve the 17 cases where ellrank(_, 1) gave lo=0, up=2.
\\ Try ellrank with higher effort to determine the exact rank.

default(parisize, 4000000000);
default(timer, 0);

resolve_ambig(mm, nn) = {
  my(q, E, Emin, v, rk);
  q = (mm^2 - nn^2) / (2 * mm * nn);
  E = ellinit([0, 1 + q^2, 0, q^2, 0]);
  Emin = ellminimalmodel(E, &v);
  rk = iferr(ellrank(Emin, 3), ERR, [-1, -1, 0, []]);
  return([mm, nn, q, rk[1], rk[2], #rk[4]]);
};

{
lines = readstr("epcp_rank_ambig.txt");
ambig = List();
for(i = 1, #lines,
  ln = lines[i];
  if(ln == "" || Vecsmall(ln)[1] == 35, next);
  pieces = strsplit(ln, " ");
  if(#pieces >= 2,
    listput(ambig, [eval(pieces[1]), eval(pieces[2])]);
  );
);
print("Loaded ", #ambig, " ambiguous pairs.");

write("ambig_resolved.txt", "# m  n  q  lo_new  up_new  n_gens");
for(i = 1, #ambig,
  p = ambig[i];
  res = iferr(resolve_ambig(p[1], p[2]), ERR, [p[1], p[2], 0, -1, -1, 0]);
  write("ambig_resolved.txt",
        res[1], " ", res[2], " ", res[3], " ", res[4], " ", res[5], " ", res[6]);
  print("  (", res[1], ",", res[2], ") lo=", res[4], " up=", res[5], " gens=", res[6]);
);
}
quit;
