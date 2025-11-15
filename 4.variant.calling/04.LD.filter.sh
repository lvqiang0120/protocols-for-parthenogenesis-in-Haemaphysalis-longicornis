#!/usr/bin/bash

### software source
## plink:  https://s3.amazonaws.com/plink1-assets/plink_linux_x86_64_20231211.zip

### Steps
## LD-pruning was performed independently for each population by PLINK

for i in {1..11}
do
cd $vcf_dir
vcf_nam=pop.chr"$i"

plink --vcf "$vcf_nam".vcf.gz  --indep-pairwise 50 10 2 --out $out_dir/"$vcf_nam"."$pairwise" --allow-extra-chr --keep-allele-order

plink --vcf "$vcf_nam".vcf.gz \
	--extract $out_dir/"$vcf_nam"."$pairwise".prune.in \
	--recode vcf-iid \
	--out $out_dir/"$vcf_nam"."$pairwise".prune.in --allow-extra-chr --keep-allele-order

bgzip $out_dir/"$vcf_nam"."$pairwise".prune.in.vcf

done