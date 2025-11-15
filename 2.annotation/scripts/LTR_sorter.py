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

bindir = os.path.abspath(os.path.dirname(__file__))

__author__ = 'lixiaobo'
__mail__ = 'xiaoboli@genome.cn'
__doc__ = '''
**************************************************************
'''

pat1=re.compile('^\s*$')

def main():
	parser=argparse.ArgumentParser(description=__doc__,
			formatter_class=argparse.RawDescriptionHelpFormatter,
			epilog='author:\t{0}\nmail:\t{1}'.format(__author__,__mail__))
	parser.add_argument('-i','--input',help='input file',dest='input',required=True)
	parser.add_argument('-o','--output',help='output file',dest='output',required=True)
	args=parser.parse_args()
	out = open(args.output,'w')
	with open (args.input,'r') as fp:
		for line in fp:
			lines = line.strip()
			if lines.startswith('>'):
				id = lines[1:].split(' ')
				if len(id) > 1:
					if "unknown" in id[1] and "Unknown" not in id[0]:
						new_id = ">" + id[0] + "\n"
					else:
						new_id = ">" + id[1] + "\n"
				else:
					new_id = ">" + id[0] + "\n"
				out.write(new_id)
			else:
				out.write(line)
	out.close()

if __name__ == '__main__':
	main()
