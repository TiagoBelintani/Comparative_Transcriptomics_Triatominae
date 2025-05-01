#!/bin/bash
# Trinity assembly and CD-HIT clustering
species_list=(mg mp ms)
for sp in "${species_list[@]}"; do
    Trinity --seqType fq --max_memory 500G --CPU 40 \
        --left ../data/trimmed/${sp}_left.fq.gz --right ../data/trimmed/${sp}_right.fq.gz \
        --output ../data/assemblies/${sp}_trinity
    cd-hit-est -i ../data/assemblies/${sp}_trinity/Trinity.fasta \
        -o ../data/assemblies/${sp}_cdhit.fasta -c 0.95 -n 8
done
