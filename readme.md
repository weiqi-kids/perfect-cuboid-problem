# The Perfect Cuboid Problem

**Author:** Lightman Chang (Independent Researcher) · lightman.chang@gmail.com

## What is a perfect cuboid?

A **perfect cuboid** is a rectangular box whose three edges, three face diagonals,
*and* the long space diagonal are all whole numbers (or, equivalently, all rational).
A box where only the three faces have integer diagonals is an **Euler brick** — those
exist in abundance. Demanding that the space diagonal *also* be an integer is the extra
condition that no one has ever been able to satisfy, nor to prove impossible. Euler
posed the question in 1769; after more than 250 years it is still open. Exhaustive
computer searches have found none with smallest edge below about $3\times10^{12}$.

This site collects six self-contained papers. **None of them claims to settle the
problem.** Each closes a clearly delimited piece, or maps a structural obstruction, in
a way that is fully verified by computer algebra (PARI/GP) and complementary to the
recent work of Peschmann (2026), Yoshida (2024), and Naskręcki (2013).

## The common thread

Every paper studies the same object: to each Pythagorean rational $q$ one attaches the
elliptic curve
$$E_q:\quad y^2 = x(x+1)(x+q^2),$$
and a perfect cuboid on the $q$-fiber forces a rational point on $E_q$ whose
"recovery-map" value is a genuine, non-degenerate edge. Closing a sub-family means
showing no such point exists there.

## The six papers

1. **Saunderson family (paper-a).** No Euler brick produced by the classical Saunderson
   parametrization is a perfect cuboid. The space-diagonal condition collapses to a
   genus-one curve whose Jacobian is the rank-zero elliptic curve Cremona **80a1**, which
   has only four rational points — all degenerate. *Unconditional.*

2. **Case B at p=1 (paper-b).** A one-parameter stratum with edges $(4q,\,q^2-4,\,2(q^2-1))$
   contains no perfect cuboid: the space condition becomes the Pell equation $g^2-5q^4=20$,
   whose solutions are odd-indexed Lucas numbers, and a 1964 theorem of Cohn forces
   $q\in\{1,2\}$ (degenerate). The associated genus-five curve has Mordell–Weil rank equal
   to its genus, so the Chabauty–Coleman method *cannot* close it — confirming a concern
   raised by Peschmann. *Unconditional.*

3. **Rank-positive fibers (paper-c).** Resolves Peschmann's smallest open case, the fiber
   $(5,2)$, together with six further rank-positive fibers, on an explicit search window;
   and pinpoints exactly why the natural "primitive-divisor" closure fails in general
   (the obstruction lives in a different sequence than the one the effective theorems
   bound, and a primitive divisor need not appear to odd multiplicity).

4. **Szpiro ratio (paper-d).** Computes the arithmetic of the family $E_q$ exactly —
   minimal model, conductor, discriminant — and bounds its Szpiro ratio: at most
   $4+\varepsilon$ for almost all parameters, with the large-ratio exceptions lying along
   $\mathbb{Z}[\sqrt2]$ Pell conics. *Density-one bound unconditional.*

5. **Sophie–Germain sub-family (paper-e).** For every prime $p$, neither Sophie–Germain
   branch yields a perfect cuboid; a single elliptic curve (Cremona **800a3**) disposes of
   the entire infinite tail of primes, beyond any finite scan. The lone near-miss,
   $(11,71)$, satisfies the space diagonal and two faces but fails the third.
   *Unconditional for prime $p$.*

6. **Ranks and an experimental survey (paper-h).** A certified explicit fiber of
   Mordell–Weil rank 3 over $\mathbb{Q}$ (the pair $(22,17)$), a rank histogram over 303
   fibers, and a verified record of zero perfect cuboids among the 36 primitive Euler
   bricks with all edges $\le 30000$.

## Honest scope

These are six clean partial results and structural maps, not a solution. The full
perfect-cuboid locus is a surface of general type, whose finiteness of rational points
is governed by the (open) conjectures of Bombieri–Lang and Vojta and remains out of
reach. The contribution here is to close named sub-families unconditionally, resolve
specific open fibers, and chart precisely where the elementary and curve-theoretic
methods stall.

## Downloads

The six papers (PDF) are linked at the top of the page. Full LaTeX sources, the
submission index, and the PARI/GP verification scripts accompany each paper in the
repository.
