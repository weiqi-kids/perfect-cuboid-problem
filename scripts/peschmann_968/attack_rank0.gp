\\ attack_rank0.gp
\\ Trivial closure for rank-0 fibers: by Lemma 1, the torsion subgroup
\\ of E_PCP(q) for any Pythagorean q is trivial in the Face-3 sense
\\ (cf. LEMMA-1-UNIVERSAL-TORSION.md). With rk = 0, E(Q) = E(Q)_tors and
\\ there are no infinite-order rational points; checking the (finite)
\\ torsion subgroup directly is sufficient.
\\
\\ This script verifies the torsion subgroup of every rank-0 E_PCP(q) and
\\ checks Face-3 at each torsion point (excluding identity).

default(parisize, 1500000000);
default(timer, 0);

\\ face3_is_square: return 1 only for a *nontrivial* Face-3 hit, i.e.
\\   - c is a nonzero rational, and
\\   - a3 = c^2 + 1 + q^2 is a rational square.
\\ Returns 0 for "no hit", -1 for identity, -2 for vertical line (denom = 0),
\\ -3 for the trivial torsion case c = 0 (Y = 0 on the curve).
face3_is_square(q, pt) = {
  my(X, Y, denom, c, a3, num, den);
  if(pt == [0], return(-1));
  X = pt[1];
  Y = pt[2];
  denom = q^2 - X^2;
  if(denom == 0, return(-2));
  c = 2 * Y * q / denom;
  if(c == 0, return(-3));    \\ Y = 0 torsion: degenerate (gives a3 = 1+q^2, not a 3D solution)
  a3 = c^2 + 1 + q^2;
  if(a3 == 0, return(0));
  num = numerator(a3);
  den = denominator(a3);
  return(issquare(num) * issquare(den));
};

attack_rank0(mm, nn) = {
  my(q, E, T, n_tors, hits, sq);
  q = (mm^2 - nn^2) / (2 * mm * nn);
  E = ellinit([0, 1 + q^2, 0, q^2, 0]);
  T = elltors(E);
  n_tors = T[1];
  hits = 0;
  \\ Iterate over all torsion points of the group (i.e. all combinations
  \\ of generators T[3] with multipliers in their respective cyclic orders)
  if(n_tors > 0 && #T[2] >= 1,
    \\ T[2] is the list of cyclic orders, T[3] the generators.
    if(#T[2] == 1,
      \\ Cyclic torsion group
      n1 = T[2][1];
      g1 = T[3][1];
      for(a = 1, n1 - 1,
        kP = ellmul(E, g1, a);
        if(kP != [0],
          sq = face3_is_square(q, kP);
          if(sq == 1, hits = hits + 1);
        );
      );
    ,
      \\ Z/n1 x Z/n2 case (n_tors = n1 * n2)
      n1 = T[2][1]; n2 = T[2][2];
      g1 = T[3][1]; g2 = T[3][2];
      for(a = 0, n1 - 1,
        for(b = 0, n2 - 1,
          if(a == 0 && b == 0, next);
          aG = if(a == 0, [0], ellmul(E, g1, a));
          bG = if(b == 0, [0], ellmul(E, g2, b));
          if(aG == [0], R = bG,
             if(bG == [0], R = aG,
                R = elladd(E, aG, bG)));
          if(R != [0],
            sq = face3_is_square(q, R);
            if(sq == 1, hits = hits + 1);
          );
        );
      );
    );
  );
  return([mm, nn, q, "CLOSED_RANK0", n_tors, hits]);
};

{
lines = readstr("epcp_rank0.txt");
pairs = List();
for(i = 1, #lines,
  ln = lines[i];
  if(ln == "" || Vecsmall(ln)[1] == 35, next);
  pieces = strsplit(ln, " ");
  if(#pieces >= 2,
    listput(pairs, [eval(pieces[1]), eval(pieces[2])]);
  );
);
print("Loaded ", #pairs, " rank-0 candidate pairs.");

write("attack_rank0_results.txt",
  "# m  n  q  status  tors_order  n_hits");

closed = 0; hits_count = 0;
for(i = 1, #pairs,
  p = pairs[i];
  res = iferr(attack_rank0(p[1], p[2]), ERR,
              [p[1], p[2], 0, "ERROR", 0, 0]);
  if(res[4] == "CLOSED_RANK0" && res[6] == 0, closed = closed + 1);
  if(res[6] > 0, hits_count = hits_count + 1);
  write("attack_rank0_results.txt",
        res[1], " ", res[2], " ", res[3], " ", res[4], " ", res[5], " ", res[6]);
  if(i % 100 == 0,
    print("  rank0 attacked ", i, "/", #pairs,
          " closed=", closed, " hits=", hits_count);
  );
);
print("");
print("=== Rank-0 attack summary ===");
print("Total rank-0 pairs       : ", #pairs);
print("CLOSED_RANK0 (no Face-3): ", closed);
print("HIT_RANK0 (Face-3 hit)   : ", hits_count);
}

quit;
