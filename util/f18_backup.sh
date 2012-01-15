#!/bin/bash

VER=1.0.0
AUTHOR="hernad@bring.out.ba" 
DAT=15.01.2011

echo $DAT, $VER, $AUTHOR


if [[ "$1" == "" || "$2" == "" || "$3" == "" || "$4" == "" ]]
then

 echo "  usage: $0 [hostname] [username] [dbname]  [filename (bez .dump.gz)]"
 echo "example: $0 localhost admin bringout bring_2012-14-01"
 echo "         na lokaciji ~/.f18/backup" 
 echo "         treba da se kreira bring_2012-14-01.gz"

 exit 1

fi



B_DIR=~/.f18/backup

P_HOST="$1"
P_USER="$2"
P_DATABASE="$3"
P_PORT=5432
B_NAME="$4"

DUMP_TMP="$TMP/$4.dump"
GZIP_TMP="$TMP/$4.dump.gz"
GZIP_OUT="$B_DIR/$4.dump.gz"

echo ""
echo "pravim dump"
echo ""

if ! [[ -d "$B_DIR" ]]
then
	echo "kreiram $B_DIR"
	mkdir -p "$B_DIR" 
else
    ls -l -h "$B_DIR"/*
fi
 

echo " PostgreSQL dump, kreiram $DUMP_TMP za database: $P_DATABASE ........ unesi $P_USER password:"

CMD="pg_dump --host $P_HOST --port $P_PORT --username $P_USER --format custom --blobs --verbose  --file $DUMP_TMP  $P_DATABASE"

pg_dump --host $P_HOST --port $P_PORT --username $P_USER --format custom --blobs --verbose  --file $DUMP_TMP  $P_DATABASE

if [[ $? == 0 ]]
then
    echo "PostgreSQL dump uspjesno zavrsen. gzip-ujem dump ........"

    echo " "
	gzip "$DUMP_TMP"
	echo mv "$GZIP_TMP" "$GZIP_OUT"
	mv "$GZIP_TMP" "$GZIP_OUT"


	ls -l -h "$GZIP_OUT"

	if [[ $? != 0 ]]
    then
	    echo "nema $GZIP_OUT ??"
	    exit 1
	fi

else
   echo " "
   echo " "
   echo belaj ! neuspjesna komanda:
   echo $CMD
   exit 1
fi

echo " "
echo "------------------------"
echo "backup uspjesan :)"
echo "------------------------"
echo " "
exit 0
