# hifiasm asm
hifiasm -l 2 -o PHaeL -t 48 --h1 PHaeL2022_Lib1_Lane1_R1.fastq.gz,HaeL2022_Lib2_Lane1_R1.fastq.gz --h2 PHaeL2022_Lib1_Lane1_R2.fastq.gz,PHaeL2022_Lib2_Lane1_R2.fastq.gz merge.ccs.fasta.gz
gfatools gfa2fa -l 1000 PHaeL.hifiasm.bp.p_ctg.gfa >PHaeL.hifiasm.fa
# purge_dups remove dups
minimap2 -x map-hifi -t 12 PHaeL.hifiasm.fa merge.ccs.fasta.gz -o PHaeL.aln.paf
split_fa PHaeL.hifiasm.fa >PHaeL.asm.split
minimap2 -t 12 -xasm5 -DP PHaeL.asm.split PHaeL.asm.split -o PHaeL.asm.split.self.paf && gzip -f PHaeL.asm.split.self.paf
pbcstat PHaeL.asm.split.self.paf
calcuts PB.stat 1>cutoffs 2>calcultes.log
purge_dups -2 -T cutoffs  -c PB.base.cov PHaeL.asm.split.self.paf.gz >dups.bed 2>purge_dups.log
get_seqs -e dups.bed PHaeL.hifiasm.fa && mv purged.fa PHaeL.genome.fa
# BUSCO
busco --config ~/envs/busco/config/config.ini -i PHaeL.genome.fa -r -o PHaeL --out_path ~ -l arthropoda_odb10 -m geno --augustus_species fly -c 4 -f 
cat short_summary*.txt|grep -v '^$'|grep -v '#'|grep -v 'Results'| sed 's#^\t##g'|cat > BUSCO.xls
