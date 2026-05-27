\\ Post-process rank_survey_m100.out
\\ Read lines of the form: m n m+n N ar mn_prime m2n2_prime
\\ Run with: gp -q analyze_survey.gp

default(realprecision, 20);

read_data(path) = {
  my(L, V);
  L = readstr(path);
  V = List();
  for(i = 1, #L,
    my(s = L[i]);
    \\ skip non-data lines
    if(#s == 0 || strchr(Vec(s)[1]) == "=" || s == "" || !isdigit_first(s),
       next);
    my(tok = strsplit(s, " "));
    if(#tok < 7, next);
    listput(V, [eval(tok[1]), eval(tok[2]), eval(tok[3]),
                eval(tok[4]), eval(tok[5]), eval(tok[6]), eval(tok[7])]);
  );
  V;
};

isdigit_first(s) = my(c = Vec(s)[1]); c >= "0" && c <= "9";

\\ Simpler: just use system tools via PARI's externstr
data = externstr("grep -E '^[0-9]' /root/proof/perfect-cuboid-problem/scripts/rank_survey_m100.out");
print("Rows: ", #data);

records = vector(#data);
for(i = 1, #data,
  tok = strsplit(data[i], " ");
  records[i] = vector(#tok, j, eval(tok[j]));
);

total = #records;
print("total fibers parsed: ", total);

\\ rank distribution
cnt = vector(8);
for(i = 1, total,
  r = records[i][5];
  if(r >= 0 && r <= 6, cnt[r+1]++);
);
for(k = 0, 6, print("rank ", k, ": ", cnt[k+1]));

\\ rank >= 3?
print();
print("=== RANK >= 3 ===");
high = 0;
for(i = 1, total,
  if(records[i][5] >= 3,
    high++;
    print("HIGH: ", records[i]);
  );
);
if(high == 0, print("NONE — rank<=2 conjecture survives."));

\\ m+n prime correlation for rank >= 1
print();
print("=== M+N PRIME (rank>=1) ===");
jump = 0; mn_p = 0; non_mn = List();
for(i = 1, total,
  if(records[i][5] >= 1,
    jump++;
    if(records[i][6] == 1, mn_p++, listput(non_mn, records[i]));
  );
);
print("rank>=1 total: ", jump);
print("  m+n prime  : ", mn_p);
print("  m+n composite: ", #non_mn);
print("counterexamples to 'rank>=1 => m+n prime':");
for(i = 1, #non_mn, print("  ", non_mn[i]));

\\ rank = 2 specifically
print();
print("=== M+N PRIME (rank=2 only) ===");
r2 = 0; r2_p = 0; r2_non = List();
for(i = 1, total,
  if(records[i][5] == 2,
    r2++;
    if(records[i][6] == 1, r2_p++, listput(r2_non, records[i]));
  );
);
print("rank=2 total: ", r2);
print("  m+n prime  : ", r2_p);
print("  m+n composite: ", #r2_non);
for(i = 1, #r2_non, print("  ", r2_non[i]));

\\ m^2 + n^2 prime correlation
print();
print("=== m^2+n^2 PRIME (rank>=1) ===");
ss = 0;
for(i = 1, total,
  if(records[i][5] >= 1 && records[i][7] == 1, ss++);
);
print("rank>=1 with m^2+n^2 prime: ", ss, " / ", jump);

ss0 = 0; r0 = 0;
for(i = 1, total,
  if(records[i][5] == 0,
    r0++;
    if(records[i][7] == 1, ss0++);
  );
);
print("rank=0 with m^2+n^2 prime: ", ss0, " / ", r0);

\\ m = n+1 sub-family
print();
print("=== m = n+1 sub-family ===");
for(i = 1, total,
  if(records[i][1] == records[i][2] + 1,
    print("  ", records[i]);
  );
);

\\ mod-4 / mod-8 of rank>=1
print();
print("=== mod-4 m%4, n%4 of rank>=1 fibers ===");
c4 = matrix(4, 4);
for(i = 1, total,
  if(records[i][5] >= 1,
    c4[records[i][1]%4 + 1, records[i][2]%4 + 1]++;
  );
);
print("rows = m%4 (0..3), cols = n%4 (0..3):");
for(a = 0, 3, print("  m%4=", a, ": ", vector(4, b, c4[a+1, b])));

\\ rank=2 mod-4
print();
print("=== rank=2 mod 4 ===");
c4r = matrix(4, 4);
for(i = 1, total,
  if(records[i][5] == 2,
    c4r[records[i][1]%4 + 1, records[i][2]%4 + 1]++;
  );
);
for(a = 0, 3, print("  m%4=", a, ": ", vector(4, b, c4r[a+1, b])));

\\ m * n divisibility patterns for rank=2
print();
print("=== rank=2 (m,n) tuples + factorizations ===");
for(i = 1, total,
  if(records[i][5] == 2,
    m = records[i][1]; n = records[i][2];
    print("  m=", m, " n=", n, " m+n=", m+n,
          " m*n=", m*n,
          " m-n=", m-n,
          " factor(m)=", factor(m)[,1]~,
          " factor(n)=", factor(n)[,1]~,
          " factor(m+n)=", factor(m+n)[,1]~);
  );
);

\\ rank distribution by w (root number is encoded in parity of analytic rank for elliptic; we can extract)
\\ w = +1 <=> ar even
print();
print("=== root number parity vs rank ===");
weven = 0; wodd = 0;
for(i = 1, total,
  if(records[i][5] % 2 == 0, weven++, wodd++);
);
print("ar even (w=+1): ", weven, "  ar odd (w=-1): ", wodd);
print("ratio: ", weven*1.0/total);

quit;
