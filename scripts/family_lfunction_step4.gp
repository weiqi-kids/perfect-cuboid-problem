\\ Step 4: Deeper structure. Use the formula c4 = 16(u^4 - u^2 v^2 + v^4)
\\ to detect if curves are quadratic twists of each other.
\\
\\ Key fact found in step 3:
\\   - All E_{m,n} have an isogeny class of size 6, isomorphic 2-isogeny graph.
\\   - a_p depends on (u mod p, v mod p) (no inconsistency).
\\
\\ Test if c4(E_{m,n}) is a perfect square times a fixed "core" curve's c4.

default(parisize, 800000000);

print("=================================================================");
print("Step 4: Quadratic twist structure");
print("=================================================================");
print();

\\ For E: Y^2 = X^3 + AX^2 + BX with discriminant 16 B^2 (A^2 - 4B):
\\   c4 = 16(A^2 - 3B)
\\   c6 = -64 A (A^2 - 9 B / 2) -- need to double check
\\
\\ Actually: for short Weierstrass form Y^2 + a_1 XY + a_3 Y = X^3 + a_2 X^2 + a_4 X + a_6
\\   with a_1 = a_3 = a_6 = 0, a_2 = A, a_4 = B:
\\   b_2 = 4 a_2 = 4 A
\\   b_4 = 2 a_4 = 2 B
\\   b_6 = 0
\\   b_8 = -a_4^2 = -B^2
\\   c_4 = b_2^2 - 24 b_4 = 16 A^2 - 48 B = 16(A^2 - 3B)
\\   c_6 = -b_2^3 + 36 b_2 b_4 - 216 b_6 = -64 A^3 + 288 A B = -64 A (A^2 - 9B/2)
\\                                                          = -32 A (2 A^2 - 9 B)
\\   disc = -b_2^2 b_8 - 8 b_4^3 - 27 b_6^2 + 9 b_2 b_4 b_6
\\        = -16 A^2 (-B^2) - 8 (2B)^3
\\        = 16 A^2 B^2 - 64 B^3 = 16 B^2 (A^2 - 4 B)
\\
\\ For our family: A = u^2 + v^2 = (m^2+n^2)^2, B = u^2 v^2.
\\   A^2 - 4B = (u^2+v^2)^2 - 4 u^2 v^2 = (u^2 - v^2)^2
\\   So disc = 16 (uv)^2 (u^2-v^2)^2.
\\   A^2 - 3B = (u^2+v^2)^2 - 3 u^2 v^2 = u^4 - u^2 v^2 + v^4
\\   c4 = 16 (u^4 - u^2 v^2 + v^4)
\\
\\ Note: u^4 - u^2 v^2 + v^4 = (u^2 + uv + v^2)(u^2 - uv + v^2) ... let's check
\\   (u^2 + uv + v^2)(u^2 - uv + v^2) = u^4 + u^2 v^2 + u^3 v - u^3 v - u v^3 + u v^3 + u^2 v^2 + v^4 - u^2 v^2
\\   = u^4 + u^2 v^2 + v^4. NOT what we want.
\\ Actually u^4 - u^2 v^2 + v^4 doesn't factor over Q (= Phi_12(u/v) v^4 cyclotomic).

print("Family: E_{m,n}: Y^2 = X^3 + (u^2+v^2) X^2 + (uv)^2 X");
print("  with u = 2mn, v = m^2 - n^2.");
print("  c4 = 16 (u^4 - u^2 v^2 + v^4)");
print("  c6 = -32 (u^2+v^2) (2(u^2+v^2)^2 - 9 (uv)^2)");
print("     = -32 (u^2+v^2) (2 u^4 - 5 u^2 v^2 + 2 v^4)");
print("     = -32 (u^2+v^2)(2 u^2 - v^2)(u^2 - 2 v^2)  ... let's check");
print();
{
\\ verify
test = (u^2 + v^2) * (2*(u^2+v^2)^2 - 9 * (u*v)^2);
test2 = (u^2+v^2)*(2*u^2 - v^2)*(u^2 - 2*v^2);
print("2(u^2+v^2)^2 - 9 (uv)^2 = ", 2*(u^2+v^2)^2 - 9*(u*v)^2);
print("(2u^2 - v^2)(u^2 - 2v^2) = ", (2*u^2 - v^2)*(u^2 - 2*v^2));
}

print();
print("--- j-invariant: j = c4^3 / disc = 256 (u^4-u^2v^2+v^4)^3 / ((uv)^2 (u^2-v^2)^2) ---");
print();

\\ Compute j for several (m,n):
{
for(m = 2, 10,
  for(n = 1, m - 1,
    if(gcd(m, n) == 1 && (m + n) % 2 == 1,
      u = 2*m*n;
      v = m^2 - n^2;
      E = ellinit([0, u^2+v^2, 0, u^2*v^2, 0]);
      jE = ellj(E);
      \\ Factor jE as a/b
      printf("(m,n)=(%d,%d): j = %s\n", m, n, Str(jE));
    );
  );
);
}

print();
print("--- All j-invariants are different. So no two E_{m,n} are isomorphic over Q.");
print("--- But they all share a common 'mod-p reduction pattern'. Why?");
print();

\\ Hypothesis: E_{m,n} is a quadratic twist of a fixed curve E_0.
\\ For two curves E1, E2 to be quadratic twists over Q, need:
\\   j(E1) = j(E2)  -- NOT TRUE HERE.
\\ So they're NOT quadratic twists. But a_p relations exist.
\\
\\ Could it be: E_{m,n} are all isogenous over a fixed number field K
\\ to a fixed elliptic curve E_0 / K?
\\ This would explain a uniform a_p structure if K is appropriate.

\\ Hypothesis 2: Q(j(E_{m,n})) traces out a curve in moduli space X(1) = j-line.
\\ Specifically, j(E_{m,n}) = 256 (u^4 - u^2 v^2 + v^4)^3 / ((uv)^2 (u^2-v^2)^2)
\\ as a rational function of t = v/u, gives a map P^1 -> X(1).
\\ Image is a covering of X(1).

print("--- Map (m,n) -> j(E_{m,n}) as function of t = v/u = (m^2-n^2)/(2mn) ---");
print();
\\ q = (m^2-n^2)/(2mn) = v/u = t. So q = t.
\\ j = 256 (1 - t^2 + t^4)^3 / (t^2 (1 - t^2)^2)
\\ (after substituting u=1, v=t and clearing).
\\
\\ Actually j = 256 (u^4 - u^2 v^2 + v^4)^3 / ((uv)^2 (u^2-v^2)^2)
\\ Setting u = 1, v = t:
\\   j(t) = 256 (1 - t^2 + t^4)^3 / (t^2 (1 - t^2)^2)
\\ For Pythagorean q, t = q.
print("j(q) = 256 (1 - q^2 + q^4)^3 / (q^2 (1 - q^2)^2)");
print();
{
for(m = 2, 10,
  for(n = 1, m - 1,
    if(gcd(m, n) == 1 && (m + n) % 2 == 1,
      q = (m^2 - n^2) / (2*m*n);
      jq = 256 * (1 - q^2 + q^4)^3 / (q^2 * (1 - q^2)^2);
      \\ Check matches above
      u = 2*m*n; v = m^2 - n^2;
      E = ellinit([0, u^2+v^2, 0, u^2*v^2, 0]);
      jE = ellj(E);
      match = if(jq == jE, "OK", "FAIL");
      printf("(m,n)=(%d,%d) q=%s: j(q)=%s %s\n", m, n, Str(q), Str(jq), match);
    );
  );
);
}

print();
print("--- Conclusion: family is parameterized by q on j-line via");
print("    j(q) = 256 (1 - q^2 + q^4)^3 / (q^2 (1-q^2)^2)");
print();
print("This is the MODULAR CURVE X_0(N)/something. Let's check which one.");
print();
print("Recall the Legendre family E_lambda: y^2 = x(x-1)(x-lambda) has");
print("    j(lambda) = 256 (1 - lambda + lambda^2)^3 / (lambda^2 (1-lambda)^2)");
print();
print("Substituting lambda = q^2:");
print("    j(q^2) = 256 (1 - q^2 + q^4)^3 / (q^4 (1 - q^2)^2)");
print();
print("Compare: j(E_{m,n}) = 256 (1 - q^2 + q^4)^3 / (q^2 (1 - q^2)^2)");
print();
print("Ratio: j(E_{m,n}) / j(Legendre(q^2)) = q^2.");
print("These are NOT equal. But our E_{m,n} is X(X+1)(X+q^2),");
print("which is the Legendre form with lambda = -q^2 (shifted).");
print();

\\ Direct check: E_PCP(q): Y^2 = X(X+1)(X+q^2). j-invariant?
print("--- E_PCP(q): Y^2 = X(X+1)(X+q^2), j-invariant directly ---");
{
\\ Use rational q
for(m = 2, 7,
  for(n = 1, m - 1,
    if(gcd(m, n) == 1 && (m + n) % 2 == 1,
      q = (m^2 - n^2) / (2*m*n);
      \\ Y^2 = X^3 + (1+q^2) X^2 + q^2 X
      Epcp = ellinit([0, 1+q^2, 0, q^2, 0]);
      jpcp = ellj(Epcp);
      u = 2*m*n; v = m^2 - n^2;
      Eint = ellinit([0, u^2+v^2, 0, u^2*v^2, 0]);
      jint = ellj(Eint);
      diff = jpcp - jint;
      printf("(m,n)=(%d,%d): j(E_PCP)=%s, j(E_int)=%s, equal=%d\n",
        m, n, Str(jpcp), Str(jint), diff == 0);
    );
  );
);
}

print();
print("(j(E_PCP) and j(E_int) should be EQUAL since they differ by integer rescaling.)");

quit;
