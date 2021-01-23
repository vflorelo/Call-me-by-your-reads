*Before we start*
-----------------

.. note::

	En los ambientes unix linux los programas no se instalan de la misma forma que en los ambientes windows o mac, en vez tenemos que descargar el código fuente de los programas, compilarlo cuando así sea necesario e instalarlo en algun lugar de nuestro sistema

	Los siguientes comandos nos permitirán instalar htslib, samtools y gatk en nuestra carpeta :code:`$HOME/bin`

.. admonition:: htslib
	:class: toggle

		::

			$ pwd
			/home/vflorelo

			$ git clone https://github.com/samtools/htslib.git

			$ cd /home/vflorelo/htslib

			$ autoheader

			$ autoconf

			$ ./configure --prefix=/home/vflorelo

			$ make

			$ make install

			$ cd /home/vflorelo

.. admonition:: samtools
	:class: toggle

		::

			$ pwd
			/home/vflorelo

			$ git clone https://github.com/samtools/samtools.git

			$ cd /home/vflorelo/samtools

			$ autoheader

			$ autoconf

			$ ./configure --prefix=/home/vflorelo

			$ make

			$ make install

			$ cd /home/vflorelo

.. admonition:: GATK4
	:class: toggle

		::

			$ pwd
			/home/vflorelo

			$ wget https://github.com/broadinstitute/gatk/releases/download/4.1.8.1/gatk-4.1.8.1.zip

			$ unzip gatk-4.1.8.1.zip

			$ cd /home/vflorelo/gatk-4.1.8.1

			$ mv * /home/vflorelo/bin

			$ cd /home/vflorelo

			$ chmod -R 775 /home/vflorelo/bin

Comandos del día 4
------------------

0. Preparamos el escenario, abramos nuestra terminal, nos vamos a la carpeta del día 4 y ponemos en ella el archivo en formato SAM que generamos el día 3, adicionalmente tendremos que copiar el archivo :code:`TruSight_One_xt_GRCh38.bed` que vive en la carpeta :code:`/usr/local/bioinformatics/databases`

	::

		$ pwd
		/home/vflorelo

		$ mkdir dia_04

		$ ls
		dia_01 dia_02 dia_03 dia_04

		$ mv dia_03/S1.sam dia_04/

		$ cp /usr/local/bioinformatics/databases/TruSight_One_xt_GRCh38.bed dia_04/

		$ cd dia_04

		$ ls
		S1.sam TruSight_One_xt_GRCh38.bed

1. Primer paso: transformar nuestro archivo SAM a formato BAM, esencialmente son la misma cosa pero los archivos BAM están comprimidos y en binario

	::

		samtools view \
			-@ 4 \
			-b \
			-h \
			-o S1.tmp.bam \
			-f 3 \
			-L TruSight_One_xt_GRCh38.bed S1.sam

	.. important::

		Si todo sale bien, podemos eliminar nuestro archivo SAM para ahorrarnos espacio::

			rm S1.sam

2. Posteriormente agregaremos un `readgroup`_ a nuestro archivo BAM para indicarle

* El identificador del *readgroup*
* El nombre de la biblioteca
* La plataforma de secuenciación
* El nombre de la muestra
* La unidad de la plataforma (barcodes)

	::

		gatk AddOrReplaceReadGroups --INPUT S1.tmp.bam --OUTPUT S1.rg.bam --RGLB S1 --RGID S1 --RGPL Illumina --RGSM S1 --RGPU S1

3. Hecho esto, ordenamos con base en las posiciones genómicas nuestro archivo BAM

	::

		gatk SortSam --INPUT S1.rg.bam --OUTPUT S1.sorted.bam --SORT_ORDER coordinate

4. Paso importante (ó no). Marcado de duplicados

	::

		gatk MarkDuplicates --INPUT S1.sorted.bam --OUTPUT S1.dupmarked.bam --METRICS_FILE S1.dupmarked.txt

5. Recalibración de los scores de calidad

	::

		gatk BaseRecalibrator \
			--reference /usr/local/bioinformatics/databases/genome/Homo_sapiens_GRCh38.fasta \
			--input S1.dupmarked.bam \
			--known-sites /usr/local/bioinformatics/databases/GATK4/dbsnp_146.hg38.vcf.gz \
			--known-sites /usr/local/bioinformatics/databases/GATK4/Mills_and_1000G_gold_standard.indels.hg38.vcf.gz \
			--output S1_recal-data.table \
			--intervals TruSight_One_xt_GRCh38.bed

6. Obtención de lecturas recalibradas

	::

		gatk ApplyBQSR \
			--reference /usr/local/bioinformatics/databases/genome/Homo_sapiens_GRCh38.fasta \
			--input S1.dupmarked.bam \
			--bqsr-recal-file S1_recal-data.table \
			--output S1_recal-reads.bam \
			--intervals TruSight_One_xt_GRCh38.bed

7. Obtención de scores de calidad de las lecturas recalibradas

	::

		gatk BaseRecalibrator \
			--reference /usr/local/bioinformatics/databases/genome/Homo_sapiens_GRCh38.fasta \
			--input S1_recal-reads.bam \
			--known-sites /usr/local/bioinformatics/databases/GATK4/dbsnp_146.hg38.vcf.gz \
			--known-sites /usr/local/bioinformatics/databases/GATK4/Mills_and_1000G_gold_standard.indels.hg38.vcf.gz \
			--output S1_post-recal-data.table \
			--intervals TruSight_One_xt_GRCh38.bed

8. Comparación de los scores de calidad

	::

		gatk AnalyzeCovariates \
			--before-report-file S1_recal-data.table \
			--after-report-file S1_post-recal-data.table \
			--plots-report-file S1_recal-plots.pdf

Comandos del día 5
------------------

9. Llamado de variantes **crudas**

	9.1 Llamado de variantes de línea germinal por individuo en modo *single-sample*

		::

			gatk HaplotypeCaller \
				--reference /usr/local/bioinformatics/databases/genome/Homo_sapiens_GRCh38.fasta \
				--input S1_recal-reads.bam \
				--intervals TruSight_One_xt_GRCh38.bed \
				--stand-call-conf 10.0 \
				--output S1_raw-vars.vcf 	\
				--native-pair-hmm-threads 4

	9.2 Llamado de variantes de línea germinal por individuo para joint-genotype

		::

			gatk HaplotypeCaller \
				--reference /usr/local/bioinformatics/databases/genome/Homo_sapiens_GRCh38.fasta \
				--input S1_recal-reads.bam \
				--intervals TruSight_One_xt_GRCh38.bed \
				--stand-call-conf 10.0 \
				--output S1_raw-vars.g.vcf \
				--native-pair-hmm-threads 4 \
				--emit-ref-confidence GVCF \
				--output-mode EMIT_ALL_CONFIDENT_SITES

			gatk HaplotypeCaller \
				--reference /usr/local/bioinformatics/databases/genome/Homo_sapiens_GRCh38.fasta \
				--input S2_recal-reads.bam \
				--intervals TruSight_One_xt_GRCh38.bed \
				--stand-call-conf 10.0 \
				--output S2_raw-vars.g.vcf \
				--native-pair-hmm-threads 4 \
				--emit-ref-confidence GVCF \
				--output-mode EMIT_ALL_CONFIDENT_SITES

			gatk HaplotypeCaller \
				--reference /usr/local/bioinformatics/databases/genome/Homo_sapiens_GRCh38.fasta \
				--input S3_recal-reads.bam \
				--intervals TruSight_One_xt_GRCh38.bed \
				--stand-call-conf 10.0 \
				--output S3_raw-vars.g.vcf \
				--native-pair-hmm-threads 4 \
				--emit-ref-confidence GVCF \
				--output-mode EMIT_ALL_CONFIDENT_SITES

			gatk GenomicsDBImport \
				--variant S1.g.vcf \
				--variant S2.g.vcf \
				--variant S3.g.vcf \
				--genomicsdb-workspace-path my_database \
				--intervals 1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,21,22,X,Y,MT

			gatk GenotypeGVCFs \
				--reference /usr/local/bioinformatics/databases/genome/Homo_sapiens_GRCh38.fasta \
				--variant gendb://my_database \
				--use-new-qual-calculator \
				--output joint_raw-vars.vcf

	9.3 Llamado de variantes somáticas por individuo en modo tumor-control

		::

			gatk Mutect2 \
				--reference /usr/local/bioinformatics/databases/genome/Homo_sapiens_GRCh38.fasta \
				--input S2_recal-reads.bam \
				--tumor-sample S2 \
				--input S1_recal-reads.bam \
				--normal-sample S1 \
				--germline-resource /usr/local/bioinformatics/databases/af-only-gnomad.hg38.vcf.gz \
				--panel-of-normals /usr/local/bioinformatics/databases/1000g_pon.hg38.vcf.gz \
				--intervals ClearSeq_Comprehensive_Cancer_GRCh38.bed \
				--output S2_S1.vcf.gz

	9.4 Llamado de variantes somáticas por individuo en modo tumor-only

		::

			gatk Mutect2 \
			--reference /usr/local/bioinformatics/databases/genome/Homo_sapiens_GRCh38.fasta \
			--input S2_recal-reads.bam \
			--tumor-sample S2 \
			--germline-resource /usr/local/bioinformatics/databases/af-only-gnomad.hg38.vcf.gz \
			--panel-of-normals /usr/local/bioinformatics/databases/1000g_pon.hg38.vcf.gz \
			--intervals ClearSeq_Comprehensive_Cancer_GRCh38.bed \
			--output S2.vcf.gz

10. Recalibración de SNVs

	::

		gatk VariantRecalibrator \
			--reference /usr/local/bioinformatics/databases/Genome/Homo_sapiens_GRCh38.fasta \
			--variant S1_raw-vars.vcf \
			--intervals TruSight_One_xt_GRCh38.bed \
			--resource:hapmap,known=false,training=true,truth=true,prior=15.0 /usr/local/bioinformatics/databases/GATK4/hapmap_3.3.hg38.vcf.gz \
			--resource:omni,known=false,training=true,truth=true,prior=12.0 /usr/local/bioinformatics/databases/GATK4/1000G_omni2.5.hg38.vcf.gz \
			--resource:1000G,known=false,training=true,truth=false,prior=10.0 /usr/local/bioinformatics/databases/GATK4/1000G_phase1.snps.high_confidence.hg38.vcf.gz \
			--resource:dbsnp,known=true,training=false,truth=false,prior=2.0 /usr/local/bioinformatics/databases/GATK4/dbsnp_146.hg38.vcf.gz \
			--use-annotation QD \
			--use-annotation FS \
			--use-annotation SOR \
			--use-annotation MQ \
			--use-annotation MQRankSum \
			--use-annotation ReadPosRankSum \
			--mode SNP \
			--truth-sensitivity-tranche 100.0 \
			--truth-sensitivity-tranche 99.9 \
			--truth-sensitivity-tranche 99.0 \
			--truth-sensitivity-tranche 90.0 \
			--max-gaussians 1 \
			--max-negative-gaussians 1 \
			--output S1_recalibrate-SNP.recal \
			--tranches-file S1_recalibrate-SNP.tranches \
			--rscript-file S1_recalibrate-SNP-plots.R
		gatk ApplyVQSR \
			--reference /usr/local/bioinformatics/databases/Genome/Homo_sapiens_GRCh38.fasta \
			--variant S1_raw-vars.vcf \
			--intervals TruSight_One_xt_GRCh38.bed \
			--mode SNP \
			--truth-sensitivity-filter-level 99.0 \
			--recal-file S1_recalibrate-SNP.recal \
			--tranches-file S1_recalibrate-SNP.tranches \
			--output S1_recal-snps_raw-indels.vcf

11. Recalibración de InDels

	::

		gatk VariantRecalibrator \
			--reference /usr/local/bioinformatics/databases/Genome/Homo_sapiens_GRCh38.fasta \
			--variant S1_recal-snps_raw-indels.vcf \
			--intervals TruSight_One_xt_GRCh38.bed \
			--resource:mills,known=true,training=true,truth=true,prior=12.0 /usr/local/bioinformatics/databases/GATK4/Mills_and_1000G_gold_standard.indels.hg38.vcf.gz \
			--use-annotation QD \
			--use-annotation FS \
			--use-annotation SOR \
			--use-annotation MQRankSum \
			--use-annotation ReadPosRankSum \
			--mode INDEL \
			--truth-sensitivity-tranche 100.0 \
			--truth-sensitivity-tranche 99.9 \
			--truth-sensitivity-tranche 99.0 \
			--truth-sensitivity-tranche 90.0 \
			--max-gaussians 1 \
			--max-negative-gaussians 1 \
			--output S1_recalibrate-INDEL.recal \
			--tranches-file S1_recalibrate-INDEL.tranches \
			--rscript-file S1_recalibrate-INDEL-plots.R
		gatk ApplyVQSR \
			--reference /usr/local/bioinformatics/databases/Genome/Homo_sapiens_GRCh38.fasta \
			--variant S1_recal-snps_raw-indels.vcf \
			--intervals TruSight_One_xt_GRCh38.bed \
			--mode INDEL \
			--truth-sensitivity-filter-level 99.0 \
			--recal-file S1_recalibrate-INDEL.recal \
			--tranches-file S1_recalibrate-INDEL.tranches \
			--output S1_recalibrated_variants.vcf

12. Anotación de variantes: ID

	::

		gatk VariantAnnotator \
			--reference /usr/local/bioinformatics/databases/Genome/Homo_sapiens_GRCh38.fasta \
			--variant S1_recalibrated_variants.vcf \
			--intervals TruSight_One_xt_GRCh38.bed \
			--dbsnp /usr/local/bioinformatics/databases/dbSNP/dbSNP.vcf.gz \
			--output S1_annotated_variants.vcf \
			--annotation Coverage

13. Selección de variantes

	::

		gatk SelectVariants \
			--reference /usr/local/bioinformatics/databases/Genome/Homo_sapiens_GRCh38.fasta \
			--variant S1_annotated_variants.vcf \
			--output S1_annotated_qd_dp_filtered_variants.vcf \
			--selectExpressions "QD > 5.0 && DP > 10.0"

14. Anotación funcional de variantes

	::

		gatk Funcotator \
			--variant S1_annotated_qd_dp_filtered_variants.vcf \
			--data-sources-path /usr/local/bioinformatics/databases/funcotator_dataSources \
			--output-file-format VCF \
			--reference /usr/local/bioinformatics/databases/Genome/Homo_sapiens_GRCh38.fasta \
			--ref-version hg38 \
			--output S1_func_annotated_qd_dp_filtered_variants.vcf

	.. important::

		Para descargar fuentes de anotación, es necesario entrar al servidor `ftp`_ del Broad Institute con nombre de usuario :code:`gsapubftp-anonymous` y contraseña :code:`gsapubftp-anonymous`

Formatos... formatos everywhere
-------------------------------

.. admonition:: BAM
	:class: toggle

	El formato BAM es similar en estructura al formato SAM, sin embargo, es el formato de elección para el manejo de alineamientos ya que está comprimido y ahorra mucho espacio

.. admonition:: BED
	:class: toggle

	El formato BED consta de archivos de texto plano con estructura tabular que indica posiciones dentro de un genoma

	Este formato es indispensable para el manejo óptimo de alineamientos ya que nos permite filtrar unicamente por las regiones que nos interesan!

	Hay distintas versiones del formato `BED`_, la estructura más básica consta de 4 a 6 columnas::

		13      32316459        32316526        BRCA2   .       +
		13      32319075        32319324        BRCA2   .       +
		13      32325074        32325183        BRCA2   .       +

	.. important::

		El formato BED es 0-based para la segunda columna!

		Si mi gen inicia en el nucleótido 345 y termina en el 678 del cromosoma MT, su nomenclatura en formato BED será la siguiente::

			MT	344	678	mi_gen	.	+

.. admonition:: VCF
	:class: toggle

	El formato VCF también es un archivo de texto plano con una estructura tabular::

		#CHROM  POS     ID      REF     ALT     QUAL    FILTER  INFO    FORMAT  g204
		1       13417   rs777038595     C       CGAGA   324.73  PASS    AC=1;AF=0.500;AN=2;BaseQRankSum=0.583;DB;DP=26;ExcessHet=3.0103;FS=0.000;MLEAC=1;MLEAF=0.500;MQ=22.21;MQRankSum=-0.032;QD=12.49;ReadPosRankSum=-2.185;SOR=0.446;VQSLOD=0.698;culprit=ReadPosRankSum GT:AD:DP:GQ:PL  0/1:15,11:26:99:362,0,634

	.. admonition:: Descripción extendida del formato vcf
		:class: toggle

			+---------+-----------------------+-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------+
			+1: CHROM +1                      +Cromosoma en dónde se ubica la variante                                                                                                                                              +
			+---------+-----------------------+-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------+
			+2: POS   +1053827                +Posición de la variante en el cromosoma                                                                                                                                              +
			+---------+-----------------------+-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------+
			+3: ID    +rs74685771             +Identificador de la variante                                                                                                                                                         +
			+---------+-----------------------+-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------+
			+4: REF   +G                      +Alelo de referencia                                                                                                                                                                  +
			+---------+-----------------------+-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------+
			+5: ALT   +C                      +Alelo encontrado en la muestra                                                                                                                                                       +
			+---------+-----------------------+-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------+
			+6: QUAL  +856.77                 +Score de calidad de la variante                                                                                                                                                      +
			+---------+-----------------------+-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------+
			+7: FILTER+PASS                   +Flag de calidad de la variante                                                                                                                                                       +
			+---------+-----------------------+-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------+
			+8:INFO   +AC=1;                  +Número de alelos alternos encontrados                                                                                                                                                +
			+         +-----------------------+-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------+
			+         +AF=0.500;              +Frecuencia alelica (alelo alterno)                                                                                                                                                   +
			+         +-----------------------+-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------+
			+         +AN=2;                  +Número total de alelos para una variante                                                                                                                                             +
			+         +-----------------------+-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------+
			+         +BaseQRankSum=-2.129    +Z-score de la calidad de las bases mapeadas en el alelo alterno vs el alelo de referencia empleando una prueba de Wilcoxon                                                           +
			+         +-----------------------+-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------+
			+         +ClippingRankSum=-0.286;+Z-score del número de lecturas con calidad de mapeo bajas para el alelo alterno vs el alelo de referencia empleando una prueba de Wilcoxon                                           +
			+         +-----------------------+-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------+
			+         +DB;                    +Indica si la variante pertenece a una base de datos (dbSNP)                                                                                                                          +
			+         +-----------------------+-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------+
			+         +DP=63;                 +número de lecturas mapeadas en la posición de la variante                                                                                                                            +
			+         +-----------------------+-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------+
			+         +FS=0;                  +P-value ajustado para determinar sesgo hacía una cadena de DNA empleando una prueba exacta de Fisher                                                                                 +
			+         +-----------------------+-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------+
			+         +MLEAC=1;               +Máxima verosimilitud esperada para el número de alelos observados (depende del número de muestras).                                                                                  +
			+         +-----------------------+-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------+
			+         +MLEAF=0.500;           +Máxima verosimilitud esperada para las frecuencias alélicas (depende del número de muestras).                                                                                        +
			+         +-----------------------+-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------+
			+         +MQ=60.00;              +Calidad media de mapeo en la posición de la variante.                                                                                                                                +
			+         +-----------------------+-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------+
			+         +MQRankSum=-0.0.635;    +Z-score de la calidad de mapeo las bases alíneadas en el alelo alterno vs el alelo de referencia empleando una prueba de Wilcoxon                                                    +
			+         +-----------------------+-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------+
			+         +QD=13.60;              +Confianza del alelo observado (Quality over depth)                                                                                                                                   +
			+         +-----------------------+-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------+
			+         +ReadPosRankSum=0.621;  +Z-score del sesgo posicional (con respecto de la longitud de la lectura) del alelo alternativo vs el alelo de referencia (depende del número de muestras)                            +
			+         +-----------------------+-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------+
			+         +SOR=0.768;             +Suma simétrica de la razón de momios del número de lecturas que presentan la variante cerca del final de la lectura, vs las lecturas que la presentan cerca del inicio de la lectura.+
			+         +-----------------------+-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------+
			+         +VQSLOD=3.39;           +Logaritmo de la razón de momios de que la variante sea verdadera vs que sea un falso positivo.                                                                                       +
			+         +-----------------------+-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------+
			+         +culprit=qd             +El descriptor que presentó la métrica más desfavorable                                                                                                                               +
			+---------+-----------------------+-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------+
			+9:FORMAT +GT                     +Genotipo                                                                                                                                                                             +
			+         +-----------------------+-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------+
			+         +AD                     +Profundidad de los alelos observados (Ref,Alt)                                                                                                                                       +
			+         +-----------------------+-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------+
			+         +DP                     +Profundidad total (número de lecturas                                                                                                                                                +
			+         +-----------------------+-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------+
			+         +GQ                     +Calidad del genotipado                                                                                                                                                               +
			+         +-----------------------+-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------+
			+         +PL                     +Verosimilitud de genotipos (Obs,Nul,Alt)                                                                                                                                             +
			+---------+-----------------------+-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------+
			+10:g204  +0/1                    +Heterocigoto                                                                                                                                                                         +
			+         +-----------------------+-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------+
			+         +37,26                  +(G)37 reads \+ (C)26 reads                                                                                                                                                           +
			+         +-----------------------+-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------+
			+         +63                     +                                                                                                                                                                                     +
			+         +-----------------------+-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------+
			+         +99                     +                                                                                                                                                                                     +
			+         +-----------------------+-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------+
			+         +885,0,1386             +                                                                                                                                                                                     +
			+---------+-----------------------+-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------+

	.. important::

		El formato VCF es 1-based en la segunda columna, por lo que es importante considerar esto cuando manejemos combinaciones de formatos (como con bedtools y bcftools)

.. admonition:: GFF
	:class: toggle

	El formato GFF consta de archivos de texto plano con estructura tabular que indica posiciones dentro de un genoma, pueden ser genes, mRNAs, exones, regiones codificantes, y un largo etcetera.

	Este formato es uno de los estándares de anotación genómica y se emplea en todos los proyectos de genómica como referencia para obtener genes

	::

		1	havana	exon	11869	12227	.	+	.	Parent=transcript:ENST00000456328;Name=ENSE00002234944;constitutive=0;ensembl_end_phase=-1;ensembl_phase=-1;exon_id=ENSE00002234944;rank=1;version=1
		1	havana	lnc_RNA	11869	14409	.	+	.	ID=transcript:ENST00000456328;Parent=gene:ENSG00000223972;Name=DDX11L1-202;biotype=processed_transcript;tag=basic;transcript_id=ENST00000456328;transcript_support_level=1;version=2
		1	havana	pseudogene	11869	14409	.	+	.	ID=gene:ENSG00000223972;Name=DDX11L1;biotype=transcribed_unprocessed_pseudogene;description=DEAD/H-box helicase 11 like 1 [Source:HGNC Symbol%3BAcc:HGNC:37102];gene_id=ENSG00000223972;logic_name=havana_homo_sapiens;version=5
		1	havana	exon	12010	12057	.	+	.	Parent=transcript:ENST00000450305;Name=ENSE00001948541;constitutive=0;ensembl_end_phase=-1;ensembl_phase=-1;exon_id=ENSE00001948541;rank=1;version=1
		1	havana	pseudogenic_transcript	12010	13670	.	+	.	ID=transcript:ENST00000450305;Parent=gene:ENSG00000223972;Name=DDX11L1-201;biotype=transcribed_unprocessed_pseudogene;tag=basic;transcript_id=ENST00000450305;transcript_support_level=NA;version=2
		1	havana	exon	12179	12227	.	+	.	Parent=transcript:ENST00000450305;Name=ENSE00001671638;constitutive=0;ensembl_end_phase=-1;ensembl_phase=-1;exon_id=ENSE00001671638;rank=2;version=2
		1	havana	exon	12613	12697	.	+	.	Parent=transcript:ENST00000450305;Name=ENSE00001758273;constitutive=0;ensembl_end_phase=-1;ensembl_phase=-1;exon_id=ENSE00001758273;rank=3;version=2
		1	havana	exon	12613	12721	.	+	.	Parent=transcript:ENST00000456328;Name=ENSE00003582793;constitutive=0;ensembl_end_phase=-1;ensembl_phase=-1;exon_id=ENSE00003582793;rank=2;version=1
		1	havana	exon	12975	13052	.	+	.	Parent=transcript:ENST00000450305;Name=ENSE00001799933;constitutive=0;ensembl_end_phase=-1;ensembl_phase=-1;exon_id=ENSE00001799933;rank=4;version=2
		1	havana	exon	13221	13374	.	+	.	Parent=transcript:ENST00000450305;Name=ENSE00001746346;constitutive=0;ensembl_end_phase=-1;ensembl_phase=-1;exon_id=ENSE00001746346;rank=5;version=2

	La estructura del formato GFF consta de 9 columnas:

			+------------+-----------------------------------+
			+ Campo      + Ejemplo                           +
			+============+===================================+
			+1: CHROM    + 1                                 +
			+------------+-----------------------------------+
			+2: SOURCE   + havana                            +
			+------------+-----------------------------------+
			+3: FEATURE  + exon                              +
			+------------+-----------------------------------+
			+4: START    + 13221                             +
			+------------+-----------------------------------+
			+5: END      + 13374                             +
			+------------+-----------------------------------+
			+6: SCORE    + \.                                +
			+------------+-----------------------------------+
			+7: STRAND   + \+                                +
			+------------+-----------------------------------+
			+8:FRAME     + \.                                +
			+------------+-----------------------------------+
			+9:ATTRIBUTE + Parent=transcript:ENST00000450305;+
			+            +-----------------------------------+
			+            + Name=ENSE00001746346;             +
			+            +-----------------------------------+
			+            + constitutive=0;                   +
			+            +-----------------------------------+
			+            + ensembl_end_phase=-1;             +
			+            +-----------------------------------+
			+            + ensembl_phase=-1;                 +
			+            +-----------------------------------+
			+            + exon_id=ENSE00001746346;          +
			+            +-----------------------------------+
			+            + rank=5;                           +
			+            +-----------------------------------+
			+            + version=2                         +
			+------------+-----------------------------------+

	.. important::

		El formato GFF es 1-based para la quinta columna!


.. _`BED`: https://genome.ucsc.edu/FAQ/FAQformat.html#format1
.. _`readgroup`: https://www.biostars.org/p/43897/
.. _`ftp`: ftp://gsapubftp-anonymous@ftp.broadinstitute.org/bundle/
