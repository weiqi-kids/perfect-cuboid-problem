#!/bin/bash
# Generate Magma QC scripts for all 38 hard fibers
set -u
cd "$(dirname "$0")"

FIBERS=(
"22 17" "35 22" "37 26" "40 29" "40 33" "41 18" "44 9" "53 32" "59 40" "60 43"
"61 38" "63 38" "64 53" "66 23" "69 22" "71 50" "73 24" "74 33" "77 26" "77 48"
"84 19" "84 37" "86 47" "88 7" "88 19" "88 35" "88 61" "89 72" "89 80" "91 22"
"93 26" "94 77" "95 34" "96 91" "97 60" "97 88" "97 90" "99 28"
)

for pair in "${FIBERS[@]}"; do
   read m n <<< "$pair"
   tag="${m}_${n}"
   out="qc_${tag}.magma"
   echo "Generating $out"
   MVAL=$m NVAL=$n gp -q gen_magma_script.gp 2>/dev/null | grep -v "^\[" > "$out"
   # Strip the stderr Warning lines that may have leaked
   sed -i '/Warning: new stack size/d' "$out"
done

echo "Done; produced 38 Magma scripts in $(pwd)"
ls -1 qc_*.magma | wc -l
