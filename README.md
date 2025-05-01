# 🧬 Comparative Transcriptomics in *Mepraia* Species

This repository contains the scripts and workflow used to perform a comparative transcriptomics study across three species of *Mepraia* (Hemiptera: Reduviidae), with the goal of exploring gene family dynamics, substitution rates, and evolutionary patterns.

## 📂 Pipeline Overview

The project uses de novo transcriptome assemblies, ORF prediction, functional annotation, orthology inference, and phylogenetic reconstruction based on RNA-Seq data.

### 🔧 Step-by-step scripts:

| Script | Description |
|--------|-------------|
| `01_download_reads.sh`       | Downloads raw reads from SRA using SRAtools |
| `02_qc_trimming.sh`          | Performs trimming with Trimmomatic and checks quality with FastQC |
| `03_assembly.sh`             | Assembles transcriptomes using Trinity and reduces redundancy with CD-HIT |
| `04_orf_prediction.sh`       | Extracts ORFs using Getorf and predicts coding regions with TransDecoder |
| `05_annotation.sh`           | Annotates proteins using DIAMOND, InterProScan, and HMMER |
| `06_orthology_analysis.sh`   | Infers orthologous clusters with OrthoFinder |
| `07_substitution_rates.sh`   | Estimates Ka/Ks rates using ParaAT and KaKs_Calculator |
| `08_phylogeny.sh`            | Reconstructs ML phylogeny with IQ-TREE |
| `09_species_delimitation.md` | Describes the species delimitation methods (bPTP, ABGD, ASAP, GMYC, LIMES) |
| `10_ancestral_reconstruction.md` | Describes ancestral range estimation using BEAST and RASP |

---

## 📦 Input Data

- 18 RNA-seq libraries from the heads and salivary glands of *Mepraia spinolai*, *M. gajardoi*, and *M. parapatrica*.
- NCBI BioProject: [PRJNA916468](https://www.ncbi.nlm.nih.gov/bioproject/PRJNA916468)

---

## 🧪 Requirements

All tools can be installed with Conda using the included `environment.yml`:

```bash
conda env create -f environment.yml
conda activate comparative_transcriptomics
```

### Required Tools:
- `sra-tools`, `Trimmomatic`, `FastQC`, `Trinity`, `CD-HIT`
- `TransDecoder`, `Getorf (EMBOSS)`, `DIAMOND`, `HMMER`, `InterProScan`
- `OrthoFinder`, `ParaAT`, `KaKs_Calculator`, `IQ-TREE`, `BEAST`, `RASP`, `MAFFT`, `FigTree`

---

## 🧾 Citation

If you use these scripts, please cite:

> Belintani et al. 2023. *Comparative transcriptomics of Mepraia species*. (in prep.)

You can also find a full list of software citations in the file [`CITATIONS.md`](./CITATIONS.md).

---

## 📬 Contact

For questions or collaborations, contact:  
**Tiago Belintani**  
`tiagobelintani@unesp.br`

