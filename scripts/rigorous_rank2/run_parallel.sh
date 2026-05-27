#!/bin/bash
# Run rigorous rank-2 box scan in parallel chunks.
# 300 fibers / 4 chunks = 75 per chunk.

set -u

BASEDIR=/root/proof/perfect-cuboid-problem/scripts/rigorous_rank2
cd "$BASEDIR" || exit 1

# Pre-create chunk subdirs and param files
for i in 1 2 3 4; do
  CHUNK_DIR="$BASEDIR/chunk_$i"
  mkdir -p "$CHUNK_DIR"
done

echo "1 75 chunk1"    > "$BASEDIR/chunk_1/rigorous_chunk_params.txt"
echo "76 150 chunk2"  > "$BASEDIR/chunk_2/rigorous_chunk_params.txt"
echo "151 225 chunk3" > "$BASEDIR/chunk_3/rigorous_chunk_params.txt"
echo "226 300 chunk4" > "$BASEDIR/chunk_4/rigorous_chunk_params.txt"

# Launch 4 parallel gp processes
for i in 1 2 3 4; do
  CHUNK_DIR="$BASEDIR/chunk_$i"
  (cd "$CHUNK_DIR" && nohup gp -q < "$BASEDIR/rigorous_rank2_chunk.gp" > "chunk_$i.stdout" 2>&1) &
  echo "Launched chunk $i: PID=$!"
done

wait
echo "All chunks done."
