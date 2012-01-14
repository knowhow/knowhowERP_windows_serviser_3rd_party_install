#!/bin/bash



VER=0.9.0

AUTHOR="bjasko@bring.out.ba, hernad@bring.out.ba" 

DAT=14.01.2011

echo $DAT, $VER, $AUTHOR


if [[ "$1" == "" || "$2" == "" || "$3" == "" || "$4" == "" ]]
then

 echo "  usage: $0 [hostname] [username] [dbname]  [filename (bez tar.gz)]"
 echo "example: $0 localhost admin bringout bring_2012-14-01"
 echo "         na lokaciji ~/backup/psql_dump/" 
 echo "         treba da se nalazi bring_2012-14-01.tar.gz"

 exit 1

fi


#############################

BCKPDIR=~/backup/psql_dump
PSQLHOST="$1"
PSQLUSER="$2"
PSQLFILE="$4.sql"
BACK_FILE="$4.tar.gz"

#############################

if ! [[ -d  "$BCKPDIR" ]]
then
  echo kreiram ~/backup/pg_dump
  mkdir ~/backup
  mkdir ~/backup/psql_dump
else
  echo lokacija ~/backup/pg_dump postoji
fi

echo ~/backup/psql_dump/
ls -l ~/backup/psql_dump/

echo --------------------------
echo pritisni nesto za nastavak
read

if [ -d $BCKPDIR ]; then
	echo "fajl $BCKPDIR/$BACK_FILE postoji"
else 
	mkdir -p $BCKPDIR 
fi
 

echo ""
echo "untarujem $BCKPDIR/$BACK_FILE"
echo ""

CURDIR=`pwd`
cd $BCKPDIR
tar xvfz $BACK_FILE 
cd "$CURDIR"

echo " PSQL restore........unesi $PSQLUSER PWD:"


pg_restore --host $PSQLHOST --username $PSQLUSER -W --dbname="$3"  $BCKPDIR/$PSQLFILE 


echo " Restore iz dumpa  $BACKFILE u $1 $3 zavrsen ........"
rm $BCKPDIR/$PSQLFILE

exit 0
