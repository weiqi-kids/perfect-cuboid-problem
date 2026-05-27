\\ ============================================================
\\ Paper B, Script 03: the clean genus-2 model of C_q, its Jacobian
\\ Jac(C_q) ~ X+ x X- (both rank 0), |Jac(C_q)(Q)|, and rational points.
\\
\\ Clean model (cleared of the sqrt(5) twist):
\\   C_q : W^2 = u (5u^2 - 16u + 20)(u^2 + 4).
\\ Note on C: u=q^2, f1=5u^2-16u+20=e^2, u^2+4 = (5q^4+20)/5 = g^2/5,
\\ so W^2 = u f1 (u^2+4) = (e q g)^2 / 5; C_q is defined over Q.
\\ ============================================================

Hx = x*(5*x^2 - 16*x + 20)*(x^2 + 4);
print("C_q : W^2 = H(u), H = ", Hx);
print("deg H = ", poldegree(Hx), "   (deg 5 -> genus 2)");
print("squarefree? ", issquarefree(Hx));
print("disc(H) = ", factor(poldisc(Hx)));

Xp = ellinit([0,1,0,-20,0]);   \\ 120a2
Xm = ellinit([0,0,0,-7,6]);    \\ 80a1

\\ --- a_p(C_q) =?= a_p(X+) + a_p(X-) at ALL good primes up to 200 ---
countH(pp) = {
  my(naff=0, hv, nw);
  for(uu=0,pp-1,
    hv = Mod(uu*(5*uu^2-16*uu+20)*(uu^2+4), pp);
    nw = if(hv==0,1,1+kronecker(lift(hv),pp));
    naff += nw;
  );
  naff + 1;   \\ odd-degree model: one point at infinity
};
print("\n=== a_p(C_q) vs a_p(X+)+a_p(X-), good p <= 200 ===");
dH = poldisc(Hx);
matchc=0; testc=0; badlist=[];
{
forprime(pp=3,200,
  if(pp==2 || (dH % pp == 0), next);
  my(apCq, ok);
  apCq = (pp+1) - countH(pp);
  ok = (apCq == ellap(Xp,pp)+ellap(Xm,pp));
  testc+=1; if(ok,matchc+=1, badlist=concat(badlist,[pp]));
);
}
print("matched ", matchc, " / ", testc, " good primes in [3,200]");
print("mismatches: ", badlist);

\\ --- Full Frobenius char-poly check: not just the linear coefficient a_p, but
\\ also the quadratic coefficient, via #C_q(F_p) and #C_q(F_{p^2}). For a genus-2
\\ curve, L_p(T) = 1 - a1 T + a2 T^2 - p a1 T^3 + p^2 T^4, where
\\   #C_q(F_p)   = p + 1 - a1
\\   #C_q(F_p^2) = p^2 + 1 - (a1^2 - 2 a2).
\\ If Jac(C_q) ~ X+ x X-, then L_p(T) = Lp(X+) * Lp(X-), i.e.
\\   a1 = a_p(X+) + a_p(X-),
\\   a2 = a_p(X+) a_p(X-) + 2p.
print("\n=== full Frobenius char-poly check via #C_q(F_p) and #C_q(F_{p^2}) ===");
\\ Robust F_{p^2} enumeration:
NFp2(pp) = {
  my(g = ffgen(pp^2), tot = 0, els, hv);
  els = vector(pp^2);
  my(idx = 1);
  for(a = 0, pp-1, for(b = 0, pp-1, els[idx] = a + b*g; idx += 1));
  for(i = 1, pp^2,
    my(uu = els[i]);
    hv = uu*(5*uu^2-16*uu+20)*(uu^2+4);
    if(hv == 0, tot += 1,
       \\ #{W : W^2 = hv} = 1 + chi(hv) over F_{p^2}
       tot += 1 + if(hv^((pp^2-1)/2) == 1, 1, -1));
  );
  tot + 1;   \\ one point at infinity
};
print("p : a1(curve) a1(X+X-) | a2(curve) a2(X+X-) | match");
matchfull = 0; testfull = 0;
{
forprime(pp = 7, 47,
  if(dH % pp == 0, next);
  my(NFp, NFp2v, a1c, a2c, apP, apM, a1f, a2f, ok);
  NFp = countH(pp);
  NFp2v = NFp2(pp);
  a1c = (pp + 1) - NFp;
  \\ NFp2 = p^2 + 1 - (a1^2 - 2 a2)  =>  a1^2 - 2 a2 = p^2 + 1 - NFp2
  a2c = (a1c^2 - (pp^2 + 1 - NFp2v)) / 2;
  apP = ellap(Xp, pp); apM = ellap(Xm, pp);
  a1f = apP + apM;
  a2f = apP*apM + 2*pp;
  ok = (a1c == a1f) && (a2c == a2f);
  testfull += 1; if(ok, matchfull += 1);
  print("p=", pp, " : ", a1c, " ", a1f, " | ", a2c, " ", a2f, " | ", ok);
);
}
print("FULL char-poly matched ", matchfull, " / ", testfull, " good primes [7,47]");

\\ --- ranks of X+ and X- (both 0) ---
print("\n=== ranks of X+ (120a2) and X- (80a1) ===");
print("ellrank(X+) = ", ellrank(Xp), "   [lo,hi,...] -> rank 0 if [0,0,...]");
print("ellrank(X-) = ", ellrank(Xm));
print("torsion(X+): order ", elltors(Xp)[1], " structure ", elltors(Xp)[2]);
print("torsion(X-): order ", elltors(Xm)[1], " structure ", elltors(Xm)[2]);
print("L(X+,1) = ", ellL1(Xp, 0));
print("L(X-,1) = ", ellL1(Xm, 0));
print("analytic rank X+ = ", ellanalyticrank(Xp)[1]);
print("analytic rank X- = ", ellanalyticrank(Xm)[1]);

\\ --- |Jac(C_q)(Q)| is finite: rank 0 => Jac(C_q)(Q) = torsion ---
print("\n=== |Jac(C_q)(Q)| = |X+(Q)| * |X-(Q)| (both finite, rank 0) ===");
print("|X+(Q)| = |torsion(X+)| = ", elltors(Xp)[1]);
print("|X-(Q)| = |torsion(X-)| = ", elltors(Xm)[1]);
print("=> |Jac(C_q)(Q)| = |X+(Q)|*|X-(Q)| = ", elltors(Xp)[1]*elltors(Xm)[1], " (finite, rank 0)");
quit;
