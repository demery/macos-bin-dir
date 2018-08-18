#!/bin/sh

dir=${1?"Please provide a directory"}

# chmod 755 $dir

find $dir -type d -exec chmod 755 {} \;
find $dir -type f -exec chmod 644 {} \;
