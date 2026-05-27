\\ Identify the true elliptic quotients of C_q : w^2 = h(u),
\\ h(u) = u(5u^2-16u+20)(5u^2+20), and check the sqrt(5)-twist issue.
\\
\\ The a_p data showed a_p(C_q) = chi_5(p) * (a_p(X+)+a_p(X-)), i.e. C_q is a
\\ quadratic twist by 5 of the standard X+ x X- fiber product. We now pin down
\\ the CORRECT model whose Jacobian is exactly X+ x X- (untwisted), since rank
\\ is NOT a twist invariant.

hx = 25*x^5 - 80*x^4 + 200*x^3 - 320*x^2 + 400*x;

\\ Try the substitution that removes the leading-5 twist. Put u = U/5 ... or
\\ rather: the curve w^2 = u*(5u^2-16u+20)*(5u^2+20). Substitute u -> u, and
\\ scale w. Look for u -> a/u involution. Test u -> 4/u on h(u)/u^? .
print("=== test palindromic-type symmetry u -> 4/u ===");
\\ h(u) = u (5u^2-16u+20)(5u^2+20). Compute u^5 h(4/u) and compare.
h(uu) = uu*(5*uu^2 - 16*uu + 20)*(5*uu^2 + 20);
test = subst(h(4/x)*x^6, x, x);   \\ x^6 * h(4/x)
print("x^6 * h(4/x) = ", test);
print("compare 256/25 * h(x)?  ratio numeric at x=3: ", subst(test,x,3)/subst(hx,x,3));

\\ Direct: identify the two elliptic factors by trying the standard genus-2
\\ -> elliptic decomposition for a quintic with an extra automorphism.
\\ Build the curve over Q and use genus2red to get its conductor & bad primes.
print("\n=== genus2red of C_q ===");
G = genus2red(hx);
print("conductor of Jac(C_q) = ", G[1]);
print("(N(X+)*N(X-) = 120*80 = 9600; twist by 5 changes conductor.)");

\\ Now find the UNTWISTED model: replace h by its quadratic twist by 5.
\\ Twisting w^2=h(u) by d: w^2 = d*h(u) is the same curve up to the twist; the
\\ correct curve with Jac = X+ x X- is the one whose a_p we matched WITHOUT the
\\ chi_5 sign, i.e. we want a model M with a_p(M) = a_p(X+)+a_p(X-) for ALL p.
\\ Since a_p(C_q) = chi_5 * (a_p(X+)+a_p(X-)), the quadratic twist of C_q by 5
\\ has a_p = chi_5 * a_p(C_q) = chi_5^2 * (...) = a_p(X+)+a_p(X-).
\\ Twisting w^2=h(u) by 5: w^2 = 5*h(u). Test it:
Xp = ellinit([0,1,0,-20,0]); Xm = ellinit([0,0,0,-7,6]);
h5(uu) = 5*uu*(5*uu^2-16*uu+20)*(5*uu^2+20);
counttw(pp) = {
  my(naff=0, hv, nw);
  for(uu=0,pp-1,
    hv = Mod(5*uu*(5*uu^2-16*uu+20)*(5*uu^2+20), pp);
    nw = if(hv==0,1,1+kronecker(lift(hv),pp));
    naff += nw;
  );
  naff + 1;
};
print("\n=== a_p of the twist-by-5 model w^2 = 5*h(u) vs X+ + X- ===");
dh = poldisc(5*hx);
matchc=0; testc=0;
{
forprime(pp=7,120,
  if(pp==2 || pp==5 || (poldisc(hx) % pp == 0), next);
  my(apM, ok);
  apM = (pp+1) - counttw(pp);
  ok = (apM == ellap(Xp,pp)+ellap(Xm,pp));
  testc+=1; if(ok,matchc+=1);
  if(!ok, print("  MISMATCH p=",pp," apM=",apM," sum=",ellap(Xp,pp)+ellap(Xm,pp)));
);
}
print("twist-by-5 model matched ", matchc, " / ", testc, " good primes");
quit;
