default(parisize,700000000);
default(parisizemax,1200000000);
\\ Independent verification of (16,3): q=(256-9)/(2*16*3)=247/96
q=247/96;
E=ellinit([0,1+q^2,0,q^2,0]); Em=ellminimalmodel(E,&vv);
P=ellheegner(Em);
\\ saturate
b=P; for(it=1,30, f=0; foreach([2,3,5,7],d, Q=0; if(ellisdivisible(Em,b,d,&Q), b=Q;f=1;break)); if(!f,break));
print("on curve: ", ellisoncurve(Em,b));
print("torsion order (0=infinite): ", ellorder(Em,b));
print("hat_h = ", ellheight(Em,b));
print("hat_h(2P) = ", ellheight(Em,ellmul(Em,b,2)), "  (should be 4*hat_h = ", 4*ellheight(Em,b),")");
print("sigma = ", log(abs(Em.disc))/log(ellglobalred(Em)[1]));
print("VERIFY_DONE");
quit;
