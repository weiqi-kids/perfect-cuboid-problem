/*
 * gap3_d/rankjump_3face.gp
 *
 * 3-face Heron-Hilbert filter at every known rank-jump fiber.
 * Convention: q = (m^2 - n^2) / (2mn), P = (m+n)^2 - 2n^2, Q = (m-n)^2 - 2n^2.
 */

default(parisize, 500000000);

hilbert_global(A, B) = { my(badp, badset, S);
  if (A == 0 || B == 0, return ([0, "deg"]));
  S = abs(A) * abs(B);
  if (A != B, S = S * abs(A - B));
  S = S * abs(A + B) * 2;
  badp = factor(S)[, 1];
  badset = List();
  if (hilbert(A, B) != 1, listput(badset, "oo"));
  for (i = 1, #badp, my(p = badp[i]); if (hilbert(A, B, p) != 1, listput(badset, p)));
  return ([#badset == 0, Vec(badset)]);
};

three_face(m, n) = { my(P, Q, r_ab, r_bc, r_ac);
  P = (m + n)^2 - 2*n^2; Q = (m - n)^2 - 2*n^2;
  r_ab = hilbert_global(P, Q);
  r_bc = hilbert_global(P, -Q);
  r_ac = hilbert_global(-P, Q);
  return ([P, Q, r_ab, r_bc, r_ac]);
};

q_of(m, n) = { my(num = m^2 - n^2, den = 2*m*n, g = gcd(num, den));
  Strprintf("%s/%s", Str(num/g), Str(den/g));
};

process(m, n, lbl, rk) = { my(r, P, Q, pab, pbc, pac, all3, qcomp);
  r = three_face(m, n); P = r[1]; Q = r[2];
  pab = r[3][1]; pbc = r[4][1]; pac = r[5][1];
  all3 = pab && pbc && pac;
  qcomp = q_of(m, n);
  printf("[%s] m=%d n=%d q=%s\n", rk, m, n, qcomp);
  printf("    P=%s   Q=%s\n", Str(P), Str(Q));
  printf("    sf(P)=%s  sf(Q)=%s\n", Str(core(P)), Str(core(Q)));
  printf("    (ab) P,Q   = %s  bad: %s\n", if(pab, "PASS", "FAIL"), Str(r[3][2]));
  printf("    (bc) P,-Q  = %s  bad: %s\n", if(pbc, "PASS", "FAIL"), Str(r[4][2]));
  printf("    (ac) -P,Q  = %s  bad: %s\n", if(pac, "PASS", "FAIL"), Str(r[5][2]));
  printf("    ALL-3: %s\n\n", if(all3, "YES", "no"));
  return ([rk, m, n, qcomp, P, Q, pab, pbc, pac, all3, r[3][2], r[4][2], r[5][2]]);
};

print("\n=== 3-FACE FILTER AT RANK-JUMP FIBERS ===\n");

results = List();
listput(results, process(5, 2,  "20/21", "rank1"));
listput(results, process(4, 3,  "7/24",  "rank1"));
listput(results, process(8, 3,  "48/55", "rank1"));
listput(results, process(10, 1, "20/99", "rank1"));
listput(results, process(16, 3, "96/247","rank1"));
listput(results, process(7, 6,  "13/84", "rank1"));
listput(results, process(8, 5,  "39/80", "rank1"));
listput(results, process(6, 5,  "11/60", "rank2"));
listput(results, process(9, 8,  "17/144","rank2"));
listput(results, process(13, 4, "104/153","rank2"));
listput(results, process(22, 17,"315/748","rank3"));
listput(results, process(35, 22,"741/1540","rank3"));
listput(results, process(37, 26,"693/1924","rank3"));
listput(results, process(40, 29,"759/2320","rank3"));
listput(results, process(40, 33,"511/2640","rank3"));

passcount = 0;
for (i = 1, #results, if (results[i][10], passcount += 1));
printf("\n========== SUMMARY ==========\n");
printf("ALL-3 passers: %d/%d (%.1f%%)\n", passcount, #results, 100.0*passcount/#results);
printf("By rank-class:\n");
for (rk = 1, 3, my(tot=0, ps=0); my(rkstr = Strprintf("rank%d", rk)); \
  for (i = 1, #results, if (results[i][1] == rkstr, tot += 1; if (results[i][10], ps += 1))); \
  printf("  %s: %d/%d pass\n", rkstr, ps, tot));

writebin("/root/proof/perfect-cuboid-problem/scripts/gap3_d/rankjump_3face.dat", Vec(results));
quit;
