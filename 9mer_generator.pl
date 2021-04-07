#!/usr/bin/perl -w
# Reading protein sequence data from a fasta file and generating all possible peptides to search for overlapping T and B cell epitopes in IEDB files
#usage: 9mer_generator.pl <fastafile>

# The filename of the fasta file containing the protein sequence data
my $proteinfilename = $ARGV[0];

# First we have to "open" the file, and associate
# a "filehandle" with it.  We choose the filehandle
# PROTEINFILE for readability.

open(PROTEINFILE, $proteinfilename) or die("unable to open fasta file '$proteinfilename' $!");

my $string="";
while ($line = <PROTEINFILE>){
       chomp $line;
       if ($line =~ /^>/) {
next;
       }
       else {
         #$string = join('', map { chomp; $_ } <PROTEINFILE>);
         $string = $string . "".  $line;
}
}
#print "$string\n";

my $len=length($string);

for(my $i=0; $i<=$len-9; $i++)
{
my $peptide=substr($string,$i,9);
print "$peptide\n";
}

close PROTEINFILE;
exit;
