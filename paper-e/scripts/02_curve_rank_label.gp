\\ ============================================================
\\ 02_curve_rank_label.gp
\\ Verify E_anom: model from the quartic, minimal model, conductor,
\\ j-invariant, torsion, rank (ellrank, unconditional tightness),
\\ and Cremona/LMFDB label (ellidentify).
\\ ============================================================

print("=== Jacobian of the quartic via ellfromeqn ===");
\\ Quartic 20*z^2 = y^4 + 8 y^3 + 18 y^2 - 8 y + 1; rational point (1,1).
E_raw = ellfromeqn(20*z^2 - (y^4 + 8*y^3 + 18*y^2 - 8*y + 1));
print("ellfromeqn -> ", E_raw);
Eraw = ellinit(E_raw);
print("conductor(E_raw) = ", ellglobalred(Eraw)[1]);
print("j-invariant      = ", Eraw.j);

print("");
print("=== Minimal model ===");
Emin = ellminimalmodel(Eraw);
eminv = [Emin.a1, Emin.a2, Emin.a3, Emin.a4, Emin.a6];
print("E_min ainvs = ", eminv);
print("conductor   = ", ellglobalred(Emin)[1]);
print("disc        = ", Emin.disc, "  factored: ", factor(Emin.disc));
print("j-invariant = ", Emin.j);

print("");
print("=== Framework's claimed big model y^2 = x^3 - 5702400 x + 5225472000 ===");
Ebig = ellinit([0,0,0,-5702400,5225472000]);
print("Ebig conductor = ", ellglobalred(Ebig)[1]);
print("Ebig j         = ", Ebig.j);
EbigMin = ellminimalmodel(Ebig);
ebigminv = [EbigMin.a1, EbigMin.a2, EbigMin.a3, EbigMin.a4, EbigMin.a6];
print("Ebig minimal model ainvs = ", ebigminv);
print("Same minimal model as E_min? ", ebigminv == eminv);

print("");
print("=== Torsion ===");
T = elltors(Emin);
print("torsion structure = ", T[2], "  generators = ", T[3]);

print("");
print("=== Rank (ellrank, Cremona-Stoll 2-descent) ===");
r = ellrank(Emin);
print("ellrank(E_min) = ", r);
print("  r_low = ", r[1], "   r_up = ", r[2]);
if(r[1]==r[2], print("  => rank determined UNCONDITIONALLY = " r[1]), print("  => rank NOT pinned"));
print("  generator candidates = ", r[4]);

print("");
print("=== Generator check + saturation ===");
P = [-15, 50];
print("P = ", P, "  on curve? ", ellisoncurve(Emin, P));
print("canonical height h(P) = ", ellheight(Emin, P));
print("order(P) = ", ellorder(Emin, P), " (0 = infinite)");
print("saturation of [P] to bound 100: ", ellsaturation(Emin, [P], 100));

print("");
print("=== ellidentify (Cremona/LMFDB label) ===");
id = ellidentify(Emin);
print("ellidentify -> ", id);
print("Cremona label = ", id[1][1]);

print("");
print("=== analytic rank cross-check (ellanalyticrank) ===");
ar = ellanalyticrank(Emin);
print("ellanalyticrank = ", ar, "  (analytic rank ", ar[1], ")");
quit;
