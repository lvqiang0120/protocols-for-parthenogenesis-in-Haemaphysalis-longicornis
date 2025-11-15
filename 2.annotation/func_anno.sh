# Swiss_BLASTP
blastp -query PHaeL.protein.fa -db uniprot_sprot.pep  -num_threads 8 -num_alignments 1 -outfmt '"6 qseqid sseqid pident length mismatch gapopen qstart qend sstart send evalue bitscore stitle"' -out swiss_prot.out
perl 0.choose_blast_m8.pl -i swiss_prot.out -o swiss_blast_prot.out
# Swiss_BLASTN
blastx -query PHaeL.protein.fa -db uniprot_sprot.pep  -num_threads 8 -num_alignments 1 -outfmt '"6 qseqid sseqid pident length mismatch gapopen qstart qend sstart send evalue bitscore stitle"' -out swiss_nucl.out
perl 0.choose_blast_m8.pl -i swiss_nucl.out -o swiss_blast_nucl.out
# NCBI_blastp
blastx -query PHaeL.protein.fa -db Animals_Metazoa_NR -evalue 1e-5 -word_size 4 -threshold 10 -num_alignments 1 -num_threads 8 -outfmt '"6 qseqid sseqid pident length mismatch gapopen qstart qend sstart send evalue bitscore stitle"' -out ncbi_prot.out
perl 0.choose_blast_m8.pl -i ncbi_prot.out ncbi_blast_prot.out
# NCBI_BLASTN
blastn -query PHaeL.protein.fa -db Animals_Metazoa_NT -evalue 1e-5 -num_alignments 1 -num_threads 8 -outfmt '"6 qseqid sseqid pident length mismatch gapopen qstart qend sstart send evalue bitscore stitle"'   -out ncbi_nucl.out
perl 0.choose_blast_m8.pl -i ncbi_nucl.out ncbi_blast_nucl.out
# hmmscan
hmmscan --cpu 8 --noali --domtblout TrinotatePFAM.out -o pfam.log Pfam-A.hmm PHaeL.protein.fa
# trinotate
gunzip -c Trinotate-3.0.2.sqlite.gz >Trinotate.sqlite
perl get_Trinity_gene_to_trans_map.pl PHaeL.filter.longest.cds.fa > Trinity.fasta.gene_trans_map
Trinotate Trinotate.sqlite init --gene_trans_map Trinity.fasta.gene_trans_map --transcript_fasta PHaeL.filter.longest.cds.fa --transdecoder_pep PHaeL.protein.fa
Trinotate Trinotate.sqlite LOAD_swissprot_blastp swiss_blast_prot.out
Trinotate Trinotate.sqlite LOAD_swissprot_blastx swiss_blast_nucl.out
Trinotate Trinotate.sqlite LOAD_custom_blast --outfmt6 ncbi_blast_nucl.out --prog blastx --dbtype NT
Trinotate Trinotate.sqlite LOAD_custom_blast --outfmt6 ncbi_blast_prot.out --prog blastx --dbtype NR
Trinotate Trinotate.sqlite LOAD_pfam TrinotatePFAM.out
Trinotate Trinotate.sqlite report > Trinotate.xls
