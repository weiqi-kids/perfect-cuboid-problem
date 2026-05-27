\\ Test simple subvariety: {a² = d²} in F_25.
\\ Expected: 49 points (a = ±d each give p²=25, minus the overlap a=d=0).

p = 5; q = 25;
T = ffinit(p, 2);
x = ffgen(T, 'x);
elems = vector(q);
elems[1] = x*0;
for(i = 1, q-1, elems[i+1] = x^(i-1));

test1() = {
  my(N = 0);
  for(ia = 1, q,
    my(A = elems[ia]);
    for(id = 1, q,
      my(D = elems[id]);
      if(A^2 == D^2, N++);
    )
  );
  N;
};

print("# {(a,d) in F_25^2 : a^2 = d^2}: ", test1(), " (expected 49)");

\\ Also test: # {a in F_25 : a is a square}. Should be (q-1)/2 + 1 = 13.
test2() = {
  my(N = 0);
  for(i = 1, q,
    my(s = elems[i]);
    if(s == 0, N++;
      ,
      if(s^((q-1)/2) == 1, N++);
    );
  );
  N;
};

print("# squares in F_25: ", test2(), " (expected 13)");

\\ Test counting solutions to e^2 = s for a chosen s.
test3(s) = {
  my(N = 0);
  for(i = 1, q,
    if(elems[i]^2 == s, N++);
  );
  N;
};

print("# (e: e^2 = 0): ", test3(elems[1]), " (expected 1)");
print("# (e: e^2 = 1): ", test3(elems[2]), " (expected 2)");
\\ pick a non-square: x (since x generates F_25^*, x^((q-1)/2) = x^12 = -1)
print("# (e: e^2 = x): ", test3(elems[3]), " (expected 0 since x is non-square)");

\\ Check the squareness criterion
print("x^12 = ", elems[3]^12);
