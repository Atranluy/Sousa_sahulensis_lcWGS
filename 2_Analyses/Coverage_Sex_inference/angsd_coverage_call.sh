#!/bin/bash


angsd -bbam.filelist \
-ref /path/to/folder/masked_ref_genome_Tursiops_truncatus/genome.fa \
-anc /path/to/folder/masked_ref_genome_Tursiops_truncatus/genome.fa \ 
-r NC_047043.1 \ 
-doDepth 1 -doCounts 1 -uniqueOnly 1 -remove_bads 1 -only_proper_pairs 1 -minMapQ 30 -minQ 30 -baq 1 -C 50 -minInd 34 -out chr10_depth -P 2 
