import sympy as sp
t,T,x,y,X,Y = sp.symbols('t T x y X Y')
f = t**8 + 68*t**6 - 122*t**4 + 68*t**2 + 1

# C': T^2 = f(t), genus 3, with commuting involutions:
#  sigma: t -> -t   (f even => invariant). Quotient by sigma: set x = t^2.
#  tau:   t -> 1/t  (f palindromic => T -> T/t^4 invariant up to scaling). 
#  sigma*tau: t -> -1/t.

# Quotient by sigma (t->-t): invariants x=t^2.  f = x^4+68x^3-122x^2+68x+1, T^2 = that.
# => X_sigma: T^2 = x^4+68x^3-122x^2+68x+1  (genus 1 quartic) = E_PCP.
fx = sp.Poly(f, t).as_expr()
# substitute t^2 = x:
coeffs = sp.Poly(f, t).all_coeffs()  # degree 8 ... [1,0,68,0,-122,0,68,0,1]
print("f coeffs (deg8..0):", coeffs)
# even poly: g(x) with x=t^2:
gx = x**4 + 68*x**3 - 122*x**2 + 68*x + 1
print("X_sigma quartic g(x)=", gx, " (T^2=g(x), genus1)")

# Quotient by tau (t->1/t): symmetric functions. Let s = t + 1/t. Then t^2+1/t^2 = s^2-2, etc.
# Divide T^2=f by t^4:  (T/t^4)^2 = t^4+68t^2-122+68/t^2+1/t^4
#   = (t^4+1/t^4) + 68(t^2+1/t^2) -122
# t^2+1/t^2 = s^2-2 ; t^4+1/t^4 = (s^2-2)^2-2 = s^4-4s^2+2
# => W^2 = (s^4-4s^2+2) + 68(s^2-2) -122 = s^4 +64 s^2 -256, where W=T/t^4, s=t+1/t
htau = sp.expand((sp.Symbol('s')**4 - 4*sp.Symbol('s')**2 + 2) + 68*(sp.Symbol('s')**2-2) - 122)
print("X_tau quartic in s=t+1/t:  W^2 =", htau, " (genus1)")

# Quotient by sigma*tau (t -> -1/t): let r = t - 1/t. Then t^2+1/t^2 = r^2+2; t^4+1/t^4=(r^2+2)^2-2=r^4+4r^2+2
hst = sp.expand((sp.Symbol('r')**4 + 4*sp.Symbol('r')**2 + 2) + 68*(sp.Symbol('r')**2+2) - 122)
print("X_sigtau quartic in r=t-1/t: W^2 =", hst, " (genus1)")
