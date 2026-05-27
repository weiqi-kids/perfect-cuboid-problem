\\ 05_sieve_termination.gp
\\ HONEST test of whether the factored sieve TERMINATES (proves closure) vs merely searches.
\\
\\ A genuine MW-sieve proves V_q(Q) -> J(Q) image, reduced into prod_p J(F_p), meets the
\\ reduction of the actual MW group ONLY at the known points.  Translated to our c-coordinate
\\ surrogate: the set of c that survive the sieve at primes {p_1,...,p_k}, as residue classes,
\\ must be analyzed as a subset of  Z_hat = prod Z_p  (or a quotient), NOT as a search of small c.
\\
\\ THE CORRECT TERMINATION QUESTION:
\\ On E_H+, the global generator P has X(P)=0.  The image of V_q(Q) on E_H+ is some subset of
\\ {m*P + t}.  The c-coordinate satisfies c^2 = X(mP+t).  The MW-sieve, done correctly, would
\\ track the INDEX m mod (group order at each prime) and intersect via CRT to constrain m.
\\ This is the standard Bruin-Stoll MW-sieve.  Let us see whether PARI can actually CARRY OUT
\\ that index-tracking sieve, or whether it degenerates.
\\
\\ Key obstruction we expose: to sieve the INDEX m (not just c-residues), we must know, for a
\\ hypothetical rational point Q in V_q(Q), the image phi_{H+}(Q) = m*P + t as a GROUP element.
\\ But that requires the ABEL-JACOBI map  V_q(Q) -> E_H+(Q)  to be computed on an actual point,
\\ and the index m to be read off.  For the KNOWN degenerate points that's fine (they map to P).
\\ For a HYPOTHETICAL unknown point, we only know c^2 = X(image) -- we do NOT know which m.
\\ So the sieve can only constrain c^2 = X(mP+t) for SOME m -- i.e. c^2 in the X-image of the
\\ WHOLE group, which mod p is the set reachable_X(p).  That is what 04 computed.

default(parisize, 800000000);
default(parisizemax, 1200000000);
sqrtrat(r) = my(nn=numerator(r),dd=denominator(r)); sqrtint(nn)/sqrtint(dd);

q = 4/3; A=q^2; B=1; Cc=1+q^2;
EHp = ellinit([0,(A+B+Cc),0,(A*B+A*Cc+B*Cc),(A*B*Cc)]);
w = sqrtrat(1+q^2); P=[0,q*w];
Td = elltors(EHp); torsQ=List(); listput(torsQ,"O");
ntg=length(Td[3]); if(ntg>=1, g1=Td[3][1]; o1=ellorder(EHp,g1); for(ii=1,o1-1,listput(torsQ,ellmul(EHp,g1,ii))));
torsQ=Vec(torsQ);

allowed_c(pr)={my(L=List(),qm=Mod(q,pr),c,e2,f2,g2); for(c=0,pr-1, e2=Mod(c,pr)^2+qm^2; f2=Mod(c,pr)^2+1; g2=Mod(c,pr)^2+1+qm^2; if(issquare(e2)&&issquare(f2)&&issquare(g2),listput(L,c))); Set(Vec(L));}
reachable_X(pr)={my(Ep,Pbar,ordP,Sset,Q0,Tbar,R,tt); Ep=ellinit(EHp,pr); Pbar=ellmul(Ep,[Mod(0,pr),Mod(q*w,pr)],1); ordP=ellorder(Ep,Pbar); if(ordP==0,ordP=ellcard(Ep)); Sset=Set([]); for(mm=0,ordP-1, Q0=ellmul(Ep,Pbar,mm); for(ti=1,length(torsQ), tt=torsQ[ti]; if(tt=="O",Tbar=[0],Tbar=ellmul(Ep,[Mod(tt[1],pr),Mod(tt[2],pr)],1)); R=elladd(Ep,Q0,Tbar); if(R!=[0],Sset=setunion(Sset,Set([lift(R[1])]))))); Sset;}
surviving_c(pr)={my(AC=allowed_c(pr),RX=reachable_X(pr),L=List(),c); for(i=1,length(AC),c=AC[i]; if(setsearch(RX,lift(Mod(c,pr)^2))>0,listput(L,c))); Set(Vec(L));}

\\ ===========================================================================
\\ TEST 1: Does #surviving_c(pr) stay bounded (sieve effective) or grow ~ #allowed_c?
\\ If surviving_c ~ allowed_c, the E_H+ rank-1 constraint adds NOTHING (reachable_X is almost
\\ all of F_p), so the "sieve" is really just the local solvability search V_q(F_p) != empty.
\\ ===========================================================================
print("=== TEST 1: effectiveness of the E_H+ rank-1 constraint ===");
primes_to_use=[11,13,19,23,29,31,37,41,43,47,53,59,61,67,71,73,79,83,89,97,101,103,107,109,113];
goodp=select(pr->(336%pr!=0)&&(denominator(q)%pr!=0),primes_to_use);
print("pr | #F_pr | #allowed_c | #reachable_X | #surviving_c | ratio surv/allowed");
total_surv_frac=0.0;
{
for(i=1,length(goodp),
  my(pr=goodp[i],AC,RX,SC);
  AC=allowed_c(pr); RX=reachable_X(pr); SC=surviving_c(pr);
  print(pr," | ",pr," | ",#AC," | ",#RX," | ",#SC," | ",if(#AC>0,1.0*#SC/#AC,0));
  total_surv_frac += if(#AC>0,1.0*#SC/#AC,0);
);
}
print("avg surviving/allowed fraction: ", total_surv_frac/length(goodp));
print("");

\\ ===========================================================================
\\ TEST 2: The HONEST closure test.  For the sieve to CLOSE, the surviving c-residues across
\\ primes must be CRT-incompatible for every nonzero global c.  We approximate the true
\\ infinite-coset intersection by checking: is there a residue pattern surviving all primes
\\ that does NOT come from c=0?  We do this by intersecting the allowed c-residues lifted
\\ via CRT over the first k primes and counting the size of the surviving set modulo M=prod p.
\\ If it grows like prod(#surviving/p) -> the sieve does NOT collapse to a point (ghosts remain).
\\ ===========================================================================
print("=== TEST 2: CRT coset count (does survivor set collapse?) ===");
print("k primes | M=prod p (bits) | predicted #survivors mod M (product of per-prime counts/p-scaling)");
\\ The number of c mod M surviving = prod over primes of #surviving_c(pr).  (Independent by CRT.)
{
my(M=1, prod_surv=1);
for(i=1,length(goodp),
  my(pr=goodp[i],SC);
  SC=surviving_c(pr);
  M *= pr; prod_surv *= #SC;
  if(i%3==0 || i==length(goodp),
    print(i," primes | M ~ 2^",round(log(M*1.0)/log(2))," | #survivors mod M = ", prod_surv,
          "  (density ", 1.0*prod_surv/M, ")")
  );
);
}
print("");
print(">>> If #survivors mod M includes ONLY the class of c=0 (i.e. eventually prod_surv = 1");
print("    with the single class being 0 mod each prime), sieve CLOSES.  If prod_surv stays > 1");
print("    or grows, there are residue GHOSTS the factored sieve cannot eliminate -- because");
print("    it never tracks the global INDEX m (needs Abel-Jacobi on the genus-5 curve).");
quit;
