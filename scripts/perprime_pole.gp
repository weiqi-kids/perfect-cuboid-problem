default(parisize,1000000000);
\\ Test the per-prime pole order -v_p(j) bound. For multiplicative reduction n_p = -v_p(j).
\\ Claim to test: for ODD bad primes, -v_p(j) <= 6 (since j = 256*(coprime numerator)^3 / (q^4(q^2-1)^2),
\\   and the denominator q^4(q^2-1)^2 has, p-adically, v_p = 4*v_p(q) + 2*v_p(q^2-1).
\\   With q=u/v: v_p(q)=v_p(u)-v_p(v). For p odd dividing exactly one of {u,v,u-v,u+v}.
\\ Find the actual max of -v_p(j) per odd prime, and per p=2.
maxodd=0; mno=[0,0,0]; max2=0; mn2=[0,0];
\\ also collect distribution of -v_p(j) at odd primes
distodd=vector(30);
{
for(m=2,150,
  for(n=1,m-1,
    if(gcd(m,n)==1 && (m+n)%2==1,
      q=(m^2-n^2)/(2*m*n);
      jj = 256*(q^4-q^2+1)^3 / (q^4*(q^2-1)^2);  \\ exact j as rational
      \\ bad primes = primes dividing numerator of denominator-of-j and 2
      dj = denominator(jj); nj=numerator(jj);
      \\ poles: primes p with v_p(jj)<0
      fa = factor(dj)[,1];   \\ primes in denominator of j = poles
      for(i=1,#fa,
        p=fa[i]; pole = -valuation(jj,p);
        if(pole>0,
          if(p==2,
            if(pole>max2, max2=pole; mn2=[m,n]),
            if(pole>maxodd, maxodd=pole; mno=[m,n,p]);
            if(pole<=29, distodd[pole]++);
          );
        );
      );
    );
  );
);
}
print("MAX -v_p(j) at ODD prime = ", maxodd, " at (m,n,p)=", mno);
print("MAX -v_2(j) = ", max2, " at (m,n)=", mn2);
print("Distribution of odd-prime pole orders -v_p(j) (index=order):");
for(k=1,12, if(distodd[k]>0, print("  order ",k,": ",distodd[k]," occurrences")));
