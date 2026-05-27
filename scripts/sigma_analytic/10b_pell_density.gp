default(parisize,700000000);
default(parisizemax,1000000000);
\\ Fast PARI version of the Pell-locus density count (Step 4).
powerfulpart(K) = {my(f=factor(abs(K)),r=1);for(i=1,#f~,if(f[i,2]>=2,r*=f[i,1]^f[i,2]));r;};
issq(K)=issquare(abs(K));

Hs = [200,400,800,1600,3000];
nH=#Hs; Hmax=Hs[nH];
c6=vector(nH); c5=vector(nH); ceither=vector(nH); cnear=vector(nH); tot=vector(nH);
{
for(m=2,Hmax,
  for(n=1,m-1,
    if(gcd(m,n)==1 && (m+n)%2==1,
      my(hs=0); for(h=1,nH,if(Hs[h]>=m,hs=h;break));
      if(hs>0,
        my(F5=m^2-2*m*n-n^2, F6=m^2+2*m*n-n^2);
        my(s5=issq(F5), s6=issq(F6));
        my(near = (powerfulpart(F5)>=abs(F5)^(2/3)) || (powerfulpart(F6)>=abs(F6)^(2/3)));
        for(h=hs,nH,
          tot[h]++;
          if(s6,c6[h]++); if(s5,c5[h]++); if(s5||s6,ceither[h]++); if(near,cnear[h]++);
        );
      );
    );
  );
);
}
print("H      total     #F6=sq  #F5=sq  #(F5|F6 sq)  #near-sq(pw>=|F|^{2/3})");
{for(h=1,nH, printf("%-6d %-9d %-7d %-7d %-12d %d\n", Hs[h],tot[h],c6[h],c5[h],ceither[h],cnear[h]));}
print();
print("=== local log-log slope theta (N~H^theta) ===");
print("interval        theta(F6=sq)  theta(F5|F6sq)  theta(near-sq)");
{
for(h=2,nH,
  my(dl=log(Hs[h])-log(Hs[h-1]));
  my(t6=if(c6[h-1]>0&&c6[h]>0,(log(c6[h])-log(c6[h-1]))/dl,0));
  my(te=if(ceither[h-1]>0,(log(ceither[h])-log(ceither[h-1]))/dl,0));
  my(tn=if(cnear[h-1]>0,(log(cnear[h])-log(cnear[h-1]))/dl,0));
  printf("[%d,%d]      %.4f        %.4f          %.4f\n", Hs[h-1],Hs[h], t6,te,tn);
);
}
