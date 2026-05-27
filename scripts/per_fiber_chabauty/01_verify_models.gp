\\ 01_verify_models.gp — Verify the 5-factor formulas on (m,n) = (2,1), q = 4/3.
\\ Expected conductors from V-FIBRATION-CHABAUTY.md §1.4 table:
\\   E_ef(4/3): cond 21
\\   E_eg(4/3): cond 15
\\   E_fg(4/3): cond 240
\\   E_Hp(4/3): (large)
\\   E_Hm(4/3): cond 210   <-- note this is the X_- factor (genus-2 odd part)
\\ Also: Halcke E_Hm at (2,1): conductor different (this is the bielliptic projection aux).

default(parisize, 2*10^9);
default(realprecision, 38);

read("00_catalog.gp");
