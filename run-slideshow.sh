#!/bin/sh

/usr/bin/feh \
  --quiet \
  --preload \
  --auto-zoom \
  --fullscreen \
  --hide-pointer \
  --slideshow-delay 3.0 \
  --draw-filename \
  --recursive \
  $1
