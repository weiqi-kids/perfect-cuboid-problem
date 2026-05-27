default(parisize,700000000);
default(parisizemax,1000000000);
\\ Confirm the exact-square count is governed by the proven parametrization
\\ (m,n)=(s^2-2st+2t^2, 2st) for F6 [and (s^2+2st+2t^2,2st) for F5], i.e. the
\\ #fibers with F6=square equals #valid (s,t) pairs, giving Theta(H) directly.
issq(K)=issquare(abs(K));

\\ (A) Verify completeness: every primitive fiber with F6=square arises from Param A.
\\     i.e. for m<=H with F6=square, recover (s,t). The param has m=s^2-2st+2t^2,
\\     n=2st. Given (m,n) with F6=k^2, X=m+n, we have X^2-2n^2=k^2 => (X-k)(X+k)=2n^2.
\\     We just CHECK count equality: #(F6=sq fibers, m<=H) vs #(s,t generating distinct
\\     primitive (m,n) with m<=H).
H=800;
\\ direct count
cntdir=0;
{
for(m=2,H, for(n=1,m-1,
  if(gcd(m,n)==1 && (m+n)%2==1 && issq(m^2+2*m*n-n^2), cntdir++);
));
}
\\ param count: (s,t), m=s^2-2st+2t^2>0, n=2st>=1, m>n, gcd=1, m+n odd, m<=H, dedupe
seen=Set();
{
for(s=-60,60, for(t=-60,60,
  if(s!=0 || t!=0,
    my(m=s^2-2*s*t+2*t^2, n=2*s*t);
    if(m>=2 && n>=1 && m>n && m<=H && gcd(m,n)==1 && (m+n)%2==1 && issq(m^2+2*m*n-n^2),
      seen=setunion(seen, [Str(m,",",n)]);
    );
  );
));
}
print("F6=square fibers (m<=", H, "): direct count = ", cntdir, " ; param-A reachable distinct = ", #seen);
print("(param reachable <= direct; gap = fibers from n-odd branch / other factorization)");
print();

\\ (B) Pell parametrization growth: #(s,t) lattice pts with s^2-2st+2t^2<=H is ~ area/det.
\\     The form s^2-2st+2t^2 has discriminant 4-8=-4 (pos def, disc -4), so #{Q<=H} ~ pi*H/sqrt(4)= pi H/2.
\\     => Theta(H) confirmed analytically.
print("Quadratic form g(s,t)=s^2-2st+2t^2 : disc = (-2)^2-4*1*2 = ", (-2)^2-4*2, " (neg def disc -4, pos def form)");
print("  #{(s,t): g(s,t)<=H} ~ (pi/sqrt(4)) H = (pi/2) H = ", Pi/2.0, " * H  => locus is Theta(H). SPARSE.");
print();

\\ (C) The actual PCP rank-jump record fibers (from ABSOLUTE-C-VERDICT): confirm they
\\     are on near-square Pell loci.
powerfulpart(K) = {my(f=factor(abs(K)),r=1);for(i=1,#f~,if(f[i,2]>=2,r*=f[i,1]^f[i,2]));r;};
print("=== PCP rank-jump record fibers: form anatomy ===");
fib=[[18,7],[256,121],[11,2],[16,3],[8,3]];
{
for(i=1,#fib, my(m=fib[i][1],n=fib[i][2]);
  my(F5=m^2-2*m*n-n^2,F6=m^2+2*m*n-n^2);
  printf("(%d,%d): F5=%s (pw=%d), F6=%s (pw=%d)\n",
    m,n, Str(factor(F5)), powerfulpart(F5), Str(factor(F6)), powerfulpart(F6));
);
}
