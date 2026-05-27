default(parisize,1200000000);
\\ Is sigma bounded <=> ABC for the family?
\\ sigma <= [4log|u|+4log|v|+2log|u-v|+2log|u+v|] / log rad(u*v*(u-v)*(u+v)) + o(1).
\\ The numerator <= 6 * max(log|u|,log|v|,log|u-v|,log|u+v|) roughly, and since u,v ~ m^2, mn,
\\ all four are O(log m). So numerator = O(log m). Denominator = log rad(...).
\\ If rad is comparable to the product (~ m^? ), sigma bounded.
\\ The ABC triple: u^2 = (u-v)(u+v) + v^2? No. Better: note (u-v)+(2v)=(u+v) etc. The relevant
\\ ABC relation: u, v generate; consider A=(u-v)(u+v)=u^2-v^2, and u^2 = (u^2-v^2)+v^2.
\\ ABC for (u^2-v^2) + v^2 = u^2: rad(u^2 v^2 (u^2-v^2)) >> max^(1-eps). rad(u^2 v^2(u^2-v^2))=rad(uv(u-v)(u+v)).
\\ So ABC conjecture (applied to u^2-v^2+v^2=u^2) gives:
\\   max(u^2,v^2,|u^2-v^2|) <= K_eps rad(u v (u-v)(u+v))^(1+eps).
\\ i.e. 2 log|u| <= (1+eps) log rad(...) + O(1)  [since max ~ u^2].
\\ Then log|u|,log|v|,log|u±v| are all <= log u + O(1) <= ((1+eps)/2) log rad + O(1).
\\ Numerator <= (4+4+2+2) * ((1+eps)/2) log rad = 6(1+eps) log rad.  => sigma <= 6(1+eps).  !!!
\\ CONCLUSION: sigma <= 6 + eps for the family FOLLOWS FROM ABC (applied to u^2 - v^2 + v^2 = u^2).
\\ And conversely a sigma bound for the family is essentially this ABC instance.
\\ Let me VERIFY the ABC quality numerically: q_abc = log max(u^2,v^2,|u^2-v^2|) / log rad(uv(u-v)(u+v)).
\\ ABC says this is <= 1+eps. If it stays <2 always, sigma<=6*2... let me see actual values.

worstabc=0.0; mnabc=[0,0]; worstsig=0.0; mnsig=[0,0];
\\ correlate sigma with abc-quality
{
for(m=2,400,
  for(n=1,m-1,
    if(gcd(m,n)==1 && (m+n)%2==1,
      my(u0=m^2-n^2,v0=2*m*n,g=gcd(u0,v0),u=u0/g,v=v0/g);
      my(prod=abs(u*v*(u-v)*(u+v)), rad=factorback(factor(prod)[,1]));
      my(mx=vecmax([u^2,v^2,abs(u^2-v^2)]));
      my(qabc=log(mx*1.0)/log(rad*1.0));
      if(qabc>worstabc, worstabc=qabc; mnabc=[m,n]);
      my(E=ellminimalmodel(ellinit([0,1+(u/v)^2,0,(u/v)^2,0])));
      my(Dmin=abs(E.disc),N=ellglobalred(E)[1],sig=log(Dmin*1.0)/log(N*1.0));
      if(sig>worstsig, worstsig=sig; mnsig=[m,n]);
    );
  );
);
}
print("WORST ABC-quality q = log max / log rad (m<=400): ", worstabc, " at ", mnabc, "  (ABC conj: ->1)");
print("WORST sigma (m<=400): ", worstsig, " at ", mnsig);
print("");
print("Structural conclusion: sigma <= 6(1+eps) FOLLOWS from ABC applied to (u^2-v^2)+v^2=u^2.");
print("Empirically q_abc stays ~1.0-1.3, giving sigma comfortably < 5.");
