\\ ============================================================
\\ Coleman residue computation v2 — clean variable usage
\\ ============================================================

print("=== Coleman residue disk analysis at p = 7 ===");
print();

p = 7;

\\ Enumerate F_7 affine points; store in list 'pts'
{
my(pts, qm, v1, v2);
pts = [];
for(qz = 0, 6,
  qm = Mod(qz, 7);
  v1 = lift(5*qm^4 - 16*qm^2 + 20);
  v2 = lift(5*qm^4 + 20);
  for(ez = 0, 6, if(Mod(ez^2, 7) == v1,
    for(gz = 0, 6, if(Mod(gz^2, 7) == v2,
      pts = concat(pts, [[qz, ez, gz]]);
    ));
  ));
);
print("Found ", #pts, " F_7 affine points");
print();

print("=== Verifying nu_P(omega_1) = 0 at each P_0 ===");
print("For omega_1 = dq/(eg), at P_0 = (q_0, e_0, g_0) with q uniformizer:");
print("  Leading coefficient of omega_1 = 1/(e_0 * g_0) mod 7");
print();

my(P, qa, ea, ga, prod, lead, all_ok);
all_ok = 1;
for(i = 1, #pts,
  P = pts[i];
  qa = P[1]; ea = P[2]; ga = P[3];
  prod = Mod(ea * ga, 7);
  lead = if(prod != 0, 1/prod, "UNDEF");
  if(prod == 0, all_ok = 0);
  print("  P_", i, " = (", qa, ",", ea, ",", ga, "): e_0*g_0 = ", lift(prod), ", lead = ", lead);
);
print();
if(all_ok,
  print("RESULT: nu_P(omega_1) = 0 at ALL 16 residue disks."),
  print("RESULT: omega_1 vanishes at some disk.")
);
}

print();
print("=== Now also check omega_3 = q^2 dq/(eg) ===");
{
my(pts, qm, v1, v2);
pts = [];
for(qz = 0, 6,
  qm = Mod(qz, 7);
  v1 = lift(5*qm^4 - 16*qm^2 + 20);
  v2 = lift(5*qm^4 + 20);
  for(ez = 0, 6, if(Mod(ez^2, 7) == v1,
    for(gz = 0, 6, if(Mod(gz^2, 7) == v2,
      pts = concat(pts, [[qz, ez, gz]]);
    ));
  ));
);

my(P, qa, ea, ga, lead, has_zero);
has_zero = 0;
for(i = 1, #pts,
  P = pts[i];
  qa = P[1]; ea = P[2]; ga = P[3];
  lead = Mod(qa^2, 7) / Mod(ea * ga, 7);
  if(Mod(qa^2, 7) == 0, has_zero = 1);
  print("  P_", i, " = (", qa, ",", ea, ",", ga, "): q_0^2 = ", lift(Mod(qa^2, 7)), ", lead(omega_3) = ", lead);
);
print();
if(has_zero,
  print("omega_3 vanishes where q_0 = 0 mod 7. (But omega_1 still works)"),
  print("omega_3 also nonvanishing on all 16 disks.")
);
}
