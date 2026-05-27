#!/usr/bin/env python3
# Step 4: best UNCONDITIONAL bound via Stewart-Yu explicit ABC.
# Stewart-Yu 2001 (Math. Ann. 291): for coprime A+B=C, positive integers, C>2,
#   log C <= rad(ABC)^{1/3} * exp( c * (log rad)^{... } )  -- their explicit form:
# The cleanest explicit statement (Stewart-Yu, "On the abc conjecture II"):
#   C < exp( kappa * R^{1/3} * (log R)^3 )   where R = rad(ABC), kappa effective constant.
# Equivalently log C <= kappa R^{1/3} (log R)^3.
# Our ABC triple: A=b^2, B=c=a^2-b^2 (take |.|, sign handled), C=a^2, with b^2 + (a^2-b^2)=a^2.
# rad(ABC) = rad(b^2 * (a^2-b^2) * a^2) = rad(a b c) = rad(a b (a^2-b^2)) = N (the conductor, up to 2).
# So R = N (conductor). And C = a^2.
#
# sigma = log|Delta_min|/log N. We have log|Delta_min| = 4 log a + 4 log b + 2 log c - 8 log2.
# Since b < a (b=2mn, a=m^2-n^2; actually b can exceed a) -- bound all of a,b,c by a^2 region:
#   b^2 <= a^2 = C, c=|a^2-b^2| <= a^2 = C (since both b^2,a^2 positive, |diff|<max). Actually
#   b^2 < a^2 NOT always (b can be > a). But b^2 and c=|a^2-b^2| are the two SMALLER legs of ABC,
#   both <= C=a^2... no: C=a^2 is the LARGEST since A=b^2,B=c, A+B=C only if a^2>b^2. If b>a then
#   a^2-b^2<0; rewrite triple as a^2 + (b^2-a^2) = b^2, C=b^2=max. Either way C=max(a^2,b^2).
# Let M = max(a^2,b^2) = C. Then a,b <= sqrt(M)=sqrt(C); c=|a^2-b^2| < M = C.
#   log|Delta_min| <= 4 log a + 4 log b + 2 log c <= 4*(1/2)logC + 4*(1/2)logC + 2 logC = 8 logC.
#   Hmm that's 8. Tighter: 4 log a+4 log b = 2 log(a^2)+2 log(b^2) <= 2 logC + 2 logC=4logC (since a^2,b^2<=C).
#   Actually a^2<=C and b^2<=C so log a^2<=logC, log b^2<=logC. 4 log a=2 log a^2<=2 logC. 4 log b<=2logC.
#   2 log c <= 2 logC. TOTAL <= 6 logC. So log|Delta_min| <= 6 log C = 6 log(max(a^2,b^2)).
# Therefore sigma = log|Delta_min|/log N <= 6 logC / log R   (R=N=rad).
# ABC/Szpiro: logC <= (1+eps) log R  => sigma <= 6(1+eps).  [matches scaffolding]
# Stewart-Yu UNCONDITIONAL: logC <= kappa R^{1/3}(log R)^3. Then
#   sigma <= 6 logC/log R <= 6 kappa R^{1/3}(log R)^2   -- GROWS with R. NOT bounded. But it's
#   the SLOWLY growing provable bound (sub-exponential / power of R).
# More precisely the standard form gives sigma = O(N^{1/3}(log N)^2) -- a theorem TODAY.
import math
# Illustrate: for the observed worst fiber (256,121): N=exp(26.838), a^2=max? compute.
a=50895; b=61952
C=max(a*a,b*b)
import sympy as sp
prod = a*b*abs(a*a-b*b)
R = 1
for p in sp.factorint(prod):
    R *= int(p)
print("worst fiber (256,121): a=",a," b=",b)
print("  C=max(a^2,b^2)=",C,"  log C=",math.log(C))
print("  R=rad(a b |a^2-b^2|)=",R,"  log R=",math.log(R))
print("  log C / log R =",math.log(C)/math.log(R)," (ABC-quality; ABC conj => ->1)")
print("  6*logC/logR =",6*math.log(C)/math.log(R)," (upper proxy for sigma; true sigma=4.614)")
print()
print("UNCONDITIONAL Stewart-Yu form (abc II, Math Ann 291 (1991), refined Stewart-Yu 2001):")
print("  log C <= kappa * R^{1/3} * (log R)^3   (kappa effective, ~ explicit)")
print("  => sigma <= 6 log C / log R <= 6 kappa R^{1/3} (log R)^2.")
print("  This is the BEST provable UNCONDITIONAL bound: sigma = O(N^{1/3}(log N)^2).")
print("  It GROWS with N -- NOT a constant. Only ABC/Szpiro gives the constant 6+eps.")
