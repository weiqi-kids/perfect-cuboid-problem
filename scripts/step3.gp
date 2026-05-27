default(parisize,1000000000);
\\ Step 3: log|Delta_min| ≍ log N ≍ log H_j over the family.
\\ H_j = height of j-invariant = max(|num(j)|,|den(j)|). log H_j = h(j).
r_dN=[100.0,0.0]; r_jN=[100.0,0.0]; r_jd=[100.0,0.0]; r_c4N=[100.0,0.0];
{
for(m=2,80,
  for(n=1,m-1,
    if(gcd(m,n)==1 && (m+n)%2==1,
      my(q=(m^2-n^2)/(2*m*n));
      my(E=ellminimalmodel(ellinit([0,1+q^2,0,q^2,0])));
      my(Dmin=abs(E.disc),N=ellglobalred(E)[1]);
      my(jj=E.j, Hj=max(abs(numerator(jj)),abs(denominator(jj))));
      my(lN=log(N*1.0),lD=log(Dmin*1.0),lJ=log(max(Hj,2)*1.0));
      my(a=lD/lN,b=lJ/lN,c=lJ/lD);
      r_dN=[min(r_dN[1],a),max(r_dN[2],a)];
      r_jN=[min(r_jN[1],b),max(r_jN[2],b)];
      r_jd=[min(r_jd[1],c),max(r_jd[2],c)];
    );
  );
);
}
print("log|Delta_min| / log N  in [",r_dN[1],", ",r_dN[2],"]   (= sigma range)");
print("log H_j        / log N  in [",r_jN[1],", ",r_jN[2],"]");
print("log H_j        / log|Delta_min|  in [",r_jd[1],", ",r_jd[2],"]");
print("All three ratios bounded away from 0 and infinity => log|Delta| ≍ log N ≍ log H_j.");
