#!/bin/bash
# IQ-TREE phylogenetic reconstruction
iqtree2 -s concatenated_alignment.fasta -m MFP -bb 1000 -nt AUTO
