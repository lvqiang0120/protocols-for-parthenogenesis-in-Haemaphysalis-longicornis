##Analysis of synteny##
gff1=PHaeL_genome.gff
cds1=PHaeL_cds.fa

gff2=BFHaeL_genome.gff
cds2=BHaeL_cds.fa

python -m jcvi.formats.gff bed --type=mRNA --key=Parent $gff1 -o PHaeL.bed
python -m jcvi.formats.gff bed --type=mRNA --key=Parent $gff2 -o BHaeL_F.bed
python -m jcvi.compara.catalog ortholog PHaeL BHaeL_F
python -m jcvi.graphics.dotplot PHaeL.BHaeL_F.anchors
#build *.anchors  
python -m jcvi.compara.synteny depth --histogram PHaeL.BHaeL_F.anchors
python -m jcvi.compara.synteny screen --minspan=30 --simple PHaeL.BHaeL_F.anchors PHaeL.BHaeL_F.anchors.new
python -m jcvi.graphics.karyotype seqids layout






