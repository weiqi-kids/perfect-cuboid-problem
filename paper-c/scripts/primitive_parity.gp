default(parisize, 2000000000);
qq = 20/21;
E = ellinit([0, 1+qq^2, 0, qq^2, 0]);
P = [-45/49, 10/343];
\\ does 29 divide num(a_n) for n<5?
{
for(kk=1,5,
  pt = ellmul(E,P,kk);
  xx=pt[1]; yy=pt[2];
  aa = (2*yy*qq/(qq^2-xx^2))^2 + 1 + qq^2;
  nm = numerator(aa);
  print("n=",kk,"  v_29(num a_n) = ", valuation(nm,29));
);
}
quit;
