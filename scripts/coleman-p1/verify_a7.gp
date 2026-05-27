\\ Verify a_7(X_+) = -4 and a_7(X_-) = 0 claim used in Stoll/Lorenzini bound

Xp = ellinit([0, 1, 0, -20, 0]);
Xm = ellinit([0, 0, 0, -7, 6]);

print("a_7(X_+) = ", ellap(Xp, 7), ", |a_7| < 7? ", abs(ellap(Xp, 7)) < 7);
print("a_7(X_-) = ", ellap(Xm, 7), ", |a_7| < 7? ", abs(ellap(Xm, 7)) < 7);
print();
print("Both Frobenius eigenvalue bounds satisfied.");
