default(parisize,700000000); default(parisizemax,1200000000);
q=(324-49)/(2*18*7);  \\ 275/252
E=ellinit([0,1+q^2,0,q^2,0]); Em=ellminimalmodel(E,&vv);
rr=ellrank(Em);
print("(18,7): ellrank lower=",rr[1]," upper=",rr[2]);
if(#rr>=4 && #rr[4]>=1,
  P=rr[4][1];
  b=P; for(it=1,30, f=0; foreach([2,3,5,7],d, Q=0; if(ellisdivisible(Em,b,d,&Q),b=Q;f=1;break)); if(!f,break));
  print("  gen onc=",ellisoncurve(Em,b)," ord=",ellorder(Em,b)," hat_h=",ellheight(Em,b));
  print("  h(2P)=",ellheight(Em,ellmul(Em,b,2))," 4h=",4*ellheight(Em,b));
);
\\ smallest height over found points:
if(#rr>=4, for(k=1,#rr[4], print("  point ",k," hat_h=",ellheight(Em,rr[4][k]))));
print("sigma=",log(abs(Em.disc))/log(ellglobalred(Em)[1]));
print("VERIFY_DONE"); quit;
