#!/bin/bash
#step1
add-apt-repository universe
add-apt-repository ppa:certbot/certbot
apt-get update
apt-get upgrade
apt-get install apache2 autoconf automake build-essential certbot cmake firewalld gcc gfortran git libblas-dev libbz2-dev libcurl4-gnutls-dev liblapack-dev libltdl-dev liblzma-dev libncurses5-dev libssl-dev libxrender-dev libxtst-dev make openjdk-8-jre openjdk-11-jre parallel perl pigz python3-pip python3-certbot-apache rename tree unzip zlib1g-dev python3-testresources r-base python3-pip unzip
R -e "install.packages(c('gplots','gsalib'))"
#step2
wget http://www.noip.com/client/linux/noip-duc-linux.tar.gz
tar -zxf noip-duc-linux.tar.gz
cd noip-2.1.9-1
make install
echo "[Unit]
Description=noip2 service
[Service]
Type=forking
ExecStart=/usr/local/bin/noip2
Restart=always
[Install]
WantedBy=default.target" > /etc/systemd/system/noip2.service
systemctl daemon-reload
systemctl enable noip2.service
service noip2 restart
groupadd bioinformatics
echo "atgenomics.ddns.net" > /etc/hostname
hostname atgenomics.ddns.net
#step3
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
#step4
for user in adiaz mrodriguez mochoa mromero hmartinez jgaytan nrivera jhernandez tgarrido svidal lflores bvera emartinez jcornejo yruiz vflorelo dianolasa zorbax
do
  useradd --create-home --gid bioinformatics --shell /bin/bash $user
  echo -e "${user}atg\n${user}atg" | passwd $user
  mkdir /home/$user/.ssh
  cp /home/ubuntu/.ssh/authorized_keys /home/$user/.ssh
  chown -R $user /home/$user/.ssh
  chgrp -R bioinformatics /home/$user/.ssh
  chmod -R 700 /home/$user/.ssh
done
#step5
mkdir -p /usr/local/bioinformatics/reads
mv /home/ubuntu/S3*.gz /usr/local/bioinformatics/reads
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
chgrp -R bioinformatics bioinformatics
chmod -R 775 bioinformatics
