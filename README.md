# Metagenome-assembly-and-binning
Current workflows in the symbiosis department

Step 1:
I have a bunch of reads, now what?
Metagenome sequencing reads
-Check your reads with FastQC
-Check what organisms are there: PhyloFlash for 16S rRNA and COI
-Quality trim your reads. We often use a quality of 2 since the reads get a higher quality after error correction (Bbduk). Remove PhiX, TruSeq adaptors.
-If your paired-end reads overlap, try merging the reads (Bbmerge).
-HGV tip: Check the K-mer spectrum. 
-Assemble your reads (e.g. Megahit, MetaSPades, IDBA_UD)
	Megahit: Fast, but produces highly fragmented assemblies
	MetaSpades: Crashes often with more than one library. Slow
	IDBA_UD: Produces food N50, and has a good running time. The output does not include an assembly graph.
 

Step 2:
Assembly
Before proceeding think about the following:
-Does it make sense to pool the reads of different libraries together?
If yes, do you have access to a computer that can deal with all the data?
-If you only have the sequencing of one sample, then assemble the one library. If your assembly is completely crappy, consider sequencing more samples. 
-Kmer 127: for reads >150 bp and coverage >5X 
-Brandon's script combines scaffold with graph


Step 3: 
Binning
-Differential coverage and GC% (e.g. GBTools)
-Taxonomy (Blobology, Phylamaphora)
-Check RNA (e.g. Barrnap)
-Linkage analysis (e.g. Bandage or Albertsen protocol)

Check quality control of the assembled genomes (See step 5)

Step 4:
Reassembly
Often improves assembly metrics, but you should try it yourself. 
-More work and not scalable to many data sets.

Step 5:
Quality control of assembly
-CheckM (Prokaryotes)
-BUSCO (Eukaryotes)
-Quast
Optional:
-Phylogenomic placement
-ANI (e.g. Jspecies, or Kostas website)


