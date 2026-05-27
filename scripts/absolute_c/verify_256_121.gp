default(parisize,900000000); default(parisizemax,1200000000);
m=256;n=121; a=m^2-n^2; b=2*m*n; q=a/b;
E=ellinit([0,1+q^2,0,q^2,0]); Em=ellminimalmodel(E,&vv);
print("logD=",log(abs(Em.disc))," N=",ellglobalred(Em)[1]);
print("sigma=",log(abs(Em.disc))/log(ellglobalred(Em)[1]));
rr=iferr(ellrank(Em), E_, [-1,-1]);
print("ellrank lower=",rr[1]," upper=",rr[2]);
if(#rr>=4 && #rr[4]>=1,
  P=rr[4][1];
  bb=P; for(it=1,40, f=0; foreach([2,3,5,7,11,13],d, Q=0; if(ellisdivisible(Em,bb,d,&Q),bb=Q;f=1;break)); if(!f,break));
  print("gen onc=",ellisoncurve(Em,bb));
  print("gen ord=",ellorder(Em,bb));
  print("hat_h=",ellheight(Em,bb));
  print("hat_h(2P)=",ellheight(Em,ellmul(Em,bb,2)));
  print("4*hat_h=",4*ellheight(Em,bb));
  print("ratio hat_h/logD=",ellheight(Em,bb)/log(abs(Em.disc)));
  for(k=1,#rr[4], print("  found point ",k," hat_h=",ellheight(Em,rr[4][k])));
);
print("VERIFY_DONE"); quit;
