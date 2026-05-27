\\ ============================================================================
\\ 06_cps_extrapolation.gp -- For the very-high-sigma fibers where an explicit
\\ generator is out of reach (huge conductor / even rank), give a RIGOROUS lower
\\ bound on hat_h_min and hence on hat_h_min/log|Delta|, plus the Petsche
\\ guaranteed floor. We use:
\\   (1) CPS / Silverman height-difference: hat_h(P) >= (1/2)h_naive(P) - mu, but
\\       this needs a point. Without one, the only RIGOROUS uniform lower bound on
\\       hat_h_min over a curve is Petsche's c(1,sigma)*log|Delta|.
\\   (2) The DEMONSTRATED empirical ratios at the highest reachable sigma (16,3:
\\       0.0700 at sigma=3.96; 22,3: 0.0781 at sigma=3.85) are the data; we
\\       EXTRAPOLATE the floor toward sigma=4.6 honestly: report the Petsche floor
\\       c(1,sigma)*log|Delta| at the record fibers as the GUARANTEED lower bound,
\\       and note the empirical ratio is ~0.07 (NOT shrinking to 0 in the
\\       REACHABLE range, but the deepest-component pressure -1/4 log|Delta| grows).
\\ ============================================================================
default(parisize,700000000); default(parisizemax,1200000000);
petsche_c(sig)= 1.0/(1e15 * sig^6 * log(104613*sig^2)^2);

\\ For each record fiber: sigma, log|Delta|, Petsche guaranteed floor on hat_h_min,
\\ and the structural "deepest h_NA" = -(1/4)log|Delta| (max negative non-arch).
proc(m,n)=
{
  my(a,b,q,E,Em,vv,logD,gr,N,sig,rn);
  a=m^2-n^2; b=2*m*n; q=a/b;
  E=ellinit([0,1+q^2,0,q^2,0]); Em=ellminimalmodel(E,&vv);
  logD=log(abs(Em.disc)); gr=ellglobalred(Em); N=gr[1]; sig=logD/log(N); rn=ellrootno(Em);
  print(m," ",n," ",sig," ",logD," ",rn," petsche_floor_on_hh=",petsche_c(sig)*logD," petsche_c=",petsche_c(sig)," deepest_h_NA=",-0.25*logD);
}
print("m n sigma logD rootno [petsche guaranteed floor on hat_h_min] [c(1,sigma)] [deepest h_NA=-(1/4)logD]");
FL=[[16,3],[22,3],[32,9],[56,25],[122,121],[256,121],[160,1],[128,1]];
for(i=1,#FL, iferr(proc(FL[i][1],FL[i][2]), E_, print(FL[i][1]," ",FL[i][2]," SKIP")));
\\ Petsche floor across a fine sigma grid (illustrate sigma^-6 degradation):
print("");
print("sigma  c(1,sigma)=1/(1e15 sigma^6 log^2(104613 sigma^2))  [the guaranteed absolute-style floor]");
forstep(s=2.7,4.65,0.2, print("  ",s,"  ",petsche_c(s)));
print("EXIT=ok");
quit;
