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



B_DIR=~/backup/psql_dump
B_FILE="$4.tar.gz"

SQL_HOST="$1"
SQL_USER="$2"
SQL_FILE="$4.sql"


if ! [[ -d  "$B_DIR" ]]
then
  echo kreiram ~/backup/pg_dump
  mkdir ~/backup
  mkdir ~/backup/psql_dump
else
  echo lokacija ~/backup/pg_dump postoji
fi

read

echo ~/backup/psql_dump/
ls -l ~/backup/psql_dump/

echo --------------------------
echo pritisni nesto za nastavak
read

TAR_FILE="$B_DIR/$B_FILE"

echo ""
if ! [[ -f  $TAR_FILE ]]
then
  echo nema "$TAR_FILE !?"
  exit 1
else
  echo "untarujem $TAR_FILE"
  echo ""
fi

C_DIR=`pwd`

cd $B_DIR

tar xvfz $TAR_FILE

cd ~

echo " PSQL restore........unesi $SQL_USER PWD:"


pg_restore --host $SQL_HOST --username $SQL_USER -W --dbname="$3"  "$SQL_FILE" 


echo " Restore iz dumpa  $SQL_FILE u $1 $3 zavrsen ........"
rm $SQL_FILE


exit 0
