\\ ====================================================================
\\ Extended direct check for rank-2 fiber q = 60/11
\\ ====================================================================
\\
\\ The rigorous Ingram-Mahe-box bound for q = 60/11 is
\\   N_0_box = ceil(sqrt(K / lambda_1)) = 7
\\ where lambda_1 = 2.289... is the first successive minimum of the
\\ Neron-Tate height pairing on the rank-2 lattice.
\\
\\ Hence we need |a|, |b| <= 7 (rigorously) to close the fiber.
\\ The earlier scan was |a|, |b| <= 4 (80 cases).  Here we scan
\\ |a|, |b| <= 7 (225 - 1 = 224 cases).
\\
\\ For each (a, b) != (0, 0): compute a_n = c_n^2 + 1 + q^2 where
\\ c_n = phi(R), R = a*G1 + b*G2.  Test issquare(num) && issquare(den).

default(parisize, 4000000000);
default(realprecision, 50);

{
q = 60/11;
a2 = 1 + q^2; a4 = q^2;
E = ellinit([0, a2, 0, a4, 0]);
G1 = [-180/11, 7020/121];
G2 = [-300/11, 5100/121];

print("================================================================");
print("Extended rank-2 scan: q = 60/11, |a|,|b| <= 7");
print("================================================================");
print();
print("G1 on E? ", ellisoncurve(E, G1));
print("G2 on E? ", ellisoncurve(E, G2));
print();

NBOX = 7;
total = 0;
squares_found = 0;
poles = 0;
identities = 0;

for(a = -NBOX, NBOX,
  for(b = -NBOX, NBOX,
    if(a == 0 && b == 0, next);
    total += 1;
    my(P, Q, R, Tn, Yn, denom, cn, an, valnum, valden, is_sq);
    P = ellmul(E, G1, a);
    Q = ellmul(E, G2, b);
    R = elladd(E, P, Q);
    if(R == [0],
      identities += 1;
      \\ skip identity
      next;
    );
    Tn = R[1]; Yn = R[2];
    denom = q^2 - Tn^2;
    if(denom == 0,
      poles += 1;
      next;
    );
    cn = 2 * Yn * q / denom;
    an = cn^2 + 1 + q^2;
    valnum = numerator(an);
    valden = denominator(an);
    is_sq = issquare(valnum) && issquare(valden);
    if(abs(a) <= 4 && abs(b) <= 4,
      \\ already checked in task2c
    );
    if(abs(a) > 4 || abs(b) > 4,
      print("(a=", a, ", b=", b, "): is_sq=", is_sq, ", digits(num)=", #Str(valnum));
    );
    if(is_sq,
      squares_found += 1;
      print("  !!! a_n IS a rational square !!!");
      print("  a_n = ", an);
      print("  c_n = ", cn);
      print("  R = ", R);
    );
  );
);

print();
print("================================================================");
print("Summary:");
print("  Box size N_BOX = ", NBOX);
print("  Total (a,b) checked = ", total, " (excludes (0,0))");
print("  Identities (R = O) = ", identities);
print("  Poles (T = +/- q)  = ", poles);
print("  Squares found      = ", squares_found);
print("================================================================");
}
quit;
