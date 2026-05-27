\\ Verify isomorphism / isogeny between curves from quartic-to-W and doc forms

print("=== E_1 isomorphism check ===");
E1_doc = ellinit([0, 0, 0, -39312, 2889216]);  \\ doc form
E1_quartic = ellinit([0, -1, 0, -30, 72]);     \\ from y^2 = 5q^4 - 16q^2 + 20
print("Doc E_1     conductor: ", ellglobalred(E1_doc)[1], ", j-inv: ", E1_doc.j);
print("Quartic E_1 conductor: ", ellglobalred(E1_quartic)[1], ", j-inv: ", E1_quartic.j);
print("Same j-invariant? ", E1_doc.j == E1_quartic.j);
print("Isomorphic over Q? ", ellisomat(E1_doc, 1)[1]);
print();

print("=== E_2 isomorphism check ===");
E2_doc = ellinit([0, 0, 0, -32400, 0]);
E2_quartic = ellinit([0, 0, 0, -25, 0]);
print("Doc E_2     conductor: ", ellglobalred(E2_doc)[1], ", j-inv: ", E2_doc.j);
print("Quartic E_2 conductor: ", ellglobalred(E2_quartic)[1], ", j-inv: ", E2_quartic.j);
print("Same j-invariant? ", E2_doc.j == E2_quartic.j);
print();

\\ Hmm conductor differs (800 vs ?). Let me check ratio
print("Doc E_2 c4, c6: ", E2_doc.c4, " ", E2_doc.c6);
print("Quartic E_2 c4, c6: ", E2_quartic.c4, " ", E2_quartic.c6);
print();

\\ Now check if any are 2-isogenous (which would preserve rank 0 / rank claims)
print("=== 2-isogeny classes ===");
print("E_1 doc class: ", #ellisomat(E1_doc, 2));
print("E_1 quartic class: ", #ellisomat(E1_quartic, 2));
print();
print("E_2 doc class: ", #ellisomat(E2_doc, 2));
print("E_2 quartic class: ", #ellisomat(E2_quartic, 2));
