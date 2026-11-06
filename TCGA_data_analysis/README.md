# TCGA-LUAD Gene Expression Analysis: NKX2-1

Differential expression analysis of the lung-specific lineage marker **NKX2-1** (TTF-1) comparing Primary Tumor and Solid Tissue Normal samples from the TCGA Lung Adenocarcinoma (LUAD) cohort.

## Repository Structure

* `README.md`: Documentation and execution guide.
* `scripts/`: Source code directory.
  * `data_extract.sh`: Shell script to extract NKX2-1 TPM values.
  * `plot.R`: R script for statistical testing and generating the boxplot.
* `output/`: Results directory.
  * `nkx2_1_data.tsv`: Extracted TPM quantification data.
  * `LUAD_ggplot.png`: Final notched boxplot figure.

## Pipeline Overview

### 1. Data Extraction
* Filtered `gdc_sample_sheet.tsv` for STAR-aligned RNA-seq quantification files (`*.rna_seq.augmented_star_gene_counts.tsv`).
* Identified existing sample directories and segregated samples into `Solid_Tissue_Normal` and `Primary_Tumor`.
* Extracted Column 7 (Transcripts Per Kilobase Million, TPM) for `NKX2-1` and stored values in `nkx2_1_data.tsv`.

### 2. Statistical Analysis & Visualization
* Transformation: $\log_2(\text{TPM} + 1)$
* Significance Testing: Two-sample Wilcoxon rank-sum (Mann-Whitney U) test.
* Plot: Notched boxplot visualizing median confidence intervals and distribution skewness.

## Prerequisites
* Linux / WSL environment
* Bash, AWK, Coreutils
* R (>= 4.0) with `ggplot2`

## Execution 

Run all commands from the root directory of the repository containing the input data files. 

### 1. Extraction Expression Data
Execute the extraction script located in `scripts/`:
```bash
bash scripts/data_extract.sh 
```

### 2. Statistical Analysis & Generation of Figure
Execute the R plotting script:

```bash
Rscript scripts/plot.R
```
Output image would be in LUAD_ggplot.png

