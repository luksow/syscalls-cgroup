#!/bin/sh

# This script compares if $1 file contains all numbers but those
# listed in args 2..n.

file=$1

read first last <<< $(echo `cat $SYSCALLS_LIST_FILE | tail -n1`)
result=`seq 0 $last | tr '\n' ' '`'
'
IFS=''

while shift
do
	result=`echo $result | sed "s/ $1 / /g"`
done

echo $result > tmp
diff tmp $file
ret=$?

rm tmp

exit $ret