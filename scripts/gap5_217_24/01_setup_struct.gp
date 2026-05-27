\\ Structural analysis of E_PCP(46513/10416) at (217, 24).
\\ Compute: torsion, j-invariant, discriminant, Tamagawa, isogeny structure,
\\ CM check, Heegner discriminants, root number breakdown.

default(parisize, 1500000000);
default(realprecision, 38);

m = 217; n = 24;
q = (m^2 - n^2) / (2*m*n);
print("=== (217, 24) STRUCTURAL ANALYSIS ===");
print("m = ", m, ", n = ", n, ", q = ", q);
print("q numerator factor: ", factor(numerator(q)));
print("q denominator factor: ", factor(denominator(q)));

E = ellinit([0, 1+q^2, 0, q^2, 0]);
Em = ellminimalmodel(E, &change);
print("\nMinimal model coefficients: ", Em.a1, " ", Em.a2, " ", Em.a3, " ", Em.a4, " ", Em.a6);
print("Change of variable [u, r, s, t] = ", change);

gr = ellglobalred(Em);
N = gr[1];
print("\nConductor N = ", N);
print("Conductor factorization: ", factor(N));
print("Discriminant Δ = ", Em.disc);
print("Discriminant factorization: ", factor(Em.disc));
print("j-invariant = ", Em.j);
print("j numerator factor: ", factor(numerator(Em.j)));

\\ Torsion
T = elltors(Em);
print("\nTorsion subgroup: order = ", T[1], " structure = ", T[2]);
for(i=1, #T[3], print("  T[", i, "] = ", T[3][i]));

\\ Root number breakdown (local root numbers at bad primes)
print("\nLocal data table:");
for(i=1, #gr[3], my(p=gr[3][i][1], f=gr[3][i][2], kt=gr[3][i][3], cp=gr[3][i][4]);
   print("  p = ", p, "  f_p = ", f, "  Kodaira = ", ellidentify(Em)[1], "  Kodaira-type = ", kt, "  c_p = ", cp));
print("Tamagawa product: ", gr[4]);
print("Global root number w(E) = ", ellrootno(Em));
print("Local root numbers at bad primes:");
for(i=1, #gr[3], my(p=gr[3][i][1], wp=ellrootno(Em, p));
   print("  w_", p, " = ", wp));
print("w_∞ = ", ellrootno(Em, 0));

\\ Isogeny class
print("\n--- Isogeny analysis ---");
iso = ellisomat(Em, 0, 1);
print("Number of curves in 2-isogeny class: ", #iso[1]);
print("Isogeny matrix:");
print(iso[2]);
for(i=1, #iso[1], my(Ei = ellinit(iso[1][i]));
   print("  E_", i, ": coeffs = ", iso[1][i], "  Δ = ", ellminimalmodel(Ei).disc, "  N = ", ellglobalred(Ei)[1]));

\\ CM check
print("\nCM check: j = ", Em.j);
\\ Class-number-1 CM j-invariants
cm_js = [0, 1728, -3375, 8000, 54000, -32768, 287496, -12288000, 16581375, -884736, -884736000, -147197952000, -262537412640768000];
print("j in CM list? ", vecsearch(cm_js, Em.j));

\\ For Heegner: find discriminants D < 0 satisfying Heegner hypothesis
print("\nHeegner discriminant candidates:");
for(D = -3, -200, my(d = D);
   if(d % 4 == 0 || d % 4 == 1,
      \\ Heegner: every bad prime p of N is split or ramified in Q(sqrt(D))
      \\ But more refined: (D / p) != -1 for all p | N (except some)
      my(ok = 1);
      fwd(N, e, my(p = e[1]); if(kronecker(d, p) == -1, ok = 0; break));
      if(ok, print("  D = ", d, " kronecker = ", apply(p -> kronecker(d, p), [2, 3, 7, 31, 193, 241])))));

quit;
