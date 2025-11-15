#!/usr/bin/bash

## software source
## STAR: https://github.com/alexdobin/STAR
### Steps

/public/home/rp1016swf/rp1016swf/software/STAR-2.7/source/STAR \
	--twopassMode Basic \
	--quantMode GeneCounts \
	--runThreadN $thread \
	--genomeDir $genomeDir \
	--outSAMtype BAM SortedByCoordinate \
	--sjdbOverhang 149 \
	--outSAMattrRGline ID:"$i" SM:"$i" PL:ILLUMINA \
	--outSAMmultNmax 1 \
	--outFileNamePrefix $our_dir/"$i" \
	--readFilesCommand gunzip -c --readFilesIn $rna_dir/clean_$sampleID_R1.fq.gz $rna_dir/clean_$sampleID_R2.fq.gz
