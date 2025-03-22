#!/bin/bash

INDIR=./input
OUTDIR=./processed

SCREEN_SIZE=1920x1080
BACKGROUND_COLOR=green
BORDER_COLOR=yellow
BORDER_WIDTH=50

# Cleanup $OUTDIR
rm -f $OUTDIR/*

# copy PNGs to Outdir
for i in $(ls $INDIR | egrep -i "\.(PNG|png)$")
do
  echo "Processing PNG: $i"
  cp $INDIR/$i $OUTDIR/$i
done

# create a new PNG for each PDF
for i in $(ls $INDIR | egrep -i "\.(PDF|pdf)$")
do
  echo "Processing PDF: $i"
  convert \
    -flatten \
    -density 600 \
    $INDIR/$i \
    -resize $SCREEN_SIZE \
    $OUTDIR/$i.png
done

# create a new PNG for each JPG
for i in $(ls $INDIR | egrep -i "\.(JPG|jpg)$")
do
  echo "Processing JPG: $i"
  convert \
    $INDIR/$i \
    $OUTDIR/$i.png
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
    $i \
    -background $BACKGROUND_COLOR \
    -alpha remove \
    -alpha off \
    -bordercolor $BORDER_COLOR \
    -border $BORDER_WIDTH \
    -resize $SCREEN_SIZE \
    $i
done
for i in $(ls $OUTDIR/*.png)



