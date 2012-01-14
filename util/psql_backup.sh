#!/bin/bash

VER=0.7.0

AUTHOR="bjasko@bring.out.ba, hernad@bring.out.ba" 

DAT=14.01.2011

echo $DAT, $VER, $AUTHOR



if [[ "$1" == "" || "$2" == "" || "$3" == "" || "$4" == "" ]]
then

 echo "  usage: $0 [hostname] [username] [dbname]  [filename (bez tar.gz)]"
 echo "example: $0 localhost admin bringout bring_2012-14-01"
 echo "         na lokaciji ~/backup/psql_dump/" 
 echo "         treba da se kreira bring_2012-14-01.tar.gz"

 exit 1

fi


cd ~
echo pozicioniram se HOME dir: `pwd`

BCKPDIR="backup/psql_dump"
PSQLHOST="$1"
PSQLUSER="$2"
PSQLFILE="$4.sql"
BACK_FILE="$4.tar.gz"
#############################

echo ovo je prebaceno u serviserski toolset


echo ""
echo "pravim dump"
echo ""

if [ -d $BCKPDIR ]; then
	echo "dir postoji"
else 
	mkdir -p $BCKPDIR 
fi
 


cd $BCKPDIR


echo " PSQL dump........unesi $PSQLUSER PWD:"


pg_dump --host $PSQLHOST --port 5432 --username $PSQLUSER --format custom --blobs --verbose  --file $PSQLFILE  $3


echo " SQL dump zavrsen pakujem SQl dump ........"

	tar cfvz $BACK_FILE $PSQLFILE
	rm $PSQLFILE

echo " Pakovanje zavrseno brisem SQl dump ........"

echo " lista lokalnih backup-a........"


	ls -lh 


exit 0


