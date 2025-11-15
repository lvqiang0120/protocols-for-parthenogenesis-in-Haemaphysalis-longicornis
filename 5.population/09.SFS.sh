#!/usr/bin/bash

## software source
## easySFS: https://github.com/isaacovercast/easySFS

##Manually prepare the pop_file.txt file containing sample IDs and grouping information

easySFS.py -i $vcf_dir/$vcf_nam -p $pop --preview -a  > $our_dir/"$out_name".proj_fla

easySFS.py -i $vcf_dir/$vcf_nam -p $pop --proj=66,110 -a -o $our_dir/"$out_name".proj66.110

