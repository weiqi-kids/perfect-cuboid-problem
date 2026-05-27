import sympy as sp
t = sp.symbols('t')
f = t**8 + 68*t**6 - 122*t**4 + 68*t**2 + 1

# squarefree?
g = sp.gcd(f, sp.diff(f,t))
print("gcd(f, f') =", g, " -> squarefree iff constant")
print("squarefree:", sp.degree(g, t)==0)

# degree 8, squarefree => hyperelliptic genus = floor((deg-1)/2) = floor(7/2) = 3
print("deg f =", sp.degree(f,t), "-> genus =", (sp.degree(f,t)-1)//2)

# discriminant -> bad primes
disc = sp.discriminant(f, t)
print("disc(f) =", disc)
print("factor disc:", sp.factorint(disc))

# leading coeff = 1 (square) => 2 points at infinity over Q
print("leading coeff =", sp.LC(f, t))

# roots structure: f is even in t, f(1/t)*t^8 = palindrome? check
fpal = sp.expand(t**8 * f.subs(t, 1/t))
print("palindromic check t^8 f(1/t) - f =", sp.expand(fpal - f))
