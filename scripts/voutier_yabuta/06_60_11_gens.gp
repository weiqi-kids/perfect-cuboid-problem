\\ Find generators of the rank-2 fiber q=60/11, get the minimal-height nonzero
\\ generator, and compute its decomposition. Use ellrank with effort.
default(parisize,900000000);
default(parisizemax,1000000000);
{
q=60/11; E=ellinit([0,1+q^2,0,q^2,0]); Emin=ellminimalmodel(E,&vv);
print("q=60/11");
print("Delta_min=",Emin.disc);
print("logD=",log(abs(Emin.disc)));
gr=ellglobalred(Emin); print("N=",gr[1]," sigma=",log(abs(Emin.disc))/log(gr[1]));
iferr(rk=ellrank(Emin,6); print("rank lo/hi=",rk[1],"/",rk[2]); gens=rk[3];
  print("#gens=",#gens);
  for(j=1,#gens, P=gens[j]; print("  gen ",j,": ",P," h=",ellheight(Emin,P)));
  \\ find min height among small combos
  if(#gens>=2, G1=gens[1]; G2=gens[2];
    best=1e9; bestP=0;
    for(a=-3,3, for(b=-3,3, if(a==0&&b==0,next;
      P=elladd(Emin, ellmul(Emin,G1,a), ellmul(Emin,G2,b));
      h=ellheight(Emin,P); if(h<best && h>0.01, best=h; bestP=P))));
    print("  min-height combo: ",bestP," h=",best));
, ERR, print("  ellrank failed: ",ERR));
quit;
}
