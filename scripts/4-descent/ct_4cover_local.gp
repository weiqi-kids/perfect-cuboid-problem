\\ ct_4cover_local.gp
\\ ===================
\\ Determine <beta_3, beta_4> via local solubility of the 4-cover D_{beta_3, beta_4}.
\\
\\ The 4-cover D is defined by:
\\   v_1² = (X - e_1)
\\   v_2² = -759 (X - e_2)
\\   w_1² = 8012167 (X - e_1)
\\   w_2² = 6913 (X - e_2)
\\ (third components determined by product constraints).
\\
\\ For each place v, check if there exists X in Q_v such that all 4 equations are
\\ simultaneously solvable in Q_v. If yes at all v: <CT> = 0. If no at some v:
\\ contribution += 1 from that v; total (mod 2) = <CT>.
\\
\\ Method:
\\   For finite p: brute search X mod p^N for sufficient N, check existence.
\\   For oo: check sign conditions.
\\
\\ Note: combining v_1, w_1: (w_1/v_1)² = 8012167.  So if v_1 != 0:
\\   8012167 must be a Q_v-square.
\\ If v_1 = 0 (X = e_1): then we need v_2, w_2 nonzero with right ratios, etc.
\\ So local solubility = "8012167 is a Qv square" OR "X=e_1 with appropriate other-squares" OR
\\   "X=e_2 with appropriate" OR "X=e_3 with appropriate".

default(parisize, 1500000000);

e1 = -298991117938864;
e2 =  136054851567711;
e3 =  162936266371152;
BAD = [2, 3, 5, 7, 11, 19, 23, 31, 61, 223, 337, 1033];
PLACES = concat([0], BAD);

\\ Quadruple of d_i pairs for the 4-cover (β_3 = (1, -759, -759), β_4 = (8012167, 6913, 1159))
\\ Pair for each i: (a_i(β_3), a_i(β_4)).
PAIRS = [[1, 8012167], [-759, 6913], [-759, 1159]];

is_sq_Qp(z, p) =
{
  my(v, u);
  if(z == 0, return(1));
  if(p == 0, return(z > 0));
  v = valuation(z, p);
  if(v % 2 != 0, return(0));
  u = z / p^v;
  if(p == 2, return(Mod(u, 8) == Mod(1, 8)));
  return(issquare(Mod(u, p)));
};

\\ Check: at place v, does there exist X in Q_v such that for each i,
\\  (X - e_i)/a_i(β_3) AND (X - e_i)/a_i(β_4) are both Q_v-squares?
\\
\\ Equivalently: there exists X with (X - e_i) in a_i(β_3) Q_v^2 AND
\\                                  (X - e_i) in a_i(β_4) Q_v^2.
\\ Both together: (X - e_i) in (a_i(β_3) ∩ a_i(β_4)) Q_v^2.
\\ The intersection a_i(β_3) Q_v^2 ∩ a_i(β_4) Q_v^2 in Q_v* is nonempty iff
\\ a_i(β_3) / a_i(β_4) is a Q_v-square.

\\ Equivalently: for each i, t_i := a_i(β_3) * a_i(β_4) must be a Q_v-square
\\ (multiplying by a_i(β_4)^2 since a_i are class reps).
\\ Wait: a_i(β_3) Q_v^2 = a_i(β_4) Q_v^2 iff a_i(β_3) / a_i(β_4) in Q_v^2,
\\ iff a_i(β_3) * a_i(β_4) in Q_v^2 (multiplying by a_i(β_4)^2).

T = vector(3, i, PAIRS[i][1] * PAIRS[i][2]);
print("T_i = a_i(b3) * a_i(b4) = ", T);

\\ For 4-cover to have a Q_v-point with all (X - e_i) nonzero:
\\ - For each i, (X - e_i) must lie in a_i(β_3) Q_v^2 (witness for β_3)
\\ - AND (X - e_i) must lie in a_i(β_4) Q_v^2 (witness for β_4)
\\ - Together: a_i(β_3) Q_v^2 = a_i(β_4) Q_v^2, i.e., T_i is a Q_v-square.
\\
\\ So the existence of a "generic" Q_v-point requires T_1, T_2, T_3 all Q_v-squares.
\\
\\ If some T_i is not a Q_v-square: GENERIC branch fails at v.
\\ But we may still have Q_v-points at X = e_j for some j (degenerate branch).

\\ Degenerate branch: X = e_j.
\\ Then (X - e_j) = 0; vacuously in any square class.
\\ For i ≠ j: (X - e_i) = (e_j - e_i). Need this to be in a_i(β_3) Q_v^2 AND a_i(β_4) Q_v^2.

\\ So 4-cover locally soluble at v iff:
\\   GENERIC: T_1, T_2, T_3 all Q_v-squares
\\   OR DEGENERATE_1 (X = e_1): for i=2: (e_1-e_2)/a_2(β_3) and (e_1-e_2)/a_2(β_4) both squares;
\\                              for i=3: (e_1-e_3)/a_3(β_3) and (e_1-e_3)/a_3(β_4) both squares
\\   OR DEGENERATE_2 (X = e_2): analogous
\\   OR DEGENERATE_3 (X = e_3): analogous

print("");
print("=== Local solubility of 4-cover D_{β_3, β_4} ===");

\\ Generic branch condition
generic_branch(v) =
{
  return(is_sq_Qp(T[1], v) && is_sq_Qp(T[2], v) && is_sq_Qp(T[3], v));
};

\\ Degenerate at X = e_j
degen_branch(j, v) =
{
  my(ej, ok = 1);
  ej = [e1, e2, e3][j];
  for(i = 1, 3,
    if(i != j,
      my(d_b3 = PAIRS[i][1], d_b4 = PAIRS[i][2], z1, z2);
      z1 = (ej - [e1, e2, e3][i]) / d_b3;
      z2 = (ej - [e1, e2, e3][i]) / d_b4;
      if(!is_sq_Qp(z1, v) || !is_sq_Qp(z2, v), ok = 0; break);
    );
  );
  ok;
};

\\ Print branches per place
print("");
{
total_obstruction = 0;
for(j = 1, #PLACES,
  my(v = PLACES[j], gen, d1, d2, d3, soluble);
  gen = generic_branch(v);
  d1 = degen_branch(1, v);
  d2 = degen_branch(2, v);
  d3 = degen_branch(3, v);
  soluble = gen || d1 || d2 || d3;
  print("  v=", if(v==0,"oo",v), ": generic=", gen, " X=e1:", d1, " X=e2:", d2, " X=e3:", d3, "  ⇒ soluble=", soluble);
  if(!soluble, total_obstruction = (total_obstruction + 1) % 2);
);
print("");
print("Total obstruction places mod 2 = ", total_obstruction);
}

\\ But wait: this 'naive' check misses cases where X is generic at v but
\\ (X - e_j)/a_j(β_3) etc happen to be Q_v-squares.
\\ The generic branch is the "main" branch; degenerate is fallback.
\\ However the generic branch only requires that for SOME class representative,
\\ T_i is a Q_v-square. So we should also check whether modifying the class repr
\\ helps. But the T_i are intrinsic mod Q*^2, so no.
\\ The generic check IS correct mod squares.

\\ Hmm. The generic branch may also "fail" but still have a soluble nearby X.
\\ This is because the constraint is "exists X such that EACH (X-e_i)/a_i(β_3)
\\ and (X-e_i)/a_i(β_4) are both squares". The two conditions per i combine
\\ into "X-e_i in a_i(β_3) Q_v^2 ∩ a_i(β_4) Q_v^2".
\\ Nonempty iff a_i(β_3) Q_v^2 = a_i(β_4) Q_v^2, i.e., T_i in Q_v^2.
\\ If T_i in Q_v^2 for all i: condition is "X-e_i in a_i(β_3) Q_v^2 for all i"
\\ which is β_3's witness condition — solvable since β_3 is in Sel² and locally soluble.
\\ So generic branch succeeds at v iff all T_i in Q_v^2.

quit;
