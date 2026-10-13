#!/usr/bin/env bash
#SBATCH --time=04:00:00
#SBATCH --cpus-per-task=2
#SBATCH --mem=30G
#SBATCH --output=%x-%a-%j.out
#SBATCH --error=%x-%a-%j.err
#SBATCH --array=1-21%5


OUTPUT=path_to/the_folder/Sousa/ANGSD_OUTPUT
SCRIPT=path_to/the_folder/Sousa/SCRIPTS
REF_G=path_to/the_folder/masked_ref_genome_Tursiops_truncatus/genome.fa
List_samp_GVCF=path_to/the_folder/Sousa/SCRIPTS/List_CHROM.txt

ITER=$SLURM_ARRAY_TASK_ID
CHR=$(awk -v ITER=${SLURM_ARRAY_TASK_ID} '{if(NR==ITER) print $1}' ${List_samp_GVCF} )

angsd -b pop1.filelist -ref ${REF_G} -anc ${REF_G} -r ${CHR} -doDepth 1 -doCounts 1 -uniqueOnly 1 -remove_bads 1 -only_proper_pairs 1 -minMapQ 30 -minQ 30 -baq 1 -C 50 -minInd 24 -out chr${ITER}_depth_pop1 -P 2

angsd -b pop2.filelist -ref ${REF_G} -anc ${REF_G} -r ${CHR} -doDepth 1 -doCounts 1 -uniqueOnly 1 -remove_bads 1 -only_proper_pairs 1 -minMapQ 30 -minQ 30 -baq 1 -C 50 -minInd 7 -out chr${ITER}_depth_pop2 -P 2
