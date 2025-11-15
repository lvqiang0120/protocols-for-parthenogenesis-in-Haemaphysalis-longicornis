#variant calling
## filter fastq file by fqtools
for i in $(cat $rawdir/sample_list); do
{
fqtools_plus filter \
	--m 32 --ql 19 --Q 0.5 --n 0.05  \
	--adapt1 AGATCGGAAGAGCACACGTCTGAACTCCAGTCAC \
	--adapt2 AGATCGGAAGAGCGTCGTGTAGGGAAAGAGTGTA \
	$rawdir/$i/"$i"_R1.fq.gz $rawdir/$i/"$i"_R2.fq.gz \
	$cleandir/"$i"_clean_R1.fq $cleandir/"$i"_clean_R2.fq 
}
done 

## map reads by BWA-MEM
bwa mem -t 8 -k 35 -R "@RG\tID:$RGID\tPL:ILLUMINA\tPU:$sample\tLB:$library\tSM:$sample" ${reference} \
	${fq_file_name}.clean_R1.fq.gz ${fq_file_name}.clean_R2.fq.gz | samtools view -bS - > ${sample}.bam

## sort BAM file
gatk SortSam --INPUT ${sample}.bam --OUTPUT ${sample}.sorted.bam

## mark PCR duplicates
gatk MarkDuplicates --INPUT ${sample}.sorted.bam --METRICS_FILE ${sample}.markdup_metrics.txt --OUTPUT ${sample}.sorted.markdup.bam

## build BAM index
samtools index ${sample}.sorted.markdup.bam

## generate GCVF by HaplotypeCaller
gatk HaplotypeCaller --reference ${reference} --emit-ref-confidence GVCF --INPUT ${sample}.sorted.markdup.bam --OUTPUT ${sample}.g.vcf.gz

### Steps
## generate --variant parameter
for sample in `ls $samples_list`; do
		sample_gvcfs=${sample_gvcfs}"--variant ${sample}.g.vcf.gz "
done

## joint calling
gatk CombineGVCFs --reference ${reference} ${sample_gvcfs} --output ${pop}.g.vcf.gz

## genotype
gatk GenotypeGVCFs --reference ${reference} --variant ${pop}.g.vcf.gz --output ${pop}.vcf.gz
