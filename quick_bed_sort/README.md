# Sorting a .bed file but making it quick

A lightweight, streaming Bash and Python pipeline to partition large, mixed-chromosome BED files into per-chromosome subsets, coordinate-sort them in parallel/in-place, and merge them  according to a custom karyotype order.

## Overview


Standard sorting of genome-scale BED files using single-pass tools often encounters high I/O overhead or memory limits. This pipeline splits the problem into three focused stages:

1. **Partition by Chromosome**: Streams gzipped BED records via standard input and routes them into chromosome-specific subsets using Python, filtering exclusively for targets in `selection.tsv`.
2. **Sort**: Runs GNU `sort` independently across each intermediate chromosome file, numerically indexing start (column 2) and end (column 3).
3. **Merge**: Concatenates sorted subsets into `output/quick_sorted.bed` according to the exact karyotypic order defined in `selection.tsv 

## Requirements

- Linux / WSL (Ubuntu/Debian recommended)
- Bash 4+
- Python 3.x
- Coreutils: `sort`, `sed`, `cat`, `gzip`/`zcat`

## Repository Structure

- `script/`: Execution scripts (`split.py` and `sort_merge.sh`).
- `README.md\`

## Execution

Run the complete pipeline from the root directory where the input data file slection.tsv present:

```bash
zcat shuf.a.bed.gz shuf.b.bed.gz | python3 script/split.py && bash script/sort_merge.sh

The ouput would come in a file quick_sorted.bed .
