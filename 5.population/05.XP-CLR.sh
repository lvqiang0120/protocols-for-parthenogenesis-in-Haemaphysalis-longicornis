#!/usr/bin/bash

## software source
## VCFtools: https://reich.hms.harvard.edu/sites/reich.hms.harvard.edu/files/inline-files/XPCLR.tar

sampleA=BFHaeL.list
sampleB=PHaeL.list

xpclr -Sa $sampleA -Sb $sampleB -I $vcf -C chr1 --maxsnps 3000 --size 100000 --step 20000 --out ./$vcf.chr1.snp.xpclr
xpclr -Sa $sampleA -Sb $sampleB -I $vcf -C chr2 --maxsnps 3000 --size 100000 --step 20000 --out ./$vcf.chr2.snp.xpclr
xpclr -Sa $sampleA -Sb $sampleB -I $vcf -C chr3 --maxsnps 3000 --size 100000 --step 20000 --out ./$vcf.chr3.snp.xpclr
xpclr -Sa $sampleA -Sb $sampleB -I $vcf -C chr4 --maxsnps 3000 --size 100000 --step 20000 --out ./$vcf.chr4.snp.xpclr
xpclr -Sa $sampleA -Sb $sampleB -I $vcf -C chr5 --maxsnps 3000 --size 100000 --step 20000 --out ./$vcf.chr5.snp.xpclr
xpclr -Sa $sampleA -Sb $sampleB -I $vcf -C chr6 --maxsnps 3000 --size 100000 --step 20000 --out ./$vcf.chr6.snp.xpclr
xpclr -Sa $sampleA -Sb $sampleB -I $vcf -C chr7 --maxsnps 3000 --size 100000 --step 20000 --out ./$vcf.chr7.snp.xpclr
xpclr -Sa $sampleA -Sb $sampleB -I $vcf -C chr8 --maxsnps 3000 --size 100000 --step 20000 --out ./$vcf.chr8.snp.xpclr
xpclr -Sa $sampleA -Sb $sampleB -I $vcf -C chr9 --maxsnps 3000 --size 100000 --step 20000 --out ./$vcf.chr9.snp.xpclr
xpclr -Sa $sampleA -Sb $sampleB -I $vcf -C chr10 --maxsnps 3000 --size 100000 --step 20000 --out ./$vcf.chr10.snp.xpclr
xpclr -Sa $sampleA -Sb $sampleB -I $vcf -C chr11 --maxsnps 3000 --size 100000 --step 20000 --out ./$vcf.chr11.snp.xpclr