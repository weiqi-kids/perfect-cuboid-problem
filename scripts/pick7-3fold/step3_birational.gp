\\ Step 3: Birational type of W via the two natural fibrations
\\ W: 4 m^2 n^2 Y^2 = X(X+1)(4 m^2 n^2 X + (m^2-n^2)^2)
\\
\\ Key observation: rewrite as
\\   Y^2 = X(X+1)(X + q^2) where q = (m^2-n^2)/(2mn)
\\
\\ Fibration pi_1: W -> A^2_{m,n}, with fiber an elliptic curve E_PCP(q(m,n)).
\\ Fibration pi_2: W -> A^2_{X,Y}, with fiber a curve in (m,n).

print("====================================================");
print(" Step 3: Birational type & fibrations of W");
print("====================================================");

print();
print("=== Fibration pi_1: W -> A^2_{m,n} ===");
print("Generic fiber: E_PCP(q) elliptic curve.");
print("Map (X,Y,m,n) |-> (m,n).");
print("This is W as an elliptic fibration over A^2_{m,n}.");
print();
print("Mordell-Weil over Q(m,n): generic fiber E_PCP(q) over function field Q(q).");
print("By V-FIBRATION-CHABAUTY analysis: generic rank over Q(q) is 0.");
print("(This was the 'corrected generic rank 0' result.)");

print();
print("=== Fibration pi_2: W -> A^2_{X,Y} ===");
print("Fix (X_0, Y_0) in Q^2 with Y_0 != 0.");
print("The fiber in (m,n) is:");
print("  4 m^2 n^2 Y_0^2 = X_0(X_0+1) * (4 m^2 n^2 X_0 + (m^2-n^2)^2)");
print();
print("Set t = m^2, s = n^2 (so m,n -> sqrt of t,s; symmetric).");
print("Then with u = t/s (or m^2/n^2), divide both sides by n^4:");
print("  4 u Y_0^2 = X_0(X_0+1) * (4 u X_0 + (u-1)^2)");
print();
print("where u = m^2/n^2 = (1+q)/(1-q)... wait, let's recompute.");
print("q = (m^2 - n^2)/(2mn), so q^2 = (m^2-n^2)^2/(4 m^2 n^2).");
print();

\\ For fixed (X0,Y0), the equation in (m,n) is a degree-4 form
\\ Let me homogenize: set v = m/n. Then the equation in v is:
\\   4 v^2 n^4 Y_0^2 = X_0(X_0+1) * n^4 * (4 v^2 X_0 + (v^2 - 1)^2)
\\ Divide both sides by n^4:
\\   4 v^2 Y_0^2 = X_0(X_0+1) * (4 v^2 X_0 + (v^2-1)^2)
\\
\\ Let w = v^2. Then:
\\   4 w Y_0^2 = X_0(X_0+1) * (4 w X_0 + (w-1)^2)
\\   4 w Y_0^2 = X_0(X_0+1) * (4 X_0 w + w^2 - 2w + 1)
\\
\\ This is a quadratic in w:
\\   X_0(X_0+1) w^2 + [4 X_0^2 (X_0+1) - 2 X_0(X_0+1) - 4 Y_0^2] w + X_0(X_0+1) = 0
\\
\\ Let A = X_0(X_0+1), B = 4 X_0^2 A - 2 A - 4 Y_0^2 = 2A(2X_0^2 - 1) - 4 Y_0^2, C = A.
\\ So: A w^2 + B w + A = 0, palindromic!
\\
\\ Solutions w = (-B ± sqrt(B^2 - 4 A^2)) / (2A)
\\
\\ For w = v^2 to give rational v = m/n, we need w to be a rational square.
\\
\\ So fiber over (X0,Y0) is the curve in v:
\\   4 v^2 Y_0^2 = X_0(X_0+1) (4 v^2 X_0 + (v^2-1)^2)
\\
\\ This is a quartic in v! Let's compute its genus.

print("=== Genus of pi_2 fiber over generic (X_0, Y_0) ===");
print();
print("In v = m/n: 4 v^2 Y_0^2 = X_0(X_0+1) (4 v^2 X_0 + (v^2-1)^2)");
print("Expanding (v^2-1)^2 = v^4 - 2v^2 + 1:");
print("  4 v^2 Y_0^2 = X_0(X_0+1) (v^4 + (4 X_0 - 2) v^2 + 1)");
print();
print("  X_0(X_0+1) v^4 + [X_0(X_0+1)(4 X_0-2) - 4 Y_0^2] v^2 + X_0(X_0+1) = 0");
print();
print("This is quadratic in w = v^2. So in fact the equation in v is reducible:");
print("v^2 satisfies quadratic in w.");
print();
print("BUT: in terms of (m,n) (not (v=m/n,1)), the curve in A^2_{m,n} is degree 4.");
print("It's a plane quartic. Generic plane quartic has genus 3.");
print("HOWEVER our quartic has symmetries: m <-> n (q -> -q), m,n -> -m,-n etc.");
print();

\\ Use PARI to compute genus of the quartic for specific (X0,Y0) - generic
\\ X0 = 2, Y0 = 1 (random)
print("=== Numeric genus check for (X_0, Y_0) = (2, ??) ===");
\\ Actually we need (X0, Y0) on the elliptic curve E_PCP(q) for some q
\\ Let's pick q = 3/4 (a Pythagorean rational, m=2, n=1: q = 3/4)
\\ Then E_PCP: Y^2 = X(X+1)(X+9/16)
\\ For X = 1: Y^2 = 1 * 2 * 25/16 = 50/16, not a square. Try other X.
\\ For X = -1/2: Y^2 = (-1/2)(1/2)(1/16 + 9/16) = -1/4 * 10/16 = -10/64, negative.
\\ Just pick generic X0, Y0 - the fiber generically defines a curve.

\\ Generic fiber genus computation via change of variables:
\\ Set u = v^2; in v the curve is "quartic"
\\   X_0(X_0+1) v^4 + R v^2 + X_0(X_0+1) = 0  where R = X_0(X_0+1)(4X_0-2) - 4Y_0^2
\\ This is a quadratic in v^2. So v^2 = (-R ± sqrt(R^2 - 4 X_0^2 (X_0+1)^2))/(2 X_0 (X_0+1))
\\ Thus the curve in v factors as a union of two conics in (v, w=v^2)
\\ Equivalently: as a curve in v, it's defined by deg 4, but reducibility depends on R^2 - 4 A^2.
\\
\\ The fibers of pi_2 are reducible in general!
\\ For generic (X0, Y0): genus formula
\\   the curve in (m,n) projectively is a quartic.
\\   But (m,n) are like coordinates, so we're talking about curves in A^2 = (m,n).
\\
\\ Let's think geometrically: the equation in (m,n) defines
\\   (m^2 - n^2)^2 + 4 X_0 m^2 n^2 - 4 m^2 n^2 Y_0^2/(X_0(X_0+1)) = 0
\\ which is symmetric in m, n via (m,n) -> (n,m) AND under (m,n) -> (-m,n), etc.
\\
\\ Substituting m = u+w, n = u-w (changing variables):
\\   m^2 - n^2 = 4 u w
\\   m n = u^2 - w^2
\\ Then m^2 n^2 = (u^2 - w^2)^2
\\   (m^2-n^2)^2 = 16 u^2 w^2
\\ So equation becomes: 16 u^2 w^2 + 4 X_0 (u^2-w^2)^2 - 4 Y_0^2/(X_0(X_0+1)) * (u^2-w^2)^2 = 0
\\   = 16 u^2 w^2 + (4 X_0 - 4 Y_0^2 / A) (u^2-w^2)^2 = 0   where A = X_0(X_0+1)
\\
\\ Let K = 4 X_0 - 4 Y_0^2 / A.
\\ Equation: 16 u^2 w^2 + K (u^2 - w^2)^2 = 0
\\         = 16 u^2 w^2 + K (u^4 - 2 u^2 w^2 + w^4)
\\         = K u^4 + (16 - 2K) u^2 w^2 + K w^4
\\
\\ This is a "biquadratic" homogeneous polynomial of degree 4 in (u,w).
\\ It factors over an extension since it's quadratic in u^2/w^2.
\\
\\ Set t = u^2 / w^2: K t^2 + (16-2K) t + K = 0
\\ t = [(2K-16) ± sqrt((16-2K)^2 - 4K^2)] / (2K)
\\   = [(2K-16) ± sqrt(256 - 64K + 4K^2 - 4K^2)] / (2K)
\\   = [(2K-16) ± sqrt(256 - 64K)] / (2K)
\\   = [(2K-16) ± 8 sqrt(4 - K)] / (2K)
\\
\\ So t = u^2/w^2 lives in Q(sqrt(4-K)).
\\
\\ The curve splits over Q(sqrt(4-K)) into two conics (each defines u^2 = t_i w^2).
\\ Each conic in (u,w) has genus 0.
\\
\\ Over Q: irreducible quartic, but geometrically reducible.
\\ Geometric genus of each component: 0 (conic).

print();
print("Substituting m = u+w, n = u-w:");
print("  Equation becomes K u^4 + (16-2K) u^2 w^2 + K w^4 = 0");
print("  where K = 4 X_0 - 4 Y_0^2 / [X_0(X_0+1)].");
print();
print("This biquadratic form factors as two conics over Q(sqrt(4-K)):");
print("  u^2 = t_± w^2  with  t_± = [(2K-16) ± 8 sqrt(4-K)] / (2K)");
print();
print("Each component is a conic (genus 0).");
print();
print("DISCRIMINANT: 4 - K = 4 - 4X_0 + 4 Y_0^2 / [X_0(X_0+1)]");
print("              = 4 [X_0(X_0+1)(1-X_0) + Y_0^2] / [X_0(X_0+1)]");
print("              = 4 [Y_0^2 - X_0(X_0+1)(X_0-1)] / A");
print("              = 4 [Y_0^2 - X_0(X_0^2 - 1)] / A");
print("              = 4 [Y_0^2 - X_0^3 + X_0] / A");
print();
print("So the fiber is geometrically a union of two conics — i.e. RATIONAL.");
print("Pi_2 has rational fibers! This means W is UNIRULED.");

print();
print("=== Conclusion: W is uniruled ===");
print("Over generic (X_0, Y_0) the fiber is two genus-0 curves.");
print("Through every point of W passes a rational curve (the fiber of pi_2).");
print("=> W is uniruled.");
print("=> W is NOT of general type (κ = -∞).");
print("=> Lang's conjecture for general type does NOT apply.");
print("=> Faltings 1991 (abelian variety subvarieties) needs Albanese > 0, which uniruled W has Alb=0.");
