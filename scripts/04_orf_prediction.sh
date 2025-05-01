#!/bin/bash
# 04_orf_prediction.sh - Predict coding sequences using TransDecoder, BLASTP, and HMMER

# Fictitious directory structure as example
BASE_DIR="/project/mepraia/transcriptomics"
TRINITY_DIR="$BASE_DIR/assemblies/species_x"
OUT_DIR="$BASE_DIR/cds/species_x/Trinity.transdecoder_dir"

# Step 1: TransDecoder LongOrfs
TransDecoder.LongOrfs \
    -t "$TRINITY_DIR/Trinity.fasta" \
    -G universal \
    -S \
    --output_dir "$OUT_DIR"

# Step 2: BLASTP (run this inside the SwissProt db folder)
blastp \
    -query "$OUT_DIR/longest_orfs.pep" \
    -db uniprot_sprot.fasta \
    -evalue 1e-5 \
    -num_threads 60 \
    -max_target_seqs 5 \
    -outfmt 5 \
    -out "$OUT_DIR/blastp/blastp.outfmt6"

# Step 3: HMMER scan
hmmscan \
    --domtblout "$OUT_DIR/pfam/species_x.domblout" \
    --acc --notextw \
    "$BASE_DIR/databases/pfam/Pfam-A.hmm" \
    "$OUT_DIR/longest_orfs.pep" \
    > "$OUT_DIR/pfam/log.pfam"

# Step 4: Final prediction with TransDecoder using external evidence
TransDecoder.Predict \
    -t "$TRINITY_DIR/Trinity.fasta" \
    --retain_pfam_hits "$OUT_DIR/pfam/species_x.domblout" \
    --retain_blastp_hits "$OUT_DIR/blastp/blastp.outfmt6" \
    -O "$OUT_DIR"

# Utility commands for inspecting output
# grep --count ">" Trinity.fasta.transdecoder.cds         # total CDS
# grep --count "complete" Trinity.fasta.transdecoder.cds  # complete CDS only
# grep --count "GO" Trinity.fasta.transdecoder.cds         # GO-annotated sequences

# Note: For multiple species, use a loop or replicate this block with species_x replaced by actual IDs (e.g., m6, m7, etc.)
