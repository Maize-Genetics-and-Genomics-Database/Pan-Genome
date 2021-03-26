# Pan-Genome
Pan-genome methods used by MaizeGDB for the pan-gene tab.


## Step 1: Create the blast database
Blast databases from the primary CDS transcripts of each maize genome is generated using the script `blastdb.sh`.


## Step 2: Run pairwise blastn
Blastn between the CDS primary transcript fasta files of each genome to the CDS blast databases of every other genome. This includes self-blasts for downstream tandem duplication analyses (see "Generate the tandem duplicate information" below). The blasts are run using the script `nonredundant_pangenome_blast_includes_selfs.sh`. If you have SLURM or other manager, this job can be parallelized.


## Step 3: Process the pairwise blast results for DagChainer inputs
The script `format_for_dagchainer.sh` formats the blast results for DagChainer, which expects a specific scheme. Since the CDS fasta files do not contain genomic coordinate information, these are added in this step. They could also be added to the fasta headers prior to the blastn step.


## Step 4: Run DagChainer on each pairwise blastn result
The script `dagchainer.sh` filters and then runs DagChainer on each pairwise, formatted blastn result.


## Step 5: Run MCL
Note that determining inflation size (I) for MCL is probably one of the most important parameters to tune. Here is a resource on inflation and other params in large eukaryotic pangenomes: https://bmcbioinformatics.biomedcentral.com/articles/10.1186/s12859-018-2362-4

An inflation size of 2.0 is about standard according to literature:

microbe cluster size: https://aem.asm.org/content/79/24/7696
brassica cluster size: https://www.nature.com/articles/s41477-019-0577-7
soybean cluster size: https://www.sciencedirect.com/science/article/pii/S0092867420306188

#### a) Concatentate all the pairwise dagchainer outputs into one file containing only the query and subject CDS gene model IDs:

```
$ cat *aligncoords | awk -v OFS="\t" '$1!~/^#/ {print $2, $6}' > dagchainer_outputs.tsv
```

#### b) Run MCL

```
$ mcl dagchainer_outputs.tsv -I 2.0 -te 20 --abc -o  dagchainer_outputs_mcl_I2.0_clst.tsv
```


## Generate the tandem duplicate information

#### a) Prepare the self-self blastn outputs for MCL
The script `make_tandem_for_mcl.sh` prepares the self-self blastn outputs for MCL.

#### b) Concatenate the tandem duplication files

```
$ cat *3Mb_tandem_window.txt | awk -v OFS="\t" '$1!~/^#/ {print $2, $6}' > tandems.tsv
```

#### c) Run MCL
```
$ mcl tandems.tsv -I 2.0 -te 20 --abc -o  tandems_mcl_I2.0_clst.tsv
```
