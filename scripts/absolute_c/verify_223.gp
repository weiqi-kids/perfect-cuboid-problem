default(parisize,700000000); default(parisizemax,1200000000);
q=(484-9)/(2*22*3);  \\ 475/132
E=ellinit([0,1+q^2,0,q^2,0]); Em=ellminimalmodel(E,&vv);
P=ellheegner(Em);
b=P; for(it=1,30, f=0; foreach([2,3,5,7],d, Q=0; if(ellisdivisible(Em,b,d,&Q),b=Q;f=1;break)); if(!f,break));
print("(22,3): onc=",ellisoncurve(Em,b)," ord=",ellorder(Em,b)," hat_h=",ellheight(Em,b));
print("  4*h=",4*ellheight(Em,b)," h(2P)=",ellheight(Em,ellmul(Em,b,2)));
print("VERIFY_DONE"); quit;
