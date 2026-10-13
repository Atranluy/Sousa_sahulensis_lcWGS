# **Sousa sahulensis lcWGS project**
=====================================

## Overview
In this repository, you will find different folders and README files that provide scripts for the bioinformatic pipeline and analyses of low coverage Whole-Genome sequencing for the Australian Humpback dolphin *Sousa sahulensis* 

## Scripts Overview
### 1_Bioinformatic
- **Check_FastQC.sh**: Quality control of raw FASTQ files using FastQC
- **Filtering_Fastp.sh**: Adapter removal, quality filtering, and trimming of reads using fastp \
(removes residual adapters, low-quality reads, and first 5 base pairs)
- **Mapping_fastq_to_bam.sh**: Mapping of filtered FASTQ files to reference genome using BWA-MEM and Picard
- **ANGSD_filter.sh**: Genotype likelihood calling (beagle file) with strict filters for all samples and per populations
- **ANGSD_cov.sh**: Depth and coverage calculations per populations
- **ANGSD_saf_realSFS.sh**: Site allele frequency (SAF) estimation and realSFS analysis 
(used to calculate whole Fst and nucleotide diversity)

### 2_Analyses

#### Coverage_Sex_inference
- **angsd_coverage_call.sh**: Estimates depth and coverage for X sex chromosome

#### Inbreeding
- **ngsF-HMM.sh**: Hidden Markov Model for inbreeding estimation (ngsF-HMM provided script)

- **run_ngsf-HMM_rep.sh**: Wrapper script to run multiple replicates of ngsF-HMM \
    (my own provided wrapper script to use the ngsF-HMM.sh)

#### Population_structure
- **PCAngsd.sh**: Principal Component Analysis using PCAngsd
- **ngsAdmix.sh**: Admixture analysis using NGSadmix
- **realSFS_Fst.sh**: Fst calculation between populations using realSFS
- **theta_script.sh**: Estimates nucleotide diversity (theta) statistics

#### Relatedness
- **ngsrelate_running.sh**: Estimates relatedness coefficients using ngsrelate (v2)

## Requirements
- Bash scripts designed for SLURM job scheduler \
   - (mostly Bioinformatic ones)
   - Otherwise ran locally (depend on your dataset size)
- Conda/Mamba environment with bioinformatics tools
- Reference genome: *Tursiops truncatus* masked genome \
 See the Manuscript for more details on the genome.

## Usage
1. Adapt all scripts with correct paths and variables
2. Submit jobs using `sbatch script_name.sh`
3. Check output directories for results

## Notes
All scripts include SLURM directives for HPC execution. Modify parameters according to your dataset.

