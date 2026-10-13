#!/usr/bin/env bash
#SBATCH --time=12:00:00
#SBATCH --cpus-per-task=2
#SBATCH --mem=40G
#SBATCH --output=%x-%a-%j.out
#SBATCH --error=%x-%a-%j.err
#SBATCH --array=2

#####1-21%21
module load mamba/24.9.0-0
mamba activate BIOINFO

OUTPUT=/path_to/the_folder/Sousa/ANGSD_OUTPUT
SCRIPT=/path_to/the_folder/Sousa/SCRIPTS
REF_G=/path_to/the_folder/masked_ref_genome_Tursiops_truncatus/genome.fa
List_samp_GVCF=/path_to/the_folder/Sousa/SCRIPTS/List_CHROM.txt

POP1=pop1.filelist
POP2=pop2.filelist

ITER=$SLURM_ARRAY_TASK_ID
CHR=$(awk -v ITER=${SLURM_ARRAY_TASK_ID} '{if(NR==ITER) print $1}' ${LIST_CHROM})

cd ${SCRIPT}

angsd -b ${POP1} \
-ref ${REF_G} \
-out ${OUTPUT}/CHROM_${ITER}_POP1 \
-r ${CHR} \
-uniqueOnly 1 \
-remove_bads 1 \
-minMapQ 30 \
-minQ 20 \
-minInd 15 \
-GL 2 \
-doSaf 1 \
-P 2 \
-anc ${REF_G}

angsd -b ${POP2} \
-ref ${REF_G} \
-out ${OUTPUT}/CHROM_${ITER}_POP2 \
-r ${CHR} \
-uniqueOnly 1 \
-remove_bads 1 \
-minMapQ 30 \
-minQ 20 \
-minInd 5 \
-GL 2 \
-doSaf 1 \
-P 2 \
-anc ${REF_G}
