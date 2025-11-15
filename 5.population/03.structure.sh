#!/usr/bin/bash

### software source
## ADMIXTURE: http://dalexander.github.io/admixture/download.html

### Steps
## population structure analysis by ADMIXTURE

plink --vcf $vcf_dir/"$vcf_nam".vcf.gz \
        --recode 12 --out $out_dir/$vcf_nam --allow-extra-chr


for K in {1..10}; do 
	for repeat in {1..10}; do 
		admixture --cv "$vcf_nam".bed ${K} -j4 -s ${repeat} | tee log${K}.${repeat}.out;
	done
done
