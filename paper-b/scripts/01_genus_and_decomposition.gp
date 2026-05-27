\\ ============================================================
\\ Paper B, Script 01: genus of C, the five elliptic quotients,
\\ Jacobian decomposition J(C) ~ E1 x E2 x E3 x X+ x X-,
\\ and a_p matching over many primes.
\\ Curve C: e^2 = f1(q) = 5q^4 - 16q^2 + 20,  g^2 = f2(q) = 5q^4 + 20.
\\ PARI/GP 2.15.4
\\ ============================================================

f1 = 5*q^4 - 16*q^2 + 20;
f2 = 5*q^4 + 20;

print("=== f1, f2 basic facts ===");
print("disc(f1) = ", poldisc(subst(f1,q,x)));
print("disc(f2) = ", poldisc(subst(f2,q,x)));
print("resultant(f1,f2) = ", polresultant(subst(f1,q,x), subst(f2,q,x)));
print("factor resultant = ", factor(polresultant(subst(f1,q,x), subst(f2,q,x))));
print("f1 rational roots? ", polrootsreal(subst(f1,q,x)));  \\ expect none real -> none rational
print("f2 has rational root? ", #select(t->t==0, [subst(f1,q,r) | r<-divisors(20)]));

\\ --- Genus via Riemann-Hurwitz ---
\\ C -> P^1_q is degree 4 (two independent quadratic covers).
\\ Ramification: over each of the 4 roots of f1 (f2 nonzero there): the e-cover
\\ ramifies, g-cover does not -> 2 points each, ram index 2 -> contributes 2 to
\\ ram divisor per root. Same for the 4 roots of f2. At q=infinity all 4 points
\\ unramified (deg 4 even, leading coeffs in Q^*).
\\ 2g-2 = 4*(2*0-2) + R, with R = (4 roots f1)*2 + (4 roots f2)*2 = 16.
R = 16;
twogm2 = 4*(2*0-2) + R;
g_C = (twogm2 + 2)/2;
print("\n=== Genus of C (Riemann-Hurwitz) ===");
print("ramification degree R = ", R);
print("2g-2 = 4*(-2) + R = ", twogm2);
print("g(C) = ", g_C);

\\ --- The five elliptic quotients (a-invariant models from the prompt/lead) ---
\\ E1 = C/<sigma_g>: e^2 = f1(q), genus-1.  Minimal model:
E1 = ellinit([0,0,0,-39312,2889216]);   \\ conductor 480
\\ E2 = C/<sigma_e>: g^2 = f2(q), genus-1 (CM by Z[i]).  Minimal model:
E2 = ellinit([0,0,0,-32400,0]);          \\ conductor 800
\\ E3: factor of the genus-2 quotient C/<sigma_q>.  Minimal model:
E3 = ellinit([0,-1,0,-108,-288]);        \\ conductor 1200
\\ X+ : Cremona 120a2
Xp = ellinit([0,1,0,-20,0]);             \\ conductor 120
\\ X- : Cremona 80a1
Xm = ellinit([0,0,0,-7,6]);              \\ conductor 80

print("\n=== Conductors of the five factors ===");
print("N(E1) = ", ellglobalred(E1)[1]);
print("N(E2) = ", ellglobalred(E2)[1]);
print("N(E3) = ", ellglobalred(E3)[1]);
print("N(X+) = ", ellglobalred(Xp)[1]);
print("N(X-) = ", ellglobalred(Xm)[1]);

print("\n=== ellidentify (Cremona labels) ===");
print("X+ identify: ", ellidentify(Xp)[1][1]);
print("X- identify: ", ellidentify(Xm)[1][1]);

\\ --- Verify the genus-1 quotient curves e^2=f1, g^2=f2 give E1,E2 ---
\\ Use ellfromeqn / quartic-to-Weierstrass. PARI: a quartic y^2=f(x) with a
\\ rational point can be converted. Both f1,f2 have leading coeff 5 (=square*5),
\\ but the point (q,e) with q small gives rational points: f1(1)=9=3^2, f2(1)=25=5^2.
print("\n=== Identify the genus-1 covers e^2=f1, g^2=f2 ===");
C1 = ellfromeqn(ee^2 - (5*q^4 - 16*q^2 + 20));   \\ rational pt (q,ee)=(1,3)
print("C1 = ellfromeqn(ee^2 - f1) raw = ", C1);
E1c = ellinit(C1);
print("minimal model of cover e^2=f1: ", ellglobalred(E1c)[1], "  (conductor)");
print("  j(cover)=", E1c.j, "   j(E1)=", E1.j, "   match=", E1c.j==E1.j);

C2 = ellfromeqn(gg^2 - (5*q^4 + 20));
print("C2 = ellfromeqn(gg^2 - f2) raw = ", C2);
E2c = ellinit(C2);
print("minimal model of cover g^2=f2: ", ellglobalred(E2c)[1], "  (conductor)");
print("  j(cover)=", E2c.j, "   j(E2)=", E2.j, "   match=", E2c.j==E2.j);

\\ --- a_p matching:  a_p(C) =?= a_p(E1)+a_p(E2)+a_p(E3)+a_p(X+)+a_p(X-) ---
\\ Count |C(F_p)| directly (affine + points at infinity over F_p) and compute
\\ a_p(C) = (number predicted by sum of factors). For a genus-5 curve with
\\ Jacobian isogenous to the product, #C(F_p) = p + 1 - sum a_p(factor).
print("\n=== a_p matching over good primes ===");
print("a_p(C) computed from the smooth projective model point count;");
print("compare to a_p(E1)+a_p(E2)+a_p(E3)+a_p(X+)+a_p(X-).");
print("p :  apC(direct)   sum_ap_factors   match?");
badp = Set([2,3,5]);
matchcount = 0; testcount = 0;
countCFp(pp) = {
  my(naff = 0, v1, v2, ne, ng, ninf);
  for(qq = 0, pp-1,
    v1 = Mod(5*qq^4 - 16*qq^2 + 20, pp);
    v2 = Mod(5*qq^4 + 20, pp);
    ne = if(v1==0, 1, 1 + kronecker(lift(v1),pp));
    ng = if(v2==0, 1, 1 + kronecker(lift(v2),pp));
    naff += ne*ng;
  );
  ninf = (1 + kronecker(5,pp))^2;
  naff + ninf;
};
{
forprime(pp = 7, 100,
  if(setsearch(badp, pp), next);
  my(apC, apSum, ok);
  apC = (pp + 1) - countCFp(pp);
  apSum = ellap(E1,pp)+ellap(E2,pp)+ellap(E3,pp)+ellap(Xp,pp)+ellap(Xm,pp);
  testcount += 1;
  ok = (apC == apSum);
  if(ok, matchcount += 1);
  print(pp, " :   ", apC, "          ", apSum, "          ", ok);
);
}
print("\nMATCHED ", matchcount, " / ", testcount, " good primes in [7,100]");
quit;
