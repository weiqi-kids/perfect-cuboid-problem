default(parisize,1000000000);
add2=0; mult2=0; good2=0; addother=0; examples_add=List();
maxIn=0; mnp=[0,0,0];
{
for(m=2,60,
  for(n=1,m-1,
    if(gcd(m,n)==1 && (m+n)%2==1,
      q=(m^2-n^2)/(2*m*n);
      E=ellminimalmodel(ellinit([0,1+q^2,0,q^2,0]));
      N=ellglobalred(E)[1];
      fa=factor(N)[,1];
      for(i=1,#fa,
        p=fa[i]; lr=elllocalred(E,p); kod=lr[2];
        if(p==2,
          if(kod>=5, mult2++, if(kod==1, good2++, add2++)),
          if(kod<5 && kod!=1, addother++; listput(examples_add,[m,n,p,kod]))
        );
        if(kod>=5 && kod-4>maxIn, maxIn=kod-4; mnp=[m,n,p]);
      );
    );
  );
);
}
print("p=2 reduction over fibers: mult(I_n)=",mult2,"  additive=",add2,"  good=",good2);
print("ODD primes additive count=", addother);
if(#examples_add>0, print("  odd-additive examples (m,n,p,kod): ", Vec(examples_add)[1..min(5,#examples_add)]));
print("MAX I_n index=", maxIn, " at (m,n,p)=", mnp);
