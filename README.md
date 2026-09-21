# **Sousa sahulensis lcWGS project**
=====================================

## Overview
In this repository, you will find different folders and README files that provide scripts for the bioinformatic pipeline and analyses of low coverage Whole-Genome sequencing for the Australian Humpback dolphin *Sousa sahulensis* 

## Repository Structure
------------------------

- **1_Bioinformatic_pipeline/**: Contains all the bash script to do the rawdata cleaning, mapping prior the genotype likelihood calling with angsd.
- **2_Analyses/**: Contains different subfolders to do population structure, infering sex based on coverage, relatedness and inbreeding.

## Notes
Most of the scripts are written in bash and were used on a HPC using slurm job scheduler. Additionally, i also used conda/mamba (python) env to install all the software and utility tools.
Additionaly, check the script and adapt it with the right paths and variables.



