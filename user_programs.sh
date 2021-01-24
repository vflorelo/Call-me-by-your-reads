#!/bin/bash
cd $HOME
mkdir bin
cd bin
wget https://hgdownload.soe.ucsc.edu/admin/exe/linux.x86_64/liftOver
chmod 775 liftOver
echo "PATH=\$PATH:\$HOME/bin" >> .bashrc
echo "export PATH" >> .bashrc
conda config --add channels defaults
conda config --add channels bioconda
conda config --add channels conda-forge
conda create -n gatk -c bioconda samtools bwa fastqc
cd $HOME
wget https://github.com/broadinstitute/gatk/releases/download/4.1.9.0/gatk-4.1.9.0.zip
unzip gatk-4.1.9.0.zip
echo "PATH=\$HOME/gatk-4.1.9.0:\$PATH" >> .bashrc
echo "export PATH" >> .bashrc
echo "source \$HOME/gatk-4.1.9.0/gatk-completion.sh"
cd $HOME
wget https://snpeff.blob.core.windows.net/versions/snpEff_latest_core.zip
unzip snpEff_latest_core.zip
