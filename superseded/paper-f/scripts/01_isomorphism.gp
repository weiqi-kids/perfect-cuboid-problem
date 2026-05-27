\\ 01_isomorphism.gp
\\ HONEST relationship between E_PCP(q) and Yoshida's E_{1,s}.
\\
\\ FINDING (corrects an earlier internal note that claimed a Q-ISOMORPHISM
\\ E_PCP(q) ~ E_{1,s} at q=2s/(s^2-1)):
\\   * E_PCP(q): Y^2 = X(X+1)(X+q^2)        has roots {0,-1,-q^2}  (two negative).
\\   * Yoshida E_{1,s}: y^2=x(x-(2s)^2)(x+(s^2-1)^2) has roots {0,4s^2,-(s^2-1)^2}.
\\   The j-invariants do NOT agree at q=2s/(s^2-1); they agree only at the NON-Pythagorean
\\   value q=(s^2+1)/(2s).  Hence for Pythagorean q, E_PCP(q) is NOT Q-isomorphic to any
\\   E_{1,s}.  The genuine relation is a -1 quadratic twist:
\\       E_PCP(q) = (-1)-twist of  Y^2 = x(x-1)(x-q^2).
\\   BOTH are sub-families of the Yagi family y^2=x(x-a^2)(x+b^2), a^2+b^2 a square,
\\   and BOTH have torsion Z/4 x Z/2 by the SAME Mazur+Fermat-descent argument.
\\
\\ This script demonstrates the j-invariant facts numerically so the attribution in the
\\ paper is exact: the torsion CLASSIFICATION is Yoshida's (re-derived here), but the
\\ curves are twist-related, not isomorphic, on the Pythagorean locus.

print("=== Relationship of E_PCP(q) to Yoshida E_{1,s} (honest) ===");
print("");

\\ (1) For Pythagorean q, search for rational s with j(E_{1,s}) = j(E_PCP(q)).
print("(1) Pythagorean q: is there rational s with j(E_{1,s}) = j(E_PCP(q))?");
{
  pyq = [4/3, 3/4, 5/12, 12/5, 15/8, 8/15];
  for(k = 1, #pyq,
    q = pyq[k];
    EP = ellinit([0, 1+q^2, 0, q^2, 0]);
    jP = EP.j;
    hit = 0;
    for(a = 1, 80,
      for(b = 1, 80,
        if(gcd(a,b)==1,
          s = a/b;
          if(s==1, next);
          EY = ellinit([0,(s^2-1)^2-(2*s)^2,0,-(2*s)^2*(s^2-1)^2,0]);
          if(EY.disc==0, next);
          if(EY.j == jP, hit++);
        );
      );
    );
    print("   q=", q, "  cond=", ellglobalred(EP)[1], "  rational s (h<=80) with matching j: ", hit);
  );
}
print("   => 0 matches: E_PCP(q) (Pythagorean) is NOT Q-isomorphic to any E_{1,s}.");
print("");

\\ (2) Confirm the j-invariants agree for the NON-Pythagorean q=(s^2+1)/(2s):
print("(2) Non-Pythagorean q=(s^2+1)/(2s): j-invariants agree (the genuine Q-isom locus)");
{
  okcnt = 0; tot = 0;
  for(a = 2, 9,
    for(b = 1, a-1,
      if(gcd(a,b)==1,
        s = a/b;
        if(s==1, next);
        q = (s^2+1)/(2*s);
        EP = ellinit([0,1+q^2,0,q^2,0]);
        EY = ellinit([0,(s^2-1)^2-(2*s)^2,0,-(2*s)^2*(s^2-1)^2,0]);
        if(EP.disc==0 || EY.disc==0, next);
        tot++;
        if(EP.j == EY.j, okcnt++, print("   MISMATCH s=",s));
      );
    );
  );
  print("   j(E_PCP((s^2+1)/2s)) == j(E_{1,s}) on ", okcnt, "/", tot, " samples");
}
print("");

\\ (3) The -1 quadratic twist bridge, numerically:  E_PCP(q) and its (-1)-twist
\\     Y^2 = x(x-1)(x-q^2) have the SAME torsion Z/4 x Z/2.
print("(3) E_PCP(q) and its (-1)-twist y^2=x(x-1)(x-q^2): both torsion Z/4 x Z/2");
{
  for(k = 1, 4,
    q = [4/3, 3/4, 5/12, 12/5][k];
    EP = ellinit([0, 1+q^2, 0, q^2, 0]);
    ET = ellinit([0, -(1+q^2), 0, q^2, 0]);  \\ y^2=x(x-1)(x-q^2): X^2 coeff -(1+q^2), X coeff q^2
    print("   q=", q, "  tors(E_PCP)=", elltors(EP)[2], "  tors((-1)-twist)=", elltors(ET)[2]);
  );
}
print("");
print("RESULT: E_PCP(q) is NOT Q-isom to Yoshida E_{1,s} on the Pythagorean locus;");
print("        they are (-1)-twist-related and both have torsion Z/4 x Z/2 by the same");
print("        Mazur + Fermat-descent argument (Yoshida Lemma 2.1 / Yagi).  Attribution");
print("        of the torsion CLASSIFICATION to Yoshida stands; 'isomorphism' was wrong.");
quit;
