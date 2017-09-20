#!/usr/bin/perl -w
use Data::Dumper;

# UnComment both to have DataDumper output Hash as Key:Value
# $Data::Dumper::Useqq= 1;
# $Data::Dumper::Pair = " : ";

# uncomment and add appropriate values for input file
# my $f = "Galaxy101-\[29_S40_L001_R1_001.fastq\].fastqsanger.txt";
# open (my $fh, "<", $f) or die "cannot open file $!\n";

# most often-used input loop while
# loops over each line, removes newline, then adds to array
# modify as needed

my @a;
# while (<$fh>) {
#       chomp;
#       push @a, $_;
# }

# credit user Ron on [SO](https://stackoverflow.com/questions/3138649/programmatically-read-from-stdin-or-input-file-in-perl)
# redirect from STDIN with 
# ./parseFile.pl < someFile.txt

# NOTE: if using bsub you MUST use the -i option for the input file with perl from STDIN
# bsub -J "something" -o perloutput.txt -i inputForThisScript

foreach my $line ( <STDIN> ) {
        chomp( $line );
        push @a, $line;
}

# problem, perl regex does not regognize triplets, i.e. 'GTA' can match 'GNN'
# sort of fix: make the string long enough to filter out shorter matches
# then match triplets in second array
my $sEntry = 'AC';
my $regex = 'ACACACACACAC[AC]{2,}';
my @b;
foreach my $i (@a) {
        if ($i =~ m/($regex)/) {
                push @b, $1;
        }
}
my @resultArray;
foreach my $v (@b) {
        # my @bArray = split(/(.{3})/, $v);
        my @bArray = split(/(.{2})/, $v);
        my $bString = "";
        foreach my $bItem (@bArray) {
                if ($bItem eq $sEntry) {
                        $bString .= $bItem;
                }
        }
        my $l = length $bString;
        $l = $l/2;
        print "$bString,$l\n";
}
