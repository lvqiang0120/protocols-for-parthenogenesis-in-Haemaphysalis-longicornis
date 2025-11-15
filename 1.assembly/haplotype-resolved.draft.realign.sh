# Realignment
ln -s seq.HiCcorrected.fasta genome.fa
bowtie2-build genome.fa ./genome
bowtie2 --very-sensitive -L 30 --score-min L,-0.6,-0.2 --end-to-end --reorder --rg-id BMG --phred33-quals -p 48 --un PHaeL2022_R1_genome.bwt2glob.unmap.fastq --rg SM:PHaeL2022_R1 -x genome -U PHaeL2022_R1_genome.bwt2glob.unmap_trimmed.fastq | samtools view -bS - > PHaeL2022_R1_genome.bwt2glob.unmap_bwt2loc.bam
samtools merge -@ 48 -n -f PHaeL2022_R1_genome.bwt2merged.bam PHaeL2022_R1_genome.bwt2glob.bam PHaeL2022_R1_genome.bwt2glob.unmap_bwt2loc.bam
samtools sort -@ 48 -n PHaeL2022_R1_genome.bwt2merged.bam PHaeL2022_R1_genome.bwt2merged.sorted
mv PHaeL2022_R1_genome.bwt2merged.sorted.bam PHaeL2022_R1_genome.bwt2merged.bam
bowtie2 --very-sensitive -L 30 --score-min L,-0.6,-0.2 --end-to-end --reorder --rg-id BMG --phred33-quals -p 48 --un PHaeL2022_R2_genome.bwt2glob.unmap.fastq --rg SM:PHaeL2022_R2 -x genome -U PHaeL2022_R2_genome.bwt2glob.unmap_trimmed.fastq | samtools view -bS - > PHaeL2022_R2_genome.bwt2glob.unmap_bwt2loc.bam
samtools merge -@ 48 -n -f PHaeL2022_R2_genome.bwt2merged.bam PHaeL2022_R2_genome.bwt2glob.bam PHaeL2022_R2_genome.bwt2glob.unmap_bwt2loc.bam
samtools sort -@ 48 -n PHaeL2022_R2_genome.bwt2merged.bam PHaeL2022_R2_genome.bwt2merged.sorted
mv PHaeL2022_R2_genome.bwt2merged.sorted.bam PHaeL2022_R2_genome.bwt2merged.bam
python mergeSAM.py -q 0 -t -v -f PHaeL2022_R1_genome.bwt2merged.bam -r PHaeL2022_R2_genome.bwt2merged.bam -o PHaeL2022_genome.bwt2pairs.bam
python3 rmdup_for_bam.py PHaeL2022_genome.bwt2pairs.bam PHaeL2022_genome.bwt2pairs.rmdup.bam
samtools sort -@ 32 -O BAM -o PHaeL2022.sort.bam PHaeL2022_genome.bwt2pairs.rmdup.bam
samtools index PHaeL2022.sort.bam

