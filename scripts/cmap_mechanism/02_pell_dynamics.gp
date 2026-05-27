/* Pell / Vieta dynamics: is the c-map a fixed-shift Möbius / Pell composition?
   Hypothesis 1: c = (q*s - 1) / (q + s) (Pell composition with shift s).
   Hypothesis 2: c = (q + s) / (1 - q*s) (tangent addition).
   Hypothesis 3: c follows from Mobius with rational coefficients depending on q.

   For each c-map pair (q, c), solve for s under each ansatz and look for
   a CONSISTENT s value across pairs.
*/
default(parisize, 800000000);

{
pairs = [
  [20/21, 48/55],
  [7/24, 20/99],
  [11/60, 39/80],
  [11/60, 17/144],
  [44/117, 11/60],
  [48/55, 20/21],
  [20/99, 7/24],
  [39/80, 11/60],
  [17/144, 11/60],
  [104/153, 195/748],
  [104/153, 55/1512],
  [27/364, 120/209]
];
}

print("=== Pell-composition test: c = (q*s - 1)/(q + s) ===");
{
for(i=1, length(pairs),
  my(q, c, s);
  q = pairs[i][1];
  c = pairs[i][2];
  \\ Solve c*(q+s) = q*s - 1  =>  c*q + c*s = q*s - 1  =>  c*s - q*s = -1 - c*q
  \\ s*(c-q) = -1-c*q  =>  s = -(1+c*q)/(c-q)
  if (c == q, print("  pair ", i, ": c == q, skip"); next);
  s = -(1+c*q)/(c-q);
  print("  pair ", i, ": q=", q, " c=", c, "  s=", s);
);
}

print("\n=== Tangent-addition test: c = (q+s)/(1 - q*s) ===");
{
for(i=1, length(pairs),
  my(q, c, s);
  q = pairs[i][1];
  c = pairs[i][2];
  \\ c*(1 - q*s) = q + s  =>  c - c*q*s = q + s  =>  -c*q*s - s = q - c  =>  s*(c*q + 1) = c - q
  \\ s = (c - q)/(1 + c*q)
  if (1 + c*q == 0, print("  pair ", i, ": denom=0, skip"); next);
  s = (c - q)/(1 + c*q);
  print("  pair ", i, ": q=", q, " c=", c, "  s=", s);
);
}

print("\n=== Half-angle / Vieta jumping test ===");
\\ If (m,n) parameter for q and (M,N) for c:
\\ q = 2mn/(m^2-n^2), c = 2MN/(M^2-N^2).
\\ Test if (M,N) is obtained from (m,n) by simple rule.

mn_of_q(q) = {
  my(n=abs(numerator(q)), d=abs(denominator(q)));
  \\ For q = 2mn/(m^2-n^2), we have q + 1/q' = ...; tan(2t) form
  \\ Easier: q = (1-t^2)/(2t)? No, that's cot.
  \\ Use: q = 2mn/(m^2-n^2) <=> q/2 = mn/(m^2-n^2), so m/n + n/m = 2/q? No: m/n - n/m = (m^2-n^2)/(mn) = 2/q.
  \\ Hmm, let me try differently. The Pythagorean rationals q < 1 with 1+q^2 = (sqrt)^2.
  \\ Solve: 1 + q^2 = h^2  =>  (h-q)(h+q) = 1.
  \\ If h = p/r, q = s/r, then (p-s)(p+s) = r^2  =>  p^2 - s^2 = r^2  =>  (p, s, r) primitive triple.
  \\ So q = s/r where (r, s, p) is the triple with r^2 + s^2 = p^2.
  print("  q=", q, "  n/d=", n, "/", d, "  1+q^2=", 1+q^2);
  if (issquare(1+q^2, &h),
    print("    Pythagorean! hypotenuse = ", h, " in canonical (s/r form): s=", n, " r=", d, " p=", numerator(h));
  );
};

print("\n=== Inspect (s, r) parametrization for each q ===");
{
for(i=1, length(pairs),
  print("Pair ", i);
  print("  q1=:");
  mn_of_q(pairs[i][1]);
  print("  c =:");
  mn_of_q(pairs[i][2]);
);
}

quit;
