#!/usr/bin/env bash
#SBATCH --time=100:00:00
#SBATCH --cpus-per-task=3
#SBATCH --mem-per-cpu=5G
#SBATCH --output=%x-%a-%j.out
#SBATCH --error=%x-%a-%j.err
#SBATCH --array=7-46%10

module load mamba/24.9.0-0
mamba activate BIOINFO

#### change all path 

MAIN=/path_to/the_folder/main_dir
OUTPUT=/path_to/the_folder/main_dir/BWA_MAPPING
SCRIPT_F=${MAIN}/SCRIPTS
List_sample=${MAIN}/SCRIPTS/all_samples_ID.txt
IN_PATH=/path_to/the_folder/main_dir/Fastp_output
REF=/path_to_dir/masked_ref_genome_Tursiops_truncatus/genome.fa
List_sample2=${MAIN}/SCRIPTS/all_samples_name.txt
TEMP_DIR=${MAIN}/tmp


mkdir -p ${OUTPUT}
cd ${OUTPUT}

ITER=$SLURM_ARRAY_TASK_ID
SAMPLE=$(awk -v ITER=${SLURM_ARRAY_TASK_ID} '{if(NR==ITER) print $1}' ${List_sample})
SAMPLE_NAME=$(awk -v ITER=${SLURM_ARRAY_TASK_ID} '{if(NR==ITER) print $1}' ${List_sample})

bwa mem \
-M -t 4 \
-R '@RG\tID:${ITER}\tSM:${SAMPLE_NAME}\tPL:ILLUMINA\tLB:WGS_Sousa\tPU:Barcelona' \
${REF} ${IN_PATH}/${SAMPLE}clean_1.fq.gz ${IN_PATH}/${SAMPLE}clean_2.fq.gz > ${OUTPUT}/${SAMPLE}_Tt_masked.sam

picard SortSam \
    I=${OUTPUT}/${SAMPLE}_Tt_masked.sam \
    O=${OUTPUT}/${SAMPLE}_Tt_masked_sorted.bam \
    SORT_ORDER=coordinate \
    CREATE_INDEX=true \
    VALIDATION_STRINGENCY=LENIENT \
    TMP_DIR=${TEMP_DIR}

samtools flagstat ${OUTPUT}/${SAMPLE}_Tt_masked_sorted.bam > ${SAMPLE}_Tt_masked.stats

picard MarkDuplicates \
    I=${OUTPUT}/${SAMPLE}_Tt_masked_sorted.bam \
    O=${OUTPUT}/${SAMPLE}_Tt_masked_sorted_markdup.bam \
    ASSUME_SORTED=TRUE \
    REMOVE_DUPLICATES=FALSE \
    CREATE_INDEX=TRUE \
    METRICS_FILE=${OUTPUT}/${SAMPLE}_metrics_file_markdup.txt \
    VALIDATION_STRINGENCY=LENIENT \
    TMP_DIR=${TEMP_DIR}

# Indexing final BAM file
samtools index ${OUTPUT}/${SAMPLE}_Tt_masked_sorted_markdup.bam

