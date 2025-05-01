#!/bin/bash
# GetORF and TransDecoder
for file in ../data/assemblies/*_cdhit.fasta; do
    base=$(basename $file _cdhit.fasta)
    getorf -sequence $file -outseq ../data/assemblies/${base}_orfs.fasta -minsize 450
    TransDecoder.LongOrfs -t $file
    TransDecoder.Predict -t $file
done
