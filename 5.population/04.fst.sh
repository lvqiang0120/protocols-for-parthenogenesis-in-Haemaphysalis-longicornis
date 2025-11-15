#!/usr/bin/bash

### software source
## VCFtools: https://vcftools.github.io

### Steps
## calculate genetic differentiation (Fst) by VCFtools
vcftools --gzvcf ${pop}.maffiltered.snp.vcf.gz --weir-fst-pop population1.txt --weir-fst-pop population2.txt \
	--fst-window-size 100000 --fst-window-step 20000 --out ${pop}.100kbwindow_20kbstep