\\ enum_epcp_fast.gp
\\ Fast enumeration using ellrank(_, 1) instead of ellanalyticrank.
\\ Gives sharp lower/upper rank bounds in nearly all cases via 2-Selmer.
\\
\\ Output:
\\   epcp_rank0.txt : (m, n, cond) for E_PCP(q) with rank_up = 0
\\   epcp_rank1.txt : (m, n, cond) for E_PCP(q) of rank exactly 1 (lo=up=1)
\\   epcp_rank2.txt : (m, n, cond) for E_PCP(q) of rank exactly 2 (lo=up=2)
\\   epcp_rankhi.txt: (m, n, cond, lo, up) for rank >= 3 (HARD)
\\   epcp_rank_ambig.txt : (m, n, cond, lo, up) for cases lo < up (Sha guess)
\\   epcp_errored.txt    : (m, n) for errored computations
\\
\\ Also writes incrementally so partial results are visible.

default(parisize, 3000000000);
default(timer, 0);

epcp_rank_fast(mm, nn) = {
  my(q, E, Emin, cond, rk);
  q = (mm^2 - nn^2) / (2 * mm * nn);
  E = ellinit([0, 1 + q^2, 0, q^2, 0]);
  Emin = ellminimalmodel(E);
  cond = ellglobalred(Emin)[1];
  rk = ellrank(Emin, 1);
  return([cond, rk[1], rk[2]]);
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

\\ Initialise output files with headers
write("epcp_rank0.txt", "# m  n  cond");
write("epcp_rank1.txt", "# m  n  cond");
write("epcp_rank2.txt", "# m  n  cond");
write("epcp_rankhi.txt", "# m  n  cond  lo  up");
write("epcp_rank_ambig.txt", "# m  n  cond  lo  up");
write("epcp_errored.txt", "# m  n");

r0 = 0; r1 = 0; r2 = 0; rhi = 0; ramb = 0; err = 0;
count_done = 0;
for(idx = 1, #master,
  pair = master[idx];
  mm = pair[1];
  nn = pair[2];
  res = iferr(epcp_rank_fast(mm, nn), ERR, [-1, -1, -1]);
  cond = res[1]; lo = res[2]; up = res[3];
  if(cond < 0,
    write("epcp_errored.txt", mm, " ", nn);
    err = err + 1;
  ,
    if(up == 0,
      write("epcp_rank0.txt", mm, " ", nn, " ", cond);
      r0 = r0 + 1;
    ,
      if(lo == 1 && up == 1,
        write("epcp_rank1.txt", mm, " ", nn, " ", cond);
        r1 = r1 + 1;
      ,
        if(lo == 2 && up == 2,
          write("epcp_rank2.txt", mm, " ", nn, " ", cond);
          r2 = r2 + 1;
        ,
          if(lo >= 3,
            write("epcp_rankhi.txt", mm, " ", nn, " ", cond, " ", lo, " ", up);
            rhi = rhi + 1;
          ,
            \\ ambiguous: lo < up
            write("epcp_rank_ambig.txt", mm, " ", nn, " ", cond, " ", lo, " ", up);
            ramb = ramb + 1;
          );
        );
      );
    );
  );
  count_done = count_done + 1;
  if(count_done % 100 == 0,
    print("  ", count_done, "/", #master,
          " r0=", r0, " r1=", r1, " r2=", r2,
          " r3+=", rhi, " ambig=", ramb, " err=", err);
  );
);
print("");
print("=== Fast enumeration done ===");
print("Rank 0     : ", r0);
print("Rank 1     : ", r1);
print("Rank 2     : ", r2);
print("Rank >= 3  : ", rhi);
print("Ambiguous (lo<up, possible Sha): ", ramb);
print("Errored    : ", err);
}

quit;
