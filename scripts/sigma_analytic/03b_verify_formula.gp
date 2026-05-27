default(parisize,700000000);
default(parisizemax,1000000000);
\\ Cross-check the analytic sigma formula against PARI ellminimalmodel.
radK(K) = factorback(factor(abs(K))[,1]);
powerfulpart(K) = {
  my(f=factor(abs(K)), res=1);
  for(i=1,#f~, if(f[i,2]>=2, res *= f[i,1]^f[i,2]));
  res;
};
sigformula(mm,nn) = {
  my(a=mm^2-nn^2, b=2*mm*nn, c=a^2-b^2, v2b=valuation(b,2));
  my(D = 4*log(abs(a)) + 4*log(abs(b)) + 2*log(abs(c)) - 8*log(2));
  my(N = radK(a)*radK(b)*radK(c));
  if(v2b==2, N = N/2);
  D/log(N);
};
sigPARI(mm,nn) = {
  my(a=mm^2-nn^2,b=2*mm*nn);
  my(E=ellminimalmodel(ellinit([0, a^2+b^2, 0, a^2*b^2, 0])));
  my(Dmin=abs(E.disc), Nc=ellglobalred(E)[1]);
  log(Dmin)/log(Nc);
};
testfibers = [[4,3],[11,2],[16,3],[18,7],[2,1],[64,9],[32,9],[256,121],[265,114],[304,135],[233,80]];
print("=== sigma_formula vs sigma_PARI ===");
{
for(i=1,#testfibers,
  my(pr=testfibers[i], mm=pr[1], nn=pr[2]);
  my(sf=sigformula(mm,nn), ch=sigPARI(mm,nn));
  printf("(%3d,%3d): formula=%.7f  PARI=%.7f  |diff|=%.2e\n", mm, nn, sf, ch, abs(sf-ch));
);
}
print();
\\ (256,121) anatomy
{
my(mm=256, nn=121, a=mm^2-nn^2, b=2*mm*nn, c=a^2-b^2);
print("=== (256,121) anatomy ===");
print("a=m^2-n^2=", a, " = ", factor(a));
print("b=2mn=", b, " = ", factor(b));
print("c=a^2-b^2=", c, " = ", factor(c));
print("F5=m^2-2mn-n^2=", mm^2-2*mm*nn-nn^2, " = ", factor(mm^2-2*mm*nn-nn^2));
print("F6=m^2+2mn-n^2=", mm^2+2*mm*nn-nn^2, " = ", factor(mm^2+2*mm*nn-nn^2));
print("c = F5*F6 ? ", c == (mm^2-2*mm*nn-nn^2)*(mm^2+2*mm*nn-nn^2));
print("powerful part of F6 = ", powerfulpart(mm^2+2*mm*nn-nn^2));
}
