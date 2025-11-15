#!/usr/bin/bash

## software source
## PopLDdecay: https://github.com/BGI-shenzhen/PopLDdecay

### Steps
## calculate linkage disequilibrium (LD) decay by PopLDdecay

for i in PHaeL.list BFHaeL.list
do 
/PopLDdecay-3.42/bin/PopLDdecay -InVCF "$vcf_nam".vcf.gz -OutStat ${i} -SubPop ${i} --MaxDist 150
done

ls *.gz > multi.list
sed 's/.list.stat.gz//g' multi.list > temp
paste multi.list temp >temp2 
mv temp2 multi.list 
rm temp

/PopLDdecay-3.42/bin/Plot_MultiPop.pl -inList multi.list --output $vcf_nam -bin1 10 -bin2 200
