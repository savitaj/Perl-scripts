#This program will parse the header lines of fasta files given the path to folder containing the fasta files and outputs the results in a tabular format

die "Usage: $0: < path-to-fasta-file> and <output-file-name>\n" if (@ARGV != 2);
open (SCREEN, ">/dev/tty");

if (-f $ARGV[1])
{
  print SCREEN "$ARGV[1] already exists, would you like to overwrite it?\n";
  print SCREEN "Please ender Y for yes or N for no!\n";
  
  $ans = <STDIN>;
  if (@ans =~/[Nn]/) {exit 1;}
}
 
if (! -f[$ARGV[1] || $ans =~ /[Yy]/
{
  open(DATA, ">$ARGV[1]") || die "Cannot open file for output\n";
}
 
$output = $ARGV[1]. "_sequence_files";
 
print SCREEN "Finding header sequence files...please wait\n";
system ("find $ARGV[0] -name sequences -print > $output");
 
open (AA, "<$output") || die "Cannot open header_sequence_files\n";

@aa_files =<AA>;
close (AA);

print DATA "PROTEIN_ID\tGENEATLAS_NAME\tGENE_ID\tCIP_NUM\n";
$count =1;
$CIP_num ="";
foreach $aa_file (@aa_files)
{
  chomp $aa_file;
  if ($aa_file =~ m".*/Report/cgi-bin/sequences")
  {
   open (A, "<$aa_file") || die "Cannot open $aa_file\n";
  }
  else
  {
    next;
  }
  
  while (<A>)
  {
    if (/^>dlist/ || /^>CNUM/)
    {
      #print SCREEN "$_\n";
      ($GeneAtlas_id, $gene_name) = (split (/\s+/, $_))[0,1];
      $c_num = (split(/_/, $gene_name))[2];
      $c_num =~ s/C//i;
      $GeneAtlas_id =~ s/^>(.*)/$1/;
      
      print SCREEN "Processing file $GeneAtlas_id\n";
      
      print DATA "$count\t$GeneAtlas_id\t$c_num\n";
      
      $count++;
     }
     if (/^>ptf/)
     {
        @gene_arr = split;
        $gene_id = pop (@gene_arr);
        $GeneAtlas_id = $gene_arr[0];
        $CIP_num =$gene_arr[1] if ($gene_arr[1]);
        $GeneAtlas_id =~s/^>(.*)/$1/;
        
        print SCREEN "Processing file $GeneAtlas_id\n";
        
        print DATA "$count\tGeneAtlas_id\tgene_id\tCIP_num\n";
        count++;
      }
    }
  }
  close(A);
