##Identification of the IAPs family genes##
##Any other family genes can also be used
pep=Ixodida.spec5_Dro.Mela.Human.pep.fa
out_prefix=tick9.WZ2.Dmel.Human.dsDNA_bind
hmm_nam=PF00653
hmmsearch --cpu 4 --cut_ga --domtblout "$out_prefix".hmm.out "$hmm_nam".hmm $pep.fa

grep -v '#' "$out_prefix".hmm.out | awk '{print $1}' | sort -u > "$out_prefix".famly.ID
seqkit grep -f "$out_prefix".famly.ID $pep.fa > "$out_prefix".famly.pep.fa
mafft --thread $thread  --auto "$out_prefix".famly.pep.fa  > "$out_prefix".famly.pep.mafft.fa
FastTree "$out_prefix".famly.pep.mafft.fa > "$out_prefix".famly.fasttree.tree

	
