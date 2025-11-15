#!/usr/bin/evn python3
######################################################################### import ##########################################################
import argparse
import os
import sys
import re
import pandas as pd
######################################################################### ___  ##########################################################
__author__ = 'xuemeizhang'
__mail__ = 'xuemeizhang02@genome.cn'
__date__ = '2021年03月01日 星期一 15时47分29秒'
__version__ = '1.0'
######################################################################### main  ##########################################################
def read(infile,output):
	out=open(output,'w')
	with open(infile,'r') as inf:
		for line in inf:
			if line.startswith('>'):
				ID = line.strip('\n')
				newID=ID.split('#')
				id1=newID[0]
				id2=newID[1].split('__')[1]
				if id2.startswith('unknown'):
					print(id1,"#","Unknown",file=out,sep='')
				elif id2.startswith('ClassII'):
					newline=id2.split('_')
					if len(newline)>=3:
						family='/'.join(["DNA",newline[2]])
						print(id1,"#",family,file=out,sep='')
					elif len(newline)==2:
						family='/'.join(["DNA",newline[1]])
						print(id1,"#",family,file=out,sep='')
					else:
						print(id1,"#","DNA",file=out,sep='')
				else:
					newline2=id2.split('_')
					if len(newline2)==3:
						family2='/'.join([newline2[1],newline2[2]])
						print(id1,"#",family2,file=out,sep='')
					elif len(newline2)==4:
						family2='/'.join([newline2[2],newline2[3]])
						print(id1,"#",family2,file=out,sep='')
					else:
						print(id1,"#",'RNA',file=out,sep='')
			else:
				line=line.strip('\n')
				print (line,file=out)

def main():
	function="this program is used to "
	parser=argparse.ArgumentParser(description=__doc__,
		formatter_class=argparse.RawDescriptionHelpFormatter,
		epilog='author:\t{0}\nmail:\t{1}\ndate:\t{2}\nversion:\t{3}\nfunction:\t{4}'.format(__author__,__mail__,__date__,__version__,function))
	parser.add_argument('-i',help='input file',type=str,required=True)
	parser.add_argument('-o',help='out file',type=str,required=True)
	args=parser.parse_args()
	read(args.i,args.o)
if __name__=="__main__":
	main()
