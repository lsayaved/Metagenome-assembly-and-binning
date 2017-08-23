#!/usr/bin/perl -w
#Script written by Lizbeth Sayavedra on the 23 Aug.2017
#This script is designed to get the scaffolded version of nodes produced by spades, binned with Bandage


use strict;
use Bio::DB::Fasta;

my $usage = "scriptname.pl paths_fileFromSpades  final_fastaFromSpades bandage.fasta output.fasta";

my $paths = shift or die $usage; ##paths file produced by Spades
my $fasta = shift or die $usage; ##finals scaffolds.fasta file produced by spades
my $bandage =shift or die $usage; ## bandage output when selecting "save selected nodes to fasta"
my $output =shift or die $usage; ## output will be the scaffolds that are linked to the nodes(with +) from bandage


my ($line, $node, @temp_array, $region, $host, %pop_node, %pop_num);
open (PATHS, $paths);
while ($line =<PATHS>){
	chomp $line;
	if ($line =~/(NODE\S+\.\S+)/){
			$node =$1; #the name of the genome needs to be shorted in the output file to 10
			$node =~ s/\'// ;
	}
	if ($line =~ /^\d+/){
			@temp_array = split /,|;|\+|\-/, $line; #consider: get rid of + and - sign
			#$pop_node {$node} =@temp_array; #keys are the scaffold name, array has the list of nodes with + and -
			push @{$pop_node {$node}}, @temp_array; #keys are scaffold name, push the number of the nodes
			#print "$node\n @{$pop_node {$node}}\n";#
	}		
	}
	
close (PATHS);

####


####put in an array all the ids from bandage (just the number of the node)
my %ids_ban; 
my $j=0;
open (FILE, $bandage);
while (<FILE>){
    chomp;
    if (/>NODE_(\S+)\+.*/){
    $ids_ban{$1}=1;
     }
}


#my $output = "OUT_BIN.txt"; my $result; 
open(MYFILE, ">$output") ||die "Sorry, I can not create the file";
#Get the name of the scaffolds that have the node number from bandage
my %bined_scaffs;
foreach my $scaff (keys (%pop_node)){ #goes over all the NODES from the original assembly
	#print MYFILE "$scaff" . "@{$pop_node{$scaff}}" . "\n";
	foreach my $rec (@{$pop_node{$scaff}}){ #nodes from the scaff
		if (exists $ids_ban{$rec}){  #if the id of bandage is in the list of the identifiers from bandage
			if( !(exists($bined_scaffs{$scaff} )) ){
			$scaff=~ s/_lengt\S+// ;
			$bined_scaffs{$scaff} =1;
			}
		}
	}
}

##print the binned scaffolds to a file
my @bin_scaffs = keys (%bined_scaffs);

my $id_reduced;
my $db = Bio::DB::Fasta->new("$fasta", -makeid=>\&make_my_id);
my @ids = $db->get_all_ids;
@ids=sort(@ids);
foreach my $rec (@ids){
    my $obj = $db->get_Seq_by_id($rec);
    my $id = make_my_id($obj);
    $id=~ s/_lengt\S+// ; #there is a "feature" from Spades that changes sometimes the length of the scaffold by one. This comes from the odd and even kmers
		#print "$id\n";
    if (grep { $_ eq $id } @bin_scaffs ){
        my $seq     = $obj->seq; # sequence string
        #print "$id \n$seq\n\n";
        print MYFILE ">". "$id\n$seq\n";
    }
}
 
close(MYFILE);

 
###Subrutines
 
 sub make_my_id {
    my $description_line = shift;
    $description_line =~ /(\S+.*)/;
    my $id=$1;
		$id =~ s/>// ;
    return $id;
  }
