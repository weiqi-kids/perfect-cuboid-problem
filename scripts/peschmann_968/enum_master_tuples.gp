\\ enum_master_tuples.gp
\\ Enumerate the 2,040 master tuples (m, n) with
\\   1 <= n < m <= 100, gcd(m, n) = 1, (m - n) odd.
\\ Build a *candidate* OPEN list using a proxy for "rank >= 1 on all three
\\ Klein-four quotients" of H_{m,n} (Peschmann arXiv:2604.28072).
\\
\\ Proxy: three curves derived from c(s) = (s^4 - 6s^2 + 1)/(1+s^2)^2,
\\        A = 2 - 4 c^2, with s = m/n:
\\   E1 : y^2 = x^3 + A x^2 - 4 x - 4 A     (= (x+A)(x-2)(x+2))
\\   E2 : y^2 = x^3 - A x^2 - 4 x + 4 A     ((-1)-twist of E1)
\\   E3 : y^2 = x^3 - (1+s^2) x^2 + s^2 x   (Pythagorean Frey-like, s=m/n)
\\
\\ If ALL THREE analytic ranks are >= 1 then (m,n) is CANDIDATE OPEN.

default(parisize, 1500000000);
default(timer, 0);

process_pair(mm, nn) = {
  my(ss, cs, AA, EC1, EC2, EC3, r1, r2, r3);
  ss = mm/nn;
  cs = (ss^4 - 6*ss^2 + 1) / (1 + ss^2)^2;
  AA = 2 - 4 * cs^2;
  EC1 = ellinit([0, AA, 0, -4, -4*AA]);
  EC2 = ellinit([0, -AA, 0, -4, 4*AA]);
  EC3 = ellinit([0, -(1 + ss^2), 0, ss^2, 0]);
  r1 = ellanalyticrank(EC1)[1];
  r2 = ellanalyticrank(EC2)[1];
  r3 = ellanalyticrank(EC3)[1];
  return([r1, r2, r3]);
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
print("Master tuples (m,n), 1<=n<m<=100, gcd=1, m-n odd: ", #master);

candidate_open = List();
all_closed     = List();
zerorank       = List();
errored        = List();

count_done = 0;
for(idx = 1, #master,
  pair = master[idx];
  mm = pair[1];
  nn = pair[2];
  ranks = iferr(process_pair(mm, nn), ERR, [-1, -1, -1]);
  r1 = ranks[1]; r2 = ranks[2]; r3 = ranks[3];
  if(r1 < 0,
    listput(errored, [mm, nn]);
  ,
    if(r1 >= 1 && r2 >= 1 && r3 >= 1,
      listput(candidate_open, [mm, nn, r1, r2, r3]);
    ,
      if(r1 == 0 && r2 == 0 && r3 == 0,
        listput(zerorank, [mm, nn]);
      ,
        listput(all_closed, [mm, nn, r1, r2, r3]);
      );
    );
  );
  count_done = count_done + 1;
  if(count_done % 50 == 0,
    print("  processed ", count_done, "/", #master,
          "; cand_open=", #candidate_open,
          ", peschmann_closed=", #all_closed,
          ", zerorank=", #zerorank,
          ", errored=", #errored);
  );
);

print();
print("=== Enumeration result ===");
print("Total master tuples         : ", #master);
print("Candidate OPEN (r1,r2,r3>=1): ", #candidate_open);
print("Peschmann CLOSED (some r=0) : ", #all_closed);
print("All-zero-rank (extra closed): ", #zerorank);
print("Errored (skipped)           : ", #errored);
print();

write("candidate_open.txt", "# m  n  r1(E1)  r2(E2)  r3(E3)");
for(i = 1, #candidate_open,
  p = candidate_open[i];
  write("candidate_open.txt", p[1], " ", p[2], " ", p[3], " ", p[4], " ", p[5]);
);

write("peschmann_closed.txt", "# m  n  r1  r2  r3");
for(i = 1, #all_closed,
  p = all_closed[i];
  write("peschmann_closed.txt", p[1], " ", p[2], " ", p[3], " ", p[4], " ", p[5]);
);

write("zerorank.txt", "# m  n");
for(i = 1, #zerorank,
  p = zerorank[i];
  write("zerorank.txt", p[1], " ", p[2]);
);

if(#errored > 0,
  write("errored.txt", "# m  n");
  for(i = 1, #errored,
    p = errored[i];
    write("errored.txt", p[1], " ", p[2]);
  );
);
}

quit;
