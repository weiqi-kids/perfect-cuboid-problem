\\ Second-descent stub: for each cover C_k: y^2 = q_k(x), compute the Jacobian J(C_k)
\\ as an elliptic curve (since C_k is genus 1 over Q, locally soluble, J(C_k) = E)
\\ and do 2-descent there. The 2-Selmer group of J(C_k) injects into S^2 of E shifted by the class,
\\ and second-descent on C_k is equivalent to 2-descent on J(C_k) modulo the obstruction class.
\\
\\ This is a stub illustrating the approach; full implementation requires more care.

default(parisize, 2000000000);
default(realprecision, 38);

E_Hm = ellinit([1, 0, 0, -4201713691887954766021162410, 103564307677747011646913552825626935447972]);
A2 = 4*E_Hm.a2 + E_Hm.a1^2;
A4 = 16*E_Hm.a4;
A6 = 64*E_Hm.a6;
E_short = ellinit([0, A2, 0, A4, A6]);

covers = ell2cover(E_short);
print("Number of covers: ", #covers);

{
for(k = 1, #covers,
    print();
    print("=== Cover #", k, ": Jacobian descent ===");
    q = covers[k][1];
    print("q(x) = ", q);
    \\ Jacobian of y^2 = quartic q(x). Standard form: lift via Weierstrass form.
    \\ For y^2 = f(x) with deg f = 4 (no repeated roots), Jacobian is an elliptic curve.
    \\ PARI: ellfromj or hyperelliptic to elliptic. Actually for genus 1, easier to use
    \\ ellfromeqn:
    JF = ellfromeqn(y^2 - q);
    print("Jacobian a-invariants attempt: ", JF);
    \\ ellfromeqn may return [a, b] of y^2 = x^3 + a x + b
    if(#JF == 2,
      JE = ellinit([0, 0, 0, JF[1], JF[2]]);
      print("  Jacobian J(C_", k, ") = ellinit(", [0, 0, 0, JF[1], JF[2]], ")");
      print("  j(J) = ", JE.j);
      print("  j(E_short) = ", E_short.j);
      print("  Equal? ", JE.j == E_short.j);
      print("  rank of J(C_", k, "): ");
      t0 = getwalltime();
      rJ = ellrank(JE, 4);
      t1 = getwalltime();
      print("    ellrank = ", rJ, "  wall=", (t1-t0)/1000.0, "s");
      \\ Note: J(C_k) is Q-isomorphic to E_short, so rank(J(C_k)) = rank(E_short).
      \\ But 2-Selmer(J(C_k)) computed via different model may give different info.
      \\ This isn't really a second descent — just the Jacobian.
    );
);
}

print();
print("Note: J(C_k) is Q-isomorphic to E_short (Jacobian of a torsor IS the curve).");
print("True 'second descent' requires descent ON the cover C_k itself, ");
print("which means computing 2-Selmer of (C_k, +). This isn't directly available in PARI 2.15.4.");

quit;
