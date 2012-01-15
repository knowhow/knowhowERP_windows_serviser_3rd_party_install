#!/bin/bash

DOWNLOADS_DIR=~
DOWNLOADS_DIR="${DOWNLOADS_DIR}/My Documents/Downloads"

echo $DOWNLOADS_DIR

cp -av "$DOWNLOADS_DIR"/$1 ~/.f18/backup/

