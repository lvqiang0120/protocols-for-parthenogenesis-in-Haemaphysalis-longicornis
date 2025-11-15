# Running ALLHiC
## get Allele.ctg.table
gmap_build -D ./ -d DB seq.HiCcorrected.fasta
gmapl -D ./ -d DB -t 36 -f 2 -n 3 --min-trimmed-coverage=0.8 --min-identity=0.8 PHaeL.filter.chr.longest.cds.fa >gmap.gff3
perl gmap2AlleleTable.pl PHaeL.filter.chr.longest.gff3
python3 Allele.stat.py -i Allele.ctg.table -l seq.HiCcorrected.fasta.fai >stat.xls
## partition
python3 partition_gmap.py -g Allele.ctg.table -r seq.HiCcorrected.fasta -b PHaeL2022.sort.bam -d ./partition
## run allhic
for i in chr1 chr2 chr3 chr4 chr5 chr6 chr7 chr8 chr9 chr10 chr11;do sh $i/run_allhic.sh
### run allhic eg chr1:
ALLHiC_prune -i ../../Allele.ctg.table -b chr1.bam -r chr1.fa 1>prune.log 2>&1 
ALLHiC_partition -b prunning.bam -r chr1.fa -e GATC -k 3 > partion.log 2>&1
ALLHiC_rescue -b chr1.bam -r chr1.fa -c prunning.clusters.txt -i prunning.counts_GATC.txt > rescue.log 2>&1 
allhic extract chr1.bam chr1.fa --RE GATC 1>extract.log 2>&1
for dd in {1..3}; do allhic optimize group${dd}.txt chr1.clm;done 1>optimize.o 2>&1
ALLHiC_build chr1.fa
grep -w 'group1' ../../chr*/chr.agp |grep -v contig|cut -f6 >hap1.list
fish_seq.py hap1.list seq.HiCcorrected.fasta hap1.fa
perl getFalen.pl -i hap1.fa -o hap1.fa.len
python ALLHiC_plot chr1.bam groups.agp hap1.fa.len 500K hap1.500k.pdf
