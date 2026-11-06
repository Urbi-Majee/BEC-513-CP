#!/bin/bash

for f in chr*.bed; do
    sort -k2,2n -k3,3n -o "$f" "$f"
done

awk '{sub(/\r$/,""); print $1".bed"}' selection.tsv | xargs cat > quick_sorted.bed 
rm -f chr*.bed
