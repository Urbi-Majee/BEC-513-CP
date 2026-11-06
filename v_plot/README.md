# cfDNA V-Plot Analysis Pipeline

## Overview
This project provides a reproducible computational workflow to generate V-plot heatmaps from cell-free DNA (cfDNA) paired-end sequencing fragments aligned around reference CTCF binding motifs. The resulting 2D density profile resolves the steric footprint of DNA-bound CTCF proteins alongside flanking phased nucleosomal arrays.

## Repository Structure
- `script/`: Contains executable scripts for coordinate matrix generation (`making_matrix.py`) and visualization (`vplot.gp`).
- `output/`: Stores the computed frequency matrix (`final_matrix.tsv`) and the rendered figure (`vplot.png`).

## Approach of the Project
1. **Motif-Centric Coordinate Calculation:** For each mapped record, the reference site coordinates are extracted directly from columns 1 and 2 (start and end) to compute the site midpoint, and cfDNA fragment length and midpoint are calculated from the aligned fragment coordinates.
2. **Strand-Specific Offset Assignment:** The relative distance (offset) from the fragment midpoint to the motif center is calculated and inverted for minus-strand motifs to maintain proper directional orientation.
3. **Dynamic Coordinate Tallying:** Valid data points within the predefined spatial window (-500 to +499 bp) and fragment length range (30 to 350 bp) are tallied in memory using a fast dictionary accumulator.
4. **Gnuplot Heatmap Rendering:** The resulting long-form TSV matrix is visualized using Gnuplot with `pm3d map` to display fragment density across continuous coordinates.

## Requirements
- Python 3.6+
- Gnuplot
- gzip / zcat

```bash
sudo apt update && sudo apt install -y gnuplot python3 gzip
```

## Pipeline Execution
The pipeline is executed from the repository root via a two-stage sequential workflow:
1.**Matrix Generation:**
The compressed alignment file is decompressed on the fly via zcat and piped to making_matrix.py, outputting the calculated coordinate matrix to final_matrix.tsv

```bash
zcat mapped.bed.gz | python3 script/making_matrix.py > final_matrix.tsv
```
2.**V-plot Generation:**
Gnuplot processes final_matrix.tsv using the predefined map projection and color palette in script/vplot.gp

```bash
gnuplot script/vplot.gp
```

