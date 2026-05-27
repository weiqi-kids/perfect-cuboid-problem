default(parisize,800000000);
default(parisizemax,1200000000);
{
  my(p=7, f, v, cnt=0, affpts=List(), kk);
  print("=== #C'(F_7) explicit residue breakdown (sharpest Coleman prime) ===");
  for(tt=0,p-1,
    v = (tt^8+68*tt^6-122*tt^4+68*tt^2+1)%p;
    kk = kronecker(v,p);
    if(kk==1, cnt+=2; listput(affpts,[tt,"2 pts (sqrt)"]),
       if(kk==0, cnt+=1; listput(affpts,[tt,"1 pt (T=0)"]),
          listput(affpts,[tt,"0 pts (nonsquare)"])));
    print("  t=",tt,"  f(t) mod 7=",v,"  kronecker=",kk);
  );
  print("affine points = ", cnt);
  print("infinity points = 2 (deg 8, leading coeff 1 = square in F_7)");
  print("TOTAL #C'(F_7) = ", cnt+2);
  print("Coleman bound = #C'(F_7) + 2g-2 = ", cnt+2, " + 4 = ", cnt+2+4);
  print("");
  print("good reduction at 7: disc(f)=2^72*5^4, 7 does not divide => GOOD. 7>2g=6 => Coleman valid.");
}
