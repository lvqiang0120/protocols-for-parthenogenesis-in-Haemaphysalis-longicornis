# hifiasm asm
hifi=Hifi.fasta.gz 
hifiasm -o $rawgenome -t 40 --hg-size 2.6g -l 2 -s 0.99 --n-hap 40 --h1 Hicdata_R1.fq.gz --h2 Hicdata_R2.fq.gz $hifi
#remove dups
##hifi data map##
minimap2 -ax map-hifi -t 40 $rawgenome $hifi --secondary=no -o hifi_aln.sam
samtools view -@ 40 -t $rawgenome -bS hifi_aln.sam -o hifi_aln.bam
samtools sort  -t 40 hifi_aln.bam > hifi_aln_sorted.bam
##purge_haplotigs 
purge_haplotigs readhist -b hifi_aln_sorted.bam -g $rawgenome -t 40
purge_haplotigs cov -i hifi_aln_sorted.bam.gencov -l 0 -m 55 -h 200 -o coverage_stats.csv 
purge_haplotigs purge -g $rawgenome -c coverage_stats.csv -a 43 -t 40 $genome
#Juicer
##zun bei##
restriction_sites_dir=/public/home/rp1016swf/rp1016swf/lyuqiang/phael/result_lvqiang/denovo/canu/juicer/restriction_sites
bwa index $genome -a bwtsw
python generate_site_positions.py DpnII $restriction_sites_dir/$genome $genome_dir/$genome 
awk 'BEGIN{OFS="\t"}{print $1, $NF}' $restriction_sites_dir/"$genome_nam"_DpnII.txt > $restriction_sites_dir/"$genome_nam"_chrom.sizes
##juicer begin##
bash juicer.sh -d $hic_dir -z $genome -y $restriction_sites_dir/"$genome_nam"_DpnII.txt -p $restriction_sites_dir/"$genome_nam"_chrom.sizes -s DpnII -t 40 -D /juicer/juicer-1.6/
#3DDNA
merged_nodups=merged_nodups.txt
bash run-asm-pipeline.sh $genome $merged_nodups > $out_dir/3d.log
review=$genome.review.assembly.assembly
bash run-asm-pipeline-post-review.sh -r $review $genome $merged_nodups  > $out_dir/3d_review.log 

#BMHaeL asm
ref=BFHaeL.genome.fa
qry=BMHaeL.draft.geneome.fa
##correct a query assembly##
ragtag.py correct $ref $qry -t 20 -o $out_dir
##scaffold a query assembly##
ragtag.py scaffold $ref $out_dir/ragtag.correct.fasta -t 20 -o $out_dir -w
##patch##
ragtag.py patch $out_dir/ragtag.scaffold.fasta $qry -t 40 -o $out_dir