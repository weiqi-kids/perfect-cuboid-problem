default(parisize, 400000000);
Eofq(q) = ellinit([0, 1+q^2, 0, q^2, 0]);
for(t=1,5, q=[20/21,60/11,24/7,84/13,5544/9017][t]; E=Eofq(q); T=elltors(E); print("q=",q," torsion structure=",T[2]," order=",T[1]));
\\ symbolic j-invariant check
print("---symbolic j for generic q via specialization checks---");
\\ j(E) for y^2=x(x+1)(x+q^2). c4,c6 from [0,1+q^2,0,q^2,0]
\\ verify j formula 256(q^4-q^2+1)^3 / (q^4 (q^2-1)^2) claimed in T2
for(k=1,4, q=[20/21,24/7,60/11,48/55][k]; E=Eofq(q); jf=256*(q^4-q^2+1)^3/(q^4*(q^2-1)^2); print("q=",q," E.j=",E.j," formula=",jf," match=",E.j==jf));
quit;
