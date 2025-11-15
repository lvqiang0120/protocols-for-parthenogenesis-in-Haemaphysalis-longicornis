#!/usr/bin/bash

### software source
## consense:  https://github.com/edgardomortiz/vcf2phylip/archive/v2.0.zip

### Steps
## generate consense input.phy
vcf2phylip.py -i "$vcfname".vcf.gz

## generate final tree

iqtree -s "$fa_nam".phy --seqtype DNA --prefix "$fa_nam".iqtree -T AUTO -ntmax 20 -m GTR+I+G -bb 1000  -t PARS 

