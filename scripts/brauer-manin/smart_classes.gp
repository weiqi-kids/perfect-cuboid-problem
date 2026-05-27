\\ ============================================================
\\ Smart Brauer-Manin Hilbert-symbol candidate classes on V_q
\\
\\ Track I (local_invariants.gp) ruled out all "naive" candidates whose
\\ second slot equals one of the defining quadratic forms c^2+1, c^2+q^2,
\\ c^2+1+q^2 (each a square on V_q) or q^2+1 (a square for Pythagorean q).
\\
\\ Smart-class strategy:
\\   d in { e+f, e-f, e+g, e-g, f+g, f-g, e*f, e*g, f*g, e*f*g }
\\   X in { -1, 2, -2, 3, -3, 5, -5, 6, -6, 7, -7, 10, -10, 15 }
\\
\\ d is NOT a square on V_q (it is a sum/diff/product of square roots).
\\ Evaluate d at the 8 c=0 baseline points of V_q:
\\   c=0 ==> e = +/- q,  f = +/- 1,  g = +/- w/D  with w=m^2+n^2, D=m^2-n^2.
\\
\\ KEY METHODOLOGICAL POINT (corrected from earlier draft):
\\ ---------------------------------------------------------
\\ Global Hilbert reciprocity says that for ANY rationals a, b in Q*,
\\   prod_{all primes p, incl. infty} hilbert(a,b,p) = +1,
\\ i.e. sum_p inv_p(a,b) = 0 mod 2.  This holds at EVERY rational point.
\\ Therefore the reciprocity sum CAN NEVER detect a Brauer-Manin obstruction
\\ from a single rational point evaluation -- the sum is identically 0.
\\
\\ What we CAN do for a Brauer class is:
\\   1. Compute the full local invariant TUPLE (inv_p)_p at each baseline.
\\   2. Check whether this tuple is the SAME across all 8 c=0 baselines.
\\      If YES, the candidate represents a well-defined locally-constant
\\      function on the c=0 stratum of V_q(A_Q) -- a precondition for
\\      being a coherent Brauer class.
\\   3. Check whether this tuple is NONTRIVIAL (some inv_p != 0).
\\      A nontrivial-but-constant tuple is interesting: it means the
\\      candidate Hilbert symbol pulled back to V_q produces a definite
\\      ramification pattern at c=0.
\\
\\ Even so: the partial sum sum_p inv_p (over the FULL prime support) is
\\ always 0 (reciprocity), so it tells us nothing. We instead look at the
\\ invariant *vector* and whether it depends on the choice of baseline.
\\ ============================================================

default(parisize, 500000000);

fibers = [[61,38], [63,38], [73,24], [88,35]];
\\ Restricted prime list: those of small absolute value. Hilbert symbols at
\\ p outside the bad set are automatically 0 (when a,b are units at p), so
\\ this captures the "local interesting" places. For the full reciprocity
\\ check we use a separate function that auto-detects bad primes.
primelist = [2, 3, 5, 7, 11, 13, 0];   \\ 0 = archimedean place in PARI
prime_labels = ["2", "3", "5", "7", "11", "13", "oo"];
X_values = [-1, 2, -2, 3, -3, 5, -5, 6, -6, 7, -7, 10, -10, 15];
d_labels = ["e+f","e-f","e+g","e-g","f+g","f-g","e*f","e*g","f*g","e*f*g"];

inv_p_fn(a, b, p) = {
  my(h);
  if(a == 0 || b == 0, return(-1));   \\ -1 sentinel: undefined
  h = hilbert(a, b, p);
  if(h == 1, 0, 1);
};

\\ Full reciprocity sum: extract all primes from a*b*2 and sum invariants.
\\ Always 0 mod 2 for rational a, b. Used as a self-consistency check.
full_reciprocity_sum(a, b) = {
  my(s, f, p);
  if(a == 0 || b == 0, return(-1));
  s = 0;
  \\ Combine numerators and denominators of a and b times 2 to find bad primes
  f = factor(numerator(a)*denominator(a)*numerator(b)*denominator(b)*2);
  for(i = 1, matsize(f)[1],
    p = f[i,1];
    if(p > 0,
      s = s + inv_p_fn(a, b, p);
    );
  );
  s = s + inv_p_fn(a, b, 0);
  s % 2;
};

d_eval(d_idx, se, sf, sg, q, wD) = {
  my(e, f, g);
  e = se * q;
  f = sf * 1;
  g = sg * wD;
  if(d_idx == 1, return(e + f));
  if(d_idx == 2, return(e - f));
  if(d_idx == 3, return(e + g));
  if(d_idx == 4, return(e - g));
  if(d_idx == 5, return(f + g));
  if(d_idx == 6, return(f - g));
  if(d_idx == 7, return(e * f));
  if(d_idx == 8, return(e * g));
  if(d_idx == 9, return(f * g));
  if(d_idx == 10, return(e * f * g));
  error("bad d_idx");
};

print("====================================================================");
print("SMART BRAUER-MANIN HILBERT-SYMBOL CANDIDATES on V_q");
print("====================================================================");
print("");
print("For each fiber, each of 10 d-candidates, each of 14 X values:");
print("  - evaluate d at 8 baseline c=0 points (signs of e,f,g)");
print("  - compute inv_p(d,X) at p in {2,3,5,7,11,13,oo}");
print("  - check (a) full reciprocity sum (must be 0 by Hilbert reciprocity)");
print("           (b) whether the local invariant TUPLE is constant on baselines");
print("           (c) whether it is nontrivial");
print("");
print("A candidate is INTERESTING if its invariant tuple is constant across");
print("ALL 8 baselines AND nontrivial. This means the Hilbert symbol descends");
print("to a well-defined locally constant function on the c=0 stratum of V_q.");
print("");

\\ Sanity-check global reciprocity on a sample
{
print("Sanity: global reciprocity sum for a=6913/2277, b=-1 (sample):");
print("  sum = ", full_reciprocity_sum(6913/2277, -1), "  (must be 0)");
print("");
}

\\ Aggregated counter
flagged_total = 0;
nontrivial_constant_total = 0;
trivial_constant_total = 0;
varies_total = 0;

\\ Build 8 baselines once
baselines = [];
{
for(s1 = 0, 1, for(s2 = 0, 1, for(s3 = 0, 1,
  se = if(s1==0,1,-1);
  sf = if(s2==0,1,-1);
  sg = if(s3==0,1,-1);
  baselines = concat(baselines, [[se,sf,sg]]);
)));
}

{
for(fi = 1, length(fibers),
  mn = fibers[fi];
  mm = mn[1];
  nn = mn[2];
  qn = 2*mm*nn;
  qd = mm^2 - nn^2;
  q_val = qn/qd;
  w = mm^2 + nn^2;
  wD = w/qd;

  print("==================================================");
  print("Fiber (m,n) = (", mm, ",", nn, ")");
  print("  q     = ", qn, "/", qd, " = ", q_val);
  print("  w/D   = ", w, "/", qd, " = ", wD);
  print("");

  fiber_nontrivial_constant = 0;
  fiber_trivial_constant = 0;
  fiber_varies = 0;

  for(di = 1, 10,
    for(xi = 1, length(X_values),
      X = X_values[xi];

      \\ Compute the 8x7 invariant matrix
      tuples = [];
      reciproc_sums = [];
      d_vals = [];
      bad = 0;
      for(bi = 1, 8,
        bl = baselines[bi];
        dval = d_eval(di, bl[1], bl[2], bl[3], q_val, wD);
        d_vals = concat(d_vals, dval);
        if(dval == 0, bad = 1; break);
        row = [];
        for(pi = 1, 7,
          p = primelist[pi];
          row = concat(row, inv_p_fn(dval, X, p));
        );
        tuples = concat(tuples, [row]);
        reciproc_sums = concat(reciproc_sums, full_reciprocity_sum(dval, X));
      );

      if(bad == 1, next);

      \\ Are all tuples equal?
      constant_tuple = 1;
      for(bi = 2, 8,
        for(pi = 1, 7,
          if(tuples[bi][pi] != tuples[1][pi], constant_tuple = 0; break);
        );
        if(constant_tuple == 0, break);
      );

      \\ Is the tuple nontrivial?
      nontrivial = 0;
      for(pi = 1, 7, if(tuples[1][pi] != 0, nontrivial = 1; break));

      \\ Sanity: reciprocity sums must all be 0
      recip_ok = 1;
      for(bi = 1, 8, if(reciproc_sums[bi] != 0, recip_ok = 0; break));

      if(constant_tuple == 1 && nontrivial == 1,
        fiber_nontrivial_constant = fiber_nontrivial_constant + 1;
        print(">>> CONSTANT-NONTRIVIAL  fiber (", mm, ",", nn, ")  d=", d_labels[di], "  X=", X);
        print("    tuple [2,3,5,7,11,13,oo] = ", tuples[1]);
        print("    d values across baselines:");
        for(bi = 1, 8,
          print("      sign ", baselines[bi], " -> d=", d_vals[bi]);
        );
        print("    recip sums (full): ", reciproc_sums);
        print("    NOTE: per global Hilbert reciprocity, the partial sum over");
        print("          a finite prime set may be nonzero; the FULL sum over");
        print("          all bad primes is always 0 (sanity).");
      );
      if(constant_tuple == 1 && nontrivial == 0,
        fiber_trivial_constant = fiber_trivial_constant + 1;
      );
      if(constant_tuple == 0,
        fiber_varies = fiber_varies + 1;
      );

      if(recip_ok == 0,
        print("!!! RECIPROCITY VIOLATION at fiber=(", mm, ",", nn, ") d=", d_labels[di], " X=", X, " -- BUG?");
      );
    );
  );

  print("  Fiber (", mm, ",", nn, ") summary across 10*14=140 (d,X) pairs:");
  print("    constant tuple, nontrivial  : ", fiber_nontrivial_constant);
  print("    constant tuple, trivial     : ", fiber_trivial_constant);
  print("    tuple varies between baselines : ", fiber_varies);
  print("");

  nontrivial_constant_total = nontrivial_constant_total + fiber_nontrivial_constant;
  trivial_constant_total = trivial_constant_total + fiber_trivial_constant;
  varies_total = varies_total + fiber_varies;
);
}

print("====================================================================");
print("AGGREGATE across 4 fibers, 10*14 = 140 (d,X) pairs each:");
print("  constant-tuple nontrivial : ", nontrivial_constant_total);
print("  constant-tuple trivial    : ", trivial_constant_total);
print("  tuple varies              : ", varies_total);
print("====================================================================");
print("");
print("Interpretation:");
print("  - 'constant-tuple nontrivial' candidates are the ones whose Hilbert");
print("    symbol gives an identical nontrivial local invariant pattern at all");
print("    8 c=0 baselines. These are the most promising for further Brauer-");
print("    class investigation: the pattern is uniform on the degenerate fiber.");
print("  - 'constant-tuple trivial' candidates are uniformly zero -- no info.");
print("  - 'varies' candidates: the Hilbert symbol depends on the sign choice");
print("    of (e, f, g) at c=0. This means the symbol does NOT factor through");
print("    Br(V_q): different rational points in the same baseline cluster");
print("    give different local invariants. NOT a Brauer class.");
print("");

\\ Full dump of invariants per fiber/d/X for the appendix
print("====================================================================");
print("FULL DUMP: inv_p tuple at each baseline for every (fiber, d, X)");
print("Format: signs (se,sf,sg)  d_val  [inv_2, inv_3, inv_5, inv_7, inv_11, inv_13, inv_oo]");
print("====================================================================");

{
for(fi = 1, length(fibers),
  mn = fibers[fi];
  mm = mn[1];
  nn = mn[2];
  qn = 2*mm*nn;
  qd = mm^2 - nn^2;
  q_val = qn/qd;
  w = mm^2 + nn^2;
  wD = w/qd;

  print("");
  print("##########################################");
  print("Fiber (", mm, ",", nn, ")");
  print("##########################################");

  for(di = 1, 10,
    for(xi = 1, length(X_values),
      X = X_values[xi];
      print("");
      print("---- d = ", d_labels[di], ",  X = ", X, " ----");
      for(bi = 1, 8,
        bl = baselines[bi];
        dval = d_eval(di, bl[1], bl[2], bl[3], q_val, wD);
        if(dval == 0,
          print("  signs ", bl, "   d=0   (degenerate, skipped)");
        ,
          row = vector(7);
          for(pi = 1, 7,
            p = primelist[pi];
            row[pi] = inv_p_fn(dval, X, p);
          );
          rsum = full_reciprocity_sum(dval, X);
          print("  signs ", bl, "   d=", dval, "   tuple=", row, "   recip=", rsum);
        );
      );
    );
  );
);
}

print("");
print("====================================================================");
print("END OF DUMP");
print("====================================================================");

quit;
