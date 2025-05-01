#!/bin/bash
# 06_kaks_estimation.sh - Estimate substitution rates (Ka/Ks) for ortholog pairs

# Requirements:
# - EMBOSS getorf
# - OrthoFinder output (orthogroups)
# - MAFFT
# - ParaAT
# - KaKs_Calculator
# - Python + pandas for filtering

BASE_DIR="/project/mepraia/transcriptomics"
SPECIES_PAIR="mg_vs_mp"  # Change this for each pair
ORTHO_DIR="$BASE_DIR/orthologs/$SPECIES_PAIR"
NUC_FILE="$ORTHO_DIR/single.nuc"
PEP_FILE="$ORTHO_DIR/single.pep"
HOMOLOG_FILE="$ORTHO_DIR/${SPECIES_PAIR}.homolog"
PARAAT_OUT="$ORTHO_DIR/paraat"
KAKS_OUT="$ORTHO_DIR/kaks"

# Step 1: Codon alignment using ParaAT
mkdir -p "$PARAAT_OUT"
ParaAT.pl \
    -c 1 \
    -m mafft \
    -homolog "$HOMOLOG_FILE" \
    -aminoacid "$PEP_FILE" \
    -nuc "$NUC_FILE" \
    -processor "$ORTHO_DIR/hmc.proc" \
    -output "$PARAAT_OUT" \
    -format axt

# Step 2: Estimate Ka/Ks values
mkdir -p "$KAKS_OUT"
KaKs_Calculator \
    -i "$PARAAT_OUT/${SPECIES_PAIR}_single.axt" \
    -o "$KAKS_OUT/${SPECIES_PAIR}.kaks" \
    -m YN -c 1

# Step 3: Filter Ka/Ks values using pandas (Python)
cat <<EOF > "$KAKS_OUT/filter_kaks.py"
import pandas as pd

input_file = "$KAKS_OUT/${SPECIES_PAIR}.kaks"
output_file = "$KAKS_OUT/${SPECIES_PAIR}_filtered.tsv"

# Read the KaKs results
cols = pd.read_csv(input_file, sep='\t', nrows=0).columns.tolist()
df = pd.read_csv(input_file, sep='\t', comment='#')

# Apply filtering criteria
filtered = df[
    (df['Length'] >= 450) &
    (df['Ks'] <= 0.1) &
    df['Ka'].notna() &
    df['Ks'].notna() &
    (df['Ka/Ks'] <= 1)
]

filtered.to_csv(output_file, sep='\t', index=False)
print(f"Filtered Ka/Ks results saved to {output_file}")
EOF

python3 "$KAKS_OUT/filter_kaks.py"

# Completion message
echo "Ka/Ks estimation and filtering complete for $SPECIES_PAIR. Output in $KAKS_OUT."

# Note: Loop over all species pairs for full automation
