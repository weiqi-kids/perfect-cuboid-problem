default(parisize,800000000);
default(parisizemax,1200000000);

\\ === Genus-3 C': T^2 = f(t),  J(C') ~ X_sigma x X_tau x X_sigtau ===
\\ X_sigma : T^2 = x^4+68x^3-122x^2+68x+1   (= E_PCP)
\\ X_tau   : W^2 = s^4+64s^2-256
\\ X_sigtau: W^2 = r^4+72r^2+16

print("=== Building the three quotient elliptic curves from quartic models ===");

\\ ellfromcoeffs not available; use the genus-1 quartic -> elliptic via known construction.
\\ For y^2 = quartic with rational point, PARI: ellfromj won't help. Use the standard
\\ 'a quartic y^2 = a x^4 + b x^3 + c x^2 + d x + e^2 with rational pt at x=inf (a square)':
\\ We instead identify each by computing a_p directly from the quartic point counts and
\\ matching against ellsearch / ellinit candidates. But cleaner: build the Jacobian elliptic
\\ curve of the quartic via its standard invariants I, J (classical quartic invariants).
\\ For Y^2 = a4 x^4 + a3 x^3 + a2 x^2 + a1 x + a0,
\\   I = 12 a4 a0 - 3 a3 a1 + a2^2
\\   J = 72 a4 a2 a0 - 27 a4 a1^2 - 27 a3^2 a0 + 9 a3 a2 a1 - 2 a2^3
\\ Jacobian elliptic curve: Y^2 = X^3 - 27 I X - 27 J.
quarticJac(a4,a3,a2,a1,a0) = {
  my(I = 12*a4*a0 - 3*a3*a1 + a2^2);
  my(J = 72*a4*a2*a0 - 27*a4*a1^2 - 27*a3^2*a0 + 9*a3*a2*a1 - 2*a2^3);
  ellinit([0,0,0,-27*I,-27*J]);
}

Esig  = ellminimalmodel(quarticJac(1,68,-122,68,1));
Etau  = ellminimalmodel(quarticJac(1,0,64,0,-256));
Estau = ellminimalmodel(quarticJac(1,0,72,0,16));

print("X_sigma : cond=",ellglobalred(Esig)[1], " ainvs=",Esig.disc!=0, " ", Esig[1..5]);
print("   torsion=",elltors(Esig)[1], " rootno=",ellrootno(Esig));
rs=ellrank(Esig); print("   ellrank=[",rs[1],",",rs[2],"]  analytic=",ellanalyticrank(Esig)[1]);
print();
print("X_tau   : cond=",ellglobalred(Etau)[1], " ", Etau[1..5]);
print("   torsion=",elltors(Etau)[1], " rootno=",ellrootno(Etau));
rt=ellrank(Etau); print("   ellrank=[",rt[1],",",rt[2],"]  analytic=",ellanalyticrank(Etau)[1]);
print();
print("X_sigtau: cond=",ellglobalred(Estau)[1], " ", Estau[1..5]);
print("   torsion=",elltors(Estau)[1], " rootno=",ellrootno(Estau));
rst=ellrank(Estau); print("   ellrank=[",rst[1],",",rst[2],"]  analytic=",ellanalyticrank(Estau)[1]);
print();

\\ === a_p of C' from direct point count over F_p ===
fpval(tt,p) = my(v=(tt^8+68*tt^6-122*tt^4+68*tt^2+1)%p); ((v%p)+p)%p;
apC(p) = { my(cnt=0); for(tt=0,p-1, cnt += 1 + kronecker(fpval(tt,p),p)); my(N=cnt+2); p+1-N; }

print("=== Verify a_p(J,C') = a_p(Xsig)+a_p(Xtau)+a_p(Xstau) over good primes ===");
print("p | a_p(C') | a_sig+a_tau+a_stau | a_sig | a_tau | a_stau | match");
ps=[3,7,11,13,17,19,23,29,31,37,41,43,47,53,59,61,67,71,73,79,83,89,97,101,103];
allok=1;
for(i=1,#ps,
  my(p=ps[i]);
  if(p==2||p==5, next);
  my(aJ=apC(p), as=ellap(Esig,p), at=ellap(Etau,p), ast=ellap(Estau,p));
  my(sum=as+at+ast, ok=(aJ==sum));
  if(!ok, allok=0);
  print(p," | ",aJ," | ",sum," | ",as," | ",at," | ",ast," | ",ok);
);
print();
print("ALL PRIMES MATCH a_p(J)=a_sig+a_tau+a_stau : ", allok);
