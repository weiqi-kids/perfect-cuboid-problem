\\ GAP3-C task 5: Bound r_gen(E_PCP/Q(q)) by specializing at many q and finding
\\ the minimum rank, which is an upper bound for r_gen.
\\
\\ More precisely: Silverman 1983 says rk E_q(Q) >= r_gen for all but a thin set.
\\ So MIN over many "generic" specializations bounds r_gen FROM ABOVE.
\\
\\ Also: rk over Q(q) = rk of any non-torsion section. If we never find a section
\\ over Q(q), evidence is r_gen = 0.
\\
\\ We compute analytic ranks for a wide variety of q (not just Pythagorean):
\\   q = 2, 3, 4, 5/2, 7/3, 11/5, sqrt-irrationals as small fractions, etc.

default(parisize, 500000000);

print("=== GAP3-C task 5: bounding r_gen via generic specialization ===");

\\ Generic (non-Pythagorean) q values: integers, simple fractions.
\\ Pythagorean fibers have rank >= r_gen + extra; non-Pythagorean fibers have rank >= r_gen too.

generic_q = [2, 3, 4, 5, 7, 11, 1/2, 2/3, 3/4, 3/5, 5/7, 7/11, 11/13, 13/17, 9/4, 25/4, 49/4, 5/3, 7/5, 11/7];

print("Computing analytic rank for ", length(generic_q), " generic q values:");
min_rank = 100;
for(i=1, length(generic_q), my(q=generic_q[i], E, Em, ar); E = ellinit([0, 1+q^2, 0, q^2, 0]); Em = ellminimalmodel(E); ar = ellanalyticrank(Em, 0.005); print("  q=", q, " analrank=", ar[1]); if(ar[1] < min_rank, min_rank = ar[1]));

print("\nMin analytic rank across these = ", min_rank);
print("=> r_gen(E_PCP/Q(q)) <= ", min_rank);
print("Combined with Mordell-Weil generic torsion (Z/2)^2 only (no horizontal MW visible), r_gen likely = ", min_rank);

quit;
