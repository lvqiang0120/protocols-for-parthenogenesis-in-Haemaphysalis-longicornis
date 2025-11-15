#!/usr/bin/bash

### Steps
java -jar /public/home/rp1016swf/rp1016swf/software/Trimmomatic-0.36/trimmomatic-0.36.jar PE -phred33 -threads 40 \
	$data_dir/$sampleID_R1.fastq.gz \
	$data_dir/$sampleID_R2.fastq.gz \
	$clean_dir/clean_$sampleID_R1.fq.gz \
	$clean_dir/trim_$sampleID_R1.fq.gz \
	$clean_dir/clean_$sampleID_R2.fq.gz \
	$clean_dir/trim_$sampleID_R2.fq.gz \
	ILLUMINACLIP:/public/home/rp1016swf/rp1016swf/software/Trimmomatic-0.36/adapters/TruSeq3-PE-2.fa:2:30:10 SLIDINGWINDOW:4:15 LEADING:3 TRAILING:3 MINLEN:36


