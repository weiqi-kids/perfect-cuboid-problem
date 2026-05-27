\\ 04_full_sieve.gp
\\ FULL factored MW-sieve on the c-coordinate, using ALL 5 elliptic factors.
\\
\\ Observation: every elliptic factor E_i is a (Z/2)-quotient of V_q, and the X-coordinate
\\ of phi_i(P) for P=(c,e,f,g) in V_q is a RATIONAL FUNCTION of c alone (the (Z/2)^3 cover
\\ is over the c-line; e,f,g only fix signs).  Explicitly:
\\   E_H+ : X = c^2
\\   E_H- : X = c^2 (odd part; same X-line, quartic)
\\   E_ef : the (ef,c) curve w^2 = (c^2+q^2)(c^2+1); its Weierstrass X is a function of c
\\   E_eg, E_fg : likewise.
\\ Therefore a rational point of V_q reduces, on EVERY factor and EVERY good prime pr, to a
\\ group element whose X-coord is a fixed function of (c mod pr).
\\
\\ For the generic fiber the 4 factors E_ef,E_eg,E_fg,E_H- are rank 0 => their Q-points are
\\ TORSION.  The reduction of V_q(Q) on each lands in reduction-of-torsion, a tiny set.
\\ E_H+ is rank 1 (generator P), so V_q(Q) reduces into <Pbar>+tors there.
\\
\\ SIEVE: For each good prime pr, compute
\\   Allowed_c(pr) = { c in F_pr : (c,*) lifts to V_q(F_pr) i.e. c^2+q^2, c^2+1, c^2+1+q^2 all squares }
\\ Then intersect with the constraint coming from the GLOBAL group on E_H+:
\\   c^2 must be an X-value reachable by <Pbar>+tors on E_H+(F_pr).
\\ (The 4 rank-0 factors give the SAME kind of constraint via their own X(c); but since their
\\  global points are torsion, the reachable X-set is even smaller.)
\\ The genuine MW-sieve question: after intersecting over many primes (CRT), is c=0 the only
\\ surviving GLOBAL c-class?

default(parisize, 800000000);
default(parisizemax, 1200000000);
sqrtrat(r) = my(nn = numerator(r), dd = denominator(r)); sqrtint(nn)/sqrtint(dd);

q = 4/3;
A = q^2; B = 1; Cc = 1 + q^2;
EHp = ellinit([0, (A+B+Cc), 0, (A*B+A*Cc+B*Cc), (A*B*Cc)]);
w = sqrtrat(1+q^2);
P = [0, q*w];

\\ torsion of E_H+ over Q
Td = elltors(EHp); torsQ = List(); listput(torsQ, "O");
ntg = length(Td[3]);
if(ntg >= 1, g1 = Td[3][1]; o1 = ellorder(EHp, g1); for(ii=1,o1-1, listput(torsQ, ellmul(EHp,g1,ii))));
torsQ = Vec(torsQ);

\\ c-values in F_pr that lift to V_q(F_pr)  (all three faces squares)
allowed_c(pr) = {
  my(L = List(), qm = Mod(q,pr), c, e2,f2,g2);
  for(c = 0, pr-1,
    e2 = Mod(c,pr)^2 + qm^2;
    f2 = Mod(c,pr)^2 + 1;
    g2 = Mod(c,pr)^2 + 1 + qm^2;
    if(issquare(e2) && issquare(f2) && issquare(g2), listput(L, c))
  );
  Set(Vec(L));
};

\\ X-residues reachable on E_H+ by global group <Pbar>+tors mod pr
reachable_X(pr) = {
  my(Ep, Pbar, ordP, Sset, Q0, Tbar, R, tt);
  Ep = ellinit(EHp, pr);
  Pbar = ellmul(Ep, [Mod(0,pr), Mod(q*w, pr)], 1);
  ordP = ellorder(Ep, Pbar); if(ordP==0, ordP = ellcard(Ep));
  Sset = Set([]);
  for(mm = 0, ordP-1,
    Q0 = ellmul(Ep, Pbar, mm);
    for(ti = 1, length(torsQ),
      tt = torsQ[ti];
      if(tt == "O", Tbar = [0], Tbar = ellmul(Ep,[Mod(tt[1],pr),Mod(tt[2],pr)],1));
      R = elladd(Ep, Q0, Tbar);
      if(R != [0], Sset = setunion(Sset, Set([lift(R[1])])))
    )
  );
  Sset;
};

\\ For a given prime, the surviving c-residues are:
\\   c in allowed_c(pr)  AND  c^2 in reachable_X(pr)
surviving_c(pr) = {
  my(AC = allowed_c(pr), RX = reachable_X(pr), L = List(), c);
  for(i = 1, length(AC),
    c = AC[i];
    if(setsearch(RX, lift(Mod(c,pr)^2)) > 0, listput(L, c))
  );
  Set(Vec(L));
};

primes_to_use = [11,13,19,23,29,31,37,41,43,47,53,59,61,67,71,73,79,83,89,97];
goodp = select(pr -> (336 % pr != 0) && (denominator(q) % pr != 0), primes_to_use);

print("Per-prime surviving c-residues (c in V_q(F_pr) AND c^2 reachable on E_H+ global image):");
print("pr | #allowed_c | #surviving_c | surviving residues (nonzero shown)");
print("---|-----------|--------------|------------------------------------");
survlist = List();
{
for(i = 1, length(goodp),
  my(pr = goodp[i], AC, SC, nz);
  AC = allowed_c(pr);
  SC = surviving_c(pr);
  nz = select(x -> x != 0, SC);
  listput(survlist, [pr, SC]);
  print(pr, " | ", #AC, " | ", #SC, " | nonzero: ", Vec(nz));
);
}
print("");

\\ --- CRT intersection: does requiring c == r_pr (mod pr) for compatible residues across
\\     all primes force c to be (the reduction of) 0 only? ---
\\ We check: is there a SINGLE nonzero residue class consistent across ALL primes that could
\\ be a small rational c?  We test small rational c = m/n, |m|,|n| <= 50, whether they survive
\\ ALL primes (this is the practical CRT test).
print("=== CRT test: which small rational c survive ALL primes' sieve? ===");
survlist = Vec(survlist);
test_c(c) = {
  my(ok = 1, pr, SCpr, cm);
  for(i = 1, length(survlist),
    pr = survlist[i][1]; SCpr = survlist[i][2];
    if(denominator(c) % pr == 0, next);  \\ skip prime dividing denom
    cm = lift(Mod(c, pr));
    if(setsearch(SCpr, cm) == 0, ok = 0; break)
  );
  ok;
};
cnt_survive = 0; survivors = List();
{
for(m = -50, 50,
  for(n = 1, 50,
    if(gcd(m,n)==1,
      my(c = m/n);
      if(test_c(c), cnt_survive++; if(#survivors < 30, listput(survivors, c)))
    )
  )
);
}
print("Small rational c (|m|,|n|<=50) surviving ALL ", #goodp, " primes: ", cnt_survive);
print("First survivors: ", Vec(survivors));
print("");
print("(c=0 is the degenerate locus. Any OTHER survivor that is a genuine V_q(Q) point would");
print(" be a real PCP-relevant point; survivors that are NOT in V_q(Q) are sieve residue ghosts.)");
quit;
