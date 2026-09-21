#!/usr/bin/env bash

realSFS SAF_POP1_nomaf.saf.idx SAF_POP2_nomaf.saf.idx > pop1_pop2.ml 

realSFS fst index SAF_POP1_nomaf.saf.idx SAF_POP2_nomaf.saf.idx -sfs pop1_pop2.ml -fstout fst_pop1_pop2

### compute the meanFst overall
realSFS fst stats  fst_pop1_pop2.fst.idx

### compute it per windows
realSFS fst stats2 fst_pop1_pop2.fst.idx 
