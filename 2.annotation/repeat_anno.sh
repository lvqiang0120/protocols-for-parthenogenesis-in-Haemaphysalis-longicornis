# tRNA
tRNAscan-SE PHaeL.genome.fa -o PHaeL.genome.fa.out 
# 18s_28s
formatdb -p F -o T -i PHaeL.genome.fa 
blastall -p blastn -e 1e-5  -v  10000  -b  10000  -d PHaeL.genome.fa -a  10  -i ncRNA_db_animal -o PHaeL.genome.fa.rRNA.blast 
blast_parser.pl PHaeL.genome.fa.rRNA.blast PHaeL.genome.fa.rRNA
perl tab2gff3.pl -i PHaeL.genome.fa.rRNA
# rRNA
rfam_scan.pl -blastdb Rfam.fasta Rfam.cm PHaeL.genome.fa -o PHaeL.genome.fa.ncRNA.gff3
# RepeatMasker
TEsorter LTR.lib 
python3 LTR_sorter.py -i LTR.lib.rexdb.cls.lib -o LTR.new.lib
cat all.RepBase.25.05.lib LTR.new.lib >all_repeat.lib
RepeatMasker -nolow  -no_is  -norna  -parallel  3  -lib all_repeat.lib PHaeL.genome.fa 
cat *.out >RepeatMasker.out
perl repeat_to_gff.pl RepeatMasker.out 
cat *.masked >genome.repeatmaskermasked.fa
# RepeatProteinMask
RepeatProteinMask -engine ncbi PHaeL.genome.fa
for i in log/*.annot; do perl makegff3.pl $i $i.proteinmask.gff3;done
cat log/*proteinmask.gff3 >proteinmask.gff3
# Trf
perl fastaDeal.pl -cutf 100 PHaeL.genome.fa ./split_genome_assembly
for dd in `ls ./split_genome_assembly/*fasta`;do echo "cd ./split_genome_assembly && trf $dd 2 7 7 80 10 50 500 -d -h" >>trf.sh;done
ParaFly -c trf.sh -CPU 50
cat ./split_genome_assembly/*.dat > genome.trf.dat && perl makegff3.pl genome.trf.dat trf.gff3
# DeepTE
conda activate deepte && DeepTE_domain.py -d deepTE_working_dir -o RepeatModeler -i RepeatModeler/RM_*/consensi.fa.classified -s supfile_dir --hmmscan bin/hmmscan
conda activate deepte && DeepTE.py -d deepTE_working_dir -o RepeatModeler -i RepeatModeler/RM_*/consensi.fa.classified -m_dir DeepTE/database/animal -sp M -modify opt_te_domain_pattern.txt
python3 process_class.py -i opt_DeepTE.fasta -o opt_DeepTE.rename.fasta
# RepeatModeler
cd ./RepeatModeler && BuildDatabase -name Repeats -engine ncbi genome.repeatmaskermasked.fa
cd ./RepeatModeler && RepeatModeler -database Repeats -pa 10 -engine ncbi
RepeatMasker -nolow  -no_is  -norna  -parallel  3  -lib opt_DeepTE.rename.fasta PHaeL.genome.fa
cat *.out >RepeatModeler.out
cat *.fa.masked >PHaeL.genome.masked.fa
