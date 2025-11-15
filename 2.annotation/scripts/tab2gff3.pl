use strict;
use Getopt::Long;
use FindBin qw($Bin $Script);
use File::Basename qw(basename dirname);

my ($file,$pre_tag);
GetOptions(
				"i:s"=>\$file,
				"p:s"=>\$pre_tag);
my $usage=<<"USAGE";
	Program:perl $0 -i <rRNA_file> -p <prefix>
	Usage:perl $0 -i <rRNA_file> -p [options]
USAGE
die $usage unless ($file);

my $output="";
$pre_tag .= "_" if($pre_tag);
my $mark = "0001";
open IN,$file || die "fail $file";
while (<IN>) {
	my @t = split /\t/;
	my ($target_id,$rRNA_type) = ($1,$2) if($t[0] =~ /(\w+)\#([\w\.]+)/); 
	my $gene_id = $pre_tag.$rRNA_type."_".$mark;
	my $seq_id = $t[4];
	my $score = $t[13];
	my $strand = ($t[6] <= $t[7]) ? "+" : "-";
	my ($gene_start, $gene_end) = ($t[6] <= $t[7]) ? ($t[6],$t[7]) : ($t[7],$t[6]);
	#print "$gene_start\n";
	$output .= "$seq_id\tblastn\trRNA\t$gene_start\t$gene_end\t$score\t$strand\t.\tID=$gene_id;Target=$target_id $t[2] $t[3];Annotation=\"$t[14]\"\n";
	$mark++;
}
close IN;
#print "$output\n";
open OUT,">$file.gff" || die "fail creat $file";
print OUT "##gff-version 3\n$output";
close OUT;

