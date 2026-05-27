\\ The genus-3 curve T^2 = t^8 + 68 t^6 - 122 t^4 + 68 t^2 + 1
\\ Palindrome substitution W = t + 1/t, S = T/t^2 gives S^2 = W^4 + 64 W^2 - 256.
\\ Verify that S^2 = W^4 + 64 W^2 - 256 is birational to E_PCP: y^2=x^3+x^2-x+15.
\\ A quartic S^2 = f(W) with a rational point has Jacobian an elliptic curve.
\\ Standard: y^2 = quartic in W -> Weierstrass. Use ellfromeqn.
print("=== Quartic C0: S^2 = W^4 + 64 W^2 - 256 ===");
\\ check rational points: W=2 -> 16+256-256=16=4^2 ; so (W,S)=(2,4) rational point
print("W=2: f = ", 2^4+64*2^2-256, " (should be 16=4^2)");
\\ Build Weierstrass model of the quartic genus-1 curve via ellfromeqn
E0 = ellfromeqn(S^2 - (W^4 + 64*W^2 - 256));
print("ellfromeqn -> ", E0);
Ew = ellinit(E0);
Ewm = ellminimalmodel(Ew);
print("minimal model: ", Ewm[1..5]);
print("conductor of quartic Jacobian: ", ellglobalred(Ewm)[1]);
print("ellidentify quartic Jacobian: ", ellidentify(Ewm)[1][1]);
\\ Compare with E_PCP
Epcp = ellinit([0,1,0,-1,15]);
print("E_PCP ellidentify: ", ellidentify(Epcp)[1][1]);
print("isomorphic over Q? ", ellisomat(Ewm,,1)!=0 );
\\ direct: are they Q-isomorphic?
print("ellisisom-style via j: jE0=",Ewm.j, " jEpcp=", Epcp.j);
