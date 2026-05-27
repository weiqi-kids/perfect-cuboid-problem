default(parisize,700000000);
default(parisizemax,1000000000);
\\ Step 1 (integer level). For gcd(m,n)=1, m+n odd, compute the ACTUAL pairwise
\\ gcds of the six forms over a large (m,n) range and record the MAX gcd seen for
\\ each pair. The symbolic resultants say common prime divisors divide a power of 2;
\\ here we pin the EXACT bounded factor (and confirm odd-prime coprimality).
\\
\\ Forms: F1=m, F2=n, F3=m-n, F4=m+n, F5=m^2-2mn-n^2, F6=m^2+2mn-n^2
\\ Also track: are F5,F6 ODD?  v2 of each form. And the key reduction:
\\   powerful part of product = product of powerful parts (up to bounded 2-power)?

fname = ["m","n","m-n","m+n","m^2-2mn-n^2","m^2+2mn-n^2"];

maxgcd = vector(15, i, 0);   \\ 15 pairs among 6 forms
pairidx = matrix(6,6);
{
  c=0;
  for(i=1,6, for(j=i+1,6, c++; pairidx[i,j]=c));
}
worstpair = vector(15, i, [0,0]);

\\ also track parity / 2-adic valuation distribution of each form
v2hist = matrix(6, 8);  \\ form x v2 in 0..7

cnt = 0;
{
for(m=2,400,
  for(n=1,m-1,
    if(gcd(m,n)==1 && (m+n)%2==1,
      cnt++;
      my(F = [m, n, m-n, m+n, m^2-2*m*n-n^2, m^2+2*m*n-n^2]);
      for(i=1,6,
        my(vv = valuation(abs(F[i]), 2));
        if(vv<8, v2hist[i, vv+1]++);
      );
      for(i=1,6, for(j=i+1,6,
        my(g = gcd(abs(F[i]), abs(F[j])), pi = pairidx[i,j]);
        if(g > maxgcd[pi], maxgcd[pi]=g; worstpair[pi]=[m,n]);
      ));
    );
  );
);
}
print("fibers scanned (gcd(m,n)=1, m+n odd, m<=400): ", cnt);
print();
print("=== MAX pairwise gcd over all fibers (the bounded common factor) ===");
{
  c=0;
  for(i=1,6, for(j=i+1,6, c++;
    print(fname[i], " , ", fname[j], " : max gcd = ", maxgcd[c], "   at (m,n)=", worstpair[c]);
  ));
}
print();
print("=== 2-adic valuation distribution of each form (v2 = 0,1,...,7 ; col1=v2=0) ===");
for(i=1,6, print(fname[i], " : ", v2hist[i,]));
print();
print("NOTE: m+n odd => exactly one of m,n is even. So among {m,n,m-n,m+n}");
print("the even one is m or n (whichever), and m-n,m+n are BOTH odd.");
print("F5=m^2-2mn-n^2, F6=m^2+2mn-n^2 are BOTH odd (since one of m^2,n^2 odd, 2mn even).");
