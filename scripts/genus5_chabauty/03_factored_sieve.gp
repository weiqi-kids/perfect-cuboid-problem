\\ 03_factored_sieve.gp  (rewritten, careful PARI syntax)
\\ The ONLY PARI-feasible MW-sieve route on non-hyperelliptic genus-5 V_q:
\\ use the E_H+ elliptic quotient (carrying the rank-1 generator) and sieve the c-coordinate.
\\
\\ Logic: a rational point of V_q has c-coord c0; its E_H+ image is m*P + t (m in Z, t in tors),
\\ with X-coordinate = c0^2.  So c0^2 must equal X(m*P+t) for SOME group element.  Mod a good
\\ prime pr, the reachable X-values form a finite set S(pr) = {X(m*Pbar + tbar)}.  A global
\\ rational point needs c0^2 mod pr in S(pr), AND c0^2 is a square mod pr.  We intersect
\\ S(pr) with the quadratic residues and see if any NONZERO residue survives across primes.

default(parisize, 800000000);
default(parisizemax, 1200000000);

sqrtrat(r) = my(nn = numerator(r), dd = denominator(r)); sqrtint(nn)/sqrtint(dd);

q = 4/3;
A = q^2; B = 1; Cc = 1 + q^2;
EHp = ellinit([0, (A+B+Cc), 0, (A*B+A*Cc+B*Cc), (A*B*Cc)]);
w = sqrtrat(1+q^2);
P = [0, q*w];
Tdata = elltors(EHp);
print("E_H+ torsion order = ", Tdata[1]);

\\ Build explicit torsion point list over Q (small group, Z/4)
torsQ = List();
listput(torsQ, "O");
ntg = length(Tdata[3]);
if(ntg >= 1, g1 = Tdata[3][1]; o1 = ellorder(EHp, g1); for(ii = 1, o1-1, listput(torsQ, ellmul(EHp, g1, ii))));
torsQ = Vec(torsQ);
print("torsion points over Q (incl O): ", #torsQ);
print("");

\\ reachable X-residues mod a good prime pr
reachable_X(pr) = {
  my(Ep, Pbar, ordP, Sset, Q0, Tbar, R, tt);
  Ep = ellinit(EHp, pr);
  Pbar = ellmul(Ep, [Mod(0,pr), Mod(q*w, pr)], 1);
  ordP = ellorder(Ep, Pbar);
  if(ordP == 0, ordP = ellcard(Ep));
  Sset = Set([]);
  for(mm = 0, ordP-1,
    Q0 = ellmul(Ep, Pbar, mm);
    for(ti = 1, length(torsQ),
      tt = torsQ[ti];
      if(tt == "O",
        Tbar = [0]
      ,
        Tbar = ellmul(Ep, [Mod(tt[1],pr), Mod(tt[2],pr)], 1)
      );
      R = elladd(Ep, Q0, Tbar);
      if(R != [0],
        Sset = setunion(Sset, Set([lift(R[1])]))
      );
    );
  );
  Sset;
};

qr_set(pr) = {
  my(S = Set([]), cc);
  for(cc = 0, pr-1, S = setunion(S, Set([lift(Mod(cc,pr)^2)])));
  S;
};

primes_to_use = [11, 13, 19, 23, 29, 31, 37, 41, 43, 47, 53, 59, 61, 67, 71, 73];
goodp = select(pr -> (336 % pr != 0) && (denominator(q) % pr != 0), primes_to_use);
print("Good primes for sieve: ", goodp);
print("");

print("pr | #S(reachable X) | 0 in S? | #(QR cap S) | #nonzero survivors");
print("---|-----------------|---------|-------------|-------------------");
{
for(i = 1, length(goodp),
  my(pr = goodp[i], SX, QR, inter, nz);
  SX = reachable_X(pr);
  QR = qr_set(pr);
  inter = setintersect(SX, QR);
  nz = select(x -> x != 0, inter);
  print(pr, " | ", #SX, " | ", if(setsearch(SX, 0) > 0, "yes", "no"), " | ", #inter, " | ", #nz);
);
}
print("");
print("Note: '#nonzero survivors' counts residues r != 0 that are (a) a square mod pr AND");
print("(b) reachable as X(mP+t) mod pr.  If this stays LARGE across primes, the per-prime");
print("E_H+ image does NOT pin c=0.  See 04_analysis for the CRT-style intersection.");
quit;
