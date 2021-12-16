#!/bin/bash
DATE=`date '+%Y%m%d-%H:%M'`

PROJECT=$1
SRC=
DEST=

#Update SRC
git -C $SRC/$PROJECT pull

#Update DEST
git -C $DEST/$PROJECT pull

#Merge to DEST
rsync -avh --delete --exclude-from='./exclude.env' $SRC/$PROJECT/ $DEST/$PROJECT
git -C $DEST/$PROJECT add --all
git -C $DEST/$PROJECT commit -m "Update_$DATE"
git -C $DEST/$PROJECT push
