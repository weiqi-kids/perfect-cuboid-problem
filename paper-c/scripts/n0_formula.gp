\\ Re-verify the framework's c_S, w2, N0 numbers (the heuristic-tightened formula)
default(parisize, 2000000000);
default(realprecision, 40);
c_S_upper(E) = {
  my(Delta=E[12], jj=E[13], b2=E[6], hj, term);
  hj = log(max(abs(numerator(jj)), abs(denominator(jj))));
  term = (1.0/12)*log(abs(Delta)) + hj/12.0;
  term += 0.5*log(max(1, abs(b2)/12.0 + 1));
  term += 2.0; term;
};
w2(E) = { my(Delta=abs(E[12]), fac, m=1); fac=factor(Delta);
  for(i=1,matsize(fac)[1], if(fac[i,2]>m, m=fac[i,2])); m; };
{
fibers = [[20/21,[-45/49,10/343]],[80/39,[-160/39,1760/1521]],
          [24/7,[-75/7,510/49]],[84/13,[17787/169,216678/169]],
          [48/55,[-24/25,24/275]],[20/99,[-20/27,980/2673]]];
print("q | hhat | c_S | w2 | K=8(cS+log2w2+1) | N0_formula(non-rigorous)");
for(i=1,#fibers,
  qq=fibers[i][1]; P=fibers[i][2];
  E=ellinit([0,1+qq^2,0,qq^2,0]);
  hh=ellheight(E,P); cS=c_S_upper(E); w=w2(E);
  K=8.0*(cS+log(2.0*w)+1.0);
  N0=ceil(sqrt(K/hh));
  print(qq," | ",precision(hh,5)," | ",precision(cS,5)," | ",w," | ",precision(K,5)," | ",N0);
);
}
quit;
