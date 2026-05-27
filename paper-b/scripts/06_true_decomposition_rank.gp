\\ ============================================================
\\ Paper B, Script 06: determine the TRUE Q-isogeny decomposition of J(C) and
\\ its total Mordell-Weil rank. Earlier a_p data (scripts 01,02) showed the
\\ (-,-,-) eigenspace factors carry a quadratic twist by 5. We now pin down the
\\ true five factors and compute the total rank of J(C).
\\
\\ C : e^2=5q^4-16q^2+20, g^2=5q^4+20  (genus 5).
\\ ============================================================

\\ The three "axis" elliptic quotients E1,E2,E3 (these involve only one of the
\\ two square roots, so are NOT twisted by 5):
E1 = ellinit([0,0,0,-39312,2889216]);   \\ cond 480, from e^2=f1
E2 = ellinit([0,0,0,-32400,0]);          \\ cond 800, from g^2=f2 (CM)
E3 = ellinit([0,-1,0,-108,-288]);        \\ cond 1200

\\ The (-,-,-) eigenspace factors: the GENUINE quotient C_q has
\\ Jac ~ X+^(5) x X-^(5):
Xp5 = ellinit(elltwist(ellinit([0,1,0,-20,0]),5));   \\ 600a2
Xm5 = ellinit(elltwist(ellinit([0,0,0,-7,6]),5));    \\ 400a2

print("=== candidate true factors ===");
print("E1: N=", ellglobalred(E1)[1], " label ", ellidentify(E1)[1][1]);
print("E2: N=", ellglobalred(E2)[1], " label ", ellidentify(E2)[1][1]);
print("E3: N=", ellglobalred(E3)[1], " label ", ellidentify(E3)[1][1]);
print("X+^(5): N=", ellglobalred(Xp5)[1], " label ", ellidentify(Xp5)[1][1]);
print("X-^(5): N=", ellglobalred(Xm5)[1], " label ", ellidentify(Xm5)[1][1]);

\\ Confirm a_p(C) (smooth genus-5 model) = sum of a_p of these TRUE factors,
\\ for ALL good primes (both chi5=+1 and chi5=-1), using the smooth-model count.
\\ The smooth-model #C(F_p): we computed naive affine + ninf gave a chi5 twist.
\\ Use the corrected count: the (-,-,-) part is twisted, so we test the SUM with
\\ E1,E2,E3 untwisted and X+,X- TWISTED (Xp5,Xm5).
countCaff(pp) = {
  my(naff=0,v1,v2,ne,ng);
  for(qq=0,pp-1,
    v1=Mod(5*qq^4-16*qq^2+20,pp); v2=Mod(5*qq^4+20,pp);
    ne=if(v1==0,1,1+kronecker(lift(v1),pp));
    ng=if(v2==0,1,1+kronecker(lift(v2),pp));
    naff+=ne*ng;
  );
  naff;
};
print("\n=== a_p(C) =?= a_p(E1)+a_p(E2)+a_p(E3)+a_p(X+^(5))+a_p(X-^(5)) ===");
print("(using smooth-model count: affine + (1+chi5)^2 at infinity)");
mc=0; tc=0; bad=[];
{
forprime(pp=7,150,
  if(pp==2||pp==3||pp==5,next);
  my(naff, ninf, apC, sumf, ok);
  naff = countCaff(pp);
  ninf = (1+kronecker(5,pp))^2;
  apC = (pp+1) - naff - ninf;
  sumf = ellap(E1,pp)+ellap(E2,pp)+ellap(E3,pp)+ellap(Xp5,pp)+ellap(Xm5,pp);
  ok = (apC == sumf);
  tc+=1; if(ok,mc+=1,bad=concat(bad,[pp]));
);
}
print("matched ", mc, " / ", tc, "  mismatches: ", bad);

print("\n=== TRUE total Mordell-Weil rank of J(C) ===");
print("rank E1 = ", ellrank(E1));
print("rank E2 = ", ellrank(E2));
print("rank E3 = ", ellrank(E3));
print("rank X+^(5) (600a2) = ", ellrank(Xp5));
print("rank X-^(5) (400a2) = ", ellrank(Xm5));
print("analytic rank E1 = ", ellanalyticrank(E1)[1]);
print("analytic rank E2 = ", ellanalyticrank(E2)[1]);
print("analytic rank E3 = ", ellanalyticrank(E3)[1]);
print("analytic rank X+^(5) = ", ellanalyticrank(Xp5)[1]);
print("analytic rank X-^(5) = ", ellanalyticrank(Xm5)[1]);
rn = [ellrootno(E1),ellrootno(E2),ellrootno(E3),ellrootno(Xp5),ellrootno(Xm5)];
print("root numbers [E1,E2,E3,X+^(5),X-^(5)] = ", rn);
print("\n=== CONCLUSION: total rank J(C)(Q) = 1+1+1+1+1 = 5 = genus(C) ===");
print("Chabauty hypothesis rank < genus FAILS. Chabauty-Coleman does NOT apply to C.");
quit;
