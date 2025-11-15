#! /usr/bin/env python3
#import getopt
import os
import sys
import pysam
#Bin = os.path.abspath(os.path.dirname(sys.argv[0]))

__author__='Yuan Zan'
__mail__= 'zanyuan@annoroad.com'

def usage():
    print (sys.argv[0] + 'bwt2pairs.bam out.bam')
    exit()

def main():
    if len(sys.argv) < 3:
        usage()    

    inBam = pysam.AlignmentFile(sys.argv[1], "rb")
    outBam = pysam.AlignmentFile(sys.argv[2], "wb", header=inBam.header)
    
    i = 0
    ii = 0
    sets = set()
    for r1 in inBam:
        r2 = inBam.__next__()
        chrom1 = inBam.getrname(r1.tid)        
        chrom2 = inBam.getrname(r2.tid)
        a = chrom1 + str(r1.pos) + chrom2 + str(r2.pos)

        if a not in sets:
            sets.add(a)
            outBam.write(r1)
            outBam.write(r2)
            ii += 1
        else:
            i += 1
    
    inBam.close()
    outBam.close()
    print ('outReadsPair:\t' + str(ii))
    print ('dupReadsPair:\t' + str(i))


if __name__ == '__main__':
    main()
