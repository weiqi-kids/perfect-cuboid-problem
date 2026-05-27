#!/bin/bash
# Post-processing analysis. Reads rigorous_rank2_results.txt and emits
# tables for the report.
set -u

BASEDIR=/root/proof/perfect-cuboid-problem/scripts/rigorous_rank2
R="$BASEDIR/rigorous_rank2_results.txt"

if [ ! -f "$R" ]; then
  echo "$R not found"
  exit 1
fi

echo "=== Total ==="
grep -c -v "^#" "$R"

echo ""
echo "=== Status breakdown ==="
awk '$1 != "#" {print $5}' "$R" | sort | uniq -c | sort -rn

echo ""
echo "=== B distribution (CLOSED only) ==="
awk '$5 == "CLOSED" {print $6}' "$R" | sort -n | uniq -c

echo ""
echo "=== B summary ==="
awk '$5 == "CLOSED" {print $6}' "$R" | sort -n | awk '
  BEGIN {c=0; sum=0}
  {a[c++]=$0; sum += $0}
  END {
    if (c == 0) {print "no CLOSED rows"; exit}
    print "min=" a[0] " max=" a[c-1] " mean=" sum/c " median=" a[int(c/2)]
  }
'

echo ""
echo "=== HARD / PCP cases ==="
awk '$5 != "CLOSED" && $1 != "#" {print}' "$R"
