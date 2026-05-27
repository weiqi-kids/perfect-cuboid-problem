default(parisize, 800000000);
\p 40
face3(q, P) = {my(X,Y,den,c,F3); X=P[1];Y=P[2];den=q^2-X^2; if(den==0,return([oo,oo,-1])); c=2*q*Y/den; F3=c^2+1+q^2; [c,F3,issquare(F3)];}
Eofq(q) = ellinit([0, 1+q^2, 0, q^2, 0]);
q = 20/21;
E = Eofq(q);
print("N=", ellglobalred(E)[1]);
print("j=", E.j);
rk = ellrank(E, 3);
print("rank=", rk[1],"..",rk[2], " gens=", rk[4]);
if(#rk[4]>=1, P=rk[4][1]; print("onc=", ellisoncurve(E,P), " hhat=", ellheight(E,P)); print("face3=", face3(q,P)));
quit;
