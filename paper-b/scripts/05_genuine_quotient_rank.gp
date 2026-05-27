\\ ============================================================
\\ Paper B, Script 05: the GENUINE rational quotient C_q of C and the rank of
\\ its Jacobian. The Q-morphism pi: C -> C_q is (q,e,g) |-> (u,w)=(q^2, e g q),
\\ giving the model
\\   C_q : w^2 = u(5u^2-16u+20)(5u^2+20) = 25u^5-80u^4+200u^3-320u^2+400u.
\\ Its Jacobian is the quadratic twist by 5 of X+ x X-:
\\   Jac(C_q) ~ X+^(5) x X-^(5),  where E^(5) is the twist of E by Q(sqrt 5).
\\ We compute the ranks of X+^(5) and X-^(5) and confirm they are 0.
\\ ============================================================

\\ The genuine (rational-lift) model:
Hg = 25*x^5 - 80*x^4 + 200*x^3 - 320*x^2 + 400*x;
print("Genuine quotient C_q : w^2 = ", Hg);
print("  = u(5u^2-16u+20)(5u^2+20),  w = e g q,  u = q^2.");

Xp = ellinit([0,1,0,-20,0]);   \\ 120a2
Xm = ellinit([0,0,0,-7,6]);    \\ 80a1

\\ Quadratic twist by d=5:
Xp5 = ellinit(elltwist(Xp, 5));
Xm5 = ellinit(elltwist(Xm, 5));
print("\nX+^(5) = ", Xp5.disc, "  minimal model coeffs ", [Xp5.a1,Xp5.a2,Xp5.a3,Xp5.a4,Xp5.a6]);
print("X-^(5) = ", Xm5.disc, "  minimal model coeffs ", [Xm5.a1,Xm5.a2,Xm5.a3,Xm5.a4,Xm5.a6]);
print("N(X+^(5)) = ", ellglobalred(Xp5)[1]);
print("N(X-^(5)) = ", ellglobalred(Xm5)[1]);
print("ellidentify(X+^(5)) = ", ellidentify(Xp5)[1][1]);
print("ellidentify(X-^(5)) = ", ellidentify(Xm5)[1][1]);

\\ Confirm a_p(C_q genuine) = a_p(X+^(5)) + a_p(X-^(5)) at all good primes <= 200.
countHg(pp) = {
  my(naff=0, hv);
  for(uu=0,pp-1,
    hv = Mod(uu*(5*uu^2-16*uu+20)*(5*uu^2+20), pp);
    naff += if(hv==0,1,1+kronecker(lift(hv),pp));
  );
  naff + 1;   \\ wait: leading coeff is 25 (deg 5 odd) -> one point at infinity?
};
\\ deg Hg = 5 (odd) -> one rational point at infinity regardless of leading coeff.
print("\n=== a_p(C_q genuine) =?= a_p(X+^(5)) + a_p(X-^(5)), good p <= 200 ===");
dHg = poldisc(Hg);
mc=0; tc=0; bad=[];
{
forprime(pp=3,200,
  if(pp==2 || (dHg % pp == 0), next);
  my(apc, ok);
  apc = (pp+1) - countHg(pp);
  ok = (apc == ellap(Xp5,pp)+ellap(Xm5,pp));
  tc+=1; if(ok,mc+=1, bad=concat(bad,[pp]));
);
}
print("matched ", mc, " / ", tc, " good primes. mismatches: ", bad);

\\ === RANKS of the twists (the load-bearing computation) ===
print("\n=== ranks of X+^(5) and X-^(5) ===");
print("ellrank(X+^(5)) = ", ellrank(Xp5));
print("ellrank(X-^(5)) = ", ellrank(Xm5));
print("analytic rank X+^(5) = ", ellanalyticrank(Xp5));
print("analytic rank X-^(5) = ", ellanalyticrank(Xm5));
print("L(X+^(5),1) = ", ellL1(Xp5,0));
print("L(X-^(5),1) = ", ellL1(Xm5,0));
print("torsion X+^(5): ", elltors(Xp5)[1], " ", elltors(Xp5)[2]);
print("torsion X-^(5): ", elltors(Xm5)[1], " ", elltors(Xm5)[2]);
quit;
