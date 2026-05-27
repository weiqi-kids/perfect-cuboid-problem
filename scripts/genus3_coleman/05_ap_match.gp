default(parisize,800000000);
default(parisizemax,1200000000);

quarticJac(a4,a3,a2,a1,a0) = {
  ellinit([0,0,0, -27*(12*a4*a0 - 3*a3*a1 + a2^2),
                  -27*(72*a4*a2*a0 - 27*a4*a1^2 - 27*a3^2*a0 + 9*a3*a2*a1 - 2*a2^3)]);
}
apC(pp) = {
  my(cnt=0, v);
  for(tt=0, pp-1,
    v = (tt^8 + 68*tt^6 - 122*tt^4 + 68*tt^2 + 1) % pp;
    cnt = cnt + 1 + kronecker(v, pp);
  );
  pp + 1 - (cnt + 2);
}

{
  Esig  = ellminimalmodel(quarticJac(1,68,-122,68,1));
  Etau  = ellminimalmodel(quarticJac(1,0,64,0,-256));
  Estau = ellminimalmodel(quarticJac(1,0,72,0,16));
  my(ps = [3,7,11,13,17,19,23,29,31,37,41,43,47,53,59,61,67,71,73,79,83,89,97,101,103,107,109,113]);
  my(allok = 1, q1, v1, v2, v3, v4, v5, v6);
  print("p | a_p(C') | sum | a_sig | a_tau | a_stau | match");
  for(i = 1, length(ps),
    q1 = ps[i];
    v1 = apC(q1);
    v2 = ellap(Esig, q1);
    v3 = ellap(Etau, q1);
    v4 = ellap(Estau, q1);
    v5 = v2 + v3 + v4;
    v6 = (v1 == v5);
    if(v6 == 0, allok = 0);
    print(q1, " | ", v1, " | ", v5, " | ", v2, " | ", v3, " | ", v4, " | ", v6);
  );
  print("");
  print("primes tested = ", length(ps));
  print("ALL MATCH a_p(J)=a_sig+a_tau+a_stau : ", allok);
  print("X_sig==X_tau (E_PCP^2): ", Esig[1..5] == Etau[1..5]);
  print("conds: sig=", ellglobalred(Esig)[1], " tau=", ellglobalred(Etau)[1], " stau=", ellglobalred(Estau)[1]);
}
