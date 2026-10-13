#!/usr/bin/env bash
#SBATCH --time=30:00:00
#SBATCH --cpus-per-task=2
#SBATCH --mem=60G
#SBATCH --output=%x-%a-%j.out
#SBATCH --error=%x-%a-%j.err
#SBATCH --array=1-22%10

module load mamba/24.9.0-0
mamba activate BIOINFO

OUTPUT=/path_to/the_folder/Sousa/ANGSD_OUTPUT
SCRIPT=/path_to/the_folder/Sousa/SCRIPTS
REF_G=/path_to/the_folder/masked_ref_genome_Tursiops_truncatus/genome.fa
List_samp_GVCF=/path_to/the_folder/Sousa/SCRIPTS/List_CHROM.txt

ITER=$SLURM_ARRAY_TASK_ID
CHR=$(awk -v ITER=${SLURM_ARRAY_TASK_ID} '{if(NR==ITER) print $1}' ${List_samp_GVCF} )


#### call genotype likelihood in beagle format with strict filters threshold for all samples 
#### remove or add the -minmaf 0.05 to add or not the maf filterin 
cd ${SCRIPT}
angsd -b bam.filelist \
-ref ${REF_G} -anc ${REF_G} \
-out ${OUTPUT}/CHROM_${ITER}_hardfilter_nomaf \
-r ${CHR} \
-uniqueOnly 1 -remove_bads 1 -only_proper_pairs 1 \
-minMapQ 30 -minQ 30 -baq 1 -C 50 \
-doCounts 1 \
-GL 2 -doGlf 2 \
-doMajorMinor 1 -doMaf 1 \
-snp_pval 1e-6 \
-rmTriallelic 1 \
-minInd 34 \
-doIBS 1 \
-doSaf 1 \
-P 2 
#-minmaf 0.05


#### call genotype likelihood in beagle format with strict filters threshold for pop2
angsd -b pop2.filelist \
-ref ${REF_G} -anc ${REF_G} \
-out ${OUTPUT}/CHROM_${ITER}_hardfilter_nomaf_pop2 \
-r ${CHR} \
-uniqueOnly 1 -remove_bads 1 -only_proper_pairs 1 \
-minMapQ 30 -minQ 30 -baq 1 -C 50 \
-doCounts 1 \
-GL 2 -doGlf 2 \
-doMajorMinor 1 -doMaf 1 \
-snp_pval 1e-6 \
-rmTriallelic 1 \
-minInd 7 \
-doIBS 1 \
-doSaf 1 \
-P 2

#### call genotype likelihood in beagle format with strict filters threshold for pop1
angsd -b pop1.filelist \
-ref ${REF_G} -anc ${REF_G} \
-out ${OUTPUT}/CHROM_${ITER}_hardfilter_nomaf_pop1 \
-r ${CHR} \
-uniqueOnly 1 -remove_bads 1 -only_proper_pairs 1 \
-minMapQ 30 -minQ 30 -baq 1 -C 50 \
-doCounts 1 \
-GL 2 -doGlf 2 \
-doMajorMinor 1 -doMaf 1 \
-snp_pval 1e-6 \
-rmTriallelic 1 \
-minInd 24 \
-doIBS 1 \
-doSaf 1 \
-P 2
