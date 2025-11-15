##Analysis of SVs ##
source activate syri

ref=BFHaeL.Chr.fasta
qry=PHaeL.Chr.fasta
prefix=BFHaeL.PHaeL
#Whole genome alignment.Any other alignment can also be used
nucmer --maxmatch -c 100 -b 500 -l 50 -p $out_dir/$prefix $ref $qry -t 40 
delta-filter -l 100 -i 90 -m $out_dir/"$prefix".delta > $out_dir/"$prefix"f.delta # Remove small and lower quality alignments
show-coords -THlrd  $out_dir/"$prefix"f.delta > $out_dir/coord.txt
syri -c $out_dir/coord.txt -d $out_dir/"$prefix"f.delta -r $ref -q $qry






