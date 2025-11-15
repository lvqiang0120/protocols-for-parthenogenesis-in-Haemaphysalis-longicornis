# draft genome asm & index
hifiasm -l 2 -o PHaeL -t 48 --h1 PHaeL2022_Lib1_Lane1_R1.fastq.gz,HaeL2022_Lib2_Lane1_R1.fastq.gz --h2 PHaeL2022_Lib1_Lane1_R2.fastq.gz,PHaeL2022_Lib2_Lane1_R2.fastq.gz merge.ccs.fasta.gz
gfatools gfa2fa -l 1000 PHaeL.hifiasm.bp.p_utg.gfa >PHaeL.draft.fa
bwa index -a bwtsw PHaeL.draft.fa
samtools faidx PHaeL.draft.fa
