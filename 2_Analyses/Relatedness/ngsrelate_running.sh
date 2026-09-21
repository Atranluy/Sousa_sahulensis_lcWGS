#!/usr/bin/env bash

beagle="$1"

zcat ${beagle}.beagle.gz | \
  awk 'NR>1 {
    i = match($1, /_[^_]*$/); 
    print substr($1, 1, i-1) "\t" substr($1, i+1)
  }' > ${beagle}.pos
  
nb_sites=$(wc -l < ${beagle}.pos)
nb_sam=$(zcat ${beagle}.beagle.gz | head -1 | awk '{print (NF-3)/3}')

ngsrelate -G ${beagle}.beagle.gz -n ${nb_sam} -L ${nb_sites}  -O ${beagle}_results_ngsrelate.txt
