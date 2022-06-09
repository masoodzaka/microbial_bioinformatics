# Microbial Bioinformatics

[Introduction](#introduction)

[Software](#software)

[Usage](#usage)

[Updates](#updates)



## Introduction

This docker image is collection of some of the most popular software and tools currently being used in the analysis of raw NGS data, genome assembly and annotation of microbial genomes. All of the software are ready to use in the docker image that can be run on any machine (e.g. Mac, Linux and Windows) or on high performance cluster/computing platform via singularity. The docker app respository is available from the [docker hub](https://hub.docker.com/repository/docker/masoodzaka/microbial_bioinformatics).

## Software 

Here is the list of software available through this docker app. All of the sotware binaries are paresent in the /opt directory and soft linked to the /usr/bin for ready to use. Each of the sotware/tool standard use or manual can be accessed on providers webpages.

* Raw fastq quality check and manipulation tools 
  - [FastQC](https://www.bioinformatics.babraham.ac.uk/projects/fastqc/)
  - [MultiQC](https://multiqc.info/)
  - [Trimmomatic](http://www.usadellab.org/cms/?page=trimmomatic)
  - [Cutadapt](https://cutadapt.readthedocs.io/en/stable/index.html)
  - [Trim Galore](https://www.bioinformatics.babraham.ac.uk/projects/trim_galore/)
* NGS data manipulation tools
  - [Bcftools](https://samtools.github.io/bcftools/bcftools.html)
  - [Samtools](http://www.htslib.org/download/)
  - [Htslib](http://www.htslib.org/download/)
  - [Seqkit](https://bioinf.shenwei.me/seqkit/) 
* Fasta file alignment and fastq mapping tools
  - [Blast+](https://blast.ncbi.nlm.nih.gov/Blast.cgi?PAGE_TYPE=BlastDocs&DOC_TYPE=Download)
  - [ClustaW](https://vcru.wisc.edu/simonlab/bioinformatics/programs/clustal/clustalw.1.html)
  - [Mafft](https://mafft.cbrc.jp/alignment/software/)
  - [Diamond](https://github.com/bbuchfink/diamond/)
  - [Mummer](https://github.com/mummer4/mummer)
  - [Snp-dists](https://github.com/tseemann/snp-dists)
  - [Snp-sites](https://github.com/sanger-pathogens/snp-sites)
  - [FastTree](http://www.microbesonline.org/fasttree/FastTree)
  - [Bowtie2](http://bowtie-bio.sourceforge.net/bowtie2/index.shtml)
  - [BWA](http://bio-bwa.sourceforge.net/)
  - [Minimap2](https://lh3.github.io/minimap2/minimap2.html)
  - [Lofreq](https://csb5.github.io/lofreq/)
  - [Snippy](https://github.com/tseemann/snippy)
 * Genome assemblers 
    - [Kraken2](https://github.com/DerrickWood/kraken2)
    - [Spades](https://cab.spbu.ru/files/release3.15.4/manual.html)
    - [Unicycler](https://github.com/rrwick/Unicycler)
    - [MIRA](http://mira-assembler.sourceforge.net/docs/DefinitiveGuideToMIRA.html)
    - [Ariba](https://github.com/sanger-pathogens/ariba)
    - [Quast](https://sourceforge.net/projects/quast/)
    - [Megahit](https://github.com/voutcn/megahit)
    - [Garm-meta](http://garm-meta-assem.sourceforge.net/)
    - [Racon](https://github.com/lbcb-sci/racon)
    - [Shovill](https://github.com/tseemann/shovill)
    - [Scaffold builder](https://github.com/metageni/Scaffold_builder.git)
 * Genomes annotation tools
    - [Prokka](https://github.com/tseemann/prokka)
    - [Artemis](https://github.com/sanger-pathogens/Artemis)
    - [Eggnog-mapper](https://github.com/eggnogdb/eggnog-mapper)
    - [SnpEFF](http://pcingola.github.io/SnpEff/)
    - [Vcf-annotator](https://github.com/rpetit3/vcf-annotator)
 * Phylogenetic analysis tools
    - [Metaphlan](https://huttenhower.sph.harvard.edu/metaphlan/)
    - [PhyloFlash](https://github.com/HRGV/phyloFlash)
 * Visualisation and other genome manipulation tools
    - [Ribopicker](http://ribopicker.sourceforge.net/manual.html)
    - [Barrnap](https://github.com/tseemann/barrnap)
    - [Krona Tools](https://github.com/marbl/Krona)
    - [Abricate](https://github.com/tseemann/abricate)
    - [Breseq](https://github.com/barricklab/breseq)
    - [ClonalFrameML](https://github.com/xavierdidelot/ClonalFrameML)
 * NGS and genome download tools
    - [NCBI genome download](https://github.com/kblin/ncbi-genome-download)

## Usage 

### Login account details for sudo

----
User: `microgen`

Password: `bioinfo`

----
### For docker desktop (windows)

* Create a folder to map it to docker container on your window's drive
```
e.g. drive(d):/microgen
```
----
* Start the your contianer using following command from the latest version of docker app
```
docker run -d -v d:/microgen:/home/microgen \
--name microgen_container \
-it masoodzaka/microbial_bioinformatics:<tag>
```
* Connect to the running container using following command
```
docker exec -i -t microgen_container
```
* Stop the running container 
```
docker stop microgen_container
```
* Re-running the existing will have two steps
```
docker start microgen_container
docker attach microgen_container
```
### For docker (Ubuntu)

* Create a folder to map it to docker container using following command
```
sudo mkdir -p microgen
```
----
* Start the your contianer using following command from the latest version of docker app
```
sudo docker run -d -v ~/microgen:/home/microgen \
--name microgen_container \
-it masoodzaka/microbial_bioinformatics:<tag>
```
* Connect to the running container using following command
```
docker exec -i -t microgen_container
```

### For HPC or Clusters

For security reasons, docker is not directory accessible on HPC or Computer clusters environment such as SGE or Slurm on private, research lab or University network. However, we can use [Singularity](https://hpc.nih.gov/apps/singularity.html) such as this one from NIH as an ulternate for performing similar tasks. To learn more about singularity visit this documentation from [Sylabs](https://sylabs.io/guides/2.6/user-guide/singularity_and_docker.html). 

You can quick start singularity by pulling the docker image using following command. 
```
singularity pull docker://masoodzaka/microbial_bioinformatics
```

## Updates

Clone the main git repository using:
```bash
git clone https://github.com/masoodzaka/microbial_bioinformatics.git
```
and make a new folder with version tag:
```bash
cd microbial_bioinformatics
mkdir -p <tag>
cd <tag>
touch Dockerfile
```
Access the content of previous Dockerfile image using the "FROM" root container:
```bash
FROM masoodzaka/microbial_bioinformatics:latest
```
And build the latest docker image app using standard docker build command
```bash
docker build -t masoodzaka/microbial_bioinformatics:latest
```
Push the docker image 
```bash
docker image push masoodzaka/microbial_bioinformatics:latest
```

----
Please report or suggest on any changes on [git](https://github.com/masoodzaka/microbial_bioinformatics.git)
