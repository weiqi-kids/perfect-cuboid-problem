\\ MASSIVE H_q Pass A only — integer-X search at B = 10^7 on 4 remaining BEYOND-QC fibers.

default(parisize, 500000000);
default(realprecision, 38);

B = 10000000;
SIEVE_PRIMES = [5, 7, 11, 13, 17, 19, 23, 29, 31];

{ build_QR_residues(modp, d2, p2, w2) = my(v, r, val); v = vector(modp); for(r = 0, modp - 1, val = ((r*r + d2) * (r*r + p2) * (r*r + w2)) % modp; if(val == 0, v[r+1] = 1, if(issquare(Mod(val, modp)), v[r+1] = 1, v[r+1] = 0))); v; }

{ process_fiber(fname, mm, nn) = my(d, p, w, d2, p2, w2, y0, sieve_tables, j, hits, t0, t1, survived, X, is_possible, pj, fval, Y); d = mm^2 - nn^2; p = 2*mm*nn; w = mm^2 + nn^2; d2 = d^2; p2 = p^2; w2 = w^2; print(); print("----------------------------------------------------------------------"); print("FIBER ", fname, "  m=", mm, " n=", nn, "  (d,p,w) = (", d, ",", p, ",", w, ")"); print("----------------------------------------------------------------------"); y0 = d*p*w; print("  X=0 baseline: Y = +-", y0); sieve_tables = vector(#SIEVE_PRIMES); for(j = 1, #SIEVE_PRIMES, sieve_tables[j] = build_QR_residues(SIEVE_PRIMES[j], d2, p2, w2)); hits = List(); t0 = getwalltime(); survived = 0; for(X = 1, B, is_possible = 1; for(j = 1, #SIEVE_PRIMES, pj = SIEVE_PRIMES[j]; if(sieve_tables[j][(X % pj) + 1] == 0, is_possible = 0; break)); if(!is_possible, next); survived += 1; fval = (X^2 + d2) * (X^2 + p2) * (X^2 + w2); if(issquare(fval, &Y), print("    !! HIT !! X=", X, "  Y=", Y); listput(hits, [X, Y]))); t1 = getwalltime(); print("  scanned                 = ", B); print("  QR-sieve survivors      = ", survived); print("  non-degenerate hits     = ", #hits); print("  wall                    = ", (t1 - t0)/1000.0, " s"); [#hits, (t1-t0)]; }

print("======================================================================");
print("MASSIVE H_q PASS A SEARCH at B = ", B, " on 4 BEYOND-QC fibers");
print("Sieve primes: ", SIEVE_PRIMES);
print("======================================================================");

r1 = process_fiber("(61,38)", 61, 38);
r2 = process_fiber("(63,38)", 63, 38);
r3 = process_fiber("(73,24)", 73, 24);
r4 = process_fiber("(88,35)", 88, 35);

print();
print("======================================================================");
print("OVERALL: total wall = ", (r1[2] + r2[2] + r3[2] + r4[2])/1000.0, " s");
print("Total non-degenerate hits across 4 fibers = ", r1[1] + r2[1] + r3[1] + r4[1]);
print("======================================================================");
quit;
