# Descent Class of the "PCP Half" — Cassels-Tate Link

**CΛ / Lightman Chang · 2026-05-19**

## §1. Doubling and inversion

`E_PCP : y² = x(x+A)(x+B)`, `A=a², B=b²`. PCP point `P_PCP = (c², ·)` with
`e²=c²+a², f²=c²+b², g²=c²+a²+b²`.

For `R=(X,Y)`: `x(2R) = f'(X)²/(4 f(X)) − (A+B) − 2X`,
`f'(X)=3X²+2(A+B)X+AB`. Setting `x(2Q)=c²` and using `c²+A+B=g²`:
```
(g² + 2X)·4 X(X+A)(X+B) = (3X² + 2(A+B)X + AB)²                (★)
```
A degree-4 polynomial in X. PARI expansion (with `A=a², B=b²`):
```
P(X) = X⁴ − 4c²X³ − [2a²b² + 4c²(a²+b²)]X² − 4c² a²b² X + a⁴b⁴
```

## §2. Explicit roots

Try factor `(X² + uX + a²b²)(X² + u'X + a²b²)`. Vieta:
`u+u' = -4c²`, `uu' = -4(a²b² + c²(a²+b²)) = -4 e²f²`. So `u, u' = -2c² ± 2ef`.
Discriminants: `(c²−ef)² − a²b² = c²(e−f)²` and `(c²+ef)² − a²b² = c²(e+f)²`.

**Four roots** (= x-coords of the 4 halves Q, Q+T₀, Q+T_a, Q+T_b):
```
r₁=(c+e)(c−f),  r₂=(c−e)(c+f),  r₃=(c+e)(c+f),  r₄=(c−e)(c−f).
```

## §3. Descent class of Q

Pick `x(Q)=r₃=(c+e)(c+f)`. Using `a²=e²−c², b²=f²−c²`:
```
x(Q) + a² = (c+e)(c+f) + (e−c)(e+c) = (c+e)(e+f)
x(Q) + b² = (c+e)(c+f) + (f−c)(f+c) = (c+f)(e+f)
```
So `y(Q) = ±(c+e)(c+f)(e+f) ∈ Q` automatically. **Descent class**:
```
class(Q) = ( sf((c+e)(c+f)),  sf((c+e)(e+f)),  sf((c+f)(e+f)) )
         = ( αβ, αγ, βγ ),     α=sf(c+e), β=sf(c+f), γ=sf(e+f).
```
Product `(αβγ)² ≡ 1` ✓. Translations by `E[2]` give Klein 4-group
```
image(E[2]) = ⟨(1,1,1), (-1,PQ,-PQ), (-1,-PQ,PQ), (1,-1,-1)⟩
```
(note `image(T₀) = (1,1,1)` since `A=a², B=b²` are squares).

## §4. Comparison with Heron class

Heron class (3-coord form): `Heron = (sf(P), sf(Q), sf(PQ)) = (sf(a+b), sf(a−b), sf(a²−b²))`.

The only algebraic identities tying α, β, γ to a, b are
```
(c+e)(c−e)=−a²,  (c+f)(c−f)=−b²,  (e+f)(e−f)=a²−b² = PQ
```
giving `sf(c−e)=−α, sf(c−f)=−β, sf(e−f)=γ·sf(PQ)`. These yield ONLY
the tautological `(αβγ)·(αβγ·sf(PQ)) = sf(PQ)`. **No identity forces
`αβ = sf(P)` or any permutation thereof.**

Checking `class(Q) = Heron · image(T_j)` for `j ∈ {0,a,b}` gives three
distinct sets of conditions (e.g. `j=0`: `αβ=sf(P), αγ=sf(Q)`;
`j=a`: `β=−γ, αγ=sf(P)`); each is a SPECIFIC numerical relation on
`(c,e,f)`, NOT implied by `(a,b)` alone.

## §5. Verdict on (d): NO

**`class(Q)` is NOT always `(sf P, sf Q)`-conjugate.** It is a free
element of `S²(E_PCP) / image(E[2])` constrained only by `αβγ`
multiplied by `sf(PQ)` being a square.

Consequently: **failure of (♦) does not directly forbid PCP**. (♦)
blocks the Heron coset; `class(Q)` may legitimately live in a
DIFFERENT 2-Selmer class — exactly the cross-pair classes empirically
found in HERON-FACE-SELMER §3 at (63, 38), (73, 24), (88, 35).

## §6. Refined obstruction

For PCP at `(m, n)`, `(αβ, αγ, βγ)` must lie in `S²(E_PCP)`. Procedure:
(1) enumerate Selmer F₂-basis classes (cross-pair rule §1.1 of HERON-FACE-SELMER);
(2) for each `[d₁, d₂, d₃]` solve the 2-cover torsor `d₁X² = d₂Y² + d₃Z²`;
(3) recover candidate `(c, e, f)` from rational solutions, test `c²+a²+b² ∈ Q*²`.

(♦) remains a useful microsecond-filter for the Heron coset but is
NOT sufficient for PCP non-existence.

---

## 100-word summary

The half `Q` of a PCP point on `E_PCP : y²=x(x+a²)(x+b²)` satisfies
`x(Q)=(c+e)(c+f)` (one of 4 roots of an explicit quartic) with descent
class `(αβ, αγ, βγ)` where `α=sf(c+e), β=sf(c+f), γ=sf(e+f)`. Comparing
to the Heron class `(sf(P), sf(Q), sf(PQ)) = (sf(a+b), sf(a−b), sf(a²−b²))`:
the only algebraic identities give `sf(c±e)=±α, sf(c±f)=±β, sf(e±f)`
related via `PQ`, leaving `(α, β, γ)` essentially free.
**Therefore (♦) is NOT a direct PCP obstruction**; it only blocks the
Heron Selmer coset. PCP at a (♦)-failing fiber would require `class(Q)`
to occupy a cross-pair Selmer class — testable by enumerating the
F₂-basis of `S²(E_PCP)` and solving each 2-cover torsor for `(c, e, f)`.
