#!/bin/sh

OLDIFS="$IFS"
IFS=:

md5_cmd=
opts=
cmd=`basename $0`

if which md5 >/dev/null 2>&1
then
    md5_cmd="md5"
    opts="-r"
elif which md5sum >/dev/null 2>&1
then
    md5_cmd="md5sum"
elif which gmd5sum >/dev/null 2>&1
then
    md5_cmd="gmd5sum" 
    echo "WARNING: using gmd5sum; this hasn't been tested" >&2
fi

if [ -z "$md5_cmd" ]
then
    echo "No md5 command found; quitting"
    exit 1
fi
    
for x 
do
    if [ -f $x ]
    then
        echo "[$cmd] $x \c"
        md5_file=
        if [ -f $x.md5 ]
        then
            md5_file=$x.md5
        else
            chomped=`echo $x | sed -e 's/\.txt$//' -e 's/\.tiff?//' -e 's/\.xml//'`
            if [ -f $chomped.md5 ]
            then
                md5_file=$chomped.md5
            fi
        fi

        if [ -z "$md5_file" ]; then
            echo "WARNING: no md5 found"
        else
            tmpfile=/tmp/`basename $x`.md5$$
            $md5_cmd $opts $x > $tmpfile
            site_md5=`awk '{ print $1 }' $md5_file`
            temp_md5=`awk '{ print $1 }' $tmpfile`
            if [ "$site_md5" = "$temp_md5" ]; then
                echo "OK"
            else
                echo "FAIL"
            fi
            rm $tmpfile
        fi


    else
        echo "WARNING: No file found named $x; skipping" >&2
    fi
done

IFS="$OLDIFS"
