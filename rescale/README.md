## Rescalling cDna fragment length to fit the reference plot

A lightweight computational pipeline to rescale cell-free DNA (cfDNA) fragment length distributions from BED data (`query.bed.gz`) to match an empirical reference profile (`reference.hist`)
---

## Overview & Approach

1. **Count Fragment Sizes:** 
   The pipeline reads through all sequenced DNA fragments and records the percentage of fragments at each size (from short ~50 bp reads to longer fragments).

2. **Find the Limiting Size (Bottleneck):** 
   Since downsampling can only discard reads, the final sample size is limited by whichever fragment length is rarest in the data compared to the reference curve. The pipeline identifies this limiting point (anchored around the ~167 bp nucleosome core) and keeps 100% of those reads.

3. **Downsample the Excess (Rejection Sampling):** 
   In a second pass, each read is tested individually with a weighted random check. Overrepresented short fragments (such as ~50 bp reads) are aggressively thinned out, while reads at the limiting length are preserved.

4. **Distribution Matching:** 
   This selective removal reshapes the remaining data so its overall size profile matches the target reference curve.---

## Directory Structure  
Script Directory (script/): Contains the computational scripts, including the rejection sampling implementation (rescale.py) and the plotting routine (rescale_plotc.gp).   
Output Directory (output/): Stores the rendered rescalled plot image (plot_r.png)

## Pre-requisites

Python 3.8+
Linux native utilities (zcat / gzip)
Gnuplot 5.x+

## Execution
Run everything from thr root directory where query.bed.gz and reference.hist is present.
```bash
python3 script/rescale.py 
gnuplot script/rescale_plotc.gp
```
The resulting plot will be saved to output/plot_r.png.
