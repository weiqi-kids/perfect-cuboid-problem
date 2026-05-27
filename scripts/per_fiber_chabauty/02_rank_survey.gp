\\ 02_rank_survey.gp — Rank survey on 47 rank-jump fibers (Strategy II + I).
\\ KEY: X_- ≡ E_Hm (Halcke aux) — same minimal model. So 5 ranks per fiber.

default(parisize, 2*10^9);
default(realprecision, 38);
read("lib.gp");

rank4_fibers = [[99,28],[118,25],[174,83],[176,63],[181,38],[205,66],[209,72],[216,185],[221,202],[261,52],[273,86],[578,319]];

rank3_fibers = [[341,208],[359,138],[366,107],[391,248],[413,214],[442,229],[451,152],[451,214],[457,154],[462,71],[464,65],[502,341],[506,47],[506,313],[526,319],[538,279],[541,306],[562,483],[581,362],[589,316],[592,539],[629,398],[737,574],[778,531],[816,497],[834,361],[851,334],[869,442],[892,551],[899,158],[928,623],[943,206],[974,259],[988,251],[988,321]];

\\ Helper: rank a curve and return [lo, up].
quick_rank(E, eff) = my(r = ellrank(E, eff)); [r[1], r[2]];

\\ Print one fiber's data; outputs vector [lo1..lo5, up1..up5, sumlo, sumup, time_s]
do_one(m, n, eff) = my(q = qof(m,n), t0=getabstime(), E1, E2, E3, E4, E5, r1, r2, r3, r4, r5, sl, su); \
  E1 = ellminimalmodel(make_Eef(q)); \
  E2 = ellminimalmodel(make_Eeg(q)); \
  E3 = ellminimalmodel(make_Efg(q)); \
  E4 = ellminimalmodel(make_EHp(q)); \
  E5 = ellminimalmodel(make_EHm_halcke(m,n)); \
  r1 = quick_rank(E1, eff); \
  r2 = quick_rank(E2, eff); \
  r3 = quick_rank(E3, eff); \
  r4 = quick_rank(E4, eff); \
  r5 = quick_rank(E5, eff); \
  sl = r1[1]+r2[1]+r3[1]+r4[1]+r5[1]; \
  su = r1[2]+r2[2]+r3[2]+r4[2]+r5[2]; \
  [r1, r2, r3, r4, r5, sl, su, (getabstime()-t0)/1000.];

print_fiber(label, m, n, res) = print(label, " (", m, ",", n, ") | Eef=", res[1], " Eeg=", res[2], " Efg=", res[3], " EHp=", res[4], " X-=", res[5], " | sumJ=[", res[6], ",", res[7], "] | t=", res[8], "s");

write_fiber(label, m, n, res) = my(q=qof(m,n)); \
  write("survey_results.txt", label, " ", m, " ", n, " ", numerator(q), " ", denominator(q), " ", res[1][1], " ", res[1][2], " ", res[2][1], " ", res[2][2], " ", res[3][1], " ", res[3][2], " ", res[4][1], " ", res[4][2], " ", res[5][1], " ", res[5][2], " ", res[6], " ", res[7]);

write("survey_results.txt", "# label m n q_num q_den ef_lo ef_up eg_lo eg_up fg_lo fg_up Hp_lo Hp_up Xm_lo Xm_up sum_lo sum_up");

print("=== Strategy II rank survey (5 V_q factors per fiber) ===");
print();
print("--- rank-4 E_PCP fibers (12) ---");
for(k = 1, length(rank4_fibers), mn = rank4_fibers[k]; res = do_one(mn[1], mn[2], 1); print_fiber("R4", mn[1], mn[2], res); write_fiber("R4", mn[1], mn[2], res));

print();
print("--- rank-3 E_PCP fibers (35) ---");
for(k = 1, length(rank3_fibers), mn = rank3_fibers[k]; res = do_one(mn[1], mn[2], 1); print_fiber("R3", mn[1], mn[2], res); write_fiber("R3", mn[1], mn[2], res));

print();
print("DONE. Results in survey_results.txt");
quit;
