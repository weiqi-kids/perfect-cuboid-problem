\\ enum_epcp.gp
\\ Enumerate all 2,040 master tuples (m, n) with
\\   1 <= n < m <= 100, gcd(m, n) = 1, (m - n) odd.
\\ For each, compute analytic rank of
\\   E_PCP(q):  Y^2 = X^3 + (1+q^2) X^2 + q^2 X,
\\ where q = (m^2 - n^2) / (2 m n).  This is a single rank computation
\\ per master tuple (vs three for the Klein-four proxy in
\\ enum_master_tuples.gp), making it ~3x faster.
\\
\\ Outputs:
\\   epcp_rank0.txt : (m, n, cond) for E_PCP(q) of rank 0 (Lemma 1 closes)
\\   epcp_rank1.txt : (m, n, cond) for E_PCP(q) of rank 1
\\   epcp_rank2.txt : (m, n, cond) for E_PCP(q) of rank 2
\\   epcp_rankhi.txt: (m, n, cond, ar) for E_PCP(q) of rank >= 3 (HARD)
\\   epcp_errored.txt: (m, n) for errored computations

default(parisize, 2500000000);
default(timer, 0);

epcp_rank(mm, nn) = {
  my(q, E, Emin, cond, ar);
  q = (mm^2 - nn^2) / (2 * mm * nn);
  E = ellinit([0, 1 + q^2, 0, q^2, 0]);
  Emin = ellminimalmodel(E);
  cond = ellglobalred(Emin)[1];
  ar = ellanalyticrank(Emin)[1];
  return([cond, ar]);
};

{
master = List();
for(m = 2, 100,
  for(n = 1, m-1,
    if(gcd(m, n) == 1 && ((m - n) % 2 == 1),
      listput(master, [m, n]);
    );
  );
);
print("Master tuples: ", #master);
print("");

rank0 = List();
rank1 = List();
rank2 = List();
rankhi = List();
errored = List();

count_done = 0;
for(idx = 1, #master,
  pair = master[idx];
  mm = pair[1];
  nn = pair[2];
  res = iferr(epcp_rank(mm, nn), ERR, [-1, -1]);
  cond = res[1];
  ar = res[2];
  if(cond < 0,
    listput(errored, [mm, nn]);
  ,
    if(ar == 0,
      listput(rank0, [mm, nn, cond]);
    ,
      if(ar == 1,
        listput(rank1, [mm, nn, cond]);
      ,
        if(ar == 2,
          listput(rank2, [mm, nn, cond]);
        ,
          listput(rankhi, [mm, nn, cond, ar]);
        );
      );
    );
  );
  count_done = count_done + 1;
  if(count_done % 50 == 0,
    print("  ", count_done, "/", #master,
          " r0=", #rank0, " r1=", #rank1, " r2=", #rank2,
          " r3+=", #rankhi, " err=", #errored);
  );
);

print("");
print("=== E_PCP rank distribution over the 2,040 master tuples ===");
print("Rank 0   : ", #rank0);
print("Rank 1   : ", #rank1);
print("Rank 2   : ", #rank2);
print("Rank >=3 : ", #rankhi);
print("Errored  : ", #errored);

write("epcp_rank0.txt", "# m  n  cond");
for(i = 1, #rank0,
  p = rank0[i];
  write("epcp_rank0.txt", p[1], " ", p[2], " ", p[3]);
);

write("epcp_rank1.txt", "# m  n  cond");
for(i = 1, #rank1,
  p = rank1[i];
  write("epcp_rank1.txt", p[1], " ", p[2], " ", p[3]);
);

write("epcp_rank2.txt", "# m  n  cond");
for(i = 1, #rank2,
  p = rank2[i];
  write("epcp_rank2.txt", p[1], " ", p[2], " ", p[3]);
);

write("epcp_rankhi.txt", "# m  n  cond  ar");
for(i = 1, #rankhi,
  p = rankhi[i];
  write("epcp_rankhi.txt", p[1], " ", p[2], " ", p[3], " ", p[4]);
);

if(#errored > 0,
  write("epcp_errored.txt", "# m  n");
  for(i = 1, #errored,
    p = errored[i];
    write("epcp_errored.txt", p[1], " ", p[2]);
  );
);
}

quit;
