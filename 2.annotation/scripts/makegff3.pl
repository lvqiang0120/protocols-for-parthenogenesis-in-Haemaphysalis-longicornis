#!/usr/bin/perl -w 
use strict;
use File::Basename;
&usage unless (@ARGV==2);
my $input=shift;
my $output=shift;
my @suffixlist=qw(.out .dat .annot);
my ($name,$path,$suffix)= fileparse($input,@suffixlist);
open (IN,"<$input") or die "can't open the file $input: $!\n";
open (OUT,">$output") or die "can't open the file $output: $!\n";
if($suffix=~/.out$/){
    while (<IN>){
        chomp;
        s/^(\s+)//;
        s/(\s+)$//;
        next if (/^\s*$/);
        next if (/^(\D+)/);
        my @line=split (/\s+/,$_);
        ### output the gff format ####
        if ($line[8]=~ /C/){
            print OUT "$line[4]\tRepeatMasker\t$line[10]\t$line[5]\t$line[6]\t$line[1]\t\-\t"."Alias=$line[10];".'Target "Motif:'."$line[9]".'"'." $line[13] $line[12]\n";	
        }   
        else{
	    print OUT "$line[4]\tRepeatMasker\t$line[10]\t$line[5]\t$line[6]\t$line[1]\t$line[8]\t"."Alias=$line[10];".'Target "Motif:'."$line[9]".'"'." $line[11] $line[12]\n";
        }  
    }
}
elsif ($suffix=~/.annot$/){
    while(<IN>){
        chomp;
        next if (/SeqID/);
        my @line=split (/\s+/,$_);
        print OUT "$line[3]\t$line[2]\t$line[8]\t$line[4]\t$line[5]\t$line[1]\t$line[6]\t\.\t".'Target "Motif:'.$line[7].'"'."$line[9] $line[10]\n";
    }
}
elsif($suffix=~/.dat$/){
    my $scaffold_id;
    while(<IN>){
        chomp;
        next if (/^\s*$/);
       # next if (/^\w+/);
        if ( /^Sequence: (\S+)/){
            $scaffold_id =$1;
        }
        elsif (/^\d+/) {    
            my @line =split /\s+/,$_;
            print OUT "$scaffold_id\tTrf\t\.\t$line[0]\t$line[1]\t$line[7]\t\+\t\.\t".'Note "Period size:'."$line[2]".'",'.'"Copy Number:'."$line[3]".'"'."\n";
        }
    }
}
close IN;
close OUT;

sub usage{
	my $program=`basename $0`;
	chomp $program;
	print "
Program : $program 
Version : 0.1.1 on 19,Dec,2016
Author  : fulaizhou\@annoroad.com
Usage   : $program <Input> <Output>
Exapmle : perl $program Ath.scaffold.fa.out Ath.scaffold.fa.out.gff3
        \n";
	exit;
}
