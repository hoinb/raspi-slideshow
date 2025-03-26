#!/bin/bash

INDIR=./input
OUTDIR=./processed

SCREEN_SIZE=4096x2160
BACKGROUND_COLOR=white
BORDER_COLOR=white
BORDER_WIDTH=50

# Ensure $OUTDIR is available and empty
mkdir -p $OUTDIR
rm -f $OUTDIR/*

# Remove whitespaces in file names
FILES=$INDIR/*
for i in $FILES
do
  OUTFILE=$(echo $i | sed 's/ /-/g')
  echo "Copying file: $i to $OUTFILE"
  mv "$i" $OUTFILE
done


# copy PNGs to Outdir
for i in $(ls $INDIR | egrep -i "\.(PNG|png)$")
do
  echo "Processing PNG: $i"
  cp "$INDIR/$i" "$OUTDIR/$i"
done

# create a new PNG for each PDF
for i in $(ls $INDIR | egrep -i "\.(PDF|pdf)$")
do
  echo "Processing PDF: $i"
  convert \
    -flatten \
    -density 600 \
    "$INDIR/$i" \
    -resize $SCREEN_SIZE \
    "$OUTDIR/$i.png"
done

# create a new PNG for each JPG
for i in $(ls $INDIR | egrep -i "\.(JPG|jpg)$")
do
  echo "Processing JPG: $i"
  convert \
    "$INDIR/$i" \
    "$OUTDIR/$i.png"
done

# post-process in outdir
# - add border
# - convert transparent background
# set fixed size
for i in $(ls $OUTDIR/*.png)
do
  echo "Post-processing: $i"
  convert \
    -flatten \
    "$i" \
    -background $BACKGROUND_COLOR \
    -alpha remove \
    -alpha off \
    -bordercolor $BORDER_COLOR \
    -border $BORDER_WIDTH \
    -resize $SCREEN_SIZE \
    "$i"
done

cd $OUTDIR
for i in $(ls *.png)
do
  mv "$i" "$(pwgen -A -0 8 1)-$i"
done
cd -
