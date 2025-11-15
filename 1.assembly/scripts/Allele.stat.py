#! /usr/bin/env python3
# -*- coding:utf-8 -*
import re
import os
import argparse
import time
import datetime
import sqlite3
import getpass
import sys
import numpy as np
import pandas as pd

bindir = os.path.abspath(os.path.dirname(__file__))

__author__ = 'lixiaobo'
__mail__ = 'xiaoboli@genome.cn'

pat1=re.compile('^\s*$')

def apply_ctg(x,len_dict):
	#global len_dict
	return len_dict[x]

def main():
	parser=argparse.ArgumentParser(description=__doc__,
			formatter_class=argparse.RawDescriptionHelpFormatter,
			epilog='author:\t{0}\nmail:\t{1}'.format(__author__,__mail__))
	parser.add_argument('-i','--input',help='input file',dest='input')
	parser.add_argument('-l','--length',help='length file',dest='length')
	args=parser.parse_args()

	len_dict = {}
	with open(args.length,'r') as fp:
		for line in fp:
			lines = line.strip().split("\t")
			len_dict[lines[0]] = int(lines[1])

	df = pd.read_csv(args.input,sep="\t",header=None,index_col=None,names=["chr","pos","ctg1","ctg2","ctg3"])
	print ("原始ctg数目统计：\n",df.loc[:,'ctg1':'ctg3'].count(axis=0))
	print ("*************************************************************")

	df2 = df.dropna(axis=0)
	#df3 = df2.copy(deep = True)
	#df3 = df2.iloc[:2:]
	df3 = df2.loc[:,'ctg1':'ctg3']
	print ("3套ctg数目统计：\n",df3.count(axis=0))
	print ("*************************************************************")
	#df4 = df3.applymap(lambda x:len_dict[x]) # 整体替换，但是不太好去冗余
	## 方式1
	for i in df2.columns[2:]:
		df3[i] = df2[i].apply(apply_ctg,args=(len_dict,))
		print("去冗余之后，{0}的大小为：{1:,}".format(i,df3.drop_duplicates([i]).apply(np.sum)[i])) ## 按照数字去冗余，值会比实际值偏小
	#print (df3.apply(np.sum, axis=0))
	'''
	## 方式2（比方式1准确，效率稍低）
	df4 = df2.loc[:,'ctg1':'ctg4']
	sum_all = 0
	for i in df2.columns[2:]:
		sum = 0
		arry_tmp = df2[i].unique()
		for j in range(len(arry_tmp)):
			sum += len_dict[arry_tmp[j]]
		sum_all += sum
		print("去冗余之后，{0}的大小为：{1:,}".format(i,sum))
	print("未去冗余的所有ctg大小和为：{0:,}".format(sum_all)) 
	'''
	print ("*************************************************************")
	Ser = pd.concat([df3['ctg1'],df3['ctg2'],df3['ctg3']])
	print("去冗余之后，所有ctg大小和为：{0:,}".format(Ser.drop_duplicates().sum()))
	df.drop('pos',axis=1, inplace=True)
	print("各条染色体的不同等位基因的个数统计如下：\n")
	print("染色体\t1Allele\t2Allele\t3Allele\n")
	df2 = df.groupby(by=['chr']).count()
	#df2.astype({'ctg1':'Int64','ctg2':'Int64','ctg3':'Int64'})
	df2['ctg1'] = df2['ctg1'] - df2['ctg2']
	print (df2)
	#print(df.groupby(by=['chr']).count())


if __name__ == '__main__':
	main()
