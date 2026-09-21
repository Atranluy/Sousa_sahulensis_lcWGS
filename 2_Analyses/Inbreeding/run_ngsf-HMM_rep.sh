#!/bin/bash

beagle="$1"

zcat ${beagle}.beagle.gz | \
  awk 'NR>1 {
    i = match($1, /_[^_]*$/); 
    print substr($1, 1, i-1) "\t" substr($1, i+1)
  }' > ${beagle}.pos
  
nb_sites=$(wc -l < ${beagle}.pos)
nb_sam=$(zcat ${beagle}.beagle.gz | head -1 | awk '{print (NF-3)/3}')

./ngsF-HMM.sh --geno ${beagle}.beagle.gz --lkl --n_ind ${nb_sam} --n_sites ${nb_sites} --out ${beagle}_results_ngsf-HMM --min_epsilon 1e-9 --pos ${beagle}.pos --n_threads 6 --seed ${RANDOM}

