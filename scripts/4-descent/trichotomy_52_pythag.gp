default(parisize, 1<<32);
fibers = [[265,14],[353,10],[413,48],[433,118],[497,80],[509,26],[509,138],[513,196],[517,42],[553,8],[577,116],[581,34],[609,34],[621,26],[629,36],[629,76],[641,252],[673,190],[693,236],[709,54],[721,22],[749,130],[757,118],[773,4],[785,14],[793,322],[797,288],[829,168],[833,94],[841,8],[845,236],[849,68],[857,228],[861,74],[869,314],[881,322],[889,226],[889,234],[889,316],[893,354],[897,238],[909,146],[929,170],[929,306],[933,208],[937,28],[937,232],[945,374],[961,98],[985,264],[989,326],[989,352]];
print("# Pythagorean search: |p|, q <= 300, gcd(p,q)=1, p ≠ ±q");
print("# For each (m, n), seek (p, q) such that:");
print("#   q_1: a^2 (p^2-q^2)^2 + (2 b p q)^2 = square    (Saunderson c gives face brick)");
print("#   q_2: a^2 (p^2-q^2)^2 + (2 d_ab p q)^2 = square (gives PCP brick)");
BMAX_P = 300;
BMAX_Q = 300;
\\ Including 63 38 for control
testfibs = concat([[63, 38]], fibers);
for(idx = 1, #testfibs, my(m = testfibs[idx][1], n = testfibs[idx][2], a, b, d_ab, q1_hits, q2_hits, A2pmq2sq_2bpq, A2pmq2sq_2dpq); a = m^2 - n^2; b = 2*m*n; d_ab = m^2 + n^2; q1_hits = List(); q2_hits = List(); for(qq = 1, BMAX_Q, for(pp = 0, BMAX_P, if(pp == qq, next); if(gcd(pp, qq) != 1, next); my(D2 = (pp^2 - qq^2)^2, A2D2 = a^2 * D2, val1 = A2D2 + 4*b^2*pp^2*qq^2, val2 = A2D2 + 4*d_ab^2*pp^2*qq^2); if(issquare(val1), if(pp != 0, listput(q1_hits, [pp, qq])); if(issquare(val2), listput(q2_hits, [pp, qq]))))); status = if(#q1_hits == 0, "I-closed", if(#q2_hits > 0, "PCP-CAND", "I->III")); print(m, " ", n, " | q1_hits=", #q1_hits, " q2_hits=", #q2_hits, " | ", status, "  first q1=", if(#q1_hits>0, q1_hits[1], "-")));
quit;
