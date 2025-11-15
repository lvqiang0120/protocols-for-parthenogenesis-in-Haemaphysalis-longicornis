#!/usr/bin/bash

## software source
## VCFtools: https://vcftools.github.io

### Steps
## calculate nucleotide diversity (π) by VCFtools
vcftools --gzvcf ${pop}.maffiltered.snp.vcf.gz --window-pi 100000 --window-pi-step 100000 --out ${pop}.100kbwindow_100kbstep
