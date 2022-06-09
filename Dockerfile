## Collection of microbial genome analysis tools

## Ubuntu 20.04 (focal)
## OS/ARCH: linux/amd64

ARG ROOT_CONTAINER=ubuntu:20.04@sha256:47f14534bda344d9fe6ffd6effb95eefe579f4be0d508b7445cf77f61a0e5724

ARG BASE_CONTAINER=$ROOT_CONTAINER
FROM $BASE_CONTAINER

LABEL description="Dockerfile for collection of microbial genome analysis tools" \
maintainer="Masood Zaka<masood6985@gmail.com>"
ARG NB_USER="microgen"
ARG NB_UID="1000"
ARG NB_GID="100"

SHELL ["/bin/bash", "-o", "pipefail", "-c"]

USER root

ENV DEBIAN_FRONTEND=noninteractive

## Install all OS dependencies

RUN apt-get update && apt-get -yq dist-upgrade \
&& apt-get install --fix-missing -yq build-essential \
xorg-dev \
apt-utils \
wget \
bzip2 \
sudo \
ca-certificates \
locales \
git \
nano \
vim \
jed \
emacs \
python-dev \
unzip \
libsm6 \
pandoc \
texlive-full \
libxrender1 \
inkscape \
pkg-config \
libxml2-dev \
libcurl4-gnutls-dev \
libatlas3-base \
libopenblas-base \
libfreetype6-dev \
pigz \
zlib1g-dev \
autoconf \
automake \
libtool \
libexpat1-dev \
libxml2-dev \
libxslt1-dev \
ghostscript \
environment-modules \
gcc \
f2c \
gfortran \
libpcre3 \
libpcre3-dev \
libssl-dev \
libsqlite3-dev \
python-dev \
zlib1g-dev \
curl \
libbz2-dev \
emboss \
bioperl \
libjson-perl \
libtext-csv-perl \
libfile-slurp-perl \
liblwp-protocol-https-perl \
libwww-perl \
roary \
python3 \
python3-distutils \
libdatetime-perl \
libxml-simple-perl \
libdigest-md5-perl \
default-jre \
&& apt-get clean \
&& rm -rf /var/lib/apt/lists/*

RUN echo "en_US.UTF-8 UTF-8" > /etc/locale.gen && \
locale-gen
ENV LC_ALL en_US.UTF-8
ENV LANG en_US.UTF-8
ENV LANGUAGE en_US.UTF-8

RUN useradd -m -s /bin/bash -N -u $NB_UID $NB_USER ; \
echo "root:bioinfo" | chpasswd ; \
echo "microgen:bioinfo" | chpasswd ; \
adduser microgen sudo



## Bioinformatics tools starts here..!

## Quality check tools

## FastQC
RUN cd /opt && wget https://www.bioinformatics.babraham.ac.uk/projects/fastqc/fastqc_v0.11.9.zip -P /opt \
&& unzip fastqc_v0.11.9.zip \
&& chmod 755 FastQC/fastqc \
&& ln -s /opt/FastQC/fastqc /usr/bin

## Multiqc
RUN cd /opt && apt-get update && apt-get install -y software-properties-common \
&& add-apt-repository ppa:deadsnakes/ppa \
&& apt-get install -y python3.9 \
&& wget https://bootstrap.pypa.io/get-pip.py \
## RUN python3.9 get-pip.py (doesn't work)
&& apt-get install -y python3-pip \
&& pip3 install cython \
&& pip3 install multiqc

## Trimmomatic
RUN cd /opt && wget http://www.usadellab.org/cms/uploads/supplementary/Trimmomatic/Trimmomatic-0.39.zip \
&& unzip Trimmomatic-0.39.zip
ENV TRIMMOMATIC /opt/Trimmomatic-0.39/trimmomatic-0.39.jar

## Cutadapt
RUN cd /opt && pip3 install --user --upgrade cutadapt \
&& ln -s ~/.local/bin/cutadapt /usr/bin

## Trime Galore
RUN cd /opt && curl -fsSL https://github.com/FelixKrueger/TrimGalore/archive/0.6.6.tar.gz -o trim_galore.tar.gz \
&& tar xvzf trim_galore.tar.gz \
&& ln -s /opt/TrimGalore-0.6.6/trim_galore /usr/bin

## Htslib
RUN cd /opt && wget https://github.com/samtools/htslib/releases/download/1.15.1/htslib-1.15.1.tar.bz2 \
&& tar -xvjf htslib-1.15.1.tar.bz2 \
&& cd htslib-1.15.1 \
&& make \
&& ln -s /opt/htslib-1.15.1 /usr/bin/htslib-1.15.1

## Samtools
RUN cd /opt && wget https://github.com/samtools/samtools/releases/download/1.15.1/samtools-1.15.1.tar.bz2 \
&& tar -xvjf samtools-1.15.1.tar.bz2 \
&& cd samtools-1.15.1 \
&& make \
&& ln -s /opt/samtools-1.15.1/samtools /usr/bin/samtools-1.15.1

## Bcftools
RUN cd /opt && wget https://github.com/samtools/bcftools/releases/download/1.15.1/bcftools-1.15.1.tar.bz2 \
&& tar -xvjf bcftools-1.15.1.tar.bz2 \
&& cd bcftools-1.15.1 \
&& make \
&& ln -s /opt/bcftools-1.15.1/bcftools /usr/bin/bcftools

## Genome alignement tools

## Blast+
RUN cd /opt && wget https://ftp.ncbi.nlm.nih.gov/blast/executables/blast+/LATEST/ncbi-blast-2.13.0+-x64-arm-linux.tar.gz \
&& tar -xzvf ncbi-blast-2.13.0+-x64-arm-linux.tar.gz \
&& ln -nsf /opt/ncbi-blast-2.13.0+/bin/* /usr/bin

## ClustalW
RUN cd /opt && wget --no-check-certificate https://ftp.ebi.ac.uk/pub/software/clustalw2/2.0.12/clustalw-2.0.12-linux-i686-libcppstatic.tar.gz \
&& tar -zxvf clustalw-2.0.12-linux-i686-libcppstatic.tar.gz \
&& ln -s /opt/clustalw-2.0.12-linux-i686-libcppstatic/clustalw2 /usr/bin

## Mafft
RUN cd /opt && wget https://mafft.cbrc.jp/alignment/software/mafft-7.490-with-extensions-src.tgz \
&& tar -xzvf mafft-7.490-with-extensions-src.tgz \
&& cd mafft-7.490-with-extensions/core \
&& make \
&& make install

## Diamond
RUN cd /opt && wget http://github.com/bbuchfink/diamond/releases/download/v0.9.24/diamond-linux64.tar.gz \
&& tar xzf diamond-linux64.tar.gz \
&& ln -s /opt/diamond /usr/bin

## Mummer
RUN cd /opt && wget https://github.com/mummer4/mummer/releases/download/v3.9.4alpha/mummer-3.9.4alpha.tar.gz \
&& tar zxvf mummer-3.9.4alpha.tar.gz \
&& cd mummer-3.9.4alpha \
&& ./configure --prefix=/opt/mummer \
&& make \
&& make install

## Snp-dists
RUN cd /opt && git clone https://github.com/tseemann/snp-dists.git \
&& cd snp-dists \
&& make \
&& ln -s /opt/snp-dists/snp-dists /usr/bin

## Snp-sites https://github.com/sanger-pathogens/snp-sites
RUN apt-get update && apt-get install -y snp-sites

## FastTree
RUN cd /opt && mkdir FastTree \
&& cd FastTree \
&& wget http://www.microbesonline.org/fasttree/FastTree \
&& chmod a+x FastTree \
&& ln -nsf /opt/FastTree/FastTree /usr/bin

## Bowtie2
RUN cd /opt && wget https://sourceforge.net/projects/bowtie-bio/files/bowtie2/2.4.2/bowtie2-2.4.2-sra-linux-x86_64.zip/download \
&& unzip download \
&& ln -s /opt/bowtie2-2.4.2-sra-linux-x86_64 /usr/bin

## BWA
RUN cd /opt && git clone https://github.com/lh3/bwa.git \
&& cd bwa \
&& make \
&& ln -s /opt/bwa /usr/bin/bwa-0.7.17

## Minimap2
RUN cd /opt && git clone https://github.com/lh3/minimap2 \
&& cd minimap2 \
&& make \
&& ln -s /opt/minimap2/minimap2 /usr/bin

## LoFreq
RUN cd /opt && wget -O lofreq_star-2.1.2.tgz https://sourceforge.net/projects/lofreq/files/lofreq_star-2.1.2_linux-x86-64.tgz/download \
&& tar -zxvf lofreq_star-2.1.2.tgz \
&& ln -s /opt/lofreq_star-2.1.2/bin/lofreq /usr/bin

## Snippy
RUN cd /opt && git clone --depth=1 https://github.com/tseemann/snippy.git \
&& ln -s /opt/snippy/bin/snippy /usr/bin

## Genome assembler

## Kraken2
RUN cd /opt && git clone https://github.com/DerrickWood/kraken2.git \
&& cd kraken2 \
&& ./install_kraken2.sh /usr/bin/

## Spades
RUN cd /opt && wget https://cab.spbu.ru/files/release3.15.4/SPAdes-3.15.4-Linux.tar.gz \
&& tar -xzvf SPAdes-3.15.4-Linux.tar.gz \
&& ln -s /opt/SPAdes-3.15.4-Linux/bin/* /usr/bin

## Unicycler
RUN cd /opt && git clone https://github.com/rrwick/Unicycler.git \
&& cd Unicycler \
&& python3 setup.py install

## Mira
RUN cd /opt && wget -O mira_4.0.2.tar.bz2 https://sourceforge.net/projects/mira-assembler/files/MIRA/stable/mira_4.0.2_linux-gnu_x86_64_static.tar.bz2/download \
&& bzip2 -d mira_4.0.2.tar.bz2 \
&& tar -xvf mira_4.0.2.tar \
&& ln -s /opt/mira_4.0.2_linux-gnu_x86_64_static/bin/* /usr/bin

## Ariba https://github.com/sanger-pathogens/ariba#installation
RUN cd /opt && pip3 install ariba

## Quast
RUN cd /opt && wget https://downloads.sourceforge.net/project/quast/quast-5.0.2.tar.gz \
&& tar -xzvf quast-5.0.2.tar.gz \
&& cd quast-5.0.2 \
&& ./install.sh \
&& ln -s /opt/quast-5.0.2/quast.py /usr/bin

## Megahit
RUn cd /opt && wget https://github.com/voutcn/megahit/releases/download/v1.2.9/MEGAHIT-1.2.9-Linux-x86_64-static.tar.gz \
&& tar -xzvf MEGAHIT-1.2.9-Linux-x86_64-static.tar.gz \
&& ln -s MEGAHIT-1.2.9-Linux-x86_64-static/bin/megahit /usr/bin

## Garm-meta http://garm-meta-assem.sourceforge.net/
RUN cd /opt && wget -O GARM_v0.7.5.tar.gz https://sourceforge.net/projects/garm-meta-assem/files/GARM_v0.7.5.tar.gz/download \
&& tar zxvf GARM_v0.7.5.tar.gz \
&& ln -s /opt/GARM_v0.7.5/GARM.pl /usr/bin

## Racon # needs cmake3.11+
RUN cd /opt && wget https://github.com/Kitware/CMake/releases/download/v3.23.2/cmake-3.23.2.tar.gz \
&& tar -xzvf cmake-3.23.2.tar.gz \
&& cd cmake-3.23.2 \
&& ./bootstrap \
&& make \
&& make install \
&& cd /opt && git clone https://github.com/lbcb-sci/racon \
&& cd racon \
&& mkdir build \
&& cd build \
&& cmake -DCMAKE_BUILD_TYPE=Release .. && make \
&& ln -s /opt/racon/build/bin/* /usr/bin

## Shovill https://github.com/tseemann/shovill
RUN cd /opt && git clone https://github.com/tseemann/shovill.git \
&& ln -s /opt/shovill/bin/shovill /usr/bin

## Scaffold builder
RUN cd /opt && git clone https://github.com/metageni/Scaffold_builder.git \
&& ln -s /opt/Scaffold_builder/scaffold_builder.py /usr/bin/scaffold_builder.py

## Annotation tools start here

## Prokka
RUN cd /opt && git clone https://github.com/tseemann/prokka.git prokka \
&& ln -s /opt/prokka/bin/prokka /usr/bin

## Artemis https://github.com/sanger-pathogens/Artemis
RUN cd /opt  && wget -O artemis-18.2.0.tar.gz https://github.com/sanger-pathogens/Artemis/releases/download/v18.2.0/artemis-unix-release-18.2.0.tar.gz \
&& tar -xzvf artemis-18.2.0.tar.gz \
&& ln -s /opt/artemis/art /usr/bin

## Eggnog-mapper https://github.com/eggnogdb/eggnog-mapper
RUN cd  /opt && pip3 install eggnog-mapper

## SnpEFF
RUN cd /opt && wget https://sourceforge.net/projects/snpeff/files/snpEff_latest_core.zip \
&& unzip snpEff_latest_core.zip \
&& mkdir /opt/snpEff/bin \
&& echo "#!/usr/bin/env bash" > /opt/snpEff/bin/snpEff \
&& echo "java -jar /opt/snpEff/snpEff.jar ${@}" >> /opt/snpEff/bin/snpEff \
&& echo "#!/usr/bin/env bash" > /opt/snpEff/bin/SnpSift \
&& echo "java -jar /opt/snpEff/SnpSift.jar ${@}" >> /opt/snpEff/bin/SnpSift \
&& chmod a+x /opt/snpEff/bin/*
ENV PATH /opt/snpEff/bin:${PATH}

## Vcf-annotator https://github.com/rpetit3/vcf-annotator
RUN cd /opt && git clone https://github.com/rpetit3/vcf-annotator.git \
&& cd vcf-annotator \
&& pip3 install -r requirements.txt \
&& ln -s /opt/vcf-annotator/vcf-annotator.py /usr/bin

## Phylogenetic analysis tools start here
RUN cd /opt && pip3 install metaphlan

## PhyloFlash https://github.com/HRGV/phyloFlash
RUN cd /opt && wget https://github.com/HRGV/phyloFlash/archive/pf3.4.tar.gz \
&& tar -xzf pf3.4.tar.gz \
&& ln -s /opt/phyloFlash-pf3.4/* /usr/bin


## Visualisation and other tools start here

## Ribopicker
RUN cd /opt && wget -O ribopicker-0.4.3.tar.gz https://sourceforge.net/projects/ribopicker/files/standalone/ribopicker-standalone-0.4.3.tar.gz/download \
&& tar zxvf ribopicker-0.4.3.tar.gz \
&& ln -s /opt/ribopicker-standalone-0.4.3/ribopicker.pl /usr/bin

## Barrnap https://github.com/tseemann/barrnap
RUN cd /opt && git clone https://github.com/tseemann/barrnap.git \
&& ln -s /opt/barrnap/bin/barrnap /usr/bin

## Krona Tools
RUN cd /opt && wget https://github.com/marbl/Krona/releases/download/v2.7.1/KronaTools-2.7.1.tar \
&& tar xvf KronaTools-2.7.1.tar \
&& cd KronaTools-2.7.1 \
&& ./install.pl

## Abricate
RUN cd /opt && git clone https://github.com/tseemann/abricate.git \
&& ln -s /opt/abricate/bin/abricate /usr/bin

## Breseq
RUN cd /opt && wget https://github.com/barricklab/breseq/releases/download/v0.33.2/breseq-0.33.2-Linux-x86_64.tar.gz \
&& tar zxvf breseq-0.33.2-Linux-x86_64.tar.gz \
&& ln -s /opt/breseq-0.33.2-Linux-x86_64/bin/breseq /usr/bin \
&& ln -s /opt/breseq-0.33.2-Linux-x86_64/bin/gdtools /usr/bin

## ClonalframeML
RUN cd /opt && git clone https://github.com/xavierdidelot/ClonalFrameML \
&& cd ClonalFrameML/src \
&& make \
&& ln -s /opt/ClonalFrameML/src/ClonalFrameML /usr/bin

## NCBI-genome-download
RUN cd /opt && pip3 install ncbi-genome-download



## Deleting temp files

RUN rm /opt/*.tar.gz \
&& rm /opt/*.tgz \
&& rm /opt/*.tar.bz2 \
&& rm /opt/*.zip

USER $NB_USER
WORKDIR /home/microgen