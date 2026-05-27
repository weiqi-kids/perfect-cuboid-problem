\\ ct_4cover_full.gp
\\ ==================
\\ Compute CT(beta_3, beta_4) via local solubility of the 4-cover D_{beta_3, beta_4}
\\ at all places.  Robust check including all degenerate branches.

default(parisize, 1500000000);

e1 = -298991117938864;
e2 =  136054851567711;
e3 =  162936266371152;
BAD = [2, 3, 5, 7, 11, 19, 23, 31, 61, 223, 337, 1033];
PLACES = concat([0], BAD);
PNAMES = vector(#PLACES, j, if(PLACES[j]==0, "oo", Str(PLACES[j])));
E_arr = [e1, e2, e3];

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

\\ For pair (alpha, beta) and place v:
\\ generic branch OK iff a_i(α)·a_i(β) is Q_v-square for all i (T_i sq in Q_v).
\\ degen branch X = e_j OK iff for each i ≠ j, (e_j - e_i)/a_i(α) AND (e_j - e_i)/a_i(β) both Q_v-squares.

generic_OK(alpha, beta, v) =
{
  my(ok = 1);
  for(i = 1, 3,
    my(T = alpha[i] * beta[i]);
    if(!is_sq_Qp(T, v), ok = 0; break);
  );
  ok;
};

degen_OK(alpha, beta, jj, v) =
{
  my(ej = E_arr[jj], ok = 1);
  for(i = 1, 3,
    if(i != jj,
      if(!is_sq_Qp((ej - E_arr[i]) / alpha[i], v), ok = 0; break);
      if(!is_sq_Qp((ej - E_arr[i]) / beta[i], v), ok = 0; break);
    );
  );
  ok;
};

local_soluble(alpha, beta, v) =
{
  if(generic_OK(alpha, beta, v), return(1));
  if(degen_OK(alpha, beta, 1, v), return(1));
  if(degen_OK(alpha, beta, 2, v), return(1));
  if(degen_OK(alpha, beta, 3, v), return(1));
  return(0);
};

CT_pair(alpha, beta) =
{
  my(total = 0);
  for(j = 1, #PLACES,
    if(!local_soluble(alpha, beta, PLACES[j]), total = (total + 1) % 2);
  );
  total;
};

\\ Per-place detail printout
print_detail(alpha, beta, name) =
{
  print("");
  print("=== ", name, " ===");
  print(" v   | Gen | X=e1 | X=e2 | X=e3 | Solu | Obstruction");
  my(total = 0);
  for(j = 1, #PLACES,
    my(v = PLACES[j], g, d1, d2, d3, sol, obs);
    g = generic_OK(alpha, beta, v);
    d1 = degen_OK(alpha, beta, 1, v);
    d2 = degen_OK(alpha, beta, 2, v);
    d3 = degen_OK(alpha, beta, 3, v);
    sol = g || d1 || d2 || d3;
    obs = if(sol, 0, 1);
    total = (total + obs) % 2;
    print(" ", PNAMES[j], "  |  ", g, "  |  ", d1, "  |  ", d2, "  |  ", d3, "  |  ", sol, "  |  ", obs);
  );
  print("Total <", name, "> = ", total);
  total;
};

beta_3 = [1, -759, -759];
beta_4 = [8012167, 6913, 1159];
beta_1 = [16307767, -16307767, -1];
beta_2 = [28243056730, -3082611455, -586454];

\\ Main computation
v_main = print_detail(beta_3, beta_4, "beta_3, beta_4");

\\ Cross-checks
print("");
print("=== Cross-checks (alternating + torsion-vanishing) ===");
print("<beta_3, beta_3> = ", CT_pair(beta_3, beta_3), " (should be 0)");
print("<beta_4, beta_4> = ", CT_pair(beta_4, beta_4), " (should be 0)");
print("<beta_1, beta_1> = ", CT_pair(beta_1, beta_1), " (should be 0)");
print("<beta_2, beta_2> = ", CT_pair(beta_2, beta_2), " (should be 0)");
print("<beta_1, beta_3> = ", CT_pair(beta_1, beta_3), " (torsion-image; should be 0)");
print("<beta_2, beta_3> = ", CT_pair(beta_2, beta_3), " (torsion-image; should be 0)");
print("<beta_1, beta_4> = ", CT_pair(beta_1, beta_4), " (torsion-image; should be 0)");
print("<beta_2, beta_4> = ", CT_pair(beta_2, beta_4), " (torsion-image; should be 0)");
print("<beta_1, beta_2> = ", CT_pair(beta_1, beta_2), " (both torsion; should be 0)");
print("");
print("<beta_3, beta_4> = ", CT_pair(beta_3, beta_4));
print("<beta_4, beta_3> = ", CT_pair(beta_4, beta_3), " (symmetry check)");

print("");
print("======================================================");
print("FINAL <beta_3, beta_4> = ", v_main);
print("======================================================");

quit;
