\\ 06_solve_conic_ff.gp — Test specialization-based Q-solvability for our conic family

default(parisize, 1000000000);

\\ Solve a x^2 + b y^2 + c z^2 = 0 over Q.
\\ Returns 1 if solvable, 0 if not.
qf_solvable_q(a, b, c) = {
  my(M, sol);
  if (a == 0 || b == 0 || c == 0, return(1));
  \\ Normalize to squarefree integer coefficients
  a = numerator(a) * denominator(a);
  b = numerator(b) * denominator(b);
  c = numerator(c) * denominator(c);
  a = core(a); b = core(b); c = core(c);
  M = matdiagonal([a, b, c]);
  sol = qfsolve(M);
  if (type(sol) == "t_COL", return(1));
  return(0);
};

\\ Test the conic at specialization q = q_val:
\\  Conic: d_1(q_val) X^2 - d_2(q_val) Y^2 + Z^2 = 0
spec_solvable(d_1, d_2, q_val) = {
  my(a, b, c);
  if (q_val == 0 || q_val == 1 || q_val == -1, return(-1));
  a = subst(d_1, 'q, q_val);
  b = -subst(d_2, 'q, q_val);
  c = 1;
  if (a == 0 || b == 0, return(-1));
  return(qf_solvable_q(a, b, c));
};

\\ Sanity checks
print("=== Sanity check: (d_1, d_2) = (1, 1) ===");
{
for (qv = 2, 5,
  print("q=", qv, ": solvable=", spec_solvable(1, 1, qv));
);
}

print();
print("=== T_2 = (-1, q^2-1) -- should always be solvable ===");
{
for (qv = 2, 8,
  print("q=", qv, ": solvable=", spec_solvable(-1, 'q^2-1, qv));
);
}

print();
print("=== Random class (2, q-1) ===");
{
for (qv = 2, 8,
  print("q=", qv, ": solvable=", spec_solvable(2, 'q-1, qv));
);
}

print();
print("=== Class (q, q+1) ===");
{
for (qv = 2, 8,
  print("q=", qv, ": solvable=", spec_solvable('q, 'q+1, qv));
);
}

print();
print("=== Class (-1, -1): conic -X^2 + Y^2 + Z^2 = 0 ===");
{
for (qv = 2, 5,
  print("q=", qv, ": solvable=", spec_solvable(-1, -1, qv));
);
}
