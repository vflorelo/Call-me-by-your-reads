#!/bin/bash
#step1
user_name=$(whoami)
if [ "${user_name}" != "root" ]
then
	echo -e "Must be run as root\nTry:\nsudo su\n and run again"
fi
add-apt-repository universe
apt-get update
apt-get upgrade
apt-get install apache2 autoconf automake build-essential certbot cmake firewalld gcc gfortran git libblas-dev libbz2-dev libcurl4-gnutls-dev liblapack-dev libltdl-dev liblzma-dev libncurses5-dev libssl-dev libxrender-dev libxtst-dev make openjdk-8-jre openjdk-11-jre parallel perl pigz rename tree unzip zlib1g-dev python3-testresources r-base python3-pip unzip
R -e "install.packages(c('gplots','gsalib'))"
cd /usr/bin
ln -s python3 python
pip3 install powerline-shell
pip3 install gsutil
echo "
function _update_ps1() {
	PS1=\$(powerline-shell \$?)
	}
if [[ \$TERM != linux && ! \$PROMPT_COMMAND =~ _update_ps1 ]]
then
	PROMPT_COMMAND=\"_update_ps1; \$PROMPT_COMMAND\"
fi" >>  /etc/profile
#step5
mkdir -p /usr/local/bioinformatics/bundle
mkdir -p /usr/local/bioinformatics/db/GRCh38/clinvar
mkdir -p /usr/local/bioinformatics/db/GRCh38/dbSnp
cd /usr/local/bioinformatics/bundle
gsutil -m cp -r \
  "gs://genomics-public-data/resources/broad/hg38/v0/1000G.phase3.integrated.sites_only.no_MATCHED_REV.hg38.vcf" \
  "gs://genomics-public-data/resources/broad/hg38/v0/1000G.phase3.integrated.sites_only.no_MATCHED_REV.hg38.vcf.idx" \
  "gs://genomics-public-data/resources/broad/hg38/v0/1000G_omni2.5.hg38.vcf.gz" \
  "gs://genomics-public-data/resources/broad/hg38/v0/1000G_omni2.5.hg38.vcf.gz.tbi" \
  "gs://genomics-public-data/resources/broad/hg38/v0/1000G_phase1.snps.high_confidence.hg38.vcf.gz" \
  "gs://genomics-public-data/resources/broad/hg38/v0/1000G_phase1.snps.high_confidence.hg38.vcf.gz.tbi" \
  "gs://genomics-public-data/resources/broad/hg38/v0/Axiom_Exome_Plus.genotypes.all_populations.poly.hg38.vcf.gz" \
  "gs://genomics-public-data/resources/broad/hg38/v0/Axiom_Exome_Plus.genotypes.all_populations.poly.hg38.vcf.gz.tbi" \
  "gs://genomics-public-data/resources/broad/hg38/v0/Homo_sapiens_assembly38.dbsnp138.vcf" \
  "gs://genomics-public-data/resources/broad/hg38/v0/Homo_sapiens_assembly38.dbsnp138.vcf.idx" \
  "gs://genomics-public-data/resources/broad/hg38/v0/Homo_sapiens_assembly38.dict" \
  "gs://genomics-public-data/resources/broad/hg38/v0/Homo_sapiens_assembly38.fasta" \
  "gs://genomics-public-data/resources/broad/hg38/v0/Homo_sapiens_assembly38.fasta.64.alt" \
  "gs://genomics-public-data/resources/broad/hg38/v0/Homo_sapiens_assembly38.fasta.64.amb" \
  "gs://genomics-public-data/resources/broad/hg38/v0/Homo_sapiens_assembly38.fasta.64.ann" \
  "gs://genomics-public-data/resources/broad/hg38/v0/Homo_sapiens_assembly38.fasta.64.bwt" \
  "gs://genomics-public-data/resources/broad/hg38/v0/Homo_sapiens_assembly38.fasta.64.pac" \
  "gs://genomics-public-data/resources/broad/hg38/v0/Homo_sapiens_assembly38.fasta.64.sa" \
  "gs://genomics-public-data/resources/broad/hg38/v0/Homo_sapiens_assembly38.fasta.fai" \
  "gs://genomics-public-data/resources/broad/hg38/v0/Homo_sapiens_assembly38.known_indels.vcf.gz" \
  "gs://genomics-public-data/resources/broad/hg38/v0/Homo_sapiens_assembly38.known_indels.vcf.gz.tbi" \
  "gs://genomics-public-data/resources/broad/hg38/v0/Mills_and_1000G_gold_standard.indels.hg38.vcf.gz" \
  "gs://genomics-public-data/resources/broad/hg38/v0/Mills_and_1000G_gold_standard.indels.hg38.vcf.gz.tbi" \
  "gs://genomics-public-data/resources/broad/hg38/v0/hapmap_3.3.hg38.vcf.gz" \
  "gs://genomics-public-data/resources/broad/hg38/v0/hapmap_3.3.hg38.vcf.gz.tbi" \
  "gs://genomics-public-data/resources/broad/hg38/v0/scattered_calling_intervals/" \
  "gs://genomics-public-data/resources/broad/hg38/v0/wgs_calling_regions.hg38.interval_list" \
  .
cd /usr/local/bioinformatics/db/GRCh38/clinvar
wget ftp://ftp.ncbi.nlm.nih.gov/pub/clinvar/vcf_GRCh38/clinvar.vcf.gz
cd /usr/local/bioinformatics/db/GRCh38/dbSnp
wget ftp://ftp.ncbi.nih.gov/snp/organisms/human_9606/VCF/00-All.vcf.gz
cd /usr/local
chown -R root bioinformatics bioinformatics
chmod -R 777 bioinformatics
