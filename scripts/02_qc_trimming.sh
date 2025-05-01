#!/bin/bash
# Quality trimming with Trimmomatic and FastQC
mkdir -p ../data/trimmed ../data/qc_reports
for f in ../data/raw_reads/*_1.fastq.gz; do
    base=$(basename $f _1.fastq.gz)
    trimmomatic PE -threads 4 \
        ../data/raw_reads/${base}_1.fastq.gz ../data/raw_reads/${base}_2.fastq.gz \
        ../data/trimmed/${base}_1_paired.fq.gz ../data/trimmed/${base}_1_unpaired.fq.gz \
        ../data/trimmed/${base}_2_paired.fq.gz ../data/trimmed/${base}_2_unpaired.fq.gz \
        LEADING:5 TRAILING:5 SLIDINGWINDOW:5:20 MINLEN:50
    fastqc ../data/trimmed/${base}_*_paired.fq.gz -o ../data/qc_reports
done
