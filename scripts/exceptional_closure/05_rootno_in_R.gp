default(parisize,800000000);
default(parisizemax,1200000000);

print("=== Root number + rank-within-R on exact-square locus (t=1) ===");
print("(s,1) | q | w | (if w=-1) rank");

run() = {
  my(nR=0, nR_rk1=0, nR_rkbad=0, nEven=0, tot=0);
  for(s=3,80,
    if((s%2)==0, next);
    my(t=1, m=s^2-2*s*t+2*t^2, n=2*s*t);
    if(gcd(m,n)!=1, next);
    if((m+n)%2==0, next);
    my(a=m^2-n^2, b=2*m*n, q=a/b);
    my(E=ellinit([0,1+q^2,0,q^2,0]));
    my(Em=ellminimalmodel(E));
    my(w=ellrootno(Em));
    tot++;
    if(w==-1,
      nR++;
      my(rr, rl=-1, ru=-1);
      iferr(rr=ellrank(Em,2); rl=rr[1]; ru=rr[2], e, rl=-1; ru=-1);
      print("(",s,",1) | ",a,"/",b," | w=-1 | rk=[",rl,",",ru,"]");
      if(rl==1 && ru==1, nR_rk1++, nR_rkbad++)
    ,
      nEven++;
      print("(",s,",1) | ",a,"/",b," | w=+1 | (even)");
    );
  );
  print("--- R (w=-1) fibers: ",nR,"; rank exactly 1: ",nR_rk1,"; not-det-1: ",nR_rkbad);
  print("--- even (w=+1) fibers: ",nEven,"; total: ",tot);
}
run();
