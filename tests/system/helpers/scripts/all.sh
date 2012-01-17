#!/bin/sh

# This script compares if $1 file contains all numbers listed in args
# 2..n.

file=$1

if [ $# == 1 ]
then
	echo "" > tmp
else
	shift
	echo "$@" | tr " " "\n" | sort -n | tr "\n" " " > tmp
	echo "" >> tmp
fi

diff tmp $file
ret=$?

rm tmp

exit $ret