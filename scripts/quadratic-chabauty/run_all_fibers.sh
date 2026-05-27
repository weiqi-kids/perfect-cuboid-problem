#!/bin/bash
# Run QC ingredient computation for all 38 hard fibers
# Output: one .out file per fiber, plus a summary CSV
set -u
cd "$(dirname "$0")"
OUTDIR="output"
mkdir -p "$OUTDIR"

FIBERS=(
"22 17" "35 22" "37 26" "40 29" "40 33" "41 18" "44 9" "53 32" "59 40" "60 43"
"61 38" "63 38" "64 53" "66 23" "69 22" "71 50" "73 24" "74 33" "77 26" "77 48"
"84 19" "84 37" "86 47" "88 7" "88 19" "88 35" "88 61" "89 72" "89 80" "91 22"
"93 26" "94 77" "95 34" "96 91" "97 60" "97 88" "97 90" "99 28"
)

CSV="$OUTDIR/summary.csv"
echo "m,n,q_num,q_den,cond_ef,cond_eg,cond_fg,cond_Hp,cond_Hm,rank_lo_ef,rank_lo_eg,rank_lo_fg,rank_lo_Hp,rank_lo_Hm,rank_hi_ef,rank_hi_eg,rank_hi_fg,rank_hi_Hp,rank_hi_Hm,total_lo,total_hi,chosen_prime,non_isogenous" > "$CSV"

for pair in "${FIBERS[@]}"; do
   read m n <<< "$pair"
   tag="${m}_${n}"
   out="$OUTDIR/fiber_${tag}.out"
   echo "== ($m,$n) =="
   t0=$(date +%s%N)
   MVAL=$m NVAL=$n timeout 1800 gp -q compute_fiber_ingredients.gp > "$out" 2>&1
   rc=$?
   t1=$(date +%s%N)
   dt=$(( (t1-t0)/1000000 ))
   if [ $rc -ne 0 ]; then echo "  FAILED (rc=$rc) in $dt ms"; continue; fi

   # Extract summary fields
   q_num=$(grep "^Q0=" "$out" | sed 's|Q0=||; s|/.*||')
   q_den=$(grep "^Q0=" "$out" | sed 's|.*/||')
   conds=$(grep "^CONDS=" "$out" | sed 's|CONDS=\[||;s|\]||;s|,| |g')
   ranks_lo=$(grep "^RANKS_LO=" "$out" | sed 's|RANKS_LO=\[||;s|\]||;s|,| |g')
   ranks_hi=$(grep "^RANKS_HI=" "$out" | sed 's|RANKS_HI=\[||;s|\]||;s|,| |g')
   total=$(grep "^TOTAL_RANK=" "$out" | sed 's|TOTAL_RANK=||;s|\.\.| |')
   chosen=$(grep "^CHOSEN_PRIME=" "$out" | sed 's|CHOSEN_PRIME=||')
   niso=$(grep "^NON_ISOGENOUS_5_FACTORS:" "$out" | sed 's|.*: ||')
   read ce ceg cfg chp chm <<< "$conds"
   read rle rleg rlfg rlhp rlhm <<< "$ranks_lo"
   read rhe rheg rhfg rhhp rhhm <<< "$ranks_hi"
   read tlo thi <<< "$total"
   echo "$m,$n,$q_num,$q_den,$ce,$ceg,$cfg,$chp,$chm,$rle,$rleg,$rlfg,$rlhp,$rlhm,$rhe,$rheg,$rhfg,$rhhp,$rhhm,$tlo,$thi,$chosen,$niso" >> "$CSV"
   echo "  done in $dt ms  total rank [$tlo,$thi]  p=$chosen"
done
echo ""
echo "Summary written to $CSV"
