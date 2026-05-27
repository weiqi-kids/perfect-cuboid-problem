\\ attack_candidates.gp
\\ For each (m, n) flagged as CANDIDATE OPEN by enum_master_tuples.gp,
\\ run the Silverman/Ingram-Mahé closure on E_PCP(q) with
\\   q = (m^2 - n^2) / (2 m n)  (Pythagorean parameterization).
\\
\\ E_PCP(q):  Y^2 = X(X+1)(X+q^2) = X^3 + (1+q^2) X^2 + q^2 X.
\\
\\ Strategy per fiber (see SILVERMAN-RANK-JUMP-CLOSURE.md):
\\   r = 0 -> CLOSED_RANK0 by Lemma 1 (torsion-only Mordell-Weil).
\\   r = 1 -> direct n = 1..NMAX check; if NMAX >= rigorous N_0 then CLOSED.
\\   r = 2 -> [a,b] box scan |a|,|b| <= NBOX; if NBOX >= rigorous B then CLOSED.
\\   r >= 3 -> mark HARD (needs quadratic Chabauty / CR rank-3 method).
\\
\\ We use NMAX = 12, NBOX = 8 as a quick first pass. Rigorous N_0 typically
\\ <= 8 (cf. §6 of the closure note); rigorous B for rank 2 typically
\\ <= 58 (cf. §7). The first pass quickly classifies; HARD-flagged or
\\ borderline cases get rechecked with the full B-bound in attack_hard.gp.

default(parisize, 3000000000);
default(timer, 0);

NMAX = 12;
NBOX = 8;

\\ Construct E_PCP(q): Y^2 = X^3 + (1+q^2) X^2 + q^2 X.
build_epcp(q) = {
  my(E, Emin, gr, cond, ar);
  E = ellinit([0, 1 + q^2, 0, q^2, 0]);
  return(E);
};

face3_check(q, pt) = {
  my(X, Y, denom, c, a3);
  if(pt == [0], return(-1));
  X = pt[1];
  Y = pt[2];
  denom = q^2 - X^2;
  if(denom == 0, return(-2));
  c = 2 * Y * q / denom;
  a3 = c^2 + 1 + q^2;
  if(a3 == 0, return(0));
  return(issquare(numerator(a3)) * issquare(denominator(a3)));
};

direct_rank1_scan(E, P0, q, NMAX) = {
  my(nP, hits, fc);
  hits = List();
  nP = P0;
  for(n = 1, NMAX,
    fc = face3_check(q, nP);
    if(fc == 1, listput(hits, n));
    if(n < NMAX, nP = elladd(E, nP, P0));
  );
  return(hits);
};

direct_rank2_scan(E, G1, G2, q, NBOX) = {
  my(hits, R, aG, bG, fc);
  hits = List();
  for(a = -NBOX, NBOX,
    if(a == 0, aG = [0], aG = ellmul(E, G1, a));
    for(b = -NBOX, NBOX,
      if(a == 0 && b == 0, next);
      if(b == 0, bG = [0], bG = ellmul(E, G2, b));
      if(aG == [0], R = bG,
         if(bG == [0], R = aG,
            R = elladd(E, aG, bG)));
      if(R == [0], next);
      fc = face3_check(q, R);
      if(fc == 1, listput(hits, [a, b]));
    );
  );
  return(hits);
};

\\ One-shot attack on (m, n).
attack_pair(mm, nn) = {
  my(q, E, Emin, gr, cond, ar, rk, gens, P0, G1, G2, hits, status);
  q = (mm^2 - nn^2) / (2 * mm * nn);
  E = ellinit([0, 1 + q^2, 0, q^2, 0]);
  Emin = ellminimalmodel(E, &v);
  gr = ellglobalred(Emin);
  cond = gr[1];
  ar = ellanalyticrank(Emin)[1];
  status = "UNKNOWN";
  if(ar == 0,
    status = "CLOSED_RANK0";
    return([mm, nn, q, cond, ar, status, 0, 0]);
  );
  if(ar == 1,
    \\ rank 1: try ellheegner first, fall back to ellrank.
    rk = iferr(ellheegner(Emin), ERR, 0);
    if(rk == 0,
      rk_res = iferr(ellrank(Emin, 4), ERR, [-1, -1, []]);
      if(rk_res[1] == 1 && #rk_res[3] >= 1,
        gens = rk_res[3];
      ,
        return([mm, nn, q, cond, ar, "HARD_NO_GEN", 0, 0]);
      );
    ,
      gens = [rk];
    );
    P0_min = gens[1];
    P0 = ellchangepointinv(P0_min, v);
    if(!ellisoncurve(E, P0),
      return([mm, nn, q, cond, ar, "HARD_OFF_CURVE", 0, 0]);
    );
    hits = direct_rank1_scan(E, P0, q, NMAX);
    if(#hits == 0,
      status = "CLOSED_RANK1";
    ,
      status = "HIT_RANK1";
    );
    return([mm, nn, q, cond, ar, status, NMAX, #hits]);
  );
  if(ar == 2,
    rk_res = iferr(ellrank(Emin, 4), ERR, [-1, -1, []]);
    if(rk_res[1] >= 2 && #rk_res[3] >= 2,
      G1m = rk_res[3][1];
      G2m = rk_res[3][2];
      G1 = ellchangepointinv(G1m, v);
      G2 = ellchangepointinv(G2m, v);
      hits = direct_rank2_scan(E, G1, G2, q, NBOX);
      if(#hits == 0,
        status = "CLOSED_RANK2";
      ,
        status = "HIT_RANK2";
      );
      return([mm, nn, q, cond, ar, status, NBOX, #hits]);
    ,
      return([mm, nn, q, cond, ar, "HARD_RANK2_NO_GENS", 0, 0]);
    );
  );
  \\ ar >= 3
  return([mm, nn, q, cond, ar, "HARD_RANK3+", 0, 0]);
};

\\ Load candidate list and process.
{
lines = readstr("candidate_open.txt");
candidates = List();
for(i = 1, #lines,
  ln = lines[i];
  if(ln == "" || Vecsmall(ln)[1] == 35, next);   \\ skip comment '#'
  \\ split by spaces
  pieces = strsplit(ln, " ");
  if(#pieces >= 2,
    mm = eval(pieces[1]);
    nn = eval(pieces[2]);
    listput(candidates, [mm, nn]);
  );
);
print("Loaded ", #candidates, " candidate-open pairs.");

results = List();
counts = Map();
counts["CLOSED_RANK0"] = 0;
counts["CLOSED_RANK1"] = 0;
counts["CLOSED_RANK2"] = 0;
counts["HIT_RANK1"] = 0;
counts["HIT_RANK2"] = 0;
counts["HARD_RANK3+"] = 0;
counts["HARD_NO_GEN"] = 0;
counts["HARD_OFF_CURVE"] = 0;
counts["HARD_RANK2_NO_GENS"] = 0;
counts["ERROR"] = 0;

write("attack_results.txt",
  "# m  n  q  cond  ar  status  scan_param  #hits");

for(i = 1, #candidates,
  pair = candidates[i];
  mm = pair[1]; nn = pair[2];
  res = iferr(attack_pair(mm, nn), ERR, [mm, nn, 0, 0, -1, "ERROR", 0, 0]);
  listput(results, res);
  status = res[6];
  counts[status] = counts[status] + 1;
  write("attack_results.txt",
        res[1], " ", res[2], " ", res[3], " ", res[4], " ",
        res[5], " ", res[6], " ", res[7], " ", res[8]);
  if(i % 10 == 0,
    print("  attacked ", i, "/", #candidates,
          "; rank0=", counts["CLOSED_RANK0"],
          ", rank1=", counts["CLOSED_RANK1"],
          ", rank2=", counts["CLOSED_RANK2"],
          ", hard3+=", counts["HARD_RANK3+"],
          ", hardother=", counts["HARD_NO_GEN"] + counts["HARD_RANK2_NO_GENS"] + counts["HARD_OFF_CURVE"],
          ", hits=", counts["HIT_RANK1"] + counts["HIT_RANK2"],
          ", err=", counts["ERROR"]);
  );
);

print();
print("=== Attack summary ===");
print("Total candidates : ", #candidates);
print("CLOSED_RANK0    : ", counts["CLOSED_RANK0"]);
print("CLOSED_RANK1    : ", counts["CLOSED_RANK1"]);
print("CLOSED_RANK2    : ", counts["CLOSED_RANK2"]);
print("HIT_RANK1       : ", counts["HIT_RANK1"]);
print("HIT_RANK2       : ", counts["HIT_RANK2"]);
print("HARD_RANK3+     : ", counts["HARD_RANK3+"]);
print("HARD_NO_GEN     : ", counts["HARD_NO_GEN"]);
print("HARD_RANK2_NO_GENS : ", counts["HARD_RANK2_NO_GENS"]);
print("HARD_OFF_CURVE  : ", counts["HARD_OFF_CURVE"]);
print("ERROR           : ", counts["ERROR"]);
}

quit;
