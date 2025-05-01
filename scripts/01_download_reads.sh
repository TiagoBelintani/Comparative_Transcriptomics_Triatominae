#!/bin/bash
# Download RNA-seq data from SRA
SAMPLES=(SRR9999991 SRR9999992 SRR9999993 SRR9999994 SRR9999995 SRR9999996)
mkdir -p ../data/raw_reads && cd ../data/raw_reads || exit
for SAMPLE in "${SAMPLES[@]}"; do
    fasterq-dump --gzip --defline-seq '@$sn[_$rn]/$ri' --split-files "$SAMPLE" -e 4
    gzip ${SAMPLE}_1.fastq ${SAMPLE}_2.fastq
done
