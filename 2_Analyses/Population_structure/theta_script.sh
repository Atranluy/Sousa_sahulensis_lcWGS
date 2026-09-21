#!/bin/bash

SAF_IDX="SAF_POP2_nomaf.saf.idx"
OUT="SAF_POP2"
WINDOW=50000
STEP=10000
THREADS=8

# check angsd version being used
echo "==> ANGSD version:"
angsd version 2>&1 | head -2
realSFS 2>&1 | head -2
thetaStat 2>&1 | head -2

# ── 1. SFS ────────────────────────────────────────────────────────────────────
echo "==> Estimating SFS ..."
realSFS ${SAF_IDX} \
    -maxIter 100 \
    -tole 1e-6 \
    -P ${THREADS} \
    > ${OUT}.sfs

# ── 2. saf2theta — force overwrite of old thetas files ────────────────────────
echo "==> Running saf2theta ..."
rm -f ${OUT}_theta.thetas.gz ${OUT}_theta.thetas.idx   # remove old incompatible files

realSFS saf2theta ${SAF_IDX} \
    -sfs ${OUT}.sfs \
    -outname ${OUT}_theta \
    -P ${THREADS}

ls -lh ${OUT}_theta.thetas.gz ${OUT}_theta.thetas.idx

# ── 3. Global estimate ────────────────────────────────────────────────────────
echo "==> Global theta estimate ..."
thetaStat do_stat ${OUT}_theta.thetas.idx \
    -outnames ${OUT}_theta_global

cat ${OUT}_theta_global.pestPG

# ── 4. Windowed estimates ─────────────────────────────────────────────────────
echo "==> Windowed theta estimates ..."
thetaStat do_stat ${OUT}_theta.thetas.idx \
    -win ${WINDOW} \
    -step ${STEP} \
    -outnames ${OUT}_theta_win${WINDOW}_step${STEP}

head -3 ${OUT}_theta_win${WINDOW}_step${STEP}.pestPG
