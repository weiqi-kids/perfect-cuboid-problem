\\ E_PCP: y^2 = x^3 + x^2 - x + 15
E = ellinit([0,1,0,-1,15]);
print("=== E_PCP: y^2 = x^3 + x^2 - x + 15 ===");
print("a-invariants: ", E.a1, " ", E.a2, " ", E.a3, " ", E.a4, " ", E.a6);
print("discriminant: ", E.disc);
print("conductor:    ", ellglobalred(E)[1]);
print("j-invariant:  ", E.j);
print("torsion:      ", elltors(E)[2]);
print("torsion gens: ", elltors(E)[3]);
id = ellidentify(E);
print("ellidentify:  ", id[1]);
\\ rank via ellrank
rk = ellrank(E);
print("ellrank [low,high,...]: ", rk);
\\ analytic rank
print("ellanalyticrank: ", ellanalyticrank(E));
\\ check the claimed generator P0 = (-1,4) and torsion T0=(-3,0)
P0 = [-1,4];
print("Is P0=(-1,4) on E? ", ellisoncurve(E,P0));
print("height of P0: ", ellheight(E,P0));
print("order of P0: ", ellorder(E,P0));
T0 = [-3,0];
print("Is T0=(-3,0) on E? ", ellisoncurve(E,T0));
print("order of T0: ", ellorder(E,T0));
