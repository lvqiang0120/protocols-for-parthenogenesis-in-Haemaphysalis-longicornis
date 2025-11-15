#!/usr/bin/bash

## software source
## Hisat2: https://daehwankimlab.github.io/hisat2/
## StringTie: https://github.com/gpertea/stringtie
### Steps

##Index building 
hisat2-build $genome_dir/$genome_nam $index_dir/$genome_nam

##mapping rna reads##

hisat2 --dta -p $thread -x $genome_dir/index_hisat2/$genome_nam \
		-1 $rnaseq_dir/${i}_R1.fq.gz \
		-2 $rnaseq_dir/${i}_R2.fq.gz \
		| samtools sort -@ $thread > $out_dir/${i}.sorted.bam

##StringTie##

stringtie $out_dir/${i}.sorted.bam  -o $out_dir/${i}_quantify.gtf -p $thread -G $genome_dir/$gff_nam -l ${i}_transcript -A ${i}_exp.txt -e -B 


