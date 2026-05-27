/* 02_rank_distribution.gp
   Mordell-Weil rank distribution across Pythagorean fibers of the
   perfect-cuboid family.

   Sample. All primitive Pythagorean parameter pairs (m,n) with
       2 <= m <= 38,  1 <= n < m,  gcd(m,n)=1,  m-n odd.
   For each pair set a=m^2-n^2, b=2mn, q=a/b, and form the integral model
       E(m,n): y^2 = x(x+b^2)(x+a^2),  minimalized via ellminimalmodel.
   Rank is read off ellrank's [lo,hi] interval; we record a CERTIFIED rank
   only when lo==hi, and tally an "uncertified" bucket otherwise (honest:
   we do not guess the rank when 2-descent leaves a gap).

   ellrank effort = 1 throughout. PARI/GP 2.15.4.

   NB: the whole loop body is wrapped in a single brace-block { ... } so that
   gp -q parses the multi-line for/if statements correctly.
*/
default(parisize, 6000000000);
default(realprecision, 38);

mmax = 38;
effort = 1;

cnt = vector(7, i, 0);
uncert = 0;
total = 0;
rank3list = List();
maxrank = -1;

{
for(m = 2, mmax,
  for(n = 1, m-1,
    if(gcd(m,n) == 1 && (m - n) % 2 == 1,
      a = m^2 - n^2;
      b = 2*m*n;
      E = ellinit([0, a^2 + b^2, 0, a^2*b^2, 0]);
      Emin = ellminimalmodel(E);
      r = ellrank(Emin, effort);
      total = total + 1;
      if(r[1] == r[2],
        rk = r[1];
        if(rk <= 6, cnt[rk+1] = cnt[rk+1] + 1, cnt[7] = cnt[7] + 1);
        if(rk > maxrank, maxrank = rk);
        if(rk >= 3, listput(rank3list, [m, n, a/b, rk, r[4]]))
      ,
        uncert = uncert + 1;
        print("  UNCERTIFIED: (m,n)=(", m, ",", n, ")  ellrank=[", r[1], ",", r[2], "]")
      )
    )
  )
);
}

print("");
print("=== Rank distribution, primitive Pythagorean (m,n), 2<=m<=", mmax, " ===");
print("total primitive fibers examined: ", total);
print("certified ranks (lo==hi):");
{
for(rr = 0, 6,
  if(cnt[rr+1] > 0,
    print("   rank ", rr, ":  ", cnt[rr+1], "   (", precision(100.0*cnt[rr+1]/total, 4), " %)")
  )
);
}
print("   uncertified (lo<hi): ", uncert);
print("maximum certified rank observed: ", maxrank);

print("");
print("=== rank >= 3 fibers ===");
{
for(i = 1, #rank3list,
  e = rank3list[i];
  print("   (m,n)=(", e[1], ",", e[2], ")  q=", e[3], "  rank=", e[4]);
  print("      generators (integral model): ", e[5])
);
}
quit;
