#!/bin/bash
# Ka/Ks estimation
for pair in mg_vs_mp mp_vs_ms mg_vs_ms; do
    ParaAT.pl -h ${pair}.homologs -n ${pair}.nuc -a ${pair}.pep -p proc -o ${pair}_paraat -m mafft
    KaKs_Calculator -i ${pair}_paraat/codon.aln -o ${pair}_kaks.out -m YN
done
