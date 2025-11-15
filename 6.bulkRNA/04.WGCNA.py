#! /usr/bin/env python3

import omicverse as ov
ov.utils.ov_plot_set()
import pandas as pd
data=ov.utils.read_csv(filepath_or_buffer='fpkm.csv',index_col=0)
data.head()

gene_wgcna=ov.bulk.pyWGCNA(data,save_path='/public/home/rp1016swf/rp1016swf/lyuqiang/wgcna/1/')
gene_wgcna.calculate_correlation_direct(method='pearson',save=False)

gene_wgcna.calculate_correlation_indirect(save=False)
gene_wgcna.calculate_soft_threshold(save=False)

gene_wgcna.calculate_corr_matrix()

gene_wgcna.calculate_distance()
gene_wgcna.calculate_geneTree()
gene_wgcna.calculate_dynamicMods()
module=gene_wgcna.calculate_gene_module()

#module.head()
output_path = 'module.csv' 
module.to_csv(output_path, index=True) 

gene_wgcna.plot_matrix()

meta=ov.utils.read_csv(filepath_or_buffer='/public/home/rp1016swf/rp1016swf/lyuqiang/wgcna/1/TAU大于等于0.5性状.csv',index_col=0)
meta.head()
cor_matrix=gene_wgcna.analysis_meta_correlation(meta)
new_file = open("/public/home/rp1016swf/rp1016swf/lyuqiang/wgcna/1/cor.txt", "w")
print(cor_matrix, file=new_file)
new_file.close()