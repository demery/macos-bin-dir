#!/bin/sh

dir=${1:-.}

find $dir -type f -name .\* -prune -o -type f -print
