\\ =====================================================================
\\ 01_descent_setup.gp
\\ Explicit 2-descent setup for E_PCP(q): y^2 = x(x+1)(x+q^2)
\\ Full rational 2-torsion at e_1 = 0, e_2 = -1, e_3 = -q^2
\\ 2-descent map: P -> (x(P)-e_1, x(P)-e_2, x(P)-e_3) mod squares
\\ Image lies in {(d1,d2,d3) : d1*d2*d3 in Q*^2}, encoded as (alpha, beta)
\\ with alpha = x(P), beta = x(P) + 1, gamma = x(P) + q^2
\\ alpha * beta * gamma = y^2 hence alpha*beta*gamma square globally.
\\ =====================================================================

default(parisize, 800000000);

\\ Convention: e_1 = -q^2, e_2 = -1, e_3 = 0 so that e_1 < e_2 < e_3 for q>0
\\ Selmer triples (d1, d2, d3) with d1*d2*d3 in Q*^2.
\\ Equivalently (alpha, beta) where d1=alpha-e_1, d2=alpha-e_2, d3=alpha-e_3 etc.
\\
\\ We use the SIGNED form following Schaefer/HERON-FACE-SELMER:
\\ For P = (x, y) NOT 2-torsion, define
\\   d1 = x - e_1 = x + q^2,  d2 = x - e_2 = x + 1,  d3 = x - e_3 = x
\\ All mod squares. y^2 = d1*d2*d3 so the product is in Q*^2.

build_E(m, n) = {
  my(a = m^2 - n^2, b = 2*m*n, d = m^2 + n^2, q, E, Em);
  q = a/b;
  E = ellinit([0, 1+q^2, 0, q^2, 0]);  \\ y^2 = x^3 + (1+q^2)*x^2 + q^2*x = x*(x+1)*(x+q^2)
  Em = ellminimalmodel(E);
  [q, E, Em];
};

\\ Heron-form prime set H(m, n)
heron_set(m, n) = {
  my(values, primes = List(), v);
  values = [m, n, m+n, abs(m-n), m^2+n^2, m^2-n^2,
            (m+n)^2 - 2*n^2, (m-n)^2 - 2*n^2];
  for(i=1, #values, v = abs(values[i]); if(v > 1, listput(primes, factor(v)[,1]~)));
  primes = concat(Vec(primes));
  vecsort(Set(concat(primes)));
};

\\ Bad primes from conductor of E_min
bad_primes_of_E(Em) = {
  my(N = ellglobalred(Em)[1]);
  factor(N)[,1]~;
};

\\ Sanity: at small (m,n), compute |H| and ω(N).
{
print("===== Heron set size vs ω(N) on representative fibers =====");
print("(m, n)  |H(m,n)|  ω(N)  primes_H  primes_N");
fibers = [[3,2], [5,2], [4,1], [22,17], [35,22], [37,26], [40,29], [40,33],
          [99,28], [118,25], [174,83], [176,63], [181,38], [205,66],
          [209,72], [216,185], [221,202], [261,52], [273,86], [578,319]];
for(i=1, #fibers,
  mn = fibers[i];
  m = mn[1]; n = mn[2];
  if(gcd(m,n) != 1 || (m+n) % 2 == 0, next);
  data = build_E(m, n);
  Em = data[3];
  H = heron_set(m, n);
  badN = bad_primes_of_E(Em);
  print(mn, "  ", #H, "  ", #badN, "  ", H, "  ", badN);
);
}

quit;
