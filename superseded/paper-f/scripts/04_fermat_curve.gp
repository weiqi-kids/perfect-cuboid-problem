\\ 04_fermat_curve.gp
\\ The Pythagorean condition collides with Fermat: q = s^2 Pythagorean
\\ <=> s^4+1 = u^2.  This is birational to E^Fermat: y^2 = x^3 + 4x (Cremona 32a1).
\\ Confirm analytic rank 0 (=> MW rank 0 by Kolyvagin) and torsion Z/4, so the only
\\ rational solution has s=0, q=0 (excluded).  Also confirm the alternative
\\ Yoshida route y^2 = x^3 - x has rank 0, torsion (Z/2)^2.

print("=== Fermat obstruction: s^4+1 = u^2 has only s=0 ===");
print("");

E = ellinit([0,0,0,4,0]);   \\ y^2 = x^3 + 4x  (32a1)
print("E^Fermat: y^2 = x^3 + 4x   conductor = ", ellglobalred(E)[1]);
print("  analytic rank = ", ellanalyticrank(E)[1]);
print("  torsion       = ", elltors(E)[2]);
print("");

E2 = ellinit([0,0,0,-1,0]);  \\ y^2 = x^3 - x  (Yoshida's reduction curve, 32a2)
print("Yoshida curve y^2 = x^3 - x   conductor = ", ellglobalred(E2)[1]);
print("  analytic rank = ", ellanalyticrank(E2)[1]);
print("  torsion       = ", elltors(E2)[2]);
print("");

\\ Direct search: any rational s with small height giving s^4+1 a square (other than 0)?
{
  found = 0;
  for(a = -60, 60,
    for(b = 1, 60,
      if(gcd(a,b)==1,
        s = a/b;
        v = s^4 + 1;
        if(issquare(v) && s != 0, found++; print("  unexpected s=", s));
      );
    );
  );
  print("Rational s with |num|,den <= 60, s!=0, s^4+1 a square: ", found);
}
print("");
{
  ar = ellanalyticrank(E)[1];
  tr = elltors(E)[2];
  if(ar == 0 && tr == [4],
    print("RESULT: rank 0, torsion Z/4 => s^4+1=u^2 forces s=0 => q in {0,inf}. Excluded. PASS");
  ,
    print("RESULT: FAIL  (ar=", ar, " tors=", tr, ")");
  );
}
quit;
