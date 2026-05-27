\\ For q_0 = 15/8 (rank 5 = genus 5), look for actual rational points
\\ V_{q_0}: c^2 + q_0^2 = e^2, c^2 + 1 = f^2, c^2 + 1 + q_0^2 = g^2

print("Search V_{15/8}(Q) for c = m/n with |m|, |n| <= 100:");
q0 = 15/8;
found_c = [];
for(m = -200, 200, for(n = 1, 100, if(gcd(m, n) == 1, c = m/n; e2 = c^2 + q0^2; f2 = c^2 + 1; g2 = c^2 + 1 + q0^2; if(issquare(e2) && issquare(f2) && issquare(g2), found_c = concat(found_c, [c])))))
print("Rational c values found: ", found_c);

print("\nSearch V_{20/21}(Q) for c = m/n with |m|, |n| <= 100:");
q0 = 20/21;
found_c = [];
for(m = -200, 200, for(n = 1, 100, if(gcd(m, n) == 1, c = m/n; e2 = c^2 + q0^2; f2 = c^2 + 1; g2 = c^2 + 1 + q0^2; if(issquare(e2) && issquare(f2) && issquare(g2), found_c = concat(found_c, [c])))))
print("Rational c values found: ", found_c);

print("\nSearch V_{7/24}(Q) for c = m/n with |m|, |n| <= 100:");
q0 = 7/24;
found_c = [];
for(m = -200, 200, for(n = 1, 100, if(gcd(m, n) == 1, c = m/n; e2 = c^2 + q0^2; f2 = c^2 + 1; g2 = c^2 + 1 + q0^2; if(issquare(e2) && issquare(f2) && issquare(g2), found_c = concat(found_c, [c])))))
print("Rational c values found: ", found_c);

print("\nSearch V_{4/3}(Q) for c = m/n with |m|, |n| <= 200:");
q0 = 4/3;
found_c = [];
for(m = -200, 200, for(n = 1, 100, if(gcd(m, n) == 1, c = m/n; e2 = c^2 + q0^2; f2 = c^2 + 1; g2 = c^2 + 1 + q0^2; if(issquare(e2) && issquare(f2) && issquare(g2), found_c = concat(found_c, [c])))))
print("Rational c values found: ", found_c);
