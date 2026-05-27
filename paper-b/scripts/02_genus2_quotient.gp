\\ ============================================================
\\ Paper B, Script 02: the explicit genus-2 quotient C_q of C and
\\ its Jacobian decomposition Jac(C_q) ~ X+ x X-.
\\
\\ C : e^2 = f1(q)=5q^4-16q^2+20,  g^2 = f2(q)=5q^4+20.
\\ H = <sigma_e sigma_g, sigma_e sigma_q> <= (Z/2)^3, the index-2 subgroup
\\ (even-weight involutions) acting trivially on omega_1=dq/(eg) and
\\ omega_3=q^2 dq/(eg).  C_q := C/H.
\\
\\ H-invariants: u = q^2, w = e*g*q.  Relation:
\\   w^2 = e^2 g^2 q^2 = f1(q) f2(q) q^2 = u*(5u^2-16u+20)(5u^2+20).
\\ So C_q : w^2 = h(u) := u(5u^2-16u+20)(5u^2+20), a quintic -> genus 2.
\\ ============================================================

\\ --- the quintic ---
hu = u*(5*u^2 - 16*u + 20)*(5*u^2 + 20);
print("C_q : w^2 = h(u), h(u) = ", hu);
hupoly = subst(hu, u, x);
print("h as poly in x = ", hupoly);
print("deg h = ", poldegree(hupoly), "  -> genus 2 (deg 5 or 6 hyperelliptic)");
print("disc(h) = ", factor(poldisc(hupoly)));
print("squarefree? ", issquarefree(hupoly));

\\ --- The degree-2 map C -> C_q is (q,e,g) -> (u,w)=(q^2, e*g*q).
\\ Confirm the defining identity as a polynomial identity:
\\   (e*g*q)^2 - (q^2)*f1(q)*f2(q)  vanishes mod (e^2-f1, g^2-f2).
\\ i.e. e^2 g^2 q^2 = f1 f2 q^2 identically after substituting e^2=f1,g^2=f2.
lhs = (5*q^4 - 16*q^2 + 20)*(5*q^4 + 20)*q^2;   \\ = f1 f2 q^2 = (e g q)^2
rhs = subst(subst(hu, u, q^2), w, 0);            \\ h(q^2)
print("\nIdentity check: f1*f2*q^2 - h(q^2) = ", lhs - rhs, "  (should be 0)");

\\ --- Jacobian of the genus-2 curve via the two elliptic quotients ---
\\ The hyperelliptic involution is w -> -w.  The curve C_q : w^2 = u*F(u^2-part?)
\\ Actually note h(u) is NOT even/odd in u, but C_q carries the structure inherited
\\ from C.  We instead identify Jac(C_q) by its L-polynomial: count #C_q(F_p) and
\\ compare to a_p(X+)+a_p(X-).
print("\n=== Jac(C_q): a_p(C_q) =?= a_p(X+) + a_p(X-) over good primes ===");
Xp = ellinit([0,1,0,-20,0]);   \\ 120a2
Xm = ellinit([0,0,0,-7,6]);    \\ 80a1

\\ #C_q(F_p): genus-2, w^2 = h(u), deg h = 5 (odd) -> ONE point at infinity.
\\ affine: for each u in F_p, #w = 1+kron(h(u),p) (with h(u)=0 -> 1).
countCq(pp) = {
  my(naff = 0, hv, nw);
  for(uu = 0, pp-1,
    hv = Mod(uu*(5*uu^2 - 16*uu + 20)*(5*uu^2 + 20), pp);
    nw = if(hv==0, 1, 1 + kronecker(lift(hv),pp));
    naff += nw;
  );
  naff + 1;   \\ +1 for the single point at infinity (odd-degree model)
};

\\ bad primes: divisors of disc(h) and 2.  Print which.
print("disc(h) factored: ", factor(poldisc(hupoly)));
matchc = 0; testc = 0;
{
forprime(pp = 7, 120,
  if(pp==2 || (poldisc(hupoly) % pp == 0), next);
  my(apCq, apXp, apXm, ok);
  apCq = (pp + 1) - countCq(pp);
  apXp = ellap(Xp, pp);
  apXm = ellap(Xm, pp);
  ok = (apCq == apXp + apXm);
  testc += 1; if(ok, matchc += 1);
  print("p=", pp, "  a_p(C_q)=", apCq, "   a_p(X+)+a_p(X-)=", apXp+apXm,
        "   match=", ok);
);
}
print("\nMATCHED ", matchc, " / ", testc, " good primes in [7,120]");
quit;
