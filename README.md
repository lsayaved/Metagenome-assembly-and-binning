# Metagenome-assembly-and-binning

Current workflows in the symbiosis department

## Step 1 -- I have a bunch of reads, now what?

Metagenome sequencing reads

- Check your reads with [FastQC](http://www.bioinformatics.babraham.ac.uk/projects/fastqc/)
- Check what organisms are there: [PhyloFlash](https://github.com/HRGV/phyloFlash) for 16S rRNA and COI
- Quality trim your reads. We often use a quality of 2 since the reads get a higher quality after error correction ([Bbduk](https://sourceforge.net/projects/bbmap/)). Remove PhiX, TruSeq adaptors.
- If your paired-end reads overlap, try merging the reads ([Bbmerge](https://sourceforge.net/projects/bbmap/)).
- HGV tip: Check the K-mer spectrum. 
- Assemble your reads (e.g. Megahit, MetaSPades, IDBA_UD)
  - [Megahit](https://github.com/voutcn/megahit): Fast, but produces highly fragmented assemblies
  - [MetaSpades](http://bioinf.spbau.ru/en/spades): Crashes often with more than one library. Slow
  - [IDBA_UD](http://i.cs.hku.hk/~alse/hkubrg/projects/idba_ud/): Produces food N50, and has a good running time. The output does not include an assembly graph.
 

## Step 2 -- Assembly

Before proceeding think about the following:

- Does it make sense to pool the reads of different libraries together?

If yes, do you have access to a computer that can deal with all the data?

- If you only have the sequencing of one sample, then assemble the one library. If your assembly is completely crappy, consider sequencing more samples. 
- Kmer 127: for reads >150 bp and coverage >5X 
- Brandon's script combines scaffold with graph


## Step 3 -- Binning

- Differential coverage and GC% (e.g. [GBTools](https://github.com/kbseah/genome-bin-tools/))
- Taxonomy ([Blobology](https://github.com/blaxterlab/blobology), [Phyla-Amphora](http://wolbachia.biology.virginia.edu/WuLab/Software.html))
- Check RNA (e.g. [Barrnap](https://github.com/tseemann/barrnap))
- Linkage analysis (e.g. [Bandage](https://github.com/rrwick/Bandage) or [Albertsen protocol](https://github.com/MadsAlbertsen/multi-metagenome))

Check quality control of the assembled genomes (See step 5)

## Step 4 -- Reassembly

- Often improves assembly metrics, but you should try it yourself. 
- More work and not scalable to many data sets.

## Step 5 -- Quality control of assembly

- [CheckM](http://ecogenomics.github.io/CheckM/) (Prokaryotes)
- [BUSCO](http://busco.ezlab.org/) (Eukaryotes)
- [Quast](http://bioinf.spbau.ru/quast)

Optional:
- Phylogenomic placement
- ANI (e.g. [Jspecies](http://imedea.uib-csic.es/jspecies/), or [Kostas website](http://enve-omics.gatech.edu/))
