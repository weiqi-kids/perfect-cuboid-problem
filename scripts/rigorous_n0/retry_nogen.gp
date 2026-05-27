\\ Retry the 3 NOGEN fibers with repeated effort 4 calls (non-determinism)
default(parisize, 4000000000);
default(realprecision, 50);
default(timer, 0);

c_S_upper(E) = {
  my(Delta = E[12], j_inv = E[13], b2 = E[6], hj, term);
  hj = log(max(abs(numerator(j_inv)), abs(denominator(j_inv))));
  term = (1.0/12) * log(abs(Delta)) + hj/12.0;
  term += 0.5 * log(max(1, abs(b2)/12.0 + 1));
  term += 2.0;
  term;
};

w2_E(E) = {
  my(Delta = abs(E[12]), fac, m = 1);
  fac = factor(Delta);
  for(i = 1, matsize(fac)[1],
    if(fac[i, 2] > m, m = fac[i, 2]);
  );
  m;
};

retry_gen(Emin, max_tries) = {
  my(rk);
  for(t = 1, max_tries,
    rk = iferr(ellrank(Emin, 4), ERR, [-1, -1, 0, []]);
    if(rk[1] == 1 && #rk >= 4 && #rk[4] >= 1, return(rk[4][1]));
    rk = iferr(ellrank(Emin, 3), ERR, [-1, -1, 0, []]);
    if(rk[1] == 1 && #rk >= 4 && #rk[4] >= 1, return(rk[4][1]));
  );
  return(0);
};

process(mm, nn) = {
  my(q, E, Emin, v, gen, hhat, cS, w, K, N0, cond);
  q = (mm^2 - nn^2)/(2*mm*nn);
  E = ellinit([0, 1+q^2, 0, q^2, 0]);
  Emin = ellminimalmodel(E, &v);
  cond = ellglobalred(Emin)[1];
  gen = retry_gen(Emin, 5);
  if(type(gen)=="t_INT" && gen==0,
    print(mm," ",nn," cond=",cond," still NOGEN");
    return;
  );
  hhat = ellheight(Emin, gen);
  cS = c_S_upper(Emin);
  w  = w2_E(Emin);
  K  = 8.0*(cS + log(2.0*w) + 1.0);
  N0 = ceil(sqrt(K/hhat));
  print(mm," ",nn," cond=",cond," hhat=",precision(hhat,8)," cS=",precision(cS,6)," w2=",w," N0=",N0);
};

{
  print("Retrying 3 NOGEN fibers ...");
  process(76, 35);
  process(92, 83);
  process(94, 51);
}
quit;
