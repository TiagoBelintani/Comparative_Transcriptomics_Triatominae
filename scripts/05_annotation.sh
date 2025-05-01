#!/bin/bash
# 05_go_annotation.sh - Prepare input files for functional annotation and GO enrichment

# Assumes prior TransDecoder, BLASTP, and HMMER steps have been completed

# . Notes for downstream analysis
cat <<EOL > "$BASE_DIR/go_annotation/${SPECIES}/README_annotation.txt"
# Instructions for online analysis

## Blast2GO
- Input: ${SPECIES}.pep or .cds + blastp.outfmt6 + ${SPECIES}.domblout
- Upload to Blast2GO (if you have access to the local or cloud version)
- Export GO annotations in .annot or .txt format

## ShinyGO (https://bioinformatics.sdstate.edu/go/)
- Input: List of protein or transcript IDs with GO terms (or .annot file)
- Paste or upload directly on the web tool

## WEGO 2.0 (http://wego.genomics.cn)
- Input: GO annotation file in WEGO format (.annot or list)
- Compare multiple species by merging GO files

## OrthoVenn3 (https://orthovenn3.bioinf.me/)
- Input: ${SPECIES}.pep file (FASTA format)
- Select "Multiple species comparison" and upload all target proteomes
- Outputs: shared clusters, Venn diagrams, gene family IDs
EOL

# 4. Completion message
echo "Annotation input files prepared for $SPECIES. Upload to web tools as instructed in README_annotation.txt."

