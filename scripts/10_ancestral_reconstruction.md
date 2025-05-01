### Ancestral Area Reconstruction

Performed with **RASP v4.2** using MCC tree from **BEAST v2.5**.
- Bayesian Binary MCMC (BBM) model
- 4 biogeographic regions (A–D) defined based on Chilean biomes
- Only nodes with marginal probabilities ≥ 0.8 were retained.

#!/bin/bash
# 08_ancestral_area.sh - Ancestral area reconstruction using BEAST and RASP

# Performed with RASP v4.2 using MCC tree from BEAST v2.5.
# - Bayesian Binary MCMC (BBM) model
# - 4 biogeographic regions (A–D) defined based on Chilean biomes
# - Only nodes with marginal probabilities ≥ 0.8 were retained.

# Requirements:
# - BEAST v2.5
# - TreeAnnotator
# - Tracer v1.7
# - RASP v4.2
# - FigTree (optional for visualization)

BASE_DIR="/project/mepraia/transcriptomics"
BEAST_DIR="$BASE_DIR/beast_analysis"
RASP_DIR="$BASE_DIR/rasp_analysis"
XML_FILE="$BEAST_DIR/scng_input.xml"
TREE_FILE="$BEAST_DIR/scng_timecalibrated.trees"
MCC_TREE="$BEAST_DIR/scng_mcc.tree"

mkdir -p "$RASP_DIR"

# Step 1: Run BEAST analysis
beast -threads "$" "$XML_FILE"

# Step 2: Assess convergence using TRACER (manual step)
echo "Please assess convergence in Tracer v1.7 and ensure ESS > 200."
echo "Tracer input: $TREE_FILE"

# Step 3: Summarize maximum clade credibility tree
TreeAnnotator \
    -burnin 10 \
    -heights mean \
    "$TREE_FILE" \
    "$MCC_TREE"

# Step 4: Visualize MCC tree (optional)
echo "You can now visualize $MCC_TREE in FigTree for inspection."

# Step 5: Run RASP for ancestral area reconstruction (manual)
echo "Now import $MCC_TREE into RASP v4.2, define areas A–D, and run Bayesian Binary MCMC."
echo "Suggested regions:"
echo "A: Metropolitan (Mediterranean)"
echo "B: Atacama (hyper-arid desert)"
echo "C: Tarapacá (coastal-to-Andean ecotone)"
echo "D: Antofagasta (coastal/inland desert gradient)"

echo "RASP results will be saved in: $RASP_DIR"

# Completion message
echo "BEAST and RASP analysis pipeline complete. GUI steps required for TRACER and RASP."
