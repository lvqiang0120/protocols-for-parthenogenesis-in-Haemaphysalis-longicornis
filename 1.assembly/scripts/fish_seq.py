#!/annoroad/share/software/install/Python-3.3.2/bin/python3
#-*-coding:utf8-*-

import sys
import gzip

if len(sys.argv)<4:
	print ("\tpython fish_seq.py <idlist> <fasta> <out file>\n")
	sys.exit()

class Fish():
	def __init__(self,idlist,fasta,output):
		self.idlist=idlist
		self.fasta=fasta
		self.output=output
	def _readlist(self):
		file=self.idlist
		ids=[]
		with open(file,'r') as con:
			for line in con:
				if line.startswith('#'):continue
				lines=line.strip().split('\t')
				ids.append(lines[0])
		idset=set(ids)
		return idset
	def _readfa(self):
		fa=self.fasta
		fahash={}
		
	def main(self):
		out=open(self.output,'w')
		idall=self._readlist()
		sig=0
		if self.fasta.endswith("gz"):
			FA=gzip.open(self.fasta,'rt') 
		else:
			FA = open(self.fasta,'r')
		with FA as con:
			for line in con:
				if len(idall)<0:
					sys.exit()
				else:
					if line[0]==">":
						id=line[1:]
						ida=id.strip().split()[0]
						if ida in idall:
							sig=1
							out.write(line)
							idall.remove(ida)
						else:
							sig=0
					else:
						if sig==1:
							out.write(line)
					
		out.close()
if __name__=="__main__":
	Step=Fish(sys.argv[1],sys.argv[2],sys.argv[3])
	Step.main()		
