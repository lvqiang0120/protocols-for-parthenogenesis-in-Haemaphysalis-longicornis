# Genome Correction
samtools sort -@ 32 -m 3G -O BAM -o PHaeL2022.sort.bam PHaeL2022.bam
samtools index -@ 32 PHaeL2022.sort.bam
ALLHiC_corrector -m PHaeL2022.sort.bam -r PHaeL.draft.fa -o seq.HiCcorrected.fasta -t 32
