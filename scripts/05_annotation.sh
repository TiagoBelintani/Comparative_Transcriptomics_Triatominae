#!/bin/bash
# Functional annotation
for pep in ../data/assemblies/*_cdhit.fasta.transdecoder.pep; do
    base=$(basename $pep .fasta.transdecoder.pep)
    diamond blastp -d nr -q $pep -o ../data/annotations/${base}_diamond.out -e 1e-3 -p 6
    interproscan.sh -i $pep -o ../data/annotations/${base}_ipr.tsv -f TSV
done
