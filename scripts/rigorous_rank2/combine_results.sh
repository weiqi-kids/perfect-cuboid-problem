#!/bin/bash
# Combine 4 chunk results into one final results file, plus statistics.
set -u

BASEDIR=/root/proof/perfect-cuboid-problem/scripts/rigorous_rank2
COMBINED="$BASEDIR/rigorous_rank2_results.txt"

# Header + each chunk's body
echo "# m  n  q  N(E)  status  B  lambda_min  H(E)  squares  #gens_found" > "$COMBINED"
for i in 1 2 3 4; do
  f="$BASEDIR/chunk_$i/rigorous_rank2_results_chunk$i.txt"
  if [ -f "$f" ]; then
    grep -v "^#" "$f" >> "$COMBINED" || true
  fi
done

TOTAL=$(grep -c -v "^#" "$COMBINED")
CLOSED=$(awk '$5 == "CLOSED"' "$COMBINED" | wc -l)
PCP=$(awk '$5 == "PCP_CANDIDATE"' "$COMBINED" | wc -l)
HARD_NG=$(awk '$5 == "HARD_NO_GENS"' "$COMBINED" | wc -l)
HARD_OC=$(awk '$5 == "HARD_OFF_CURVE"' "$COMBINED" | wc -l)
DEGEN=$(awk '$5 == "DEGENERATE" || $5 == "DEGENERATE_LAM"' "$COMBINED" | wc -l)
ERR=$(awk '$5 == "ERROR"' "$COMBINED" | wc -l)
MAXB=$(awk '$5 == "CLOSED" {print $6}' "$COMBINED" | sort -n | tail -1)
MINB=$(awk '$5 == "CLOSED" {print $6}' "$COMBINED" | sort -n | head -1)
MEDB=$(awk '$5 == "CLOSED" {print $6}' "$COMBINED" | sort -n | awk 'BEGIN{c=0}{a[c++]=$0}END{print a[int(c/2)]}')

echo "=== Combined Statistics ==="
echo "Total processed     : $TOTAL"
echo "CLOSED              : $CLOSED"
echo "PCP_CANDIDATE       : $PCP"
echo "HARD_NO_GENS        : $HARD_NG"
echo "HARD_OFF_CURVE      : $HARD_OC"
echo "DEGENERATE          : $DEGEN"
echo "ERROR               : $ERR"
echo "B range (CLOSED)    : $MINB .. $MAXB (median $MEDB)"

# List HARD/PCP cases
echo ""
echo "=== HARD / PCP / ERROR cases ==="
awk '$5 != "CLOSED"' "$COMBINED" || echo "(none)"
