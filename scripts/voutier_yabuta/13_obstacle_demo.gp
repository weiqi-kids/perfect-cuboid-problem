default(parisize,700000000);default(parisizemax,1000000000);
nonarch_r(EE,PP,pp)={my(a1,a2,a3,a4,b2,b4,b6,b8,c4,xx,yy,DD,NN,AA,BB,CC,nn,rr);a1=EE.a1;a2=EE.a2;a3=EE.a3;a4=EE.a4;b2=EE.b2;b4=EE.b4;b6=EE.b6;b8=EE.b8;c4=EE.c4;xx=PP[1];yy=PP[2];DD=EE.disc;NN=valuation(DD,pp);AA=valuation(3*xx^2+2*a2*xx+a4-a1*yy,pp);BB=valuation(2*yy+a1*xx+a3,pp);CC=valuation(3*xx^4+b2*xx^3+3*b4*xx^2+3*b6*xx+b8,pp);nn=-1;if(AA<=0||BB<=0,rr=max(0,-valuation(xx,pp)),valuation(c4,pp)==0,nn=min(BB,NN/2);rr=-nn*(NN-nn)/NN,CC>=3*BB,rr=-2*BB/3,rr=-CC/4);return([rr,NN,nn]);}
sumlam(EE,PP)={my(D,fa,s,res);D=EE.disc;fa=factor(abs(D));s=0.0;for(k=1,#fa~,res=nonarch_r(EE,PP,fa[k,1]);s+=res[1]*log(fa[k,1]));return(s);}
\\ Demonstrate the identity-component obstacle is REAL: for the 84/13 generator and
\\ its multiples, show the pure non-arch component sum (no log c) can be >= 0,
\\ i.e. points sitting at/near identity component giving sum_p lambda_p >= 0.
q=84/13;E=ellinit([0,1+q^2,0,q^2,0]);Em=ellminimalmodel(E,&vv);
P=ellchangepoint([56700/36517,329627340/25160213],vv);
print("84/13 generator: sum_p lambda_p (pure, no log c) = ", sumlam(Em,P));
for(k=1,5, Pk=ellmul(Em,P,k); print("  ",k,"P: sum_p lambda_p = ", sumlam(Em,Pk)," (>=0 means identity-comp-dominated)"));
\\ also 20/21
q=20/21;E=ellinit([0,1+q^2,0,q^2,0]);Em=ellminimalmodel(E,&vv);
P=ellchangepoint([4/21,220/441],vv);
print("20/21: sum_p lambda_p for kP, k=1..5:");
for(k=1,5, Pk=ellmul(Em,P,k); print("  ",k,"P: ", sumlam(Em,Pk)));
quit;
