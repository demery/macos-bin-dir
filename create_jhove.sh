#!/bin/sh

dir=`dirname $0`
cmd=`basename $0`
OUT_DIR=

function usage() {
  echo "Usage: $cmd -d OUT_DIR  FILE[, FILE, ..]" >&2
  echo " where:" >&2
  echo "        -d  - the output dir" >&2
}

while getopts d: OPT
do
   case $OPT in
       d)  OUT_DIR=$OPTARG
           ;;
       \?) usage
           exit 1
           ;;
   esac
done
shift `expr $OPTIND - 1`


if [ $# -lt 1 ]; then
   echo "No files provided" >&2
   usage
   exit 1
fi

if [ -z $OUT_DIR ]; then
  echo "No output directory given; creating JHOVE files in image directories" >&2
fi
if [ ! -d $OUT_DIR ]; then
   echo "No directory found named \"$OUT_DIR\"" >&2
   usage
   exit 1
fi

for x 
do
  if [ -z $OUT_DIR ]; then
     outfile=$x.xml
  else
     outfile=$OUT_DIR/`basename $x`.xml
  fi 
  jhove -h xml -m TIFF-hul -k $x > $outfile
  echo "Wrote $outfile" >&2
done
