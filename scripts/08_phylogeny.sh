#!/bin/bash
# 07_phylogeny.sh - Alignment and phylogenetic inference for SCNGs

# Requirements:
# - MAFFT
# - IQ-TREE v2
# - AMAS (for concatenation, assumed already run)

BASE_DIR="/project/mepraia/transcriptomics"
ALIGN_DIR="$BASE_DIR/scng_alignments"
TREE_DIR="$BASE_DIR/scng_trees"
CONCAT="$ALIGN_DIR/concatenated_alignment.fasta"

mkdir -p "$TREE_DIR"

# Step 1: Align SCNGs with MAFFT
cd "$ALIGN_DIR"
for file in *.fasta; do
    aligned="${file%.fasta}_aligned.fasta"
    mafft --auto "$file" > "$aligned"
    echo "Alignment complete for $file"

# Step 2: Concatenate all aligned FASTA files with AMAS
cd "$ALIGN_DIR"
AMAS.py concat \
    -i *_aligned.fasta \
    -f fasta \
    -d dna \
    -p partitions.txt \
    -t concatenated_alignment.fasta

# Step 3: Phylogenetic inference from concatenated alignment (if already created with AMAS)
    iqtree2 \
        -s "$aligned" \
        -m MFP \
        -bb 1000 \
        -alrt 1000 \
        -st DNA \
        -nt AUTO \
        -pre "$TREE_DIR/${aligned%.fasta}"
    echo "Tree inference complete for $aligned"
done

# Step 3: Phylogenetic inference from concatenated alignment (if already created with AMAS)
if [[ -f "$CONCAT" ]]; then
    echo "Running IQ-TREE on concatenated alignment..."
    iqtree2 \
        -s "$CONCAT" \
        -m MFP \
        -bb 1000 \
        -alrt 1000 \
        -st DNA \
        -nt AUTO \
        -pre "$TREE_DIR/concatenated_tree"
    echo "Concatenated tree inference complete."
else
    echo "Concatenated alignment not found: $CONCAT"
fi
