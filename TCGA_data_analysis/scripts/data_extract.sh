#!/bin/bash

OUTPUT="nkx2_1_data.tsv"
SAMPLE_SHEET="gdc_sample_sheet.tsv"

printf "sample_type\ttpm\n" > "$OUTPUT"

awk -F'\t' 'NR > 1 && ($8 == "Solid Tissue Normal" || $8 == "Primary Tumor") && ($2 ~ /\.rna_seq\.augmented_star_gene_counts\.tsv$/) {
    filepath = "../" $1 "/" $2
    
    if (system("test -f \"" filepath "\"") == 0) {
        if ($8 == "Solid Tissue Normal") {
            type = "Solid_Tissue_Normal"
        } else {
            type = "Primary_Tumor"
        }
        print filepath "\t" type
    }
}' "$SAMPLE_SHEET" > targets.tsv

cut -f2 targets.tsv > types.txt
cut -f1 targets.tsv > filepaths.txt

grep -m 1 -w -h "NKX2-1" $(< filepaths.txt) | cut -f7 > tpm.txt

paste types.txt tpm.txt >> "$OUTPUT"

rm -f targets.tsv types.txt filepaths.txt tpm.txt

printf "Extracted data saved to %s\n" "$OUTPUT"
