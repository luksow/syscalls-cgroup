#!/bin/bash

# Gzips 1 GB file (created from /dev/urandom) $1 times.

TIMEFORMAT='%3lR %3lU %3lS'
dd if=/dev/urandom of=./big_file bs=1073741824 count=1 > /dev/null 2>&1
for ((n=0; n<$1; n++))
do
	times=$( { time gzip -c big_file > compressed_big_file; } 2>&1 )
	read real user sys <<< $(echo $times)

	tmp='60 *'`echo $real | tr 'm' '+' | tr -d 's'`
	real=`python -c "print('%0.3f' % ($tmp))"`

	tmp='60 *'`echo $user | tr 'm' '+' | tr -d 's'`
	user=`python -c "print('%0.3f' % ($tmp))"`

	tmp='60 *'`echo $sys | tr 'm' '+' | tr -d 's'`
	sys=`python -c "print('%0.3f' % ($tmp))"`

	echo $real $user $sys

	rm -f compressed_big_file
done
rm -f big_file