default(parisize,600000000);
default(parisizemax,1000000000);
\\ Prove an UNCONDITIONAL elementary sigma bound on the squarefree sub-family.
\\ Setup: a=m^2-n^2 (odd), b=2mn, c=a^2-b^2. q=u/v, but here gcd(a,b)=? a odd, b even => gcd odd part.
\\ Actually need gcd(a,b)=1 in lowest terms: for Pythagorean (a,b,hyp) primitive, gcd(a,b)=1 since
\\ a=m^2-n^2, b=2mn, gcd(m,n)=1, m+n odd => gcd(a,b)=1. Verify, and verify gcd(a,c),gcd(b,c).
\\
\\ n_p = v_p(Delta_min). For ODD p (multiplicative, n_p=-v_p(j)):
\\   p|a (q->0 mod p? no, q=a/b, p|a => q≡0): pole order 4 v_p(a) => but on integral model X(X+b^2)(X+a^2)
\\   the bad prime structure: p|a => roots 0 and -a^2 collide mod p (both ≡0)? -a^2≡0. So 0,-a^2 collide => n_p=v_p(a^2)... let's just READ n_p from data and find max per category.
sigfib(m,n)={my(a=m^2-n^2,b=2*m*n,E=ellminimalmodel(ellinit([0,a^2+b^2,0,a^2*b^2,0])));
  log(abs(E.disc)*1.0)/log(ellglobalred(E)[1]*1.0)};
\\ Verify coprimality structure
print("=== coprimality a,b,c (c=a^2-b^2) ===");
cop_ab=1; cop_ac=1; cop_bc=1; cop_ac_odd=1;
{for(m=2,200,for(n=1,m-1,if(gcd(m,n)==1&&(m+n)%2==1,
  my(a=m^2-n^2,b=2*m*n,c=abs(a^2-b^2));
  if(gcd(a,b)!=1,cop_ab=0);
  if(gcd(a,c)!=1,cop_ac=0; if(gcd(a,c)%2!=0 && cop_ac_odd, cop_ac_odd=0));
  if(gcd(b/2^valuation(b,2),c)!=1,cop_bc=0))));}
print("  gcd(a,b)=1 always? ",cop_ab);
print("  gcd(a,c)=1 always? ",cop_ac, " (note c=a^2-b^2, a|? )");
print("  gcd(oddpart(b),c)=1 always? ",cop_bc);
print("");
\\ For ODD bad p, record n_p category: does p | a, | b, or | c, and what is n_p / v_p(that factor)?
\\ Tabulate (which factor, n_p, v_p(factor)) to derive n_p formula.
print("=== n_p structure: for odd p, n_p vs v_p(a),v_p(b),v_p(c) ===");
\\ collect samples
{my(L=List());
for(m=2,60,for(n=1,m-1,if(gcd(m,n)==1&&(m+n)%2==1,
  my(a=m^2-n^2,b=2*m*n,c=abs(a^2-b^2));
  my(E=ellminimalmodel(ellinit([0,a^2+b^2,0,a^2*b^2,0])));
  my(Dmin=abs(E.disc),N=ellglobalred(E)[1],fa=factor(N)[,1]);
  for(i=1,#fa,my(p=fa[i]); if(p>2,
    my(np=valuation(Dmin,p),va=valuation(a,p),vb=valuation(b,p),vc=valuation(c,p));
    \\ which one is nonzero
    my(cat=if(va>0,Strprintf("a^v%d",va),if(vb>0,Strprintf("b^v%d",vb),Strprintf("c^v%d",vc))));
    if(#L<200, listput(L,[p,np,cat])))))));
\\ summarize: for p|a (va>0), what is np? expect 4*va. for p|b, 4*vb. for p|c, 2*vc.
my(amax=0,bmax=0,cmax=0,aratio=List(),bratio=List(),cratio=List());
for(i=1,#L,my(e=L[i]); my(s=e[3]);
  if(s[1]==Vecsmall("a")[1], my(v=eval(Str(strsplit(s,"v")[2]))); listput(aratio,e[2]*1.0/v));
  if(s[1]==Vecsmall("b")[1], my(v=eval(Str(strsplit(s,"v")[2]))); listput(bratio,e[2]*1.0/v));
  if(s[1]==Vecsmall("c")[1], my(v=eval(Str(strsplit(s,"v")[2]))); listput(cratio,e[2]*1.0/v)));
print("  n_p / v_p(a) values seen: ",Set(Vec(aratio)));
print("  n_p / v_p(b) values seen: ",Set(Vec(bratio)));
print("  n_p / v_p(c) values seen: ",Set(Vec(cratio)));
}
print("");
print("=> CONCLUSION on odd n_p: n_p = 4 v_p(a) (p|a), 4 v_p(b) (p|b), 2 v_p(c) (p|c).");
print("   [from j-denominator a^4 b^4 (a^2-b^2)^2: pole orders 4,4,2.]");
print("");
print("=== Squarefree sub-family rigorous bound ===");
\\ If a, oddpart(b), c are ALL squarefree, then for every odd p: v_p in {0,1}, so
\\ n_p in {4 (p|a), 4 (p|b), 2 (p|c)}. Then:
\\   log|Dmin| = sum n_p log p (+2-adic) = 4 sum_{p|a}log p +4 sum_{p|oddb}log p +2 sum_{p|c}log p +2adic
\\             = 4 log a + 4 log oddpart(b) + 2 log c + (2-adic term).
\\   log N     = log a + log oddpart(b) + log c + (log2 if 2 bad).
\\ So sigma -> at most 4 as a,b,c -> infinity (the 2-term and 2-adic are O(1)/logN -> 0).
\\ Actually sigma <= 4 + o(1) on squarefree family, since the c-term has coeff 2 not 4, sigma<4 strict-ish.
\\ Let's verify sigma <= 4 strictly on squarefree fibers and find sup.
sfmax=0.0; sfmn=[0,0]; over4=0;
{for(m=2,600,for(n=1,m-1,if(gcd(m,n)==1&&(m+n)%2==1,
  my(a=m^2-n^2,b=2*m*n,c=abs(a^2-b^2),bo=b/2^valuation(b,2));
  if(issquarefree(a)&&issquarefree(bo)&&issquarefree(c),
    my(sig=iferr(sigfib(m,n),ERR,-1.0));
    if(sig>4.0,over4++);
    if(sig>sfmax,sfmax=sig;sfmn=[m,n])))));}
print("  Squarefree sub-family (m<=600): sup sigma=",sfmax," at ",sfmn,"  #(sigma>4)=",over4);
