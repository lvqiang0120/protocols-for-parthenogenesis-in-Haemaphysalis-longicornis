#!/usr/bin/bash

### software source
## VCFtools: https://vcftools.github.io

### Steps
## calculate TajimaD value by VCFtools

vcftools --gzvcf $vcf_dir/"$vcf_nam".vcf.gz  --TajimaD 1000000  --out $out_dir/"$vcf_nam".1M
