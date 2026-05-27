\\ ============================================================
\\ Brauer-Manin local invariants for V_q : c^2+q^2=e^2, c^2+1=f^2, c^2+1+q^2=g^2
\\
\\ Candidate transcendental Brauer class:
\\   alpha(c) = (q^2+1, c^2+1) in Br(V_q)[2]   (Hilbert symbol class)
\\
\\ For each of the 4 BEYOND-QC fibers and p in {2,3,5}:
\\   1) evaluate inv_p(alpha) on the 8 "degenerate" points (c=0 and pole c=infinity)
\\      plus several generic c-values
\\   2) test reciprocity sum across p in {2,3,5}
\\
\\ KEY OBSERVATION: for Pythagorean (m,n), q = 2mn/(m^2-n^2), and
\\   q^2+1 = (m^2+n^2)^2/(m^2-n^2)^2  is a RATIONAL SQUARE.
\\ Therefore the Hilbert symbol (q^2+1, c^2+1)_p = 1 trivially at every prime,
\\ and the candidate class is GLOBALLY TRIVIAL.
\\ This is a NEGATIVE but HONEST result: a different class is needed.
\\ ============================================================

default(parisize, 500000000);

fibers = [[61,38], [63,38], [73,24], [88,35]];
primelist = [2, 3, 5];

print("==========================================================");
print("BRAUER-MANIN LOCAL INVARIANTS -- candidate alpha=(q^2+1, c^2+1)");
print("==========================================================");
print("");

\\ Helper: compute Hilbert symbol invariant
\\ hilbert(a,b,p) returns +1 (trivial) or -1 (non-trivial).
\\ Brauer-invariant of a Hilbert-symbol class:  0 (if +1) or 1/2 (if -1).
\\ We return integer 0 or 1 (=1/2 in (1/2)Z/Z).
inv_from_hilb(a, b, p) = {
  my(h);
  if(a == 0 || b == 0, return(0));
  h = hilbert(a, b, p);
  if(h == 1, 0, 1);
};

\\ Per-fiber analysis -- use a block { } to allow multi-line for loops
{
for(fi = 1, length(fibers),
  mn = fibers[fi];
  mm = mn[1];
  nn = mn[2];
  qn = 2*mm*nn;
  qd = mm^2 - nn^2;
  hyp = mm^2 + nn^2;
  qsq_plus_1_num = qn^2 + qd^2;
  qsq_plus_1_den = qd^2;

  print("==================================================");
  print("Fiber (m,n) = (", mm, ",", nn, "),  q = ", qn, "/", qd);
  print("  q^2 + 1 numerator   = ", qsq_plus_1_num);
  print("  q^2 + 1 denominator = ", qsq_plus_1_den);
  print("  m^2+n^2 = hyp = ", hyp, ",   hyp^2 = ", hyp^2);
  print("  is_square(qn^2+qd^2)? ", issquare(qsq_plus_1_num),
        ",  sqrt = ", sqrtint(qsq_plus_1_num));
  print("  ==> q^2+1 = (", hyp, "/", qd, ")^2,  RATIONAL SQUARE.");
  print("");

  \\ Class of q^2+1 in Q*/Q*^2 (squarefree representative).
  \\ Since q^2+1 = N^2/D^2 with N=hyp, D=qd, its squarefree part is 1.
  \\ Equivalently a_class = qsq_plus_1_num * qsq_plus_1_den = (hyp*qd)^2
  \\ which is also a square. Confirm:
  a_class = qsq_plus_1_num * qsq_plus_1_den;
  print("  a_class = (q^2+1 num)*(q^2+1 den) = ", a_class,
        " ; is_square? ", issquare(a_class));

  \\ Test c-values:
  \\  c=0     : the 3 known 2-torsion degenerate points all give c=0
  \\  c=infty : the 4 order-4 torsion points are at the pole; treated separately
  \\  c=infty's "approach" via 1/c -> 0: would need a different chart for alpha
  \\  c in {1,2,3,1/2,5,-1, q}: generic baseline samples
  c_values = [0, 1, 2, 3, 1/2, 5, -1, qn/qd];

  print("");
  print("  Per-c, per-prime Brauer invariants (0 or 1, meaning 0 or 1/2 mod Z):");
  print("  c-value          c^2+1         inv_2  inv_3  inv_5   sum mod 1");
  print("  -------------------------------------------------------------------");

  for(ci = 1, length(c_values),
    cv = c_values[ci];
    cs1 = cv^2 + 1;
    cs1_num = numerator(cs1);
    cs1_den = denominator(cs1);
    b_class = cs1_num * cs1_den;

    iv2 = inv_from_hilb(a_class, b_class, 2);
    iv3 = inv_from_hilb(a_class, b_class, 3);
    iv5 = inv_from_hilb(a_class, b_class, 5);
    sm = (iv2 + iv3 + iv5) % 2;
    print("  c=", cv, "   c^2+1=", cs1, "   ", iv2, "      ", iv3, "      ", iv5, "      ", sm);
  );

  \\ Also test pole approach: alpha at c=infty via "1/c -> 0" needs reformulation
  \\ but the Hilbert symbol (q^2+1, t^2 + (1/c)^2*X) form. For our candidate
  \\ the natural "value at infinity" comes from rescaling the K3 model.
  \\ We don't have a separate well-defined evaluation; report this.
  print("");
  print("  (Order-4 torsion points lie at c=infty pole of phi; the candidate");
  print("   class alpha = (q^2+1, c^2+1) does not directly extend there.");
  print("   But since alpha is GLOBALLY trivial (q^2+1 is a square), this");
  print("   does not change the verdict.)");

  print("");
  print("  Hilbert symbol verification (raw):");
  print("    hilbert(qsq_plus_1_num, 5, 2)  = ", hilbert(qsq_plus_1_num, 5, 2));
  print("    hilbert(qsq_plus_1_num, 5, 3)  = ", hilbert(qsq_plus_1_num, 5, 3));
  print("    hilbert(qsq_plus_1_num, 5, 5)  = ", hilbert(qsq_plus_1_num, 5, 5));
  print("    hilbert(hyp^2, 5, 2)           = ", hilbert(hyp^2, 5, 2));
  print("    hilbert(hyp^2, 5, 3)           = ", hilbert(hyp^2, 5, 3));
  print("    hilbert(hyp^2, 5, 5)           = ", hilbert(hyp^2, 5, 5));
  print("");
);
}

print("==========================================================");
print("AGGREGATE TABLE: per-(fiber, c-value) sum of inv_p across p={2,3,5}");
print("==========================================================");
print("");
print("Since q^2+1 = (m^2+n^2)^2/(m^2-n^2)^2 is a rational square at every");
print("fiber, hilbert(q^2+1, *, p) = +1 identically, so inv_p(alpha) = 0");
print("for every fiber, every prime, every c in V_q(Q_p).");
print("");
print("Reciprocity sum   sum_p inv_p(alpha) = 0   identically.");
print("");
print("VERDICT: No Brauer-Manin obstruction from the candidate Hilbert-");
print("symbol class alpha = (q^2+1, c^2+1) at any of the 4 BEYOND-QC fibers.");
print("");
print("HONEST CAVEAT: This is a single explicit candidate. Br(V)_tr^{G_Q}");
print("has dimension 0-3 over F_2 (per PICK-15). The 'right' generator");
print("(if any) is NOT this Hilbert symbol -- it must avoid the trivializing");
print("Pythagorean square structure.");
print("");

\\ ================================================================
\\ STRUCTURAL REMARK on V_q
\\ ================================================================
\\ On V_q itself, we have the IDENTITIES of squares:
\\    c^2 + 1     = f^2   (a square)
\\    c^2 + q^2   = e^2   (a square)
\\    c^2 + 1+q^2 = g^2   (a square)
\\ Therefore ANY Hilbert-symbol class (X, c^2 + 1)_p with X using only
\\ rational constants depending on q (e.g. q, q^2+1, q^2-1, etc.) will
\\ have second argument a square on V_q itself, making the symbol trivial
\\ at every place EVERYWHERE on V_q(A_Q). Identical comments for symbols
\\ using c^2+q^2 or c^2+1+q^2 as one entry.

print("STRUCTURAL OBSTRUCTION TO HILBERT-SYMBOL CANDIDATES:");
print("On V_q the three quadratic forms c^2+1, c^2+q^2, c^2+1+q^2 are all");
print("SQUARES (= f^2, e^2, g^2). Hence ANY Hilbert symbol (*, c^2+1) or");
print("(*, c^2+q^2) or (*, c^2+1+q^2) restricted to V_q is trivial at every");
print("prime and every local point in V_q(Q_p). All naive 'face-based'");
print("Hilbert classes are killed by the defining equations of V_q.");
print("");
print("This is a strong structural reason why the transcendental Brauer");
print("class (if any non-trivial one exists in Br(V)_tr^{G_Q}) must use");
print("MORE EXOTIC entries -- e.g. linear combinations of (e+f),(e-f),");
print("(g+f),(g-f),(g+e),(g-e), or 2-descent classes from one of the five");
print("elliptic factors E_ef, E_eg, E_fg, E_H+, E_H- of J(V_q).");
print("");

\\ Test the alternative naive candidates beta = (c, c^2+q^2) and gamma = (c, c^2+1)
\\ Both factor through V_q where c^2+q^2 = e^2 and c^2+1 = f^2 are squares.
\\ So both are trivial on V_q -- but let's verify at one fiber's c-baseline.
print("Sanity-verification of two alternative candidates at fiber (61,38):");
{
mm = 61; nn = 38;
qn = 2*mm*nn; qd = mm^2 - nn^2;
\\ q^2 + 1 is square already, used above.
\\ For point (c,e,f,g) on V_q with c rational, we just test Hilbert symbols
\\ at the formal level (treating c^2+q^2 as a number, not via its identity to e^2).
\\ But the point is alpha|_V_q must vanish where the structural identity holds.

\\ Take c=2, so c^2+q^2 = 4 + (4636/2277)^2 = (4*qd^2 + qn^2)/qd^2
\\                      = (4*2277^2 + 4636^2)/2277^2
\\                      = (20739716 + 21492496)/5184729
\\                      = 42232212/5184729
\\ Is this a square? On V_q, yes (= e^2). Let's check.
cv = 2;
ee_sq_num = cv^2 * qd^2 + qn^2;     \\ numerator of c^2 + q^2
ee_sq_den = qd^2;
print("  At c=2: e^2 = c^2+q^2 = ", ee_sq_num, "/", ee_sq_den);
print("  is_square(numerator)? ", issquare(ee_sq_num));
print("  is_square(c^2+1=5)? ", issquare(5));
print("  --> c=2 is NOT generally on V_q over Q (would need rational e).");
print("  This confirms: V_q(Q) is constrained; alpha at a putative Q-point");
print("  evaluates with c^2+q^2 = (rational e)^2 making it a square.");
print("");
print("  In summary: ANY Hilbert symbol class on V_q whose second argument");
print("  is a defining quadratic form of V_q is automatically trivial at all");
print("  rational points -- so cannot give a Brauer-Manin obstruction.");
}

print("==========================================================");
print("FINAL VERDICT (across all 4 fibers, all 3 primes, candidate alpha):");
print("==========================================================");
print("");
print("  fiber       p=2     p=3     p=5    sum mod 1   obstruction?");
print("  (61,38)     0       0       0      0           NO");
print("  (63,38)     0       0       0      0           NO");
print("  (73,24)     0       0       0      0           NO");
print("  (88,35)     0       0       0      0           NO");
print("");
print("Conclusion: This specific candidate Hilbert-symbol class gives NO");
print("Brauer-Manin obstruction at any of the 4 BEYOND-QC fibers. The class");
print("is identically trivial because q^2+1 is a square for Pythagorean q.");
print("");
print("This does NOT rule out Brauer obstruction at these fibers with a");
print("different generator of Br(V_q)_tr. Such a generator must avoid the");
print("structural squares (q^2+1, c^2+1, c^2+q^2, c^2+1+q^2) which all");
print("automatically trivialize Hilbert symbols on V_q.");

quit;
