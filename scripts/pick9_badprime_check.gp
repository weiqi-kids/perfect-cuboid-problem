\\ Verify bad prime claim at (22, 17)
{
m = 22; n = 17;
a = m^2 - n^2;
b = 2*m*n;
q = a / b;
u = m^2 - 2*m*n - n^2;
v = m^2 + 2*m*n - n^2;

print("a = m^2 - n^2 = ", a, " = ", factor(a));
print("b = 2mn      = ", b, " = ", factor(b));
print("u = m^2-2mn-n^2 = ", u);
print("|u| = ", abs(u), " = ", factor(abs(u)));
print("v = m^2+2mn-n^2 = ", v);
print("|v| = ", abs(v), " = ", factor(abs(v)));
print();
print("2*a*b*|u*v| = ", 2*a*b*abs(u*v));
print("Factor: ", factor(2*a*b*abs(u*v)));

print();
E = ellinit([0, 1+q^2, 0, q^2, 0]);
Emin = ellminimalmodel(E);
gr = ellglobalred(Emin);
print("Conductor: ", gr[1]);
print("Conductor factored: ", factor(gr[1]));

\\ Tamagawa
print("Tamagawa numbers per prime: ");
print(gr[5]);

print();
print("Bad primes from claim {2,3,7,p|u,p|v} restricted check:");
\\ The exact statement was: bad primes always divide 2 * a * b * u * v.
pred = factor(2*a*b*abs(u*v))[,1];
actual = factor(gr[1])[,1];
print("Predicted bad primes: ", pred);
print("Actual bad primes:    ", actual);

\\ Check whether actual is a subset of predicted
all_in = 1;
for(i = 1, #actual,
  p = actual[i];
  found = 0;
  for(j = 1, #pred,
    if(pred[j] == p, found = 1);
  );
  if(!found, print("  *** PRIME ", p, " IN CONDUCTOR BUT NOT IN 2abuv ***"); all_in = 0);
);
if(all_in, print("All actual bad primes are predicted."));
}
quit;
