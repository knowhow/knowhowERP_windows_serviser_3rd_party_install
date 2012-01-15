#!/bin/bash


VER=1.0.2

AUTHOR="hernad@bring.out.ba" 
DAT=15.01.2011

echo $DAT, $VER, $AUTHOR


if [[ "$1" == "" || "$2" == "" || "$3" == "" || "$4" == "" ]]
then

 echo "  usage: $0 [hostname] [username] [dbname]  [filename (bez dump.gz)]"
 echo "example: $0 localhost admin bringout bring_2012-14-01"
 echo "         na lokaciji ~/.f18/backup" 
 echo "         treba da se arhiva bring_2012-14-01.dump.gz"

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
GZIP_BACKUP="$B_DIR/$4.dump.gz"

if ! [[ -d "$B_DIR" ]]
then
	echo "kreiram $B_DIR"
	mkdir -p "$B_DIR" 
else
    ls -l -h "$B_DIR"/*
fi


echo ""
if ! [[ -f  $GZIP_BACKUP ]]
then
 
  echo nema "$GZIP_BACKUP !?"
  echo " "
  echo "evo arhiva koje su raspolozive:"
  echo "----------------------------------"
  ls -l -h "$B_DIR"/*
  echo "----------------------------------"

  exit 1

else
  echo "koristim $GZIP_BACKUP"
  echo ""
fi

C_DIR=`pwd`

echo " "
cp -av "$GZIP_BACKUP" "$GZIP_TMP"
gunzip -f "$GZIP_TMP"

ls -l -h "$DUMP_TMP"

if [[ $? != 0 ]]
then
    echo "nema $DUMP_TMP !?"

	exit 1
fi

echo ""
echo "radim restore iz dumpa"
echo ""


echo "starting pg_restore ..."


if [[ "PGPASSWORD" == "" ]]
then
    echo "unesi $P_USER password:"
    PWD_SWITCH=" -W "
else
    PWD_SWITCH=""
fi


pg_restore --host $P_HOST --port $P_PORT --username $P_USER $PWD_SWITCH --dbname="$P_DATABASE" $DUMP_TMP

if [[ $? == 0 ]]
then
    echo "database $P_DATABASE uspjesno vracen iz arhive"
    echo " "
else
   echo " "
   echo " "
   echo belaj ! neuspjesna komanda:
   echo $CMD
   exit 1
fi

echo " "
echo "------------------------"
echo "restore uspjesan :)"
echo "------------------------"
echo " "
exit 0

