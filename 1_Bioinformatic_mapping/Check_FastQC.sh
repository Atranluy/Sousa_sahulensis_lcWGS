#!/usr/bin/env bash
#SBATCH --time=02:00:00
#SBATCH --cpus-per-task=2
#SBATCH --mem=10G
#SBATCH --output=%x-%a-%j.out
#SBATCH --error=%x-%a-%j.err
#SBATCH --array=1-46%10

module load mamba/24.9.0-0
mamba activate BIOINFO

#### Paths and variables
MAIN=/path_to/the_folder/main_dir
OUTPUT=${MAIN}/FastQC_results
SCRIPT_F=${MAIN}/SCRIPTS
List_sample=${MAIN}/SCRIPTS/all_samples_ID.txt
IN_PATH=${MAIN}/Raw_fastq_files

mkdir -p ${OUTPUT}
cd ${OUTPUT}

ITER=$SLURM_ARRAY_TASK_ID
SAMPLE=$(awk -v ITER=${SLURM_ARRAY_TASK_ID} '{if(NR==ITER) print $1}' ${List_sample})

#### Run FastQC on raw FASTQ files
fastqc \
  ${IN_PATH}/${SAMPLE}_1.fq.gz \
  ${IN_PATH}/${SAMPLE}_2.fq.gz \
  -o ${OUTPUT} \
  -t 2

