Introducción
------------

La finalidad de este curso es obtener un archivo de llamado de variantes (*Variant Calling File* por sus siglas en inglés) que tiene la siguiente estructura::

	#CHROM  POS     ID      REF     ALT     QUAL    FILTER  INFO    FORMAT  g204
		chr1       13417   rs777038595     C       CGAGA   324.73  PASS    AC=1;AF=0.500;AN=2;BaseQRankSum=0.583;DB;DP=26;ExcessHet=3.0103;FS=0.000;MLEAC=1;MLEAF=0.500;MQ=22.21;MQRankSum=-0.032;QD=12.49;ReadPosRankSum=-2.185;SOR=0.446;VQSLOD=0.698;culprit=ReadPosRankSum GT:AD:DP:GQ:PL  0/1:15,11:26:99:362,0,634

.. admonition:: Descripción extendida del formato vcf
	:class: toggle

		+---------+-----------------------+-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------+
		+1: CHROM +chr1                   +Cromosoma en dónde se ubica la variante                                                                                                                                              +
		+---------+-----------------------+-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------+
		+2: POS   +13417                  +Posición de la variante en el cromosoma                                                                                                                                              +
		+---------+-----------------------+-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------+
		+3: ID    +rs777038595             +Identificador de la variante                                                                                                                                                        +
		+---------+-----------------------+-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------+
		+4: REF   +C                      +Alelo de referencia                                                                                                                                                                  +
		+---------+-----------------------+-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------+
		+5: ALT   +CGAGA                  +Alelo encontrado en la muestra                                                                                                                                                       +
		+---------+-----------------------+-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------+
		+6: QUAL  +324.73                 +Score de calidad de la variante                                                                                                                                                      +
		+---------+-----------------------+-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------+
		+7: FILTER+PASS                   +Flag de calidad de la variante                                                                                                                                                       +
		+---------+-----------------------+-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------+
		+8:INFO   +AC=1;                  +Número de alelos alternos encontrados                                                                                                                                                +
		+         +-----------------------+-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------+
		+         +AF=0.500;              +Frecuencia alelica (alelo alterno)                                                                                                                                                   +
		+         +-----------------------+-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------+
		+         +AN=2;                  +Número total de alelos para una variante                                                                                                                                             +
		+         +-----------------------+-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------+
		+         +BaseQRankSum=0.583     +Z-score de la calidad de las bases mapeadas en el alelo alterno vs el alelo de referencia empleando una prueba de Wilcoxon                                                           +
		+         +-----------------------+-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------+
		+         +DB;                    +Indica si la variante pertenece a una base de datos (dbSNP)                                                                                                                          +
		+         +-----------------------+-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------+
		+         +DP=26;                 +número de lecturas mapeadas en la posición de la variante                                                                                                                            +
		+         +-----------------------+-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------+
		+         +ExcessHet=3.0103;      + p-value en escala Phred para una prueba exacta de exceso de heterocigosidad                                                                                                         +
		+         +-----------------------+-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------+
		+         +FS=0.000;              +P-value ajustado para determinar sesgo hacía una cadena de DNA empleando una prueba exacta de Fisher                                                                                 +
		+         +-----------------------+-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------+
		+         +MLEAC=1;               +Máxima verosimilitud esperada para el número de alelos observados (depende del número de muestras).                                                                                  +
		+         +-----------------------+-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------+
		+         +MLEAF=0.500;           +Máxima verosimilitud esperada para las frecuencias alélicas (depende del número de muestras).                                                                                        +
		+         +-----------------------+-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------+
		+         +MQ=22.21;              +Calidad media de mapeo en la posición de la variante.                                                                                                                                +
		+         +-----------------------+-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------+
		+         +MQRankSum=-0.032;      +Z-score de la calidad de mapeo las bases alíneadas en el alelo alterno vs el alelo de referencia empleando una prueba de Wilcoxon                                                    +
		+         +-----------------------+-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------+
		+         +QD=12.49;              +Confianza del alelo observado (Quality over depth)                                                                                                                                   +
		+         +-----------------------+-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------+
		+         +ReadPosRankSum=-2.185; +Z-score del sesgo posicional (con respecto de la longitud de la lectura) del alelo alternativo vs el alelo de referencia (depende del número de muestras)                            +
		+         +-----------------------+-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------+
		+         +SOR=0.446;             +Suma simétrica de la razón de momios del número de lecturas que presentan la variante cerca del final de la lectura, vs las lecturas que la presentan cerca del inicio de la lectura.+
		+         +-----------------------+-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------+
		+         +VQSLOD=0.698;          +Logaritmo de la razón de momios de que la variante sea verdadera vs que sea un falso positivo.                                                                                       +
		+         +-----------------------+-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------+
		+         +culprit=ReadPosRankSum +El descriptor que presentó la métrica más desfavorable                                                                                                                               +
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
		+         +15,11                  +(C)15 reads \+ (CGAGA)11 reads                                                                                                                                                       +
		+         +-----------------------+-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------+
		+         +26                     +                                                                                                                                                                                     +
		+         +-----------------------+-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------+
		+         +99                     +                                                                                                                                                                                     +
		+         +-----------------------+-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------+
		+         +362,0,634              +                                                                                                                                                                                     +
		+---------+-----------------------+-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------+

A través del uso de los siguientes comandos podemos filtrar éstos y otros archivos para optimizar y entender mejor lo que ocurre en el llamado de variantes
Para comenzar, vamos a descargar un archivo con el que podamos trabajar
:code:`wget https://github.com/vflorelo/Call-me-by-your-reads/`

:code:`grep`
------------
**G** lobally search for a **R** egular **E** xpression and **P** rint matching lines

Como su nombre lo indica, grep busca un patrón (o expresión regular) y nos entrega las líneas que contengan dicho patrón de búsqueda

	.. admonition:: Opciones :code:`grep`
		:class: toggle

		* Buscar un patrón en un archivo::

			$ grep X Homo_sapiens_GRCh38.fasta.fai
			X       156040895       2916073361      70      71

		* :code:`-w` Buscar un patrón en un archivo *si y solo si*, ocurre como **palabra completa** ::

			$ grep 2 Homo_sapiens_GRCh38.fasta.fai
			1       248956422       16      70      71
			2       242193529       252512975       70      71
			3       198295559       498166428       70      71
			4       190214555       699294797       70      71
			5       181538259       892226719       70      71
			7       159345973       1249604479      70      71
			8       145138636       1411226840      70      71
			9       138394717       1558438902      70      71
			10      133797422       1698810704      70      71
			11      135086622       1834519535      70      71
			12      133275309       1971535983      70      71
			13      114364328       2106715242      70      71
			14      107043718       2222713363      70      71
			15      101991189       2331286294      70      71
			16      90338345        2434734517      70      71
			17      83257441        2526363427      70      71
			18      80373285        2610810278      70      71
			19      58617616        2692331770      70      71
			20      64444167        2751786798      70      71
			21      46709983        2817151612      70      71
			22      50818468        2864528898      70      71
			X       156040895       2916073361      70      71
			Y       57227415        3074343428      70      71
			MT      16569   3132388394      70      71

			$ grep -w 2 Homo_sapiens_GRCh38.fasta.fai
			2       242193529       252512975       70      71

		* :code:`-c` Buscar un patrón en un archivo pero en vez de entregar las líneas que contienen el patrón, entrega el **número de líneas que contiene el patrón** ::

			$ grep -c 2 Homo_sapiens_GRCh38.fasta.fai
			24

		* :code:`-m` Buscar un patrón en un archivo y entregar como maximo m líneas ::

			$ grep -m2 2 Homo_sapiens_GRCh38.fasta.fai
			1       248956422       16      70      71
			2       242193529       252512975       70      71

		* :code:`-n` Buscar un patrón en un archivo y mostrar el **número de línea** en la que ocurre el patrón de búsqueda::

			$ grep -n X Homo_sapiens_GRCh38.fasta.fai
			23:X    156040895       2916073361      70      71

		* :code:`-v` Buscar un patrón en un archivo y muestra las líneas **que no contengan** el patrón de búsqueda::

			$ grep -v 2 Homo_sapiens_GRCh38.fasta.fai
			6       170805979       1076358398      70      71

		.. warning::

			grep puede procesar muchos archivos, pero solo un patrón de búsqueda a la vez

			.. tip::

				La siguiente construcción es correcta::

					$ grep patrón archivo_1 archivo_2 archivo_3

			.. danger::

				La siguiente construcción es incorrecta::

					$ grep patrón_1 patrón_2 patrón_3 archivo_1

				En esta ultima construcción, grep interpretará :code:`patrón_2` & :code:`patrón_3` como archivos, no como patrónes de búsqueda
		.. tip::

			Las opciones de :code:`grep` son combinables, de modo que podemos tener::

				$ grep -wv termino archivo

				$ grep -wn termino archivo

				$ grep -wc termino archivo

			O las que se te ocurran, siempre y cuando tengan sentido ;)

:code:`cut`
-----------
Cut es una utilidad para separar columnas de un archivo tabular (como el vcf!)

Para linux todo es una tabla, sabiéndola separar, aquí una pequeña introducción, tomemos el siguiente texto::

	a|b|c
	d|e|f
	g|h|i

Podemos leerlo como una tabla de 3 filas y 3 columnas, separado por el signo '\|'

Otro ejemplo, si copipegamos una tabla de excel a nuestro bloc de notas, tendremos un texto con la siguiente estructura::

	a	b	c
	d	e	f
	g	h	i

Nuevamente podemos leerlo como una tabla de 3 filas y 3 columnas, separado por el signo invisible '\\t'

Ahora si, habiendo tenido esta breve introducción:

	.. admonition:: Modos de operación de :code:`cut`
			:class: toggle

			* Obtener la primera columna de un archivo tabular::

				$ cut -f1 Homo_sapiens_GRCh38.fasta.fai
				1
				2
				3
				4
				5
				6
				7
				8
				9
				9
				10
				11
				12
				13
				14
				15
				16
				17
				18
				19
				20
				21
				22
				X
				Y
				MT

			* Obtener las primeras dos columnas de un archivo tabular::

				$ cut -f1,2 Homo_sapiens_GRCh38.fasta.fai
				1       248956422
				2       242193529
				3       198295559
				4       190214555
				5       181538259
				6       170805979
				7       159345973
				8       145138636
				9       138394717
				10      133797422
				11      135086622
				12      133275309
				13      114364328
				14      107043718
				15      101991189
				16      90338345
				17      83257441
				18      80373285
				19      58617616
				20      64444167
				21      46709983
				22      50818468
				X       156040895
				Y       57227415
				MT      16569

			* Obtener las primeras tres columnas de un archivo tabular

				.. note::

					podemos usar::

						$ cut -f1,2,3 Homo_sapiens_GRCh38.fasta.fai

				.. tip::

					o podemos usar::

						$ cut -f1-3 Homo_sapiens_GRCh38.fasta.fai

			* Obtener las columnas 2 y 3 de un archivo tabular

				.. note::

					podemos usar::

						$ cut -f2,3 Homo_sapiens_GRCh38.fasta.fai

				.. tip::

					o podemos usar::

						$ cut -f1 --complement Homo_sapiens_GRCh38.fasta.fai

			* Obtener todas las columnas de un archivo empezando por la segunda

				.. tip::

					Podemos hacerlo pidiendo un intervalo abierto::

						$ cut -f2- Homo_sapiens_GRCh38.fasta.fai

					O podemos hacerlo excluyendo la columna que nos estorba::

						$ cut -f1 --complement Homo_sapiens_GRCh38.fasta.fai


			.. warning::

				:code:`cut` usa por default el tabulador ('\\t') como separador de campo. Qué pasa si mi tabla no está separada por tabuladores?

				En ese escenario, podemos especificarle a :code:`cut` que use caracteres específicos como separadores de campo::

					$ cat file_1
					a|b|c
					d|e|f
					g|h|i

					$ cut -d\| -f2
					b
					e
					h

			.. tip::

				Al igual que con :code:`grep`, las opciones de :code:`cut` pueden ser combinables para tener un mejor control de lo que nos va a entregar nuestra terminal

				De este modo, las siguientes construcciones nos van a dar unicamente las columnas 2 y 6 de un archivo separado por comas::

					$ cut -d, -f2,6

					$ cut -d, -f1,3-5 --complement

			.. admonition:: Reto!
				:class: toggle

				Cúal seria el resultado de las siguientes construcciones? El archivo lo encuentras en tu carpeta del dia_01. Mandanos por correo tus respuestas (y su explicación) y podrás ganar una sorpresa (limitado a 3 ganadores)::

					$ cat archivo
					A,B	C	D	E	F	G	H	I	J	K	L	M	N	O,P	Q	R,S,T	U	V	W	X

					$ cut -f1,4-9,10,14,18- archivo

					$ cut -f1,4-9,10,14,18- --complement archivo

					$ cut -d, -f2,3 archivo

					$ cut -d, -f2,3- archivo

					$ cut -d, -f2,3 --complement archivo

:code:`sort`
------------
Sort puede ordenar un conjunto de líneas empleando algún criterio.

	.. admonition:: Modos de operacion de :code:`sort`
		:class: toggle

		.. admonition:: Ordenar un conjunto de líneas alfanumericamente
			:class: toggle

			::

				$ sort Homo_sapiens_GRCh38.fasta.fai
				10      133797422       1698810704      70      71
				11      135086622       1834519535      70      71
				12      133275309       1971535983      70      71
				1       248956422       16      70      71
				13      114364328       2106715242      70      71
				14      107043718       2222713363      70      71
				15      101991189       2331286294      70      71
				16      90338345        2434734517      70      71
				17      83257441        2526363427      70      71
				18      80373285        2610810278      70      71
				19      58617616        2692331770      70      71
				20      64444167        2751786798      70      71
				21      46709983        2817151612      70      71
				2       242193529       252512975       70      71
				22      50818468        2864528898      70      71
				3       198295559       498166428       70      71
				4       190214555       699294797       70      71
				5       181538259       892226719       70      71
				6       170805979       1076358398      70      71
				7       159345973       1249604479      70      71
				8       145138636       1411226840      70      71
				9       138394717       1558438902      70      71
				MT      16569   3132388394      70      71
				X       156040895       2916073361      70      71
				Y       57227415        3074343428      70      71

		.. warning::
			En cómputo, el orden alfanumérico es algo truculento, 100 va antes que 10, y 10 va antes que 1.

			De modo que ordenar líneas no es una tarea trivial

		.. admonition:: Ordenar un conjunto de líneas numericamente
			:class: toggle

			::

				$ sort -n Homo_sapiens_GRCh38.fasta.fai
				MT      16569   3132388394      70      71
				X       156040895       2916073361      70      71
				Y       57227415        3074343428      70      71
				1       248956422       16      70      71
				2       242193529       252512975       70      71
				3       198295559       498166428       70      71
				4       190214555       699294797       70      71
				5       181538259       892226719       70      71
				6       170805979       1076358398      70      71
				7       159345973       1249604479      70      71
				8       145138636       1411226840      70      71
				9       138394717       1558438902      70      71
				10      133797422       1698810704      70      71
				11      135086622       1834519535      70      71
				12      133275309       1971535983      70      71
				13      114364328       2106715242      70      71
				14      107043718       2222713363      70      71
				15      101991189       2331286294      70      71
				16      90338345        2434734517      70      71
				17      83257441        2526363427      70      71
				18      80373285        2610810278      70      71
				19      58617616        2692331770      70      71
				20      64444167        2751786798      70      71
				21      46709983        2817151612      70      71
				22      50818468        2864528898      70      71

		.. warning::
			En cómputo, el orden numérico es sensible a la presencia de caracteres alfabéticos, por lo que para ordenar líneas adecuadamente se requiere limpiar los datos (que unicamente contengan un tipo de datos por columna o por campo) o de emplear otra estrategia

		.. admonition:: Ordenar un conjunto de líneas como versionado de software
			:class: toggle

			::

				$ sort -V Homo_sapiens_GRCh38.fasta.fai
				1       248956422       16      70      71
				2       242193529       252512975       70      71
				3       198295559       498166428       70      71
				4       190214555       699294797       70      71
				5       181538259       892226719       70      71
				6       170805979       1076358398      70      71
				7       159345973       1249604479      70      71
				8       145138636       1411226840      70      71
				9       138394717       1558438902      70      71
				10      133797422       1698810704      70      71
				11      135086622       1834519535      70      71
				12      133275309       1971535983      70      71
				13      114364328       2106715242      70      71
				14      107043718       2222713363      70      71
				15      101991189       2331286294      70      71
				16      90338345        2434734517      70      71
				17      83257441        2526363427      70      71
				18      80373285        2610810278      70      71
				19      58617616        2692331770      70      71
				20      64444167        2751786798      70      71
				21      46709983        2817151612      70      71
				22      50818468        2864528898      70      71
				MT      16569   3132388394      70      71
				X       156040895       2916073361      70      71
				Y       57227415        3074343428      70      71

		.. admonition:: Ordenar de forma descendente un conjunto de líneas
			:class: toggle

			::

				$ sort -r Homo_sapiens_GRCh38.fasta.fai
				Y       57227415        3074343428      70      71
				X       156040895       2916073361      70      71
				MT      16569   3132388394      70      71
				9       138394717       1558438902      70      71
				8       145138636       1411226840      70      71
				7       159345973       1249604479      70      71
				6       170805979       1076358398      70      71
				5       181538259       892226719       70      71
				4       190214555       699294797       70      71
				3       198295559       498166428       70      71
				22      50818468        2864528898      70      71
				2       242193529       252512975       70      71
				21      46709983        2817151612      70      71
				20      64444167        2751786798      70      71
				19      58617616        2692331770      70      71
				18      80373285        2610810278      70      71
				17      83257441        2526363427      70      71
				16      90338345        2434734517      70      71
				15      101991189       2331286294      70      71
				14      107043718       2222713363      70      71
				13      114364328       2106715242      70      71
				1       248956422       16      70      71
				12      133275309       1971535983      70      71
				11      135086622       1834519535      70      71
				10      133797422       1698810704      70      71

		.. admonition:: Ordenar con base en alguna columna específica
			:class: toggle

			::

				$ sort -k2 Homo_sapiens_GRCh38.fasta.fai
				15      101991189       2331286294      70      71
				14      107043718       2222713363      70      71
				13      114364328       2106715242      70      71
				12      133275309       1971535983      70      71
				10      133797422       1698810704      70      71
				11      135086622       1834519535      70      71
				9       138394717       1558438902      70      71
				8       145138636       1411226840      70      71
				X       156040895       2916073361      70      71
				7       159345973       1249604479      70      71
				MT      16569   3132388394      70      71
				6       170805979       1076358398      70      71
				5       181538259       892226719       70      71
				4       190214555       699294797       70      71
				3       198295559       498166428       70      71
				2       242193529       252512975       70      71
				1       248956422       16      70      71
				21      46709983        2817151612      70      71
				22      50818468        2864528898      70      71
				Y       57227415        3074343428      70      71
				19      58617616        2692331770      70      71
				20      64444167        2751786798      70      71
				18      80373285        2610810278      70      71
				17      83257441        2526363427      70      71
				16      90338345        2434734517      70      71

		.. admonition:: Ordenar con opciones múltiples
			:class: toggle

			:code:`sort` al igual que :code:`cut` o :code:`grep` permite combinar opciones, siempre y cuando estas tengan sentido::

				$ sort -n -r -k3 Homo_sapiens_GRCh38.fasta.fai
				MT      16569   3132388394      70      71
				Y       57227415        3074343428      70      71
				X       156040895       2916073361      70      71
				22      50818468        2864528898      70      71
				21      46709983        2817151612      70      71
				20      64444167        2751786798      70      71
				19      58617616        2692331770      70      71
				18      80373285        2610810278      70      71
				17      83257441        2526363427      70      71
				16      90338345        2434734517      70      71
				15      101991189       2331286294      70      71
				14      107043718       2222713363      70      71
				13      114364328       2106715242      70      71
				12      133275309       1971535983      70      71
				11      135086622       1834519535      70      71
				10      133797422       1698810704      70      71
				9       138394717       1558438902      70      71
				8       145138636       1411226840      70      71
				7       159345973       1249604479      70      71
				6       170805979       1076358398      70      71
				5       181538259       892226719       70      71
				4       190214555       699294797       70      71
				3       198295559       498166428       70      71
				2       242193529       252512975       70      71
				1       248956422       16      70

Redirección: :code:`|`
----------------------

Una de las principales utilidades de la línea de comandos es la posibilidad de concatenar comandos, es decir, tomar el resultado de un comando y pasarselo al siguiente comando

Para ello debemos considerar que cuando ejecutamos un programa o comando, este nos arroja *standard streams*, dentro de las cuales tenemos dos muy importantes

.. admonition:: STDOUT
	:class: toggle

	La salida estandar (STDOUT) es lo que arroja un comando o un programa a la terminal, contiene unicamente el resultado del proceso que haya realizado un comando o programa

	En el siguiente ejemplo, :code:`"Hello world!"` es la salida estándar del comando :code:`echo`

	.. code-block:: sh

		$ echo "Hello world!"
.. admonition:: STDERR
	:class: toggle

	El error estándar (STDERR) es también lo que arroja un comando o un programa a la terminal pero que contiene diagnósticos internos e información del proceso que haya realizado un comando o programa (no necesariamente el resultado)

	En el siguiente ejemplo, :code:`"Hola mundo!"` es la salida estándar del comando :code:`cat`, no obstante, al no haber encontrado el archivo :code:`mi_otro_archivo.txt`, nos manda el mensaje de *error* (STDERR) :code:`cat: mi_archivo.txt No such file or directory`

	.. code-block:: sh

		$ cat mi_archivo.txt mi_otro_archivo.txt
		cat: mi_otro_archivo.txt No such file or directory
		Hola mundo!


Teniendo esto en mente, veremos que los pipes ':code:`|`' toman el :code:`STDOUT` y lo convierten en otro *standard stream* llamado entrada estandar (STDIN)

.. important::
	De modo natural, nuestros programas y comandos generan :code:`STDOUT`, los pipes toman este stream y lo pueden pasar a otro comando

	Aunque nosotros no vemos el :code:`STDIN`, el siguiente comando si puede verlo y procesarlo como si se tratara de un archivo

	El siguiente comando también generará :code:`STDOUT` y :code:`STDERR` y podemos seguir transformando el :code:`STDOUT` resultante *ad infinitum* & *ad nauseam*

	En teoria podríamos concatenar tantos comandos como queramos, siempre y cuando la construcción tenga sentido

	.. image:: stdin_stderr.png

	.. code-block:: sh

		$ seq 1 3
		1
		2
		3

		$ seq 1 3 | grep 2
		2

		$ seq 1 12 | grep 1
		1
		10
		11
		12

		$ seq 1 12 | grep 1 | grep 2
		12

Redirección: :code:`>` & :code:`>>`
-----------------------------------
Ya vimos como dirigir la salida de nuestros comandos y verla en una terminal, pero ahora. Qué pasa si queremos mandar esos resultados a un archivo?

Para ello usaremos los operadores :code:`>` & :code:`>>`

.. important::

	El operador :code:`>` nos permite mandar la salida estándar de un comando o una serie de comandos a un archivo::

		$ ls

		$ seq 1 12 | grep 1 | grep 2
		12

		$ seq 1 12 | grep 1 | grep 2 > archivo_1

		$ ls
		archivo_1

		$ cat archivo_1
		12

	.. danger::

		El operador :code:`>` puede ser muy destructivo si no se emplea adecuadamente::

			echo "blablabla" > tesis_final.docx

.. important::

	El operador :code:`>>` nos permite **agregar** la salida estándar de un comando o una serie de comandos a un archivo::

		$ seq 1 12 | grep 1 | grep 2 > archivo_1

		$ cat archivo_1
		12

		$ seq 1 12 | grep 1
		1
		10
		11
		12

		$ seq 1 12 | grep 1 >> archivo_1

		$ cat archivo_1
		12
		1
		10
		11
		12

Avanzado: :code:`awk`
---------------------

:code:`awk` por si mismo es un lenguaje de programación, no obstante tiene aplicación en la línea de comandos como un programa de uso general

:code:`awk` sirve para:
	* seleccionar columnas
	* seleccionar filas
	* realizar operaciones aritméticas

.. important::

	Antes de lanzarnos al uso de :code:`awk` una pequeña introducción

	* awk opera por bloques delimitados con '{}'::

		$ awk '{print $0}'

	* awk puede procesar archivos de forma directa y también puede procesar :code:`STDIN`::

		$ awk '{print $0}' mi_archivo.txt

		$ seq 1 12 | awk '{print $1}'

	* Para awk todo puede ser una tabla
		* awk puede usar delimitadores de campo tal como lo haria cut
			* Las variables FS, IFS & OFS son usadas como delimitadores de campo (field separator)
				* FS  -> field separator
				* IFS -> input field separator
				* OFS -> output field separator

		* Los campos para awk son representados con el signo '$', de modo que el primer campo es '$1'

		* Hay dos campos intrínsecos con notación especial
			* NR -> number of rows
			* $0 -> all fields

		* Tomando en consideración lo anterior, las siguientes construcciones son similares ::

			$ head -n3 archivo_1.csv
			a,b,c,d
			e,f,g,h
			i,j,k,l

			$ cut -d, -f1,2 archivo_1.csv | head -n3
			a,b
			e,f
			i,j

			$ awk 'BEGIN{FS=",";OFS=","}{print $1 OFS $2}' archivo_1.csv | head -n3
			a,b
			e,f
			i,j

Estamos listos para usar awk?
	Estamos listos para usar awk!

En la siguiente `tabla`_ están las variantes encontradas en un experimento de secuenciación de exoma, veamos que le podemos hacer con awk (o con cualquier otro programa)
::

	Chr.	Position	ID	Ref. allele	Alt. allele	Genotype	Gene	HGVS(nt)	HGVS(aa)	Effect	TOPMED	ExAC	gnomADx	gnomADg	1000G	PolyPhen(D)	PolyPhen(V)	SIFT	FATHMM	MutAssessor	MutTaster	PROVEAN	LRT	MetaSVM	MetaLR	FATHMM_MKL	VEST3	REVEL	CADD	DANN	ClinVar	InterPro	AF_verdict
	2	71668784	rs145832952	C	T	Het. (0.438596)	DYSF	c.5488C>T	p.Pro1830Ser	missense_variant	0.99989	0.00009	0.00012	0.00003	0.00060	32	32	32	32	4	32	32	32	32	32	4	0	4	832	Uncertain_significance	1	LF
	4	119150952	rs758181218	C	G	Het. (0.441176)	MYOZ2	c.157C>G	p.Arg53Gly	missense_variant	0.99999	0.00001	0.00001			32	32	32	0	4	32	32	32	32	32	4	32	4	432	Uncertain_significance	0	PLF
	17	41479481	rs138303882	G	A	Het. (0.391304)	KRT35	c.577C>T	p.Arg193Trp	missense_variant	0.99811	0.00051	0.00044	0.00162	0.00140	32	32	32	32	0	32	32	32	32	32	4	4	0	832	none	0	LF
	1	232514192	rs770896568	C	A	Het. (0.517241)	SIPA1L2	c.1148G>T	p.Ser383Ile	missense_variant	0.99999	0.00001	0.00000	0.00003		32	32	32	32	4	32	32	32	32	32	4	8	0	232	none	0	PLF
	17	20297028	test_data_novel140	C	A	Het. (0.342105)	SPECC1	c.3008C>A	p.Thr1003Asn	missense_variant	32	32	4	32	32	32	2	32	32	32	4	1	0	4	32	none	1	LF
	3	38126203	rs140127056	A	G	Het. (0.506329)	ACAA1	c.956T>C	p.Ile319Thr	missense_variant	0.99802	0.00055	0.00042	0.00175	0.00240	32	16	32	32	0	32	32	32	32	32	4	0	8	232	none	2	LF
	1	119514197	rs774738158	A	G	Het. (0.5)	HSD3B1	c.674A>G	p.Tyr225Cys	missense_variant		0.00040	0.00013	0.00045		32	32	32	32	0	32	32	32	32	32	4	4	16	2	32none	1	pLF
	1	152313385	rs61816761	G	A	Het. (0.435115)	FLG	c.1501C>T	p.Arg501*	stop_gained	0.98844	0.00873	0.00937	0.00940	0.00339	4	4	4	4	4	32	4	4	4	4	4	0	0	2	8Pathogenic	0	PLF
	4	169713231	rs770732784	A	G	Het. (0.323529)	CLCN3	c.2302A>G	p.Met768Val	missense_variant	0.99997	0.00008	0.00008			4	2	16	16	32	32	16	32	32	32	4	8	8	232	Uncertain_significance	1	PLF
	19	9996220	rs148417859	G	A	Het. (0.436364)	COL5A3	c.1465C>T	p.Arg489Cys	missense_variant	0.99959	0.00016	0.00015	0.00019		32	32	32	32	4	32	32	4	32	32	4	4	0	2	32none	0	PLF

.. admonition:: Condicionales en :code:`awk`
	:class: toggle

	Con awk podemos emplear condicionales simples que nos permiten obtener segmentos específicos de un archivo o de un stream

	.. code-block:: sh

		awk 'BEGIN{FS="\t"}{if($1==1 && $2>=1000000 && $2<=2000000){print $0}}' variant_table.tsv

	.. tip::

		Desglosemos esta construcción:

			* :code:`awk 'BEGIN{FS="\t"}'`
				Este segmento inicia el proceso de lectura del archivo (:code:`BEGIN`) y le indica a awk que el separador de campo es un tabulador '\\t'

			* :code:`{if($1==1 && $2>=1000000 && $2<=2000000}`
				Esta condicional (:code:`if(condition){actions}`) se lee como:

				* Si se cumplen las siguientes condiciones:
					* :code:`$1=='1'` la primera columna es igual a 1
					* :code:`&&` y además
					* :code:`$2>='1000000'` la segunda columna es mayor o igual a 1,000,000
					* :code:`&&` y además
					* :code:`$2<='2000000'` la segunda columna es menor o igual a 2,000,000
				* entonces:
					* :code:`{print $0}` muestrame en pantalla todas las columnas

		Y en términos biológicos:
			**Dame todas las variantes del cromosoma 1, del nucleótido 1000000 al nucleótido 2000000**

	.. warning::

		Es importante diferenciar los signos :code:`=` & :code:`==`

		* :code:`=` es un operador de asignación, por lo que no lo podemos usar en condicionales
		* :code:`==` es un operador de comparación, ideal para usarlo en condicionales

	.. warning::

		Las condicionales son sumamente útiles en cualquier lenguaje de programación, sin embargo antes de ejecutarlas debemos verificar que tengan sentido::

			{if($1==1 && $2<=1000000 && $2>=2000000}

		Esta construcción no tiene sentido, ya que esencialmente le estaremos pidiendo a awk que nos entregue filas en dónde se cumplen las siguientes condiciones:
			* :code:`$1=='1'` la primera columna sea igual a 1
			* :code:`&&` y además
			* :code:`$2<='1000000'` la segunda columna sea menor o igual a 1,000,000
			* :code:`&&` y además
			* :code:`$2>='2000000'` la segunda columna sea mayor o igual a 2,000,000

	.. admonition:: Reto!
		:class: toggle

		Mandanos por correo los comandos que usarias para:

			* Obtener las variantes que se ubiquen en el gen *DMD*
			* Obtener las variantes sinónimas del cromosoma 4
			* Obtener las variantes no sinónimas heterocigotas del cromosoma 16
			* Obtener las variantes no sinónimas heterocigotas del cromosoma 1 que tengan una frecuencia alélica en el proyecto 1000 Genomas de menos de 0.01

.. _tabla: https://raw.githubusercontent.com/vflorelo/better_call_ATG/master/docs/source/test_data_variants.tsv
.. _vcf:   https://raw.githubusercontent.com/vflorelo/better_call_ATG/docs/source/test_data_variants.vcf
