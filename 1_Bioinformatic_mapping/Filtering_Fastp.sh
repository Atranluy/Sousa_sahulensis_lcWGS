#!/usr/bin/env bash
#SBATCH --time=04:00:00
#SBATCH --cpus-per-task=4
#SBATCH --mem=15G
#SBATCH --output=%x-%a-%j.out
#SBATCH --error=%x-%a-%j.err
#SBATCH --array=1-46%10

module load mamba/24.9.0-0
mamba activate BIOINFO

#### Paths and variables
MAIN=/path_to/the_folder/main_dir
OUTPUT=${MAIN}/Fastp_output
SCRIPT_F=${MAIN}/SCRIPTS
List_sample=${MAIN}/SCRIPTS/all_samples_ID.txt
IN_PATH=${MAIN}/Raw_fastq_files

mkdir -p ${OUTPUT}
cd ${OUTPUT}

ITER=$SLURM_ARRAY_TASK_ID
SAMPLE=$(awk -v ITER=${SLURM_ARRAY_TASK_ID} '{if(NR==ITER) print $1}' ${List_sample})

#### Run fastp for adapter removal, quality filtering, and trimming
fastp \
  -i ${IN_PATH}/${SAMPLE}_1.fq.gz \
  -I ${IN_PATH}/${SAMPLE}_2.fq.gz \
  -o ${OUTPUT}/${SAMPLE}clean_1.fq.gz \
  -O ${OUTPUT}/${SAMPLE}clean_2.fq.gz \
  --trim_front1 5 \
  --trim_front2 5 \
  --qualified_quality_phred 20 \
  --thread 4
