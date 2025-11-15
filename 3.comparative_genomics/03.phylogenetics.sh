#run orthofinder#
orthofinder -f ./15_spec/ -t 40 -a 40 -S diamond -T fasttree -M msa

#run mcmctree#
## Prepare the .ctl file for mcmctree manually
# seqfile = the alignment file used in last step (orthofinder)
# treefile = modify the tree, add fossil divergence time for calibration
# IMPORTANT: rgene_gamma = 1 / (subsititution_rate)

## First run, use parameter 'usedata = 3' to generate 'out.BV'
mcmctree mcmctree.usedata3.ctl 1>log.first 2>&1

## rename
cp out.BV in.BV

## Second run, use parameter 'usedata = 2'
mcmctree mcmctree.usedata2.ctl 1>log.second 2>&1

#run Cafe#
awk -v OFS="\t" '{$NF=null;print $1,$0}' Orthogroups.GeneCount.tsv |sed -E -e 's/Orthogroup/desc/'  > gene_families.txt
awk 'NR==1 || $3<100 && $4<100 && $5<100 && $6<100 && $7<100 && $8<100 && $9<100 && $10<100  && $11<100 && $12<100 && $13<100 && $14<100 && $15<100 && $16<100 && $17<100  && $18<100  {print $0}' gene_families.txt > gene_families_filter.txt
cafe5 -i gene_families_filter.txt -t SpeciesTree_rooted.txt -p -k 3 -o k3p > cafe3.log 2>&1 &



