\\ ============================================================================
\\ 12_highsigma_chars.gp  -- FAST (no ellheegner): characterize high-sigma fibers
\\ by sigma, log|Delta|, n_max, and the THEORETICAL non-arch lower envelope
\\ -(1/4)log|Delta| (the most a deep point could subtract). This shows that the
\\ high-sigma fibers have the LARGEST capacity for negative non-arch contribution
\\ (deepest possible h_NA), reinforcing that the ratio can only shrink there.
\\ ============================================================================
default(parisize,500000000);
default(parisizemax,1000000000);
chars(m,n)=
{
  my(q,E,Em,vv,logD,gr,N,sig,fa,mx);
  q=(m^2-n^2)/(2*m*n);E=ellinit([0,1+q^2,0,q^2,0]);Em=ellminimalmodel(E,&vv);
  logD=log(abs(Em.disc));gr=ellglobalred(Em);N=gr[1];sig=logD/log(N);
  fa=factor(abs(Em.disc));mx=0;for(k=1,#fa~,if(fa[k,2]>mx,mx=fa[k,2]));
  print(m," ",n," sigma=",sig," logD=",logD," logN=",log(N)," n_max=",mx," deepest_hNA=-(1/4)logD=",-logD/4);
}
\\ the high-sigma / large-n_2 fibers from SIGMA-BOUND-FAMILY
TT=[[56,25],[256,121],[122,121],[64,1],[128,1],[96,5],[100,3],[200,3],[160,1]];
print("High-sigma fiber characteristics (no generator needed):");
runT()={for(i=1,#TT, iferr(chars(TT[i][1],TT[i][2]), E_, print(TT[i][1]," ",TT[i][2]," ERR")));}
runT();
print("EXIT=ok");
quit;
