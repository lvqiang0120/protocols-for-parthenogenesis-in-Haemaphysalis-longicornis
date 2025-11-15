# geta
cat arthropoda_odb10/refseq_db.faa homodata/*/*.pep.filter.fa >allhomo.longest.pep.filter.fa
source geta_env.sh && cd ./Geta && perl geta.pl --RM_species Embryophyta -pe1 clean_Carcass_1_1P.fq.gz,clean_Glands_1_1P.fq.gz,clean_Lymph_2_1_1P.fq.gz,clean_Ovum_2_1_1P.fq.gz,clean_Midgut_1_1P.fq.gz -pe2 clean_Carcass_1_2P.fq.gz,clean_Glands_1_2P.fq.gz,clean_Lymph_2_1_2P.fq.gz,clean_Ovum_2_1_2P.fq.gz,clean_Midgut_1_2P.fq.gz --protein allhomo.longest.pep.filter.fa --augustus_species Haemaphysalis_longicornis --out_prefix PHaeL  --cpu 48 --HMM_db Pfam-A.hmm --config conf.txt PHaeL.genome.masked.fa

perl agat_convert_sp_gxf2gxf.pl --gff PHaeL.GeneModels.gff3 -o PHaeL.GeneModels.format.gff3
