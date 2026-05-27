n = 73225;
prec = 20;
t = 1;
{
for(k=4, prec,
  my(M = 2^k);
  my(t2 = t + 2^(k-2));
  if((t^2 - n) % M == 0, ,
    if((t2^2 - n) % M == 0, t = t2,
      print("Step k=",k,": neither ",t," nor ",t2," works mod ", M);
      print("  t^2 - n mod M = ", (t^2 - n) % M);
      print("  t2^2 - n mod M = ", (t2^2 - n) % M);
      break)
  )
)
}
print("Final t = ", t);
print("t^2 = ", t^2);
print("n mod 2^",prec," = ", n % 2^prec);
print("t^2 mod 2^",prec," = ", t^2 % 2^prec);

\\ The issue: when t^2 ≡ n mod 2^k, the lift to mod 2^(k+1) requires adding 2^(k-1).
\\ Let me redo with correct step:
print("\nCorrect Hensel iteration:");
t = 1;
{
for(k=3, prec-1,
  \\ Have t with t^2 ≡ n mod 2^k. Lift to mod 2^(k+1).
  my(M_next = 2^(k+1));
  my(t_next, diff = (t^2 - n) % M_next);
  if(diff == 0, t_next = t,
    if((t + 2^k)^2 % M_next == n % M_next, t_next = t + 2^k,
      print("Failed at k=",k);
      print("  t=",t," t^2 mod 2^",k+1," = ",t^2 % M_next);
      print("  t+2^",k," = ",t+2^k," sq mod 2^",k+1," = ", (t+2^k)^2 % M_next);
      print("  n mod 2^",k+1," = ",n % M_next);
      break)
  );
  t = t_next;
);
}
print("Final t after iteration up to 2^",prec," : ", t);
print("Check t^2 mod 2^",prec," = ", t^2 % 2^prec, " vs n mod 2^",prec," = ", n % 2^prec);
