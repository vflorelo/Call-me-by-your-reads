38  cd 05_snpeff/
39  ln -s $HOME/04_gatk/S3_annotated_qd_dp_filtered_variants.vcf .
40  java -jar $HOME/snpEff/snpEff.jar ann GRCh38.99 S3_annotated_qd_dp_filtered_variants.vcf > S3_snpEff.vcf
41  ls
42  less -S S3_snpEff.vcf
43  nano ../snpEff/snpEff.config
44  java -jar ../snpEff/SnpSift.jar -help
45  java -jar ../snpEff/SnpSift.jar annotate -help
46  java -jar ../snpEff/SnpSift.jar annotate -noId -dbsnp -clinvar S3_snpEff.vcf > S3_clinvar_dbsnp.vcf
47  nano ../snpEff/snpEff.config
48  java -jar ../snpEff/SnpSift.jar annotate -noId -dbsnp -clinvar S3_snpEff.vcf > S3_clinvar_dbsnp.vcf
49  less -S S3_clinvar_dbsnp.vcf
50  history
