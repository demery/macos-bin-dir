#!/bin/sh

outfile=outfile.pdf
dir=$1
pdfs="$*"
cd $dir
if [ -f $outfile ]; then
  rm $outfile
fi


gs -sPAPERSIZE=letter -dNOPAUSE -dBATCH \
	-sDEVICE=pdfwrite \
	-sOutputFile=$outfile $pdfs

