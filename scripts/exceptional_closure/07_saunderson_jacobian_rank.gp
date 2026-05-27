default(parisize,800000000);
default(parisizemax,1200000000);

fpval(t,p) = {
  my(v = (t^8+68*t^6-122*t^4+68*t^2+1) % p);
  ((v % p) + p) % p;
}
apCfull(p) = {
  my(cnt=0);
  for(tt=0,p-1, cnt += 1 + kronecker(fpval(tt,p),p));
  my(Npts = cnt + 2);
  p+1 - Npts;
}

print("=== Saunderson genus-3 C' : J(C') decomposition & rank ===");
{
Epcp = ellinit([0,1,0,-1,15]);
Em = ellminimalmodel(Epcp);
print("E_PCP cond = ", ellglobalred(Em)[1]);
print("E_PCP torsion = ", elltors(Em)[1]);
print("E_PCP root number = ", ellrootno(Em));
my(rr = ellrank(Em));
print("E_PCP ellrank low/high = ", rr[1], " / ", rr[2]);
print("E_PCP analytic rank = ", ellanalyticrank(Em)[1]);
print();

print("Verify a_p(J,C') - 2 a_p(E_PCP) = a_p(X_st):");
print("p | a_p(J) | a_p(E) | a_p(X_st)");
my(ps=[3,7,11,13,17,19,23,29,31,37,41,43,47]);
my(apst=vector(#ps));
for(i=1,#ps,
  my(p=ps[i], aJ=apCfull(p), aE=ellap(Em,p));
  apst[i] = aJ - 2*aE;
  print(p, " | ", aJ, " | ", aE, " | ", apst[i]);
);
print();

print("=== Identify X_sigma_tau (cond | 2^a 5^b; disc(f) bad primes {2,5}) ===");
my(conds=[20,40,50,80,100,160,200,400,800], found=0);
for(ci=1,#conds,
  my(N=conds[ci]);
  iferr(
    my(v=ellsearch(N));
    for(j=1,#v,
      my(E=ellinit(v[j][2]), ok=1);
      for(i=1,#ps, if(ellap(E,ps[i]) != apst[i], ok=0; break));
      if(ok,
        my(rr2=ellrank(E));
        print("MATCH cond ",N,"  label ",v[j][1],"  ainvs ",v[j][2]);
        print("   X_st rank low/high = ",rr2[1]," / ",rr2[2],
              "   root no = ",ellrootno(E),
              "   analytic rank = ",ellanalyticrank(E)[1]);
        found=1;
      );
    );
  , e, print("  (cond ",N," ellsearch unavailable: ",e,")"));
);
if(!found, print("No elldata match; identify by Hecke/quotient construction instead."));
}
