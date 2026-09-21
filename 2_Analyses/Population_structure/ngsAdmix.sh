#!/usr/bin/env bash

cd/path/to/folder/Sousa/NGSadmix
for k in {1..6}; do
  for rep in {1..10}; do
   /path/to/folder/Demography_softwares/ANGSD/Software/NGSadmix \
    -likes/path/to/folder/Sousa/NGSadmix/merged_maf_hardfilter_filter_50_r0.5.beagle.gz \
    -K ${k} -o run_${k}_rep${rep}_LD_unlinked_r2_0.5_50kbd -P 4
  done
done

