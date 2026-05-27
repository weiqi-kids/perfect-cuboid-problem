\\ enum_quick.gp
\\ Quick screening: for each of 2,040 master tuples, compute root number
\\ (parity of rank) and a fast 2-Selmer-based ellrank lower bound.
\\ This bypasses the slow ellanalyticrank.
\\
\\ Output:
\\   quick_classes.txt: m  n  rootno  rank_lo  rank_up  cond
\\ Conjectural rank under BSD: rank = ((1 - rootno)/2 mod 2) etc., but we
\\ just record the bounds.

default(parisize, 3000000000);
default(timer, 0);

quick_class(mm, nn) = {
  my(q, E, Emin, cond, rno, rk);
  q = (mm^2 - nn^2) / (2 * mm * nn);
  E = ellinit([0, 1 + q^2, 0, q^2, 0]);
  Emin = ellminimalmodel(E);
  cond = ellglobalred(Emin)[1];
  rno = ellrootno(Emin);
  \\ ellrank with effort 0: only 2-Selmer bound.
  rk = iferr(ellrank(Emin, 0), ERR, [-1, -1, []]);
  return([cond, rno, rk[1], rk[2]]);
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

write("quick_classes.txt", "# m  n  rootno  rank_lo  rank_up  cond");

count_done = 0;
class_counts = vector(8);
\\ index 1=rno-1_lo0, 2=rno-1_lo1, 3=rno-1_lohi, 4=rno+1_lo0, 5=rno+1_lo1, ...
\\ track separately
for(idx = 1, #master,
  pair = master[idx];
  mm = pair[1]; nn = pair[2];
  res = iferr(quick_class(mm, nn), ERR, [-1, 0, -1, -1]);
  cond = res[1]; rno = res[2]; rlo = res[3]; rup = res[4];
  write("quick_classes.txt", mm, " ", nn, " ", rno, " ", rlo, " ", rup, " ", cond);
  count_done = count_done + 1;
  if(count_done % 100 == 0,
    print("  ", count_done, "/", #master);
  );
);
print("Quick screening done.");
}

quit;
