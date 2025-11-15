#!/usr/bin/bash

### software source
## GCTA: https://cnsgenomics.com/software/gcta

### Steps
plink --vcf "$pop".vcf.gz --make-bed --out "$pop" --allow-extra-chr

## generate genetic relationship matrix by GCTA
gcta64 --bfile "$pop" --make-grm --autosome --out "$pop"

## principal component analysis by GCTA
gcta64 --grm ${pop} --pca 3 --out ${pop}.pca

