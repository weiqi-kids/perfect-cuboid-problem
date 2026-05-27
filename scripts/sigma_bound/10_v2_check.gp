default(parisize,600000000);
default(parisizemax,1000000000);
\\ v_2(b)=1+v_2(mn). Since gcd(m,n)=1, at most one of m,n even. m+n odd => exactly one even.
\\ So mn has v_2 = v_2(even one) >= 1. Thus v_2(b) >= 2 ALWAYS. n_2=4v_2(b)-8 >= 0. Good=0 iff v_2(b)=2.
minv2=100; cnt=0; n2neg=0; good2cnt=0;
{for(m=2,300,for(n=1,m-1,if(gcd(m,n)==1&&(m+n)%2==1,
  my(b=2*m*n, v=valuation(b,2)); cnt++;
  if(v<minv2,minv2=v);
  my(n2=4*v-8); if(n2<0,n2neg++); if(n2==0,good2cnt++);
)));}
print("fibers=",cnt," min v_2(b)=",minv2," (expect 2)  #(n_2<0)=",n2neg," (expect 0)  #(2 good, n_2=0)=",good2cnt);
